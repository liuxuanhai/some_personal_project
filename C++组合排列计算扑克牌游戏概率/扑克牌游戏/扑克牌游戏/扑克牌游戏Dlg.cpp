
// 扑克牌游戏Dlg.cpp : 实现文件
//

#include "stdafx.h"
#include "扑克牌游戏.h"
#include "扑克牌游戏Dlg.h"
#include "afxdialogex.h"
#include "CombinationsAndPermutations.cpp"
#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialogEx
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

CAboutDlg::CAboutDlg() : CDialogEx(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// C扑克牌游戏Dlg 对话框




C扑克牌游戏Dlg::C扑克牌游戏Dlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(C扑克牌游戏Dlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void C扑克牌游戏Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(C扑克牌游戏Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON12, &C扑克牌游戏Dlg::OnBnClickedButton12)
	ON_EN_CHANGE(IDC_EDIT80, &C扑克牌游戏Dlg::OnEnChangeEdit80)
	ON_BN_CLICKED(IDC_BUTTON1, &C扑克牌游戏Dlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, &C扑克牌游戏Dlg::OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON3, &C扑克牌游戏Dlg::OnBnClickedButton3)
	ON_BN_CLICKED(IDC_BUTTON4, &C扑克牌游戏Dlg::OnBnClickedButton4)
	ON_BN_CLICKED(IDC_BUTTON5, &C扑克牌游戏Dlg::OnBnClickedButton5)
	ON_BN_CLICKED(IDC_BUTTON6, &C扑克牌游戏Dlg::OnBnClickedButton6)
	ON_BN_CLICKED(IDC_BUTTON7, &C扑克牌游戏Dlg::OnBnClickedButton7)
	ON_BN_CLICKED(IDC_BUTTON8, &C扑克牌游戏Dlg::OnBnClickedButton8)
	ON_BN_CLICKED(IDC_BUTTON9, &C扑克牌游戏Dlg::OnBnClickedButton9)
	ON_BN_CLICKED(IDC_BUTTON10, &C扑克牌游戏Dlg::OnBnClickedButton10)
	ON_BN_CLICKED(IDC_BUTTON13, &C扑克牌游戏Dlg::OnBnClickedButton13)
	ON_BN_CLICKED(IDC_BUTTON11, &C扑克牌游戏Dlg::OnBnClickedButton11)
	ON_MESSAGE(MY_MSG, &C扑克牌游戏Dlg::myMess)  //自定义消息
	ON_BN_CLICKED(IDC_BUTTON14, &C扑克牌游戏Dlg::OnBnClickedButton14)
//	ON_WM_KEYDOWN()
END_MESSAGE_MAP()

//自定义消息
afx_msg LRESULT C扑克牌游戏Dlg::myMess(WPARAM wParam, LPARAM lParam)  // 自定义消息
{
	if (redrun&&bluerun&&yellowrun)
	{
		GetDlgItem(IDC_BUTTON13)->EnableWindow(true);
		if(heji1>heji2)
			GetDlgItem(IDC_hejiresult)->SetWindowTextW(_T("闲多"));
		else
			GetDlgItem(IDC_hejiresult)->SetWindowTextW(_T("庄多"));
		std::double_t heji = heji1 + heji2 + heji3;
		double d1 = heji1 / heji;
		double d2 = heji2 / heji;
		double d3 = heji3 / heji;
		CString temp;
		temp.Format(_T("%.2lf"), d1 * 100);
		GetDlgItem(IDC_heji4)->SetWindowTextW(temp+_T("%"));
		temp.Format(_T("%.2lf"), d2 * 100);
		GetDlgItem(IDC_heji5)->SetWindowTextW(temp + _T("%"));
		temp.Format(_T("%.2lf"), d3 * 100);
		GetDlgItem(IDC_heji6)->SetWindowTextW(temp + _T("%"));
		MessageBox(_T("计算完成!"));
	}
	return 0;
}
// C扑克牌游戏Dlg 消息处理程序

BOOL C扑克牌游戏Dlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// 将“关于...”菜单项添加到系统菜单中。

	// IDM_ABOUTBOX 必须在系统命令范围内。
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
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
	red.resize(80);
	blue.resize(80);
	yellow.resize(80);
	m_editFont.CreatePointFont(180, _T("宋体")); 
	int id=1011;
	while (id < 1091) // 置空
	{
		GetDlgItem(id)->SetFont(&m_editFont);
		GetDlgItem(id)->EnableWindow(false);
		++id;
	}
	clearData();  // 清空数据
	//::WritePrivateProfileString(_T("system"), _T("string"),_T("kbc"),_T( "./setting.ini"));
	CString temp;
	::GetPrivateProfileStringW(_T("system"), _T("string"),_T("abc"), temp.GetBuffer(MAX_PATH), MAX_PATH, _T("./setting.ini"));
	
	if (temp.GetAt(0) <= 'a')
	{
		MessageBox(_T("使用期限已到！请使用正版！"));
		this->OnCancel();
	}
	temp.Format(_T("%c%s"), temp.GetAt(0) -1,temp);
	::WritePrivateProfileString(_T("system"), _T("string"), temp, _T("./setting.ini"));
	//MessageBox(temp);
	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

// 随机产生数据
void C扑克牌游戏Dlg::OnBnClickedButton14()
{
	// TODO: 在此添加控件通知处理程序代码
	int data[] = {
	1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,
	1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,
	1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,
	1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0,1,2,3,4,5,6,7,8,9,0,0,0,0
	};
	std::random_shuffle(data, data + 52*4);
	CString t;
	for (int i = 0; i<80; ++i)
	{
		red[i] = data[i];
		blue[i] = data[i];
		yellow[i] = data[i];
		t.Format(_T("%d"), data[i]);
		GetDlgItem(1011 + i)->SetWindowTextW(t);
	}
	currentindex = 79;
}

void C扑克牌游戏Dlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void C扑克牌游戏Dlg::OnPaint()
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
		CDialogEx::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR C扑克牌游戏Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void C扑克牌游戏Dlg::clearData()  // 清空数据
{
	currentindex=-1;  // 当前索引
	int id=1011;
	while (id < 1091) // 置空
	{
		GetDlgItem(id++)->SetWindowTextW(_T(""));
	}
	
	GetDlgItem(IDC_red1)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_red2)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_red3)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_blue1)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_blue2)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_blue3)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_yellow1)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_yellow2)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_yellow3)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_heji1)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_heji2)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_heji3)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_redresult)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_blueresult)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_yellowresult)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_hejiresult)->SetWindowTextW(_T(""));

	GetDlgItem(IDC_heji4)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_heji5)->SetWindowTextW(_T(""));
	GetDlgItem(IDC_heji6)->SetWindowTextW(_T(""));
	UpdateData(false);
}

