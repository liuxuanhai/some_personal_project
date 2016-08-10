// MusicPalyerDlg.cpp : implementation file
//

#include "stdafx.h"
#include "MusicPalyer.h"
#include "MusicPalyerDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMusicPalyerDlg dialog

CMusicPalyerDlg::CMusicPalyerDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CMusicPalyerDlg::IDD, pParent)
	, m_nCurrentPos(0)
	, m_RectRemain(100, 74, 220, 90)
	, m_RectCount(35, 74, 120, 90)
	, m_RectMusicName(35, 95, 280, 115)
	, m_RectPlayMode(6, 10, 66, 50)
	, PlayMode(Seq)
	, PlayControl(Play)
{
	//{{AFX_DATA_INIT(CMusicPalyerDlg)
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME); //���������ͼ���������޸ļ���
}

void CMusicPalyerDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CMusicPalyerDlg)
	DDX_Control(pDX, IDC_MainMenu, m_BtnMainMenu);
	DDX_Control(pDX, IDC_BtnMinSize, m_BtnMin);
	DDX_Control(pDX, IDC_BtnHide, m_BtnHide);
	DDX_Control(pDX, IDC_BtnExit, m_BtnExit);
	DDX_Control(pDX, IDC_BtnSort, m_BtnSort);
	DDX_Control(pDX, IDC_DeleteMusic, m_BtnDeleteMusic);
	DDX_Control(pDX, IDC_AddMusic, m_BtnAddMusic);
	DDX_Control(pDX, IDC_StaticPlayMode, m_StaticPlayMode);
	DDX_Control(pDX, IDC_Play, m_BtnPlay);
	DDX_Control(pDX, IDC_BtnNext, m_BtnNext);
	DDX_Control(pDX, IDC_BtnPre, m_BtnPre);
	DDX_Control(pDX, IDC_Stop, m_BtnStop);
	DDX_Control(pDX, IDC_MusicList, m_MusicList);
	DDX_Control(pDX, IDC_Volume, m_SliderVolume);
	DDX_Control(pDX, IDC_Progress, m_SliderProgress);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CMusicPalyerDlg, CDialog)
	//{{AFX_MSG_MAP(CMusicPalyerDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_Play, OnPlay)
	ON_BN_CLICKED(IDC_Stop, OnStop)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_Volume, OnCustomdrawVolume)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_Progress, OnCustomdrawProgress)
	ON_WM_TIMER()
	ON_BN_CLICKED(IDC_AddMusic, OnAddMusic)
	ON_BN_CLICKED(IDC_DeleteMusic, OnDeleteMusic)
	ON_LBN_DBLCLK(IDC_MusicList, OnDblclkMusicList)
	ON_BN_CLICKED(IDC_BtnPre, OnBtnPre)
	ON_BN_CLICKED(IDC_BtnNext, OnBtnNext)
	ON_WM_LBUTTONDOWN()
	ON_BN_CLICKED(IDC_BtnSort, OnBtnSort)
	ON_BN_CLICKED(IDC_MainMenu, OnMainMnue)
	ON_COMMAND(IDM_MainAboutApp, OnMainAboutApp)
	ON_COMMAND(IDM_SubStop, OnSubStop)
	ON_COMMAND(IDM_SubPre, OnSubPre)
	ON_COMMAND(IDM_SubNext, OnSubNext)
	ON_COMMAND(IDM_SubAddFile, OnSubAddFile)
	ON_COMMAND(IDM_SubAdd, OnSubAdd)
	ON_COMMAND(IDM_SubPlus, OnSubPlus)
	ON_COMMAND(IDM_SubQuiet, OnSubQuiet)
	ON_COMMAND(IDM_SubSeq, OnSubSeq)
	ON_COMMAND(IDM_SubLoop, OnSubLoop)
	ON_COMMAND(IDM_SubRandom, OnSubRandom)
	ON_COMMAND(IDM_MainExit, OnMainExit)
	ON_BN_CLICKED(IDC_StaticPlayMode, OnStaticPlayMode)
	ON_BN_CLICKED(IDC_BtnExit, OnBtnExit)
	ON_BN_CLICKED(IDC_BtnHide, OnBtnHide)
	ON_BN_CLICKED(IDC_BtnMinSize, OnBtnMinSize)
	ON_WM_CREATE()
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
	ON_COMMAND(IDM_AddMusic, OnAddSingle)
	ON_COMMAND(IDM_AddFile, OnMenuAddFile)
	ON_MESSAGE(WM_PLAY, OnMessagePlay)
	ON_COMMAND(IDM_DeleteSelect, OnMenuDeleteSelect)
	ON_COMMAND(IDM_DeleteAll, OnMenuDeleteAll)
	ON_COMMAND(IDM_DeleteRepeat, OnMenuDeleteRepeat)
	ON_COMMAND(IDM_SortInName, OnMenuSortInName)
	ON_COMMAND(IDM_SortInTimes, OnMenuSortInTimes)
	ON_COMMAND(IDM_SortInTime, OnMenuSortInTime)
	ON_MESSAGE(WM_NOTIFYMESSAGE, OnMessageNotify)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMusicPalyerDlg message handlers

