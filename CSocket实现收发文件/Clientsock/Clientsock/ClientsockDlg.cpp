

#include "stdafx.h"
#include "Clientsock.h"
#include "ClientsockDlg.h"

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


// CClientsockDlg �Ի���




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


// CClientsockDlg ��Ϣ�������

BOOL CClientsockDlg::OnInitDialog()
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


	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
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

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CClientsockDlg::OnPaint()
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
HCURSOR CClientsockDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}




//----------------------------�����ļ����߳�------------------------------
UINT Thread_Send(LPVOID lpParam)
{
	CClientsockDlg *dlg=(CClientsockDlg *)lpParam;
    (dlg->GetDlgItem(IDC_SEND))->EnableWindow(FALSE); // �رշ��Ͱ�ť

	CSocket Clientsock; //definition socket.
	if(!AfxSocketInit())
	{
		AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
	}

	CString IP;
	int port;
	// �������ļ� ��ȡIP �� �˿�
	GetPrivateProfileString(L"ServerConfiguration",L"IP",L"û�ж�ȡ�����ݣ�",IP.GetBuffer(100),100,L".\\configuration.ini");
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");
	//����
	if(!Clientsock.Socket()) 
	{
		CString str;
		str.Format(_T("Socket����ʧ��: %d"),GetLastError());
		AfxMessageBox(str);
	}
	//����
//	if(!Clientsock.Connect(_T("127.0.0.1"),8088)) //��������
	if(!Clientsock.Connect(IP,port))
	{
		CString str;
		str.Format(_T("Socket����ʧ��: %d"),GetLastError());
		AfxMessageBox(str);
	}
	else
	{
		AfxMessageBox(_T("Socket���ӳɹ�"));
		WIN32_FIND_DATA FindFileData;
		CString strPathName; //�����������淢���ļ�·����CString����
		dlg->GetDlgItemTextW(IDC_FILEPATHNAME,strPathName);  // ����ļ�·��
		FindClose(FindFirstFile(strPathName,&FindFileData));  // ���Ҵ��ļ��� ������Դ洢��FindFileData  ʹ��FindClose�ر�ʱ����Ҫ������һ���ļ���
		Clientsock.Send(&FindFileData,sizeof(WIN32_FIND_DATA)); // socket�����ļ�
        
		CFile file;
		if(!file.Open(strPathName,CFile::modeRead|CFile::typeBinary))  // ��ȡ�ļ� ������
		{
			AfxMessageBox(_T("�ļ�������"));
			return 1;
		}

		UINT nSize = 0;
		UINT nSend = 0;

		char *szBuff=NULL;
		// ѭ������
		while(nSize<FindFileData.nFileSizeLow) 
		{
            szBuff = new char[1024];
			memset(szBuff,0x00,1024);
			nSend = file.Read(szBuff,1024);
			Clientsock.Send(szBuff,nSend); //��������
			nSize += nSend;
		}
		file.Close();
		delete szBuff;
		Clientsock.Close();  // �رմ���
		(dlg->GetDlgItem(IDC_SEND))->EnableWindow(TRUE); // �򿪷��Ͱ�ť
		AfxMessageBox(_T("�ļ����ͳɹ�"));
		dlg->SetDlgItemTextW(IDC_FILEPATHNAME,_T(""));
	}
	return 0;
}

//----------------------------�����ļ����߳�------------------------------
UINT Thread_Recv(LPVOID lpParam)
{
	CSocket Clientsock; //definition socket.
	if(!AfxSocketInit())
	{
		AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
	}

	CString IP;
	int port;
	// ��ȡip�Ͷ˿�
	GetPrivateProfileString(L"ServerConfiguration",L"IP",L"û�ж�ȡ�����ݣ�",IP.GetBuffer(100),100,L".\\configuration.ini");
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");

	//����
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
		//AfxMessageBox(_T("���ӳɹ�"));
		// �˴�����������ݺͷ������ݵĴ���
        WIN32_FIND_DATA FileInfo;
		Clientsock.Receive(&FileInfo,sizeof(WIN32_FIND_DATA));  // �����ļ�������Ϣ

		CFile file;
		file.Open(FileInfo.cFileName,CFile::modeCreate|CFile::modeWrite); //�����ļ�
		//AfxMessageBox(FileInfo.cFileName);

		UINT nSize = 0;
		UINT nData = 0;
		char *szBuff;
		while(nSize<FileInfo.nFileSizeLow)  // ��ȡ��д���ļ���С������
		{
			szBuff=new char[1024];
			memset(szBuff,0x00,1024);
			nData=Clientsock.Receive(szBuff,1024);
			file.Write(szBuff,nData);
            nSize+=nData;
		}
		//�����ļ���ʱ�������
        SetFileTime((HANDLE)file.m_hFile,&FileInfo.ftCreationTime,&FileInfo.ftLastAccessTime,&FileInfo.ftLastWriteTime);
		SetFileAttributes(FileInfo.cFileName,FileInfo.dwFileAttributes);
		delete szBuff;
		Clientsock.Close();
		file.Close();
	}
    AfxMessageBox(_T("�������"));
	return 0;
}

//----------------------------��Ϣ��Ӧ����--------------------------------
void CClientsockDlg::OnBnClickedConnect()  //���ļ�
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
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

void CClientsockDlg::OnBnClickedRecv()  // ���������߳�
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	pThreadRecv = AfxBeginThread(Thread_Recv,this);//�����߳�
}

void CClientsockDlg::OnBnClickedSend()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	pThreadSend = AfxBeginThread(Thread_Send,this);//�����߳�
}


void CClientsockDlg::OnBnClickedReadini()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	CString IP;
	int port;
	GetPrivateProfileString(L"ServerConfiguration",L"IP",L"û�ж�ȡ�����ݣ�",IP.GetBuffer(100),100,L".\\configuration.ini");
	port=GetPrivateProfileInt(L"ServerConfiguration",L"port",0,L".\\configuration.ini");
	m_ip=IP;
	m_port=port;
	UpdateData(false);
	AfxMessageBox(_T("��ȡ�ɹ�"));
}


void CClientsockDlg::OnBnClickedAbout()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	CAboutDlg dlgAbout;
	dlgAbout.DoModal();
	//CDialog::OnOK();
}


void CClientsockDlg::OnBnClickedWriteini()
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