void C扑克牌游戏Dlg::OnBnClickedButton12()
{
	// TODO: 在此添加控件通知处理程序代码
	clearData();  // 清空数据
}


void C扑克牌游戏Dlg::enableButton(bool flag)  // 使能按键
{
	GetDlgItem(IDC_BUTTON1)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON2)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON3)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON4)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON5)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON6)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON7)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON8)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON9)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON10)->EnableWindow(flag);
	GetDlgItem(IDC_BUTTON13)->EnableWindow(!flag);
}

void C扑克牌游戏Dlg::OnEnChangeEdit80()
{
	// TODO:  如果该控件是 RICHEDIT 控件，它将不
	// 发送此通知，除非重写 CDialogEx::OnInitDialog()
	// 函数并调用 CRichEditCtrl().SetEventMask()，
	// 同时将 ENM_CHANGE 标志“或”运算到掩码中。
	UpdateData(true);  // 获得文本
	CString tt;
	GetDlgItem(IDC_EDIT80)->GetWindowTextW(tt);
	if(tt.Trim()=="")
		enableButton(true);
	else
		enableButton(false);
	UpdateData(false);
	// TODO:  在此添加控件通知处理程序代码
}





void C扑克牌游戏Dlg::addData(CString data)  // 添加数据
{
	if (currentindex >= 79) return;
	++currentindex;
	int id=1011;
	GetDlgItem(id+currentindex)->SetWindowTextW(data);
	red[currentindex]= _ttoi(data);
	blue[currentindex]= _ttoi(data);
	yellow[currentindex]= _ttoi(data);
}
void C扑克牌游戏Dlg::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("1"));
}


