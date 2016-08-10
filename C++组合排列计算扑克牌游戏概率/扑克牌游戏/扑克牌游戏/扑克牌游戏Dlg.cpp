
// �˿�����ϷDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "�˿�����Ϸ.h"
#include "�˿�����ϷDlg.h"
#include "afxdialogex.h"
#include "CombinationsAndPermutations.cpp"
#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// ����Ӧ�ó��򡰹��ڡ��˵���� CAboutDlg �Ի���

class CAboutDlg : public CDialogEx
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

CAboutDlg::CAboutDlg() : CDialogEx(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// C�˿�����ϷDlg �Ի���




C�˿�����ϷDlg::C�˿�����ϷDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(C�˿�����ϷDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void C�˿�����ϷDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(C�˿�����ϷDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON12, &C�˿�����ϷDlg::OnBnClickedButton12)
	ON_EN_CHANGE(IDC_EDIT80, &C�˿�����ϷDlg::OnEnChangeEdit80)
	ON_BN_CLICKED(IDC_BUTTON1, &C�˿�����ϷDlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, &C�˿�����ϷDlg::OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON3, &C�˿�����ϷDlg::OnBnClickedButton3)
	ON_BN_CLICKED(IDC_BUTTON4, &C�˿�����ϷDlg::OnBnClickedButton4)
	ON_BN_CLICKED(IDC_BUTTON5, &C�˿�����ϷDlg::OnBnClickedButton5)
	ON_BN_CLICKED(IDC_BUTTON6, &C�˿�����ϷDlg::OnBnClickedButton6)
	ON_BN_CLICKED(IDC_BUTTON7, &C�˿�����ϷDlg::OnBnClickedButton7)
	ON_BN_CLICKED(IDC_BUTTON8, &C�˿�����ϷDlg::OnBnClickedButton8)
	ON_BN_CLICKED(IDC_BUTTON9, &C�˿�����ϷDlg::OnBnClickedButton9)
	ON_BN_CLICKED(IDC_BUTTON10, &C�˿�����ϷDlg::OnBnClickedButton10)
	ON_BN_CLICKED(IDC_BUTTON13, &C�˿�����ϷDlg::OnBnClickedButton13)
	ON_BN_CLICKED(IDC_BUTTON11, &C�˿�����ϷDlg::OnBnClickedButton11)
	ON_MESSAGE(MY_MSG, &C�˿�����ϷDlg::myMess)  //�Զ�����Ϣ
	ON_BN_CLICKED(IDC_BUTTON14, &C�˿�����ϷDlg::OnBnClickedButton14)
//	ON_WM_KEYDOWN()
END_MESSAGE_MAP()

//�Զ�����Ϣ
afx_msg LRESULT C�˿�����ϷDlg::myMess(WPARAM wParam, LPARAM lParam)  // �Զ�����Ϣ
{
	if (redrun&&bluerun&&yellowrun)
	{
		GetDlgItem(IDC_BUTTON13)->EnableWindow(true);
		if(heji1>heji2)
			GetDlgItem(IDC_hejiresult)->SetWindowTextW(_T("�ж�"));
		else
			GetDlgItem(IDC_hejiresult)->SetWindowTextW(_T("ׯ��"));
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
		MessageBox(_T("�������!"));
	}
	return 0;
}
// C�˿�����ϷDlg ��Ϣ�������

BOOL C�˿�����ϷDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// ��������...���˵�����ӵ�ϵͳ�˵��С�

	// IDM_ABOUTBOX ������ϵͳ���Χ�ڡ�
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

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������
	red.resize(80);
	blue.resize(80);
	yellow.resize(80);
	m_editFont.CreatePointFont(180, _T("����")); 
	int id=1011;
	while (id < 1091) // �ÿ�
	{
		GetDlgItem(id)->SetFont(&m_editFont);
		GetDlgItem(id)->EnableWindow(false);
		++id;
	}
	clearData();  // �������
	//::WritePrivateProfileString(_T("system"), _T("string"),_T("kbc"),_T( "./setting.ini"));
	CString temp;
	::GetPrivateProfileStringW(_T("system"), _T("string"),_T("abc"), temp.GetBuffer(MAX_PATH), MAX_PATH, _T("./setting.ini"));
	
	if (temp.GetAt(0) <= 'a')
	{
		MessageBox(_T("ʹ�������ѵ�����ʹ�����棡"));
		this->OnCancel();
	}
	temp.Format(_T("%c%s"), temp.GetAt(0) -1,temp);
	::WritePrivateProfileString(_T("system"), _T("string"), temp, _T("./setting.ini"));
	//MessageBox(temp);
	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

// �����������
void C�˿�����ϷDlg::OnBnClickedButton14()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
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

void C�˿�����ϷDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void C�˿�����ϷDlg::OnPaint()
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
		CDialogEx::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR C�˿�����ϷDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void C�˿�����ϷDlg::clearData()  // �������
{
	currentindex=-1;  // ��ǰ����
	int id=1011;
	while (id < 1091) // �ÿ�
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

void C�˿�����ϷDlg::OnBnClickedButton12()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	clearData();  // �������
}


void C�˿�����ϷDlg::enableButton(bool flag)  // ʹ�ܰ���
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

void C�˿�����ϷDlg::OnEnChangeEdit80()
{
	// TODO:  ����ÿؼ��� RICHEDIT �ؼ���������
	// ���ʹ�֪ͨ��������д CDialogEx::OnInitDialog()
	// ���������� CRichEditCtrl().SetEventMask()��
	// ͬʱ�� ENM_CHANGE ��־�������㵽�����С�
	UpdateData(true);  // ����ı�
	CString tt;
	GetDlgItem(IDC_EDIT80)->GetWindowTextW(tt);
	if(tt.Trim()=="")
		enableButton(true);
	else
		enableButton(false);
	UpdateData(false);
	// TODO:  �ڴ���ӿؼ�֪ͨ����������
}





void C�˿�����ϷDlg::addData(CString data)  // �������
{
	if (currentindex >= 79) return;
	++currentindex;
	int id=1011;
	GetDlgItem(id+currentindex)->SetWindowTextW(data);
	red[currentindex]= _ttoi(data);
	blue[currentindex]= _ttoi(data);
	yellow[currentindex]= _ttoi(data);
}
void C�˿�����ϷDlg::OnBnClickedButton1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("1"));
}


