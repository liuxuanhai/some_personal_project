// ServersockDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "Serversock.h"
#include "ServersockDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// 对话框数据
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

// 实现
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


// CServersockDlg 对话框




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


// CServersockDlg 消息处理程序

BOOL CServersockDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// 将“关于...”菜单项添加到系统菜单中。

	// IDM_ABOUTBOX 必须在系统命令范围内。
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

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码
	//get   hostname 
	char   hostname[20]; 
	gethostname(hostname,20); 

	//get   ipv4   address. 
	hostent *pHost=::gethostbyname(hostname); 
	in_addr addr; 
	char *p=pHost-> h_addr_list[0]; 
	memcpy(&addr.S_un.S_addr,p,pHost-> h_length); 
	char * v4IP=::inet_ntoa(addr);  // 转化为.模式
	CString v4(v4IP);
	//AfxMessageBox(v4);
	
	m_ip=v4;
	UpdateData(false);

	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
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

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CServersockDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CServersockDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

//----------------------------发送文件的线程------------------------------
UINT ThreadFunc(LPVOID lpParam)  //发送文件的线程函数  
{

	CServersockDlg *dlg = (CServersockDlg *)lpParam; //获取对话框指针
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
        sprintf_s(errBuf,"Socket初始化失败：%d\n",IDP_SOCKETS_INIT_FAILED);
		int len=strlen(errBuf);
		logErrorfile.Write(errBuf,len);
		return 1;
	}

	CSocket Serversock;
    CSocket Clientsock;
	//创建
	if(!Serversock.Socket())
	{
		memset(errBuf,0x00,sizeof(errBuf));
		strcpy_s(errBuf,"Socket创建失败\n");
		sprintf_s(errBuf,"Socket创建失败: %d\n",GetLastError());
		int len=strlen(errBuf);
		logErrorfile.Write(errBuf,len);
		return 1;
	}

	BOOL bOptVal = TRUE;
	int bOptLen = sizeof(BOOL);
	Serversock.SetSockOpt(SO_REUSEADDR,(void *)&bOptVal,bOptLen,SOL_SOCKET);

	//绑定
	if(!Serversock.Bind(port))
	{
		memset(errBuf,0x00,sizeof(errBuf));
		strcpy_s(errBuf,"Socket绑定失败\n");
		sprintf_s(errBuf,"Socket绑定失败: %d\n",GetLastError());
        int len = strlen(errBuf);
		logErrorfile.Write(errBuf,len);
		return 1;
	}
    //监听 
	if(!Serversock.Listen(10))
	{
		memset(errBuf,0x00,sizeof(errBuf));
		strcpy_s(errBuf,"Socket监听失败...\n");
		sprintf_s(errBuf,"Socket监听失败: %d\n",GetLastError());
		int len = sizeof(errBuf);
		logErrorfile.Write(errBuf,len);
		return 1;
	}
	//AfxMessageBox(_T("服务器启动成功"));
	memset(errBuf,0x00,sizeof(errBuf));
	strcpy_s(errBuf,"服务器启动成功\r\n");
	int len = strlen(errBuf);
	logErrorfile.Write(errBuf,len);
	Serversock.Accept(Clientsock); //接收 
    
	WIN32_FIND_DATA FindFileData;
	CString strPathName; //定义用来保存发送文件路径的CString对象
    dlg->GetDlgItemTextW(IDC_FILEPATHNAME,strPathName);
	FindClose(FindFirstFile(strPathName,&FindFileData));
	Clientsock.Send(&FindFileData,sizeof(WIN32_FIND_DATA));
    //发送文件的数据
    
    CFile file;
	if(!file.Open(strPathName,CFile::modeRead|CFile::typeBinary))
	{
		//AfxMessageBox(_T("文件不存在"));
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
	strcpy_s(errBuf,"文件发送成功\n");
	len = strlen(errBuf);
	logErrorfile.Write(errBuf,len);
	AfxMessageBox(_T("文件发送成功"));
	dlg->SetDlgItemTextW(IDC_FILEPATHNAME,_T(""));
	return 0;
}

