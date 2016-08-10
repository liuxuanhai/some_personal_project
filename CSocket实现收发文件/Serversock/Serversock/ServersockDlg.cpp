// ServersockDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "Serversock.h"
#include "ServersockDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// ����Ӧ�ó��򡰹��ڡ��˵���� CAboutDlg �Ի���

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// �Ի�������
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

// ʵ��
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// CServersockDlg �Ի���




CServersockDlg::CServersockDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CServersockDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_port = 0;
	m_ip = _T("");
}

void CServersockDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_PORT, m_port);
	DDX_Text(pDX, IDC_IP, m_ip);
}

BEGIN_MESSAGE_MAP(CServersockDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	//ON_BN_CLICKED(IDC_START, &CServersockDlg::OnBnClickedStart)
//	ON_BN_CLICKED(IDC_BUTTON4, &CServersockDlg::OnBnClickedButton4)
	ON_BN_CLICKED(IDC_CHOOSE, &CServersockDlg::OnBnClickedChoose)
	ON_BN_CLICKED(IDC_SEND, &CServersockDlg::OnBnClickedSend)
	ON_BN_CLICKED(IDC_RECVDATA, &CServersockDlg::OnBnClickedRecvdata)
	ON_BN_CLICKED(IDC_ABOUT, &CServersockDlg::OnBnClickedAbout)
	ON_BN_CLICKED(IDC_WRITEINI, &CServersockDlg::OnBnClickedWriteini)
	ON_BN_CLICKED(IDC_WRITEINI, &CServersockDlg::OnBnClickedWriteini)
	ON_BN_CLICKED(IDC_READINI, &CServersockDlg::OnBnClickedReadini)
END_MESSAGE_MAP()


// CServersockDlg ��Ϣ�������

BOOL CServersockDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// ��������...���˵�����ӵ�ϵͳ�˵��С�

	// IDM_ABOUTBOX ������ϵͳ���Χ�ڡ�
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������
	//get   hostname 
	char   hostname[20]; 
	gethostname(hostname,20); 

	//get   ipv4   address. 
	hostent *pHost=::gethostbyname(hostname); 
	in_addr addr; 
	char *p=pHost-> h_addr_list[0]; 
	memcpy(&addr.S_un.S_addr,p,pHost-> h_length); 
	char * v4IP=::inet_ntoa(addr);  // ת��Ϊ.ģʽ
	CString v4(v4IP);
	//AfxMessageBox(v4);
	
	m_ip=v4;
	UpdateData(false);

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

void CServersockDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CServersockDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CServersockDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

//----------------------------�����ļ����߳�------------------------------
UINT ThreadFunc(LPVOID lpParam)  //�����ļ����̺߳���  
{

	CServersockDlg *dlg = (CServersockDlg *)lpParam; //��ȡ�Ի���ָ��
    (dlg->GetDlgItem(IDC_SEND))->EnableWindow(FALSE);

	CFile logErrorfile;
	if(!logErrorfile.Open(_T("logErrorfile.txt"),CFile::modeCreate|CFile::modeReadWrite))
	{
		return 1;
	}
	char errBuf[100]={0};

	
	int port;
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");

	if(!AfxSocketInit())
	{
		//AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
        sprintf_s(errBuf,"Socket��ʼ��ʧ�ܣ�%d\n",IDP_SOCKETS_INIT_FAILED);
		int len=strlen(errBuf);
		logErrorfile.Write(errBuf,len);
		return 1;
	}

	CSocket Serversock;
    CSocket Clientsock;
	//����
	if(!Serversock.Socket())
	{
		memset(errBuf,0x00,sizeof(errBuf));
		strcpy_s(errBuf,"Socket����ʧ��\n");
		sprintf_s(errBuf,"Socket����ʧ��: %d\n",GetLastError());
		int len=strlen(errBuf);
		logErrorfile.Write(errBuf,len);
		return 1;
	}

	BOOL bOptVal = TRUE;
	int bOptLen = sizeof(BOOL);
	Serversock.SetSockOpt(SO_REUSEADDR,(void *)&bOptVal,bOptLen,SOL_SOCKET);

	//��
	if(!Serversock.Bind(port))
	{
		memset(errBuf,0x00,sizeof(errBuf));
		strcpy_s(errBuf,"Socket��ʧ��\n");
		sprintf_s(errBuf,"Socket��ʧ��: %d\n",GetLastError());
        int len = strlen(errBuf);
		logErrorfile.Write(errBuf,len);
		return 1;
	}
    //���� 
	if(!Serversock.Listen(10))
	{
		memset(errBuf,0x00,sizeof(errBuf));
		strcpy_s(errBuf,"Socket����ʧ��...\n");
		sprintf_s(errBuf,"Socket����ʧ��: %d\n",GetLastError());
		int len = sizeof(errBuf);
		logErrorfile.Write(errBuf,len);
		return 1;
	}
	//AfxMessageBox(_T("�����������ɹ�"));
	memset(errBuf,0x00,sizeof(errBuf));
	strcpy_s(errBuf,"�����������ɹ�\r\n");
	int len = strlen(errBuf);
	logErrorfile.Write(errBuf,len);
	Serversock.Accept(Clientsock); //���� 
    
	WIN32_FIND_DATA FindFileData;
	CString strPathName; //�����������淢���ļ�·����CString����
    dlg->GetDlgItemTextW(IDC_FILEPATHNAME,strPathName);
	FindClose(FindFirstFile(strPathName,&FindFileData));
	Clientsock.Send(&FindFileData,sizeof(WIN32_FIND_DATA));
    //�����ļ�������
    
    CFile file;
	if(!file.Open(strPathName,CFile::modeRead|CFile::typeBinary))
	{
		//AfxMessageBox(_T("�ļ�������"));
		return 1;
	}

	UINT nSize = 0;
	UINT nSend = 0;

	char *szBuff=NULL;

	while(nSize<FindFileData.nFileSizeLow)
	{
		szBuff = new char[1024];
		memset(szBuff,0x00,1024);
		nSend = file.Read(szBuff,1024);
	    Clientsock.Send(szBuff,nSend);
		nSize+=nSend;
	}

	delete szBuff;
    Serversock.Close();
	Clientsock.Close();
	file.Close();
	(dlg->GetDlgItem(IDC_SEND))->EnableWindow(TRUE);
	memset(errBuf,0x00,sizeof(errBuf));
	strcpy_s(errBuf,"�ļ����ͳɹ�\n");
	len = strlen(errBuf);
	logErrorfile.Write(errBuf,len);
	AfxMessageBox(_T("�ļ����ͳɹ�"));
	dlg->SetDlgItemTextW(IDC_FILEPATHNAME,_T(""));
	return 0;
}

//----------------------------�����ļ����߳�------------------------------
UINT Thread_Func(LPVOID lpParam)  //�����ļ����̺߳���
{
	CServersockDlg *dlg = (CServersockDlg *)lpParam; //��ȡ�Ի���ָ��
    (dlg->GetDlgItem(IDC_RECVDATA))->EnableWindow(FALSE);

	if(!AfxSocketInit())
	{
		AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
	}

	CString IP;
	int port;
	GetPrivateProfileString(L"ServerConfiguration",L"IP",L"û�ж�ȡ�����ݣ�",IP.GetBuffer(100),100,L".\\configuration.ini");
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");
    
	char errBuf[100]={0};// ��ʱ����
    
	SYSTEMTIME t; //ϵͳʱ��ṹ 

	CFile logErrorfile;
	if(!logErrorfile.Open(_T("logErrorfile.txt"),CFile::modeCreate|CFile::modeReadWrite))
	{
		return 1;
	}

	CSocket Serversock;
    CSocket Clientsock;
	//����
	if(!Serversock.Socket())
	{
		CString str;
		str.Format(_T("Socket����ʧ��: %d"),GetLastError());
		AfxMessageBox(str);
	}

	BOOL bOptVal = TRUE;
	int bOptLen = sizeof(BOOL);
	Serversock.SetSockOpt(SO_REUSEADDR,(void *)&bOptVal,bOptLen,SOL_SOCKET);

	//��
	if(!Serversock.Bind(port))
	{
		CString str;
		str.Format(_T("Socket��ʧ��: %d"),GetLastError());
		AfxMessageBox(str);
	}
    //���� 
	if(!Serversock.Listen(10))
	{
		CString str;
		str.Format(_T("Socket����ʧ��: %d"),GetLastError());
		AfxMessageBox(str);
	}

	GetLocalTime(&t);
	sprintf_s(errBuf,"�������Ѿ�����...���ڵȴ������ļ�...\r\nʱ�䣺%d��%d��%d�� %2d:%2d:%2d \r\n",t.wYear,t.wMonth,t.wDay,
		t.wHour,t.wMinute,t.wSecond);
	int len = strlen(errBuf);
	logErrorfile.Write(errBuf,len);
	AfxMessageBox(_T("�����ɹ��ȴ������ļ�"));
	while(1)
	{
		//AfxMessageBox(_T("�����������ɹ�..."));
		if(!Serversock.Accept(Clientsock)) //�ȴ����� 
		{
			continue;
		}
		else
		{
			WIN32_FIND_DATA FileInfo;
			Clientsock.Receive(&FileInfo,sizeof(WIN32_FIND_DATA)); // �����ļ���

			CFile file;
			file.Open(FileInfo.cFileName,CFile::modeCreate|CFile::modeWrite);
			//AfxMessageBox(FileInfo.cFileName);
			int length = sizeof(FileInfo.cFileName);
			logErrorfile.Write(FileInfo.cFileName,length);
			//Receive�ļ�������

			UINT nSize = 0;
			UINT nData = 0;

			char *szBuff=NULL;

			while(nSize<FileInfo.nFileSizeLow)
			{
				szBuff = new char[1024];
				memset(szBuff,0x00,1024);
				nData=Clientsock.Receive(szBuff,1024);
			    file.Write(szBuff,nData);
				nSize+=nData;
			}

			delete szBuff;
			Serversock.Close();
			Clientsock.Close();
			file.Close();
			(dlg->GetDlgItem(IDC_RECVDATA))->EnableWindow(TRUE);
			sprintf_s(errBuf,"�ļ����ճɹ�...\r\nʱ�䣺%d��%d��%d�� %2d:%2d:%2d \r\n",t.wYear,t.wMonth,t.wDay,
		t.wHour,t.wMinute,t.wSecond);
			int len = strlen(errBuf);
			logErrorfile.Write(errBuf,len);
			//AfxMessageBox(_T("�ļ����ճɹ�..."));
		    break;
		}
	}
	return 0;
}


void CServersockDlg::OnBnClickedChoose()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
    CFileDialog m_filedlg(TRUE);
	if(m_filedlg.DoModal()==IDOK)
	{
		CString str=m_filedlg.GetPathName();

		//�ж��ļ��Ƿ����
		this->SetDlgItemTextW(IDC_FILEPATHNAME,str);
	}
	else
	{
		return;
	}
}

void CServersockDlg::OnBnClickedSend()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	pThread = AfxBeginThread(ThreadFunc,this);
}

void CServersockDlg::OnBnClickedRecvdata()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	AfxBeginThread(Thread_Func,this);
}


void CServersockDlg::OnBnClickedAbout()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	CAboutDlg dlgAbout;
	dlgAbout.DoModal();
}





void CServersockDlg::OnBnClickedWriteini()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	CString IP,port;
	UpdateData(true);
	IP = m_ip.GetString(); 
	port.Format(L"%d",m_port);
	WritePrivateProfileString(L"ServerConfiguration",L"IP",IP,L".\\configuration.ini");
	WritePrivateProfileString(L"ServerConfiguration",L"port",port,L".\\configuration.ini");
	AfxMessageBox(_T("д��ɹ�"));
}


void CServersockDlg::OnBnClickedReadini()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	int port;
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");
	m_port=port;
	UpdateData(false);
	AfxMessageBox(_T("��ȡ�ɹ�"));
}