void C�˿�����ϷDlg::OnBnClickedButton2()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("2"));
}


void C�˿�����ϷDlg::OnBnClickedButton3()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("3"));
}


void C�˿�����ϷDlg::OnBnClickedButton4()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("4"));
}


void C�˿�����ϷDlg::OnBnClickedButton5()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("5"));
}


void C�˿�����ϷDlg::OnBnClickedButton6()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("6"));
}


void C�˿�����ϷDlg::OnBnClickedButton7()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("7"));
}


void C�˿�����ϷDlg::OnBnClickedButton8()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("8"));
}


void C�˿�����ϷDlg::OnBnClickedButton9()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("9"));
}


void C�˿�����ϷDlg::OnBnClickedButton10()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	addData(_T("0"));
}


//�˸�
void C�˿�����ϷDlg::OnBnClickedButton11()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	int id=1011;
	if(currentindex>=0)
	{
		GetDlgItem(id+currentindex)->SetWindowTextW(_T(""));
		--currentindex;
	}
}


//���� ����
void C�˿�����ϷDlg::OnBnClickedButton13()
{
	if (currentindex <79) {
		//MessageBox(_T("����������80���˿�����!"));
		return;
	}

	// TODO: �ڴ���ӿؼ�֪ͨ����������
	heji1 = 0; heji2 = 0,heji3=0;
	redrun = false; bluerun = false; yellowrun = false;
	GetDlgItem(IDC_BUTTON13)->EnableWindow(false); // �����ٴμ��� 

	//���������߳�
	::AfxBeginThread(countRed,this);
	::AfxBeginThread(countBlue, this);
	::AfxBeginThread(countYellow, this);
}

class FFFFF
{
    std::uint64_t count1,count2,count3;  // �м� ׯ��
public:
    FFFFF() :count1(0),count2(0),count3(0) {}