void C扑克牌游戏Dlg::OnBnClickedButton2()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("2"));
}


void C扑克牌游戏Dlg::OnBnClickedButton3()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("3"));
}


void C扑克牌游戏Dlg::OnBnClickedButton4()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("4"));
}


void C扑克牌游戏Dlg::OnBnClickedButton5()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("5"));
}


void C扑克牌游戏Dlg::OnBnClickedButton6()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("6"));
}


void C扑克牌游戏Dlg::OnBnClickedButton7()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("7"));
}


void C扑克牌游戏Dlg::OnBnClickedButton8()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("8"));
}


void C扑克牌游戏Dlg::OnBnClickedButton9()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("9"));
}


void C扑克牌游戏Dlg::OnBnClickedButton10()
{
	// TODO: 在此添加控件通知处理程序代码
	addData(_T("0"));
}


//退格
void C扑克牌游戏Dlg::OnBnClickedButton11()
{
	// TODO: 在此添加控件通知处理程序代码
	int id=1011;
	if(currentindex>=0)
	{
		GetDlgItem(id+currentindex)->SetWindowTextW(_T(""));
		--currentindex;
	}
}


//计算 数量
void C扑克牌游戏Dlg::OnBnClickedButton13()
{
	if (currentindex <79) {
		//MessageBox(_T("请完整输入80张扑克数字!"));
		return;
	}

	// TODO: 在此添加控件通知处理程序代码
	heji1 = 0; heji2 = 0,heji3=0;
	redrun = false; bluerun = false; yellowrun = false;
	GetDlgItem(IDC_BUTTON13)->EnableWindow(false); // 不能再次计算 

	//开辟三个线程
	::AfxBeginThread(countRed,this);
	::AfxBeginThread(countBlue, this);
	::AfxBeginThread(countYellow, this);
}

class FFFFF
{
    std::uint64_t count1,count2,count3;  // 闲家 庄家
public:
    FFFFF() :count1(0),count2(0),count3(0) {}

    template <class It>
        bool operator()(It first, It last)  // called for each permutation
        {
			It it= first;
			int xj=0, zj=0;
			//第1张牌 闲家 
			xj += (*it);
			++it;
			//第2张牌 庄家 
			zj+= (*it);
			++it;
			//第3张牌 闲家 
			xj += (*it);
			++it;
			//第4张牌 庄家
			zj += (*it);
			++it;
			xj %= 10;
			zj %= 10;

			// 开始判断规则
			if (xj > 7||zj>7) {  // 闲家8 9点 或庄家8 9点 立定胜负
				if (xj > zj) ++count1;  // 闲家胜
				else if (xj < zj) ++count2;  // 庄家胜
				else ++count3;  // 平局
			}
			else if(xj==6||xj==7)  // 闲家6 7 点 停牌
			{
				if (zj < 6) {  // 庄家0 1 2 3 4 5 时  补牌
					zj += (*it);
					zj %= 10;
				}
				if (xj > zj) ++count1;  // 闲家胜
				else if (xj < zj) ++count2;  // 庄家胜
				else ++count3;  // 平局
			}
			else  // 闲家0 1 2 3 4 5 补牌
			{
				if (zj > 7)  // 庄家大于7  停牌 立定胜负
				{
					if (xj > zj) ++count1;  // 闲家胜
					else if (xj < zj) ++count2;  // 庄家胜
					else ++count3;  // 平局
				}
				else
				{
					int third = (*it);  // 闲家第三张牌
					++it;
					xj += third;  // 闲家补牌
					xj %= 10;
					// 庄家规则  判断庄家是否补牌
					if (zj < 3)  // 庄家0 1 2 必须补牌
						zj += (*it);
					else if (zj == 3 && third != 8)  //  庄家3点 闲家第三张牌是0 1 2 3 4 5 6 7 9时 则庄家补牌
						zj += (*it);
					else if (zj == 4 && third >1 && third<8)  //  庄家4点 闲家第三张牌是2 3 4 5 6 7时 庄家补牌 
						zj += (*it);
					else if (zj == 5 && third >3 && third<8)  //  庄家补牌
						zj += (*it);
					else if (zj == 6 && third >5 && third<8)  //  庄家补牌
						zj += (*it);
					// 庄家7 8 9点 停牌 
					zj %= 10;
					if (xj > zj) ++count1;  // 闲家胜
					else if (xj < zj) ++count2;  // 庄家胜
					else ++count3;  // 平局
				}
			}
            return false;
        }