BOOL CMusicPalyerDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		pSysMenu->RemoveMenu(SC_CLOSE, MF_BYCOMMAND);
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->InsertMenu(0, MF_BYPOSITION, IDM_ABOUTBOX, strAboutMenu);
			pSysMenu->AppendMenu(MF_SEPARATOR, 0, "");
			pSysMenu->AppendMenu(MF_STRING, IDM_MainExit, "�˳�");
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
//	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	SetWindowText("���ֲ�����");
	InitSize();
	m_MusicList.InitFile();

	ReadConfig();
	//MessageBox(_T("55"));
	InitInfo();
	
	CreateNotifyIcon();	
	InitButtons();
	
	m_SliderProgress.SendMessage(PBM_SETBKCOLOR, 0, RGB(0, 0, 0));//����ɫ

    m_SliderProgress.SendMessage(PBM_SETBARCOLOR, 0, RGB(0, 255, 0));//ǰ��ɫ
	UpdateData(false);
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CMusicPalyerDlg::ReadConfig()
{
	CString strConfigPath;
	strConfigPath = m_MusicList.m_strExePath + "\\config.dat";
	std::ifstream ifile(strConfigPath);
	std::string strTmp;
	int i = 0;
	while (std::getline(ifile, strTmp))
	{
		switch (i)
		{
		case 0:
			m_nCurrentPos = atoi(strTmp.c_str());//m_nCurrentPos
			i = 1;
			break;
		case 1:
			m_nVolume = atoi(strTmp.c_str());
			i = 2;
			break;
		case 2:
			PlayMode = (__PlayMode)atoi(strTmp.c_str());
			i = 0;
			break;
		default:
			break;
		}
	}
	ifile.close();
}

void CMusicPalyerDlg::InitSize()
{
	
	/*CRect rect;
	rect.left = 500;
	rect.top = 300;
	rect.right = rect.left + 447;
	rect.bottom = rect.top + 254;
	MoveWindow(&rect, TRUE);

	HRGN hRgn;
	hRgn = CreateRectRgn(0, 30, 447, 284);
	SetWindowRgn(hRgn, TRUE);*/

	int width=450,height=550;
	CRect rect;
	rect.left = 500;
	rect.top = 300;
	rect.right = rect.left + width;
	rect.bottom = rect.top + height;
	MoveWindow(&rect, TRUE);

	HRGN hRgn;
	hRgn = CreateRectRgn(0, 30, width, height+30);
	SetWindowRgn(hRgn, TRUE);
	
}

void CMusicPalyerDlg::InitButtons()
{
//	MessageBox("HELLO");
	m_BtnStop.MoveWindow(CRect(77-2, 13, 78-2, 14), TRUE);
	m_BtnStop.Init(IDB_STOP_NORMAL, IDB_STOP_OVER, "ֹͣ");

	m_BtnPre.MoveWindow(CRect(98-2, 13, 99-2, 14), TRUE);
	m_BtnPre.Init(IDB_PRE_NORMAL, IDB_PRE_OVER, "��һ��");

	m_BtnPlay.MoveWindow(CRect(119-2, 13,120-2, 14), TRUE);
	m_BtnPlay.Init(IDB_PLAY_NORMAL, IDB_PLAY_OVER, "����");

	m_BtnNext.MoveWindow(CRect(140-2, 13, 141-2, 14), TRUE);
	m_BtnNext.Init(IDB_NEXT_NORMAL, IDB_NEXT_OVER, "��һ��");

	




	m_BtnAddMusic.MoveWindow(CRect(90, 121, 91, 102), TRUE);
	m_BtnAddMusic.Init(IDB_ADD_NORMAL, IDB_ADD_OVER ,"��Ӹ���");

	m_BtnDeleteMusic.MoveWindow(CRect(108, 121, 109, 102));
	m_BtnDeleteMusic.Init(IDB_DELETE_NORMAL, IDB_DELETE_OVER, "ɾ������");

	m_BtnSort.MoveWindow(CRect(125, 121, 126, 103), TRUE);
	m_BtnSort.Init(IDB_LIST_NORMAL, IDB_LIST_OVER, "��������");


	m_BtnExit.MoveWindow(CRect(426, 0, 427, 2),TRUE);
	m_BtnExit.Init(IDB_EXIT_NORMAL, IDB_EXIT_OVER, "�˳�");

	m_BtnHide.MoveWindow(CRect(410, 0, 411, 2), TRUE);
	m_BtnHide.Init(IDB_HIDE_NORMAL, IDB_HIDE_OVER, "����");

	m_BtnMin.MoveWindow(CRect(394, 0, 395, 2), TRUE);
	m_BtnMin.Init(IDB_MIN_NORMAL, IDB_MIN_OVER, "��С��");

	m_BtnMainMenu.MoveWindow(CRect(378, 0, 379, 2), TRUE);
	m_BtnMainMenu.Init(IDB_MAINMENU_NORMAL, IDB_MAINMENU_OVER, "���˵�");

	m_StaticPlayMode.SetTipText("����ģʽ");
}