//----------------------------监听文件的线程------------------------------
UINT Thread_Func(LPVOID lpParam)  //接收文件的线程函数
{
	CServersockDlg *dlg = (CServersockDlg *)lpParam; //获取对话框指针
    (dlg->GetDlgItem(IDC_RECVDATA))->EnableWindow(FALSE);

	if(!AfxSocketInit())
	{
		AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
	}

	CString IP;
	int port;
	GetPrivateProfileString(L"ServerConfiguration",L"IP",L"没有读取到数据！",IP.GetBuffer(100),100,L".\\configuration.ini");
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");
    
	char errBuf[100]={0};// 临时缓存
    
	SYSTEMTIME t; //系统时间结构 

	CFile logErrorfile;
	if(!logErrorfile.Open(_T("logErrorfile.txt"),CFile::modeCreate|CFile::modeReadWrite))
	{
		return 1;
	}

	CSocket Serversock;
    CSocket Clientsock;
	//创建
	if(!Serversock.Socket())
	{
		CString str;
		str.Format(_T("Socket创建失败: %d"),GetLastError());
		AfxMessageBox(str);
	}

	BOOL bOptVal = TRUE;
	int bOptLen = sizeof(BOOL);
	Serversock.SetSockOpt(SO_REUSEADDR,(void *)&bOptVal,bOptLen,SOL_SOCKET);

	//绑定
	if(!Serversock.Bind(port))
	{
		CString str;
		str.Format(_T("Socket绑定失败: %d"),GetLastError());
		AfxMessageBox(str);
	}
    //监听 
	if(!Serversock.Listen(10))
	{
		CString str;
		str.Format(_T("Socket监听失败: %d"),GetLastError());
		AfxMessageBox(str);
	}

	GetLocalTime(&t);
	sprintf_s(errBuf,"服务器已经启动...正在等待接收文件...\r\n时间：%d年%d月%d日 %2d:%2d:%2d \r\n",t.wYear,t.wMonth,t.wDay,
		t.wHour,t.wMinute,t.wSecond);
	int len = strlen(errBuf);
	logErrorfile.Write(errBuf,len);
	AfxMessageBox(_T("启动成功等待接收文件"));
	while(1)
	{
		//AfxMessageBox(_T("服务器启动成功..."));
		if(!Serversock.Accept(Clientsock)) //等待接收 
		{
			continue;
		}
		else
		{
			WIN32_FIND_DATA FileInfo;
			Clientsock.Receive(&FileInfo,sizeof(WIN32_FIND_DATA)); // 接收文件名

			CFile file;
			file.Open(FileInfo.cFileName,CFile::modeCreate|CFile::modeWrite);
			//AfxMessageBox(FileInfo.cFileName);
			int length = sizeof(FileInfo.cFileName);
			logErrorfile.Write(FileInfo.cFileName,length);
			//Receive文件的数据

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
			sprintf_s(errBuf,"文件接收成功...\r\n时间：%d年%d月%d日 %2d:%2d:%2d \r\n",t.wYear,t.wMonth,t.wDay,
		t.wHour,t.wMinute,t.wSecond);
			int len = strlen(errBuf);
			logErrorfile.Write(errBuf,len);
			//AfxMessageBox(_T("文件接收成功..."));
		    break;
		}
	}
	return 0;
}


void CServersockDlg::OnBnClickedChoose()
{
	// TODO: 在此添加控件通知处理程序代码
    CFileDialog m_filedlg(TRUE);
	if(m_filedlg.DoModal()==IDOK)
	{
		CString str=m_filedlg.GetPathName();

		//判断文件是否存在
		this->SetDlgItemTextW(IDC_FILEPATHNAME,str);
	}
	else
	{
		return;
	}
}

void CServersockDlg::OnBnClickedSend()
{
	// TODO: 在此添加控件通知处理程序代码
	pThread = AfxBeginThread(ThreadFunc,this);
}

void CServersockDlg::OnBnClickedRecvdata()
{
	// TODO: 在此添加控件通知处理程序代码
	AfxBeginThread(Thread_Func,this);
}


void CServersockDlg::OnBnClickedAbout()
{
	// TODO: 在此添加控件通知处理程序代码
	CAboutDlg dlgAbout;
	dlgAbout.DoModal();
}





void CServersockDlg::OnBnClickedWriteini()
{
	// TODO: 在此添加控件通知处理程序代码
	CString IP,port;
	UpdateData(true);
	IP = m_ip.GetString(); 
	port.Format(L"%d",m_port);
	WritePrivateProfileString(L"ServerConfiguration",L"IP",IP,L".\\configuration.ini");
	WritePrivateProfileString(L"ServerConfiguration",L"port",port,L".\\configuration.ini");
	AfxMessageBox(_T("写入成功"));
}


void CServersockDlg::OnBnClickedReadini()
{
	// TODO: 在此添加控件通知处理程序代码
	int port;
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");
	m_port=port;
	UpdateData(false);
	AfxMessageBox(_T("读取成功"));
}