    std::uint64_t getCount1() const{
		return count1;
	}
	std::uint64_t getCount2() const {
		return count2;
	}
	std::uint64_t getCount3() const {
		return count3;
	}
};

void uint64_to_string( uint64_t value, std::string& result ) {
	result.clear();
    result.reserve( 20 ); // max. 20 digits possible
    uint64_t q = value;
    do {
		result += "0123456789"[q % 10];
        q /= 10;
    } while ( q );
    std::reverse( result.begin(), result.end() );
}

void uint64_to_cstring(uint64_t value, CString& result) {
	result=_T("");
	uint64_t q = value;
	do {
		result += "0123456789"[q % 10];
		q /= 10;
	} while (q);
	result.MakeReverse();
}

UINT countRed(LPVOID lpParam)  // 红组
{
	C扑克牌游戏Dlg* dlg=(C扑克牌游戏Dlg*)lpParam;  //获得对话框句柄
	FFFFF f;
	//红组只要计算 扑克范围为 5-68
	f=for_each_combination(dlg->red.begin()+4, dlg->red.begin() + 10, dlg->red.begin() + 68,f);
	CString temp;  // 缓存
	uint64_to_cstring(f.getCount1(), temp);
	dlg->GetDlgItem(IDC_red1)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount2(), temp);
	dlg->GetDlgItem(IDC_red2)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount3(), temp);
	dlg->GetDlgItem(IDC_red3)->SetWindowTextW(temp);

	if (f.getCount1()>f.getCount2())
		dlg->GetDlgItem(IDC_redresult)->SetWindowTextW(_T("闲多"));
	else
		dlg->GetDlgItem(IDC_redresult)->SetWindowTextW(_T("庄多"));

	// 计算合计
	dlg->heji1 += f.getCount1();
	dlg->heji2 += f.getCount2();
	dlg->heji3 += f.getCount3();
	uint64_to_cstring(dlg->heji1, temp);
	dlg->GetDlgItem(IDC_heji1)->SetWindowTextW(temp);
	uint64_to_cstring(dlg->heji2, temp);
	dlg->GetDlgItem(IDC_heji2)->SetWindowTextW(temp);
	uint64_to_cstring(dlg->heji3, temp);
	dlg->GetDlgItem(IDC_heji3)->SetWindowTextW(temp);

	dlg->redrun = true;
	dlg->SendMessage(MY_MSG, 0, 0);  //线程  发送消息给主窗口 更新主对话框数据
	return 0;
}
UINT countBlue(LPVOID lpParam)   // 蓝组
{
	C扑克牌游戏Dlg* dlg = (C扑克牌游戏Dlg*)lpParam;  //获得对话框句柄
	FFFFF f;
	//红组只要计算 扑克范围为 5-68
	f= for_each_combination(dlg->blue.begin() + 8, dlg->blue.begin() + 14, dlg->blue.begin() + 74, f);
	
	CString temp;  // 缓存
	uint64_to_cstring(f.getCount1(), temp);
	dlg->GetDlgItem(IDC_blue1)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount2(), temp);
	dlg->GetDlgItem(IDC_blue2)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount3(), temp);
	dlg->GetDlgItem(IDC_blue3)->SetWindowTextW(temp);


	if (f.getCount1()>f.getCount2())
		dlg->GetDlgItem(IDC_blueresult)->SetWindowTextW(_T("闲多"));
	else
		dlg->GetDlgItem(IDC_blueresult)->SetWindowTextW(_T("庄多"));

	// 计算合计
	dlg->heji1 += f.getCount1();
	dlg->heji2 += f.getCount2();
	dlg->heji3 += f.getCount3();
	uint64_to_cstring(dlg->heji1, temp);
	dlg->GetDlgItem(IDC_heji1)->SetWindowTextW(temp);
	uint64_to_cstring(dlg->heji2, temp);
	dlg->GetDlgItem(IDC_heji2)->SetWindowTextW(temp);
	uint64_to_cstring(dlg->heji3, temp);
	dlg->GetDlgItem(IDC_heji3)->SetWindowTextW(temp);

	dlg->bluerun = true;
	dlg->SendMessage(MY_MSG, 0, 0);  //线程  发送消息给主窗口 更新主对话框数据
	return 0;
}
UINT countYellow(LPVOID lpParam)   // 黄组
{
	C扑克牌游戏Dlg* dlg = (C扑克牌游戏Dlg*)lpParam;  //获得对话框句柄
	FFFFF f;
	//红组只要计算 扑克范围为 5-68
	f = for_each_combination(dlg->yellow.begin() + 15, dlg->yellow.begin() + 21, dlg->yellow.begin()+80,f);
	
	CString temp;  // 缓存
	uint64_to_cstring(f.getCount1(), temp);
	dlg->GetDlgItem(IDC_yellow1)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount2(), temp);
	dlg->GetDlgItem(IDC_yellow2)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount3(), temp);
	dlg->GetDlgItem(IDC_yellow3)->SetWindowTextW(temp);


	if(f.getCount1()>f.getCount2())
		dlg->GetDlgItem(IDC_yellowresult)->SetWindowTextW(_T("闲多"));
	else
		dlg->GetDlgItem(IDC_yellowresult)->SetWindowTextW(_T("庄多"));

	// 计算合计
	dlg->heji1 += f.getCount1();
	dlg->heji2 += f.getCount2();
	dlg->heji3 += f.getCount3();
	uint64_to_cstring(dlg->heji1, temp);
	dlg->GetDlgItem(IDC_heji1)->SetWindowTextW(temp);
	uint64_to_cstring(dlg->heji2, temp);
	dlg->GetDlgItem(IDC_heji2)->SetWindowTextW(temp);
	uint64_to_cstring(dlg->heji3, temp);
	dlg->GetDlgItem(IDC_heji3)->SetWindowTextW(temp);

	dlg->yellowrun = true;
	dlg->SendMessage(MY_MSG, 0, 0);  //线程  发送消息给主窗口 更新主对话框数据
	return 0;
}