    template <class It>
        bool operator()(It first, It last)  // called for each permutation
        {
			It it= first;
			int xj=0, zj=0;
			//��1���� �м� 
			xj += (*it);
			++it;
			//��2���� ׯ�� 
			zj+= (*it);
			++it;
			//��3���� �м� 
			xj += (*it);
			++it;
			//��4���� ׯ��
			zj += (*it);
			++it;
			xj %= 10;
			zj %= 10;

			// ��ʼ�жϹ���
			if (xj > 7||zj>7) {  // �м�8 9�� ��ׯ��8 9�� ����ʤ��
				if (xj > zj) ++count1;  // �м�ʤ
				else if (xj < zj) ++count2;  // ׯ��ʤ
				else ++count3;  // ƽ��
			}
			else if(xj==6||xj==7)  // �м�6 7 �� ͣ��
			{
				if (zj < 6) {  // ׯ��0 1 2 3 4 5 ʱ  ����
					zj += (*it);
					zj %= 10;
				}
				if (xj > zj) ++count1;  // �м�ʤ
				else if (xj < zj) ++count2;  // ׯ��ʤ
				else ++count3;  // ƽ��
			}
			else  // �м�0 1 2 3 4 5 ����
			{
				if (zj > 7)  // ׯ�Ҵ���7  ͣ�� ����ʤ��
				{
					if (xj > zj) ++count1;  // �м�ʤ
					else if (xj < zj) ++count2;  // ׯ��ʤ
					else ++count3;  // ƽ��
				}
				else
				{
					int third = (*it);  // �мҵ�������
					++it;
					xj += third;  // �мҲ���
					xj %= 10;
					// ׯ�ҹ���  �ж�ׯ���Ƿ���
					if (zj < 3)  // ׯ��0 1 2 ���벹��
						zj += (*it);
					else if (zj == 3 && third != 8)  //  ׯ��3�� �мҵ���������0 1 2 3 4 5 6 7 9ʱ ��ׯ�Ҳ���
						zj += (*it);
					else if (zj == 4 && third >1 && third<8)  //  ׯ��4�� �мҵ���������2 3 4 5 6 7ʱ ׯ�Ҳ��� 
						zj += (*it);
					else if (zj == 5 && third >3 && third<8)  //  ׯ�Ҳ���
						zj += (*it);
					else if (zj == 6 && third >5 && third<8)  //  ׯ�Ҳ���
						zj += (*it);
					// ׯ��7 8 9�� ͣ�� 
					zj %= 10;
					if (xj > zj) ++count1;  // �м�ʤ
					else if (xj < zj) ++count2;  // ׯ��ʤ
					else ++count3;  // ƽ��
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

UINT countRed(LPVOID lpParam)  // ����
{
	C�˿�����ϷDlg* dlg=(C�˿�����ϷDlg*)lpParam;  //��öԻ�����
	FFFFF f;
	//����ֻҪ���� �˿˷�ΧΪ 5-68
	f=for_each_combination(dlg->red.begin()+4, dlg->red.begin() + 10, dlg->red.begin() + 68,f);
	CString temp;  // ����
	uint64_to_cstring(f.getCount1(), temp);
	dlg->GetDlgItem(IDC_red1)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount2(), temp);
	dlg->GetDlgItem(IDC_red2)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount3(), temp);
	dlg->GetDlgItem(IDC_red3)->SetWindowTextW(temp);

	if (f.getCount1()>f.getCount2())
		dlg->GetDlgItem(IDC_redresult)->SetWindowTextW(_T("�ж�"));
	else
		dlg->GetDlgItem(IDC_redresult)->SetWindowTextW(_T("ׯ��"));

	// ����ϼ�
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
	dlg->SendMessage(MY_MSG, 0, 0);  //�߳�  ������Ϣ�������� �������Ի�������
	return 0;
}
UINT countBlue(LPVOID lpParam)   // ����
{
	C�˿�����ϷDlg* dlg = (C�˿�����ϷDlg*)lpParam;  //��öԻ�����
	FFFFF f;
	//����ֻҪ���� �˿˷�ΧΪ 5-68
	f= for_each_combination(dlg->blue.begin() + 8, dlg->blue.begin() + 14, dlg->blue.begin() + 74, f);
	
	CString temp;  // ����
	uint64_to_cstring(f.getCount1(), temp);
	dlg->GetDlgItem(IDC_blue1)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount2(), temp);
	dlg->GetDlgItem(IDC_blue2)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount3(), temp);
	dlg->GetDlgItem(IDC_blue3)->SetWindowTextW(temp);