void CMusicPalyerDlg::InitInfo()
{
	m_SliderVolume.SetRange(0, 1000);
	m_SliderVolume.SetPos(m_nVolume);
	m_MusicList.SetCurSel(m_nCurrentPos);
	if (m_MusicList.GetCount() > 0)
	{
		m_MusicList.ReduceTimes(m_nCurrentPos);  //�տ�ʼ��ʱ���ǲ����ţ���������һ��
		SendMessage(WM_PLAY, (WPARAM)m_nCurrentPos, NULL);
		OnStop();
	}
	if (PlayMode == Seq)
		PlayMode = Single;
	else if (PlayMode == Rand)
		PlayMode = Seq;
	else
		PlayMode = Rand;
	OnStaticPlayMode();
}

void CMusicPalyerDlg::CreateNotifyIcon()
{
	NOTIFYICONDATA nd;
	nd.cbSize=sizeof(NOTIFYICONDATA);
	nd.hWnd=m_hWnd;
	nd.uID=WM_ICON;
	nd.uFlags = NIF_ICON|NIF_MESSAGE|NIF_TIP; 
	nd.uCallbackMessage = WM_NOTIFYMESSAGE; 
	nd.hIcon = m_hIcon;
	strcpy(nd.szTip, "���ֲ�����");

	Shell_NotifyIcon(NIM_ADD, &nd);
}

void CMusicPalyerDlg::DeleteNotifyIcon()
{
	NOTIFYICONDATA nd;
	nd.cbSize = sizeof nd;
	nd.hIcon = m_hIcon;
	nd.hWnd = m_hWnd;
	strcpy(nd.szTip, "���ֲ�����");
	nd.uCallbackMessage = WM_NOTIFYMESSAGE;
	nd.uFlags = NIF_ICON | NIF_MESSAGE | NIF_TIP;
	nd.uID = WM_ICON;

	Shell_NotifyIcon(NIM_DELETE, &nd);
}

LRESULT CMusicPalyerDlg::OnMessageNotify(WPARAM wParam, LPARAM lParam)
{
	if (lParam == WM_RBUTTONDOWN)
	{
		CPoint MousePos;
		GetCursorPos(&MousePos);
		CMenu PopMenu;
		PopMenu.LoadMenu(IDR_MainMenu);
		SetForegroundWindow();
		PopMenu.GetSubMenu(0)->TrackPopupMenu(TPM_RIGHTBUTTON, MousePos.x, MousePos.y, this);
	}
	else if (lParam == WM_LBUTTONDOWN)
	{
		ShowWindow(SW_SHOW);
	}
	return 0;
}

void CMusicPalyerDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else if (nID == IDM_MainExit)
	{
		OnMainExit();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CMusicPalyerDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CPaintDC dc(this);
		DrawPicture(dc);
		DrawMyText(dc);
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CMusicPalyerDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

// void CMusicPalyerDlg::OnOpenFile() 
// {
// 	// TODO: Add your control notification handler code here
// 	CString strFilter("֧���ļ���ʽ(*.mp3, *.mav, *.wma)|*.mp3; *.mav; *.wma|");
// 	CFileDialog file(TRUE, NULL, NULL, OFN_HIDEREADONLY, strFilter);
// 
// 	if (IDOK == file.DoModal())
// 	{
// 		m_strFilePath = file.GetPathName();
// 		m_strFileName = file.GetFileName();
// 	}
// }

void CMusicPalyerDlg::OnPlay() 
{
	// TODO: Add your control notification handler code here
	if (/*strCompare.Compare("����") == 0*/PlayControl == Play)
	{
		if (m_MusicList.GetCount() <= 0)
			return ;
		m_nCurrentPos = m_MusicList.GetCurSel();
		if (m_nCurrentPos < 0)
			m_nCurrentPos = 0;
		SendMessage(WM_PLAY, (WPARAM)m_nCurrentPos, NULL);
		PlayControl = Pause;
		m_BtnPlay.SetMyBitmap(IDB_PAUSE_NORMAL, IDB_PAUSE_OVER);
		m_BtnPlay.SetTipText("��ͣ");
	}
	else if (/*strCompare.Compare("��ͣ") == 0*/PlayControl == Pause)
	{
		m_PlayControl.Pause();
		PlayControl = Continue;
		m_BtnPlay.SetMyBitmap(IDB_PLAY_NORMAL, IDB_PLAY_OVER);
		m_BtnPlay.SetTipText("����");
	}
	else
	{
		m_PlayControl.Resume();
		PlayControl = Pause;
		m_BtnPlay.SetMyBitmap(IDB_PAUSE_NORMAL, IDB_PAUSE_OVER);
		m_BtnPlay.SetTipText("��ͣ");
	}
}

void CMusicPalyerDlg::OnStop() 
{
	// TODO: Add your control notification handler code here
	m_PlayControl.Stop();
	m_BtnPlay.SetMyBitmap(IDB_PLAY_NORMAL, IDB_PLAY_OVER);
	m_BtnPlay.SetTipText("����");
	KillTimer(1);
	m_SliderProgress.SetPos(0);
	InvalidateRect(&m_RectCount, TRUE);
	InvalidateRect(&m_RectRemain, TRUE);
	PlayControl = Play;
}

void CMusicPalyerDlg::OnCustomdrawVolume(NMHDR* pNMHDR, LRESULT* pResult) 
{
	// TODO: Add your control notification handler code here
	int iTmp = m_SliderVolume.GetPos();
	if (iTmp < 0)
		iTmp = 0;
	if (m_PlayControl.GetSafeHwnd() != NULL)
		m_PlayControl.SetVolume(iTmp);

	*pResult = 0;
}

void CMusicPalyerDlg::OnCustomdrawProgress(NMHDR* pNMHDR, LRESULT* pResult) 
{
	// TODO: Add your control notification handler code here
	if (PlayControl == Pause)
	{
		static int i = 0;
		static int nTmp1, nTmp2;
		if (i == 0)
		{
			nTmp1 = m_SliderProgress.GetPos();
			i = 1;
		}
		else if (i == 1)
		{
			nTmp2 = m_SliderProgress.GetPos();
			i = 0;
		}
		int nSecond = m_PlayControl.GetLength() / m_PlayControl.GetTimeSize();
		if (nTmp2 < 0)
			nTmp2 = 0;
		if (m_PlayControl.GetSafeHwnd() != NULL)
			if (abs(nTmp1 - nTmp2) >= 5 * nSecond)
				m_PlayControl.SetProgress(m_SliderProgress.GetPos());
	}
	*pResult = 0;
}

void CMusicPalyerDlg::OnTimer(UINT nIDEvent) 
{
	// TODO: Add your message handler code here and/or call default
	m_SliderProgress.SetPos(m_PlayControl.GetCurrentLength());
	
	InvalidateRect(&m_RectRemain, FALSE);
	InvalidateRect(&m_RectCount, FALSE);
	if (m_PlayControl.RemainTime().Compare("00:00") == 0)
		OnBtnNext();
	//Invalidate();
	CDialog::OnTimer(nIDEvent);
}

void CMusicPalyerDlg::OnAddMusic() 
{
	// TODO: Add your control notification handler code here
	CRect rect;
	GetDlgItem(IDC_AddMusic)->GetWindowRect(rect);

	CMenu AddPopMenu;
	AddPopMenu.CreatePopupMenu();
	AddPopMenu.AppendMenu(MF_STRING, IDM_AddMusic, "����ļ�");
	AddPopMenu.AppendMenu(MF_STRING, IDM_AddFile, "����ļ���...");
	AddPopMenu.TrackPopupMenu(TPM_RIGHTBUTTON, rect.left, rect.bottom, this);
}

void CMusicPalyerDlg::OnDeleteMusic() 
{
	// TODO: Add your control notification handler code here
	CRect rect;
	GetDlgItem(IDC_DeleteMusic)->GetWindowRect(rect);

	CMenu DeletePopMenu;
	DeletePopMenu.CreatePopupMenu();
	DeletePopMenu.AppendMenu(MF_STRING, IDM_DeleteSelect, "ɾ��ѡ��");
	DeletePopMenu.AppendMenu(MF_STRING, IDM_DeleteAll, "ɾ������");
	DeletePopMenu.AppendMenu(MF_STRING, IDM_DeleteRepeat, "ɾ���ظ�");
	DeletePopMenu.TrackPopupMenu(TPM_RIGHTBUTTON, rect.left, rect.bottom, this);
}

void CMusicPalyerDlg::OnAddSingle()
{
	CString strFilter("֧�ָ�ʽ(*.mp3, *.mav, *.wma)|*.mp3; *.mav; *.wma|");
	CFileDialog fileDlg(TRUE, NULL, NULL, OFN_HIDEREADONLY, strFilter);

	if (IDOK == fileDlg.DoModal())
	{
		CString strFilePath = fileDlg.GetPathName();
		m_MusicList.AddToFileAndList(strFilePath, 0);
	}
}

void CMusicPalyerDlg::OnMenuAddFile()
{
	LPMALLOC pMalloc;
	if (SHGetMalloc(&pMalloc) == NOERROR)
	{
		BROWSEINFO bi;
		char szBuffer[MAX_PATH];
		LPITEMIDLIST pidl;

		bi.hwndOwner = GetSafeHwnd();
		bi.pidlRoot = NULL;
		bi.pszDisplayName = szBuffer;
		bi.lpszTitle = "ѡ���ļ���";
		bi.ulFlags = BIF_RETURNONLYFSDIRS;
		bi.lpfn = NULL;
		bi.lParam = 0;
		
		pidl = SHBrowseForFolder(&bi);

		if (pidl != NULL)
		{
			if (SHGetPathFromIDList(pidl, szBuffer))
			{
				m_MusicList.AddFolder(szBuffer);
			}
			pMalloc->Free(pidl);
		}
		pMalloc->Release();
	}
}

void CMusicPalyerDlg::OnDblclkMusicList() 
{
	// TODO: Add your control notification handler code here
	if (m_MusicList.GetCount() == 0)
		return ;
	m_nCurrentPos = m_MusicList.GetCurSel();
	if (m_nCurrentPos < 0)
		return ;
	SendMessage(WM_PLAY, (WPARAM)m_nCurrentPos, NULL);
	Invalidate();
}

LRESULT CMusicPalyerDlg::OnMessagePlay(WPARAM wParam, LPARAM lParam)
{
	m_PlayControl.Reset();
	m_strFilePath = m_MusicList.GetMusicName((int)wParam);
	m_MusicList.SetTimes((int)wParam);
	SaveList();
	m_PlayControl.Play(m_strFilePath);
	m_PlayControl.SetVolume(m_SliderVolume.GetPos());

	m_strFileName = m_MusicList.GetName(m_MusicList.GetMusicName((int)wParam));
	CPaintDC dc(this);
	DrawMyText(dc);
	InvalidateRect(&m_RectMusicName, TRUE);

	SetTimer(1, 1000, NULL);
	m_SliderProgress.SetRange(0, m_PlayControl.GetLength());
	m_SliderProgress.SetPos(0);
	if (PlayControl == Play)
	{
		PlayControl = Pause;
		m_BtnPlay.SetMyBitmap(IDB_PAUSE_NORMAL, IDB_PAUSE_OVER);
		m_BtnPlay.SetTipText("��ͣ");
	}
	else if (PlayControl == Continue)
	{
		PlayControl = Pause;
		m_BtnPlay.SetMyBitmap(IDB_PAUSE_NORMAL, IDB_PAUSE_OVER);
		m_BtnPlay.SetTipText("��ͣ");
	}
	return 0;
}

void CMusicPalyerDlg::OnBtnPre() 
{
	// TODO: Add your control notification handler code here
	if (m_MusicList.GetCount() <= 0)
		return;
	if (PlayControl == Play)
		m_nCurrentPos = m_nCurrentPos;
	else
	{
		if (PlayMode == Seq)
			-- m_nCurrentPos;
		else if (PlayMode == Single)
			m_nCurrentPos = m_nCurrentPos;
		else
			m_nCurrentPos = GetRandomNum();
	}
	if (m_nCurrentPos < 0)
	{
		m_nCurrentPos = m_MusicList.GetCount() - 1;
		m_MusicList.SetCurSel(m_MusicList.GetCount() - 1);
	}
	else
		m_MusicList.SetCurSel(m_nCurrentPos);
	SendMessage(WM_PLAY, (WPARAM)m_nCurrentPos, NULL);
	Invalidate();
}

void CMusicPalyerDlg::OnBtnNext() 
{
	if (m_MusicList.GetCount() <= 0)
		return;
	if (PlayControl == Play)
		m_nCurrentPos = m_nCurrentPos;
	else
	{
		if (PlayMode == Seq)
			++ m_nCurrentPos;
		else if (PlayMode == Single)
			m_nCurrentPos = m_nCurrentPos;
		else
			m_nCurrentPos = GetRandomNum();
	}
	if (m_nCurrentPos >= m_MusicList.GetCount())
	{
		m_nCurrentPos = 0;
		m_MusicList.SetCurSel(m_nCurrentPos);
	}
	else 
		m_MusicList.SetCurSel(m_nCurrentPos);
	//dc.TextOut(60, 45, m_strFileName);
	SendMessage(WM_PLAY, (WPARAM)m_nCurrentPos, NULL);
	Invalidate();
}

void CMusicPalyerDlg::DrawMyText(CPaintDC& dc)
{
	CFont font;
	font.CreatePointFont(110, "����_GB2312", &dc);
	CFont* pOldFont = dc.SelectObject(&font);
	dc.SetBkMode(TRANSPARENT);
	dc.SetTextColor(RGB(200, 55, 155));

	//dc.TextOut(390, 74, m_PlayControl.RemainTime());
	dc.TextOut(390, 70, m_PlayControl.CountTime());

	dc.TextOut(60, 45, m_strFileName);
	dc.TextOut(13, 70, "����");
	dc.TextOut(13, 45, "����");
	dc.TextOut(165, 13, "����");
	dc.TextOut(13, 121, "�����б�");
	dc.SelectObject(pOldFont);
	font.DeleteObject();
}

void CMusicPalyerDlg::DrawPicture(CPaintDC& dc)
{
	CBitmap bitmap;
	BITMAP  bmp;
	
	bitmap.LoadBitmap(IDB_BACKGROUND);
	bitmap.GetBitmap(&bmp);
	CDC memDC;
	memDC.CreateCompatibleDC(&dc);
	CBitmap* pOldBitmap = memDC.SelectObject(&bitmap);

	dc.BitBlt(0, 0, bmp.bmWidth, bmp.bmHeight, &memDC, 0, 0, SRCCOPY);

	memDC.SelectObject(pOldBitmap);
	bitmap.DeleteObject();
}

void CMusicPalyerDlg::OnLButtonDown(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
// 	CString strTmp;
// 	strTmp.Format("%d, %d", point.x, point.y);
// 	MessageBox(strTmp);
	PostMessage(WM_NCLBUTTONDOWN,HTCAPTION,MAKELPARAM (point.x, point.y));
	CDialog::OnLButtonDown(nFlags, point);
}

void CMusicPalyerDlg::OnMenuDeleteSelect()
{
	int nSel = m_MusicList.GetCurSel();
	if (nSel == 0 && m_MusicList.GetCount() == 1)
	{
		OnMenuDeleteAll();
		return;
	}
	if (nSel >= 0)
		m_MusicList.DeleteFile(nSel);
	if (nSel == m_nCurrentPos)
		OnBtnNext();
	SaveList();//��ʱ����д
}

UINT WINAPI ThreadSaveList(void* lParam);

//�ö��߳�ʵ���ļ��Ķ�д���е�ͻ�ƣ�2014-3-12
void CMusicPalyerDlg::SaveList()
{
	CMusicList* pList = &m_MusicList;
	HANDLE hThreadSaveFile = (HANDLE)_beginthreadex(NULL, 0, ThreadSaveList, (void*)pList, 0, NULL);
	CloseHandle(hThreadSaveFile);
}

//2014-3-13
UINT WINAPI ThreadSaveList(void* lParam)
{
	CMusicList* pList = (CMusicList*)lParam;
	int nCount = pList->GetCount();
	CString strLstPath = pList->m_strExePath; //�������Ҫ��Ҫ�ñ���õĹ���·��, ���ļ������л��޸��ļ�·��
	strLstPath += "\\musiclist.lst";

	std::ofstream ofile(strLstPath, std::ios::out);
	for (int i = 0; i < nCount; ++ i)
	{
		CString str = pList->GetMusicName(i);
		int nTimes = pList->GetTimes(i);
		std::string time = pList->GetTime(i);
		ofile << (LPSTR)(LPCTSTR)str;
 		ofile << "\n";
 		ofile << nTimes;
 		ofile << "\n";
 		ofile << time;
		ofile << std::endl;
	}
	ofile.close();
	return 0;
}

void CMusicPalyerDlg::OnMenuDeleteAll()
{
	m_MusicList.DeleteAll();
	SaveList();
	OnStop();
	m_PlayControl.Reset();
	m_strFileName = "";
	InvalidateRect(&m_RectMusicName, TRUE);
}


int CMusicPalyerDlg::GetRandomNum()
{
	srand((UINT)time(NULL));
	int nSup = m_MusicList.GetCount() - 1;
	int nNum;
	do 
	{
		nNum = rand() % (nSup + 1);
	} while (nNum < 0 || nNum > nSup || nNum == m_nCurrentPos);
	return nNum;
}

void CMusicPalyerDlg::OnMenuDeleteRepeat()
{
	m_MusicList.DeleteRepeat();
	SaveList();
}

void CMusicPalyerDlg::OnBtnSort() 
{
	// TODO: Add your control notification handler code here
	CRect rect;
	GetDlgItem(IDC_BtnSort)->GetWindowRect(&rect); //GetWindowRect����ֱ�ӻ���������Ļ������

	CMenu PopMenu;
	PopMenu.CreatePopupMenu();
	PopMenu.AppendMenu(MF_STRING, IDM_SortInName, "����������");
	PopMenu.AppendMenu(MF_STRING, IDM_SortInTimes, "�����Ŵ�������");
	PopMenu.AppendMenu(MF_STRING, IDM_SortInTime, "�����ʱ������");
	PopMenu.TrackPopupMenu(TPM_RIGHTBUTTON, rect.left, rect.bottom, this);
}

void CMusicPalyerDlg::OnMenuSortInName()
{
	m_MusicList.SortInName();
	SaveList();
}

void CMusicPalyerDlg::OnMenuSortInTimes()
{
	m_MusicList.SortInTimes();
	SaveList();
}

void CMusicPalyerDlg::OnMenuSortInTime()
{
	m_MusicList.SortInTime();
	SaveList();
}

void CMusicPalyerDlg::OnMainMnue() 
{
	// TODO: Add your control notification handler code here
	CRect rect;
	GetDlgItem(IDC_MainMenu)->GetWindowRect(&rect);

	//����Դ������һ�ΰ�
	CMenu	m_PopMenu;
	m_PopMenu.LoadMenu(IDR_MainMenu);
	m_PopMenu.GetSubMenu(0)->TrackPopupMenu(TPM_RIGHTBUTTON, rect.left, rect.bottom, this);
}

void CMusicPalyerDlg::OnMainAboutApp() 
{
	// TODO: Add your command handler code here
	CAboutDlg dlg;
	dlg.DoModal();
}

void CMusicPalyerDlg::OnSubStop() 
{
	OnStop();	
}

void CMusicPalyerDlg::OnSubPre() 
{
	// TODO: Add your command handler code here
	OnBtnPre();	
}

void CMusicPalyerDlg::OnSubNext() 
{
	// TODO: Add your command handler code here
	OnBtnNext();
}

void CMusicPalyerDlg::OnSubAddFile() 
{
	// TODO: Add your command handler code here
	OnAddSingle();
}

void CMusicPalyerDlg::OnSubAdd() 
{
	// TODO: Add your command handler code here
	int nCurrentPos = m_SliderVolume.GetPos();
	nCurrentPos += 100;
	m_PlayControl.SetVolume(nCurrentPos);
	m_SliderVolume.SetPos(nCurrentPos);
	
}

void CMusicPalyerDlg::OnSubPlus() 
{
	// TODO: Add your command handler code here
	int nCurrentPos = m_SliderVolume.GetPos();
	nCurrentPos -= 100;
	m_PlayControl.SetVolume(nCurrentPos);
	m_SliderVolume.SetPos(nCurrentPos);
}

void CMusicPalyerDlg::OnSubQuiet() 
{
	// TODO: Add your command handler code here
	m_PlayControl.SetVolume(0);
	m_SliderVolume.SetPos(0);
}

void CMusicPalyerDlg::OnSubSeq() 
{
	PlayMode = Seq;
	SetDlgItemText(IDC_BtnPlayMode, "˳��");
}

void CMusicPalyerDlg::OnSubLoop() 
{
	PlayMode = Single;	
	SetDlgItemText(IDC_BtnPlayMode, "����");
}

void CMusicPalyerDlg::OnSubRandom() 
{
	// TODO: Add your command handler code here
	PlayMode = Rand;
	SetDlgItemText(IDC_BtnPlayMode, "���");
}

void CMusicPalyerDlg::OnMainExit() 
{
	PostQuitMessage(0);	
	DeleteNotifyIcon();
	SaveConfig();
}

void CMusicPalyerDlg::OnStaticPlayMode() 
{
	// TODO: Add your control notification handler code here
	InvalidateRect(m_RectPlayMode, TRUE);
	if (PlayMode == Single)
	{
		SetDlgItemText(IDC_StaticPlayMode, "˳��");
		PlayMode = Seq;
	}
	else if (PlayMode == Seq)
	{
		SetDlgItemText(IDC_StaticPlayMode, "���");
		PlayMode = Rand;
	}
	else
	{
		SetDlgItemText(IDC_StaticPlayMode, "����");
		PlayMode = Single;
	}
}

void CMusicPalyerDlg::OnBtnExit() 
{
	OnMainExit();
}

void CMusicPalyerDlg::OnBtnHide() 
{
	ShowWindow(SW_HIDE);	
}

void CMusicPalyerDlg::OnBtnMinSize() 
{
	// TODO: Add your control notification handler code here
	ShowWindow(SW_MINIMIZE);	
}



int CMusicPalyerDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	// TODO: Add your specialized creation code here
	DragAcceptFiles(TRUE);
	return 0;
}


