

#include "stdafx.h"
#include "Clientsock.h"
#include "ClientsockDlg.h"

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


// CClientsockDlg 对话框




CClientsockDlg::CClientsockDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CClientsockDlg::IDD, pParent)
	,pThreadSend(NULL)
	,pThreadRecv(NULL)
{
	//pThreadSend = NULL;
	//pThreadRecv = NULL;
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	//  IPaddress = _T("");
	//  IPport = _T("");
	m_ip = _T("");
	m_port = 0;
}

void CClientsockDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_IP, m_ip);
	DDX_Text(pDX, IDC_PORT, m_port);
}

BEGIN_MESSAGE_MAP(CClientsockDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_CONNECT, &CClientsockDlg::OnBnClickedConnect)
	ON_BN_CLICKED(IDC_RECV, &CClientsockDlg::OnBnClickedRecv)
	ON_BN_CLICKED(IDC_SEND, &CClientsockDlg::OnBnClickedSend)
	ON_BN_CLICKED(IDC_READINI, &CClientsockDlg::OnBnClickedReadini)
	ON_BN_CLICKED(IDC_ABOUT, &CClientsockDlg::OnBnClickedAbout)
	ON_BN_CLICKED(IDC_WRITEINI, &CClientsockDlg::OnBnClickedWriteini)
END_MESSAGE_MAP()


// CClientsockDlg 消息处理程序

BOOL CClientsockDlg::OnInitDialog()
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


	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

void CClientsockDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CClientsockDlg::OnPaint()
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
HCURSOR CClientsockDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}




//----------------------------发送文件的线程------------------------------
UINT Thread_Send(LPVOID lpParam)
{
	CClientsockDlg *dlg=(CClientsockDlg *)lpParam;
    (dlg->GetDlgItem(IDC_SEND))->EnableWindow(FALSE); // 关闭发送按钮

	CSocket Clientsock; //definition socket.
	if(!AfxSocketInit())
	{
		AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
	}

	CString IP;
	int port;
	// 从配置文件 读取IP 和 端口
	GetPrivateProfileString(L"ServerConfiguration",L"IP",L"没有读取到数据！",IP.GetBuffer(100),100,L".\\configuration.ini");
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");
	//创建
	if(!Clientsock.Socket()) 
	{
		CString str;
		str.Format(_T("Socket创建失败: %d"),GetLastError());
		AfxMessageBox(str);
	}
	//连接
//	if(!Clientsock.Connect(_T("127.0.0.1"),8088)) //本机测试
	if(!Clientsock.Connect(IP,port))
	{
		CString str;
		str.Format(_T("Socket连接失败: %d"),GetLastError());
		AfxMessageBox(str);
	}
	else
	{
		AfxMessageBox(_T("Socket连接成功"));
		WIN32_FIND_DATA FindFileData;
		CString strPathName; //定义用来保存发送文件路径的CString对象
		dlg->GetDlgItemTextW(IDC_FILEPATHNAME,strPathName);  // 获得文件路径
		FindClose(FindFirstFile(strPathName,&FindFileData));  // 查找此文件的 获得属性存储在FindFileData  使用FindClose关闭时不需要查找下一个文件了
		Clientsock.Send(&FindFileData,sizeof(WIN32_FIND_DATA)); // socket发送文件
        
		CFile file;
		if(!file.Open(strPathName,CFile::modeRead|CFile::typeBinary))  // 读取文件 二进制
		{
			AfxMessageBox(_T("文件不存在"));
			return 1;
		}

		UINT nSize = 0;
		UINT nSend = 0;

		char *szBuff=NULL;
		// 循环发送
		while(nSize<FindFileData.nFileSizeLow) 
		{
            szBuff = new char[1024];
			memset(szBuff,0x00,1024);
			nSend = file.Read(szBuff,1024);
			Clientsock.Send(szBuff,nSend); //发送数据
			nSize += nSend;
		}
		file.Close();
		delete szBuff;
		Clientsock.Close();  // 关闭串口
		(dlg->GetDlgItem(IDC_SEND))->EnableWindow(TRUE); // 打开发送按钮
		AfxMessageBox(_T("文件发送成功"));
		dlg->SetDlgItemTextW(IDC_FILEPATHNAME,_T(""));
	}
	return 0;
}