	if (f.getCount1()>f.getCount2())
		dlg->GetDlgItem(IDC_blueresult)->SetWindowTextW(_T("�ж�"));
	else
		dlg->GetDlgItem(IDC_blueresult)->SetWindowTextW(_T("ׯ��"));

	// ����ϼ�
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
	dlg->SendMessage(MY_MSG, 0, 0);  //�߳�  ������Ϣ�������� �������Ի�������
	return 0;
}
UINT countYellow(LPVOID lpParam)   // ����
{
	C�˿�����ϷDlg* dlg = (C�˿�����ϷDlg*)lpParam;  //��öԻ�����
	FFFFF f;
	//����ֻҪ���� �˿˷�ΧΪ 5-68
	f = for_each_combination(dlg->yellow.begin() + 15, dlg->yellow.begin() + 21, dlg->yellow.begin()+80,f);
	
	CString temp;  // ����
	uint64_to_cstring(f.getCount1(), temp);
	dlg->GetDlgItem(IDC_yellow1)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount2(), temp);
	dlg->GetDlgItem(IDC_yellow2)->SetWindowTextW(temp);
	uint64_to_cstring(f.getCount3(), temp);
	dlg->GetDlgItem(IDC_yellow3)->SetWindowTextW(temp);


	if(f.getCount1()>f.getCount2())
		dlg->GetDlgItem(IDC_yellowresult)->SetWindowTextW(_T("�ж�"));
	else
		dlg->GetDlgItem(IDC_yellowresult)->SetWindowTextW(_T("ׯ��"));

	// ����ϼ�
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
	dlg->SendMessage(MY_MSG, 0, 0);  //�߳�  ������Ϣ�������� �������Ի�������
	return 0;
}



BOOL C�˿�����ϷDlg::PreTranslateMessage(MSG* pMsg)
{
	// TODO: �ڴ����ר�ô����/����û���
	if (pMsg->message == WM_KEYDOWN)  // If a keydown message
	{
		//���ּ���Ӧ
		if (pMsg->wParam == VK_NUMPAD0 || pMsg->wParam == '0')  // If ����0 pressed
			addData(_T("0"));
		if (pMsg->wParam == VK_NUMPAD1 || pMsg->wParam == '1')  // If ����0 pressed
			addData(_T("1"));
		if (pMsg->wParam == VK_NUMPAD2 || pMsg->wParam == '2')  // If ����0 pressed
			addData(_T("2"));
		if (pMsg->wParam == VK_NUMPAD3 || pMsg->wParam == '3')  // If ����0 pressed
			addData(_T("3"));
		if (pMsg->wParam == VK_NUMPAD4 || pMsg->wParam == '4')  // If ����0 pressed
			addData(_T("4"));
		if (pMsg->wParam == VK_NUMPAD5 || pMsg->wParam == '5')  // If ����0 pressed
			addData(_T("5"));
		if (pMsg->wParam == VK_NUMPAD6 || pMsg->wParam == '6')  // If ����0 pressed
			addData(_T("6"));
		if (pMsg->wParam == VK_NUMPAD7 || pMsg->wParam == '7')  // If ����0 pressed
			addData(_T("7"));
		if (pMsg->wParam == VK_NUMPAD8 || pMsg->wParam == '8')  // If ����0 pressed
			addData(_T("8"));
		if (pMsg->wParam == VK_NUMPAD9 || pMsg->wParam == '9')  // If ����0 pressed
			addData(_T("9"));
		if (pMsg->wParam == VK_BACK)   // backspace�˸�
			OnBnClickedButton11();
		if (pMsg->wParam == VK_DELETE)   //delete���� ���
			clearData();
		if (pMsg->wParam == VK_RETURN)  // enter����  ��ʼ����
			OnBnClickedButton13();
	}
	return CDialogEx::PreTranslateMessage(pMsg);
}