LRESULT CMusicPalyerDlg::WindowProc(UINT message, WPARAM wParam, LPARAM lParam) 
{
	// TODO: Add your specialized code here and/or call the base class
	if (message == WM_DROPFILES)
	{
		HDROP hDrop;
		hDrop = (HDROP)wParam;
		GetDropFiles(hDrop);
		DragFinish(hDrop);
	}
	else if (message == WM_ERASEBKGND)
	{
		
	}
	return CDialog::WindowProc(message, wParam, lParam);
}

void CMusicPalyerDlg::GetDropFiles(HDROP hDrop)
{
	CPoint point;
	CRect rect(34, 0, 247, 125);
	DragQueryPoint(hDrop, &point);
	if (rect.PtInRect(point))
	{
		UINT nFiles;
		TCHAR szFileName[MAX_PATH];
		nFiles = DragQueryFile(hDrop, (UINT)0xffffffff, NULL, NULL);
		for (UINT i = 0; i < nFiles; ++ i)
		{
			DragQueryFile(hDrop, i, szFileName, MAX_PATH);
			if (m_MusicList.IsSupportName(szFileName))
				m_MusicList.AddToFileAndList(szFileName, 0);
		}
	}
	else
	{
		MessageBox("�϶����б�������");
	}
}

HBRUSH CMusicPalyerDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor) 
{
	HBRUSH hbr = CDialog::OnCtlColor(pDC, pWnd, nCtlColor);
	
	// TODO: Change any attributes of the DC here
	//HBRUSH hBrush = CreateSolidBrush(RGB(0, 0, 0));
	if (pWnd == GetDlgItem(IDC_Progress) || pWnd == GetDlgItem(IDC_Volume))
	{
		return (HBRUSH)CreateSolidBrush(RGB(100,100,100));
	}
	if (nCtlColor == CTLCOLOR_LISTBOX)
	{
		HBRUSH hBrush = CreateSolidBrush(RGB(20, 20,20));
		pDC->SetBkMode(TRANSPARENT);
		pDC->SetTextColor(RGB(0,255,255));
		return hBrush;
	}
	else
		return hbr;
	// TODO: Return a different brush if the default is not desired
}

void CMusicPalyerDlg::SaveConfig()
{
	CString strConfigPath;
	strConfigPath = m_MusicList.m_strExePath + "\\config.dat";
	std::ofstream ofile(strConfigPath);
	ofile << m_MusicList.GetCurSel();
	ofile << std::endl;
	ofile << m_SliderVolume.GetPos();
	ofile << std::endl;
	ofile << PlayMode;
	ofile.close();
}