//----------------------------接收文件的线程------------------------------
UINT Thread_Recv(LPVOID lpParam)
{
	CSocket Clientsock; //definition socket.
	if(!AfxSocketInit())
	{
		AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
	}

	CString IP;
	int port;
	// 读取ip和端口
	GetPrivateProfileString(L"ServerConfiguration",L"IP",L"没有读取到数据！",IP.GetBuffer(100),100,L".\\configuration.ini");
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");

	//创建
	if(!Clientsock.Socket())
	{
		CString str;
		str.Format(_T("Create Failed: %d"),GetLastError());
		AfxMessageBox(str);
	}

	if(!Clientsock.Connect(IP,port))
	{
		CString str;
		str.Format(_T("Connect Failed: %d"),GetLastError());
		AfxMessageBox(str);
	}
	else
	{
		//AfxMessageBox(_T("连接成功"));
		// 此处处理接收数据和发送数据的代码
        WIN32_FIND_DATA FileInfo;
		Clientsock.Receive(&FileInfo,sizeof(WIN32_FIND_DATA));  // 接收文件属性信息

		CFile file;
		file.Open(FileInfo.cFileName,CFile::modeCreate|CFile::modeWrite); //创建文件
		//AfxMessageBox(FileInfo.cFileName);

		UINT nSize = 0;
		UINT nData = 0;
		char *szBuff;
		while(nSize<FileInfo.nFileSizeLow)  // 读取并写入文件大小的数据
		{
			szBuff=new char[1024];
			memset(szBuff,0x00,1024);
			nData=Clientsock.Receive(szBuff,1024);
			file.Write(szBuff,nData);
            nSize+=nData;
		}
		//设置文件的时间和属性
        SetFileTime((HANDLE)file.m_hFile,&FileInfo.ftCreationTime,&FileInfo.ftLastAccessTime,&FileInfo.ftLastWriteTime);
		SetFileAttributes(FileInfo.cFileName,FileInfo.dwFileAttributes);
		delete szBuff;
		Clientsock.Close();
		file.Close();
	}
    AfxMessageBox(_T("接收完毕"));
	return 0;
}

//----------------------------消息响应函数--------------------------------
void CClientsockDlg::OnBnClickedConnect()  //打开文件
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog m_filedlg(TRUE);
	if(m_filedlg.DoModal()==IDOK)
	{
		CString str = m_filedlg.GetPathName();
        this->SetDlgItemTextW(IDC_FILEPATHNAME,str);
	}
	else
	{
		return;
	}
}

void CClientsockDlg::OnBnClickedRecv()  // 开启接收线程
{
	// TODO: 在此添加控件通知处理程序代码
	pThreadRecv = AfxBeginThread(Thread_Recv,this);//开启线程
}

void CClientsockDlg::OnBnClickedSend()
{
	// TODO: 在此添加控件通知处理程序代码
	pThreadSend = AfxBeginThread(Thread_Send,this);//开启线程
}


void CClientsockDlg::OnBnClickedReadini()
{
	// TODO: 在此添加控件通知处理程序代码
	CString IP;
	int port;
	GetPrivateProfileString(L"ServerConfiguration",L"IP",L"没有读取到数据！",IP.GetBuffer(100),100,L".\\configuration.ini");
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");
	m_ip=IP;
	m_port=port;
	UpdateData(false);
	AfxMessageBox(_T("读取成功"));
}


void CClientsockDlg::OnBnClickedAbout()
{
	// TODO: 在此添加控件通知处理程序代码
	CAboutDlg dlgAbout;
	dlgAbout.DoModal();
	//CDialog::OnOK();
}


void CClientsockDlg::OnBnClickedWriteini()
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