BOOL C扑克牌游戏Dlg::PreTranslateMessage(MSG* pMsg)
{
	// TODO: 在此添加专用代码和/或调用基类
	if (pMsg->message == WM_KEYDOWN)  // If a keydown message
	{
		//数字键响应
		if (pMsg->wParam == VK_NUMPAD0 || pMsg->wParam == '0')  // If 数字0 pressed
			addData(_T("0"));
		if (pMsg->wParam == VK_NUMPAD1 || pMsg->wParam == '1')  // If 数字0 pressed
			addData(_T("1"));
		if (pMsg->wParam == VK_NUMPAD2 || pMsg->wParam == '2')  // If 数字0 pressed
			addData(_T("2"));
		if (pMsg->wParam == VK_NUMPAD3 || pMsg->wParam == '3')  // If 数字0 pressed
			addData(_T("3"));
		if (pMsg->wParam == VK_NUMPAD4 || pMsg->wParam == '4')  // If 数字0 pressed
			addData(_T("4"));
		if (pMsg->wParam == VK_NUMPAD5 || pMsg->wParam == '5')  // If 数字0 pressed
			addData(_T("5"));
		if (pMsg->wParam == VK_NUMPAD6 || pMsg->wParam == '6')  // If 数字0 pressed
			addData(_T("6"));
		if (pMsg->wParam == VK_NUMPAD7 || pMsg->wParam == '7')  // If 数字0 pressed
			addData(_T("7"));
		if (pMsg->wParam == VK_NUMPAD8 || pMsg->wParam == '8')  // If 数字0 pressed
			addData(_T("8"));
		if (pMsg->wParam == VK_NUMPAD9 || pMsg->wParam == '9')  // If 数字0 pressed
			addData(_T("9"));
		if (pMsg->wParam == VK_BACK)   // backspace退格
			OnBnClickedButton11();
		if (pMsg->wParam == VK_DELETE)   //delete按键 清空
			clearData();
		if (pMsg->wParam == VK_RETURN)  // enter按键  开始计算
			OnBnClickedButton13();
	}
	return CDialogEx::PreTranslateMessage(pMsg);
}
