
// �����ͼ��ѧͼ����ʾϵͳDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "ͼ��ѧ��ʾϵͳ.h"
#include "ͼ��ѧ��ʾϵͳDlg.h"
#include "afxdialogex.h"

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


// C�����ͼ��ѧͼ����ʾϵͳDlg �Ի���




C�����ͼ��ѧͼ����ʾϵͳDlg::C�����ͼ��ѧͼ����ʾϵͳDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(C�����ͼ��ѧͼ����ʾϵͳDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_codeview = _T("");
}

void C�����ͼ��ѧͼ����ʾϵͳDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_clear, m_clear);
	//  DDX_Control(pDX, IDC_Code, m_code);
	//  DDX_Control(pDX, IDC_codeview, m_codeview);
	//  DDX_Control(pDX, IDC_code, m_code);
	DDX_Control(pDX, IDC_drawarea, m_drewarea);
	DDX_Control(pDX, IDC_show, m_show);
	DDX_Control(pDX, IDC_stop, m_stop);
	//  DDX_Control(pDX, IDC_view, m_view);
	DDX_Text(pDX, IDC_codeview, m_codeview);
}

BEGIN_MESSAGE_MAP(C�����ͼ��ѧͼ����ʾϵͳDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_show, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedshow)
	ON_BN_CLICKED(IDC_clear, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedclear)
	ON_BN_CLICKED(IDC_stop, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedstop)
	ON_MESSAGE(MY_MSG, &C�����ͼ��ѧͼ����ʾϵͳDlg::myMess)  //�Զ�����Ϣ
	ON_MESSAGE(UPDATE_MSG, &C�����ͼ��ѧͼ����ʾϵͳDlg::updateMess)  //�Զ�����Ϣ
	ON_BN_CLICKED(IDC_up, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedup)
	ON_BN_CLICKED(IDC_down, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickeddown)
	ON_BN_CLICKED(IDC_left, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedleft)
	ON_BN_CLICKED(IDC_right, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedright)
	ON_BN_CLICKED(IDC_smaller, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedsmaller)
	ON_BN_CLICKED(IDC_bigger, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedbigger)

	ON_COMMAND(ID_32771, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnDDAֱ��)
	ON_COMMAND(ID_32772, &C�����ͼ��ѧͼ����ʾϵͳDlg::On���ֱ��)
	ON_COMMAND(ID_32773, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBresenhamֱ��)
	ON_COMMAND(ID_32774, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnDDAԲ)
	ON_COMMAND(ID_32775, &C�����ͼ��ѧͼ����ʾϵͳDlg::On���ȽϷ�Բ)
	ON_COMMAND(ID_32776, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBresenhamԲ)
	ON_COMMAND(ID_32777, &C�����ͼ��ѧͼ����ʾϵͳDlg::Onɨ�������)
	ON_COMMAND(ID_32778, &C�����ͼ��ѧͼ����ʾϵͳDlg::On�߶βü�)
	ON_COMMAND(ID_32779, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnHermite����)
	ON_COMMAND(ID_32780, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnSpline����)
	ON_COMMAND(ID_32781, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnBezier����)
	ON_COMMAND(ID_32782, &C�����ͼ��ѧͼ����ʾϵͳDlg::OnB��������)
	ON_COMMAND(ID_32783, &C�����ͼ��ѧͼ����ʾϵͳDlg::Onƽ��)
	ON_COMMAND(ID_32784, &C�����ͼ��ѧͼ����ʾϵͳDlg::On����)
	ON_COMMAND(ID_32785, &C�����ͼ��ѧͼ����ʾϵͳDlg::Onԭ��Գ�)
	ON_COMMAND(ID_32786, &C�����ͼ��ѧͼ����ʾϵͳDlg::On��ת�任)
	ON_WM_LBUTTONUP()
END_MESSAGE_MAP()


// C�����ͼ��ѧͼ����ʾϵͳDlg ��Ϣ�������

BOOL C�����ͼ��ѧͼ����ʾϵͳDlg::OnInitDialog()
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

	selectid=-1;
	CString allstring[22]={
    _T("DDALine"),_T("���ȽϷ�Line"),_T("BresenhamLine"),  _T("DDACircle"),_T("MiddleCircle"),
	_T("BresenhamCircle"),_T("ɨ������㷨"),_T("ֱ�߲ü�"),_T("Hermite����"),_T("spline����"), 
	_T("n��Bezier����"), _T("B��������"),_T("ƽ�Ʊ任"),_T("�����任"),_T("��ת�任"),
	_T("ԭ��ԳƱ任"),_T("���б任"),_T("�����ͶӰ"),_T("б��ͶӰ"),_T("һ��͸��"),
	_T("����͸��"),_T("������ʾ")};
	for(int i=0;i<22;i++) m_ccodepath[i]=allstring[i];

	//��ʼ��ͼƬ�ؼ��Ĵ��� CDC ����
	pWin = GetDlgItem(IDC_drawarea);  // ��ô���
	pWin->GetClientRect(pR);
	pR.left+=10;pR.top+=10;pR.bottom-=10;pR.right-=10;   // ��ͼ����
    pDC = pWin->GetDC();   // ���CDC��ͼ
	MyThread=NULL;  // �̳߳�ʼ��Ϊ0
	srand((unsigned)time( NULL ));   // ��������ӳ�ʼ��
	//��ʼ������� ��������
	xx[0]=(pR.left+pR.right)/2-50;xx[1]=xx[0]+30;xx[2]=xx[1]+50;xx[3]=pR.left;xx[4]=xx[2]-20;
	xx[5]=xx[4]+40;xx[6]=xx[5]+40;xx[7]=xx[1]-10;xx[8]=xx[0]-20;
	yy[0]=(pR.bottom+pR.top)/2-30;yy[1]=yy[0]-20;yy[2]=yy[0]+30;yy[3]=pR.top;yy[4]=yy[1]-30;yy[5]=yy[2]-30;
	yy[6]=pR.bottom-30;yy[7]=yy[2]-10;yy[8]=yy[7]+15;
	controlfunction();
	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

int C�����ͼ��ѧͼ����ʾϵͳDlg::getselectid(CString selectstring)  // ��ѡ�е��ַ����ж����ĸ�id  ʹ��id������Ϊ�˷���
{
	// ����һ���ڵ�   
    CString allstring[22]={
    _T("DDAֱ������"),_T("���ȽϷ�ֱ��"),_T("Bresenham����ֱ��"),  _T("Բ��DDA�㷨"),_T("Բ�����Ƚ��㷨"),
	_T("Բ��Bresenham�㷨"),_T("ɨ�������"),_T("�߶βü�"),_T("Hermite����"),_T("spline����"), 
	_T("n��Bezier����"), _T("����B��������"),_T("ƽ�Ʊ任"),_T("�����任"),_T("��ת�任"),
	_T("ԭ��ԳƱ任"),_T("���б任"),_T("��ƽ��ͶӰ"),_T("бƽ��ͶӰ"),_T("һ��͸��"),
	_T("����͸��"),_T("������ʾ")};
	for(int i=0;i<22;i++)
	{
		if(selectstring==allstring[i])
		{
			return i;
		}
	}
	return -1;
}
void C�����ͼ��ѧͼ����ʾϵͳDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void C�����ͼ��ѧͼ����ʾϵͳDlg::OnPaint()
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
HCURSOR C�����ͼ��ѧͼ����ʾϵͳDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::controlfunction()
{
	OnBnClickedclear();
	m_codeview=_T("");
	codeview();
	if(MyThread!=NULL)   // �̴߳�������ֹ�߳�
	{
		TerminateThread(MyThread->m_hThread , 0);  //��ֹ�߳�
		MyThread=NULL;
	}
	SetDlgItemText(IDC_stop,_T("ֹͣ"));
	GetDlgItem(IDC_show)->EnableWindow(true);
	GetDlgItem(IDC_up)->ShowWindow(false);
	GetDlgItem(IDC_down)->ShowWindow(false);
	GetDlgItem(IDC_left)->ShowWindow(false);
	GetDlgItem(IDC_right)->ShowWindow(false);
	GetDlgItem(IDC_bigger)->ShowWindow(false);
	GetDlgItem(IDC_smaller)->ShowWindow(false);
	GetDlgItem(IDC_show)->ShowWindow(true);  //
	GetDlgItem(IDC_stop)->ShowWindow(true);
	center.x=(pR.left+pR.right)/2; //ƽ�Ʊ任�ĳ�ʼԲ��
	center.y=(pR.top+pR.bottom)/2;
	bilir=50;  // �����仯�ĳ�ʼ�뾶
	dx=0;   //��ת�任�ĳ�ʼ�Ƕ�
	GetDlgItem(IDC_show)->SetWindowTextW(_T("��ʾ"));

	//ԭ��ԳƵ��ʼ��
	yuandianp[0].x=-20;yuandianp[0].y=35;yuandianp[1].x=-50;yuandianp[1].y=15;yuandianp[2].x=-70;yuandianp[2].y=55;
	line.clear();
	UpdateData(false);
}
void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedclear()  // ����
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	//RedrawWindow();
	CBrush brush;
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(0,0,0));
	pDC->SelectObject(&pen);
	brush.CreateSolidBrush(RGB(255,255,255));
	pOldBrush=pDC->SelectObject(&brush);
	pDC->Rectangle(pR.left-10,pR.top-10,pR.right+10,pR.bottom+10);
	pDC->SelectObject(pOldBrush);  // �ָ���ˢ
	brush.DeleteObject();
	pen.DeleteObject();
}

void C�����ͼ��ѧͼ����ʾϵͳDlg::drawLine()   // ����ϵͳ������ֱ��
{
	UpdateData(true);
	pDC->MoveTo(pR.left,pR.top);
	pDC->LineTo(pR.left,pR.top);
	pDC->LineTo(pR.right,pR.bottom);
	UpdateData(false);
}
void C�����ͼ��ѧͼ����ʾϵͳDlg::drawPolygon()   // ����ϵͳ�����������
{
	UpdateData(true);
	//��������
	CPoint p[4];
	for(int i=0;i<3;i++)
	{
		p[i].x=xx[i];
		p[i].y=yy[i];
	}
	p[3]=p[0];
	pDC->Polyline(p,4);  // �����

	//��������
	CPoint pp[7];
	for(int i=3;i<9;i++)
	{
		pp[i-3].x=xx[i];
		pp[i-3].y=yy[i];
	}
	pp[6]=pp[0];
	pDC->Polyline(pp,7);  // ����� Polygon��������
	UpdateData(false);
}
void C�����ͼ��ѧͼ����ʾϵͳDlg::set_Point(float x,float y,float r,int type)  // ���հ뾶��Բ  typeΪ�������
{
	float px=x,py=y;
	switch(type)
	{
		case 0:  //��������
			px=x-r/sqrt(2.0);
			py=y+r/sqrt(2.0);
			pDC->Ellipse(px-r,py-r,px+r,py+r);  //��Բ
			break;
		case 1: //����������
			px=x+r/sqrt(2.0);
			py=y-r/sqrt(2.0);
			pDC->Ellipse(px-r,py-r,px+r,py+r);  //��Բ
			break;
		case 2: //����������
			pDC->Ellipse(px-r,py-r,px+r,py+r);  //��Բ
			break;
		default:
			break;
	}
}

LRESULT C�����ͼ��ѧͼ����ʾϵͳDlg::myMess(WPARAM wParam,LPARAM lParam) // �Զ�����Ϣ �������µ��ʵʱֵ
{
	return 0;
}
LRESULT C�����ͼ��ѧͼ����ʾϵͳDlg::updateMess(WPARAM wParam,LPARAM lParam) // �Զ�����Ϣ �������µ��ʵʱֵ
{
	UpdateData(false);
	return 0;
}

UINT drawDDALine(LPVOID lpParam)   // ����DDALINE
{
	    // TODO: �ڴ���ӿؼ�֪ͨ����������
	// ������ˢ ��������ʷ��ˢ
		C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(255,55,200));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
	//DDA�㷨

	   int xa=dlg->line[0].x,ya=dlg->line[0].y,xb=dlg->line[1].x,yb=dlg->line[1].y;
	   float delta_x, delta_y, x, y,steps;
	   int dx,dy, k;
	   dx=xb-xa;
	   dy=yb-ya;
	   if (abs(dx)>abs(dy))   /*�жϲ���1�ķ���*/
		  steps=abs(dx)/(float)6;      /*steps��Ϊ������*/
		else 	
		  steps=abs (dy)/(float)6;
		delta_x=(float)dx / (float)steps;  /* ֵΪ��1���1/m*/
		delta_y=(float)dy / (float)steps;  /* ֵΪ��1���m*/
		x=xa;
		y=ya;
		dlg->set_Point(x,y,4,rand()%3);  //��ʼ��
		for (k=1; k<=steps; k++)   /*ѭ�������ֱ��*/
		{
			Sleep(100);
			x+=delta_x;
			y+=delta_y;
			/*if(k%2==0) dlg->set_Point(x,y,4,rand()%2);  //����
			else dlg->set_Point(x,y,4,2);  //������*/
			dlg->set_Point(x,y,4,2);  //������ 
			dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
		}
		dlg->pDC->SelectObject(dlg->pOldBrush);  // �ָ���ˢ
		brush.DeleteObject();
		return 0;
}
UINT drawZhudianLine(LPVOID lpParam)  // ���Ƚ�line  �̺߳���
{
	// ������ˢ ��������ʷ��ˢ
		C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(25,255,200));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//���Ƚ�xa=dlg->pR.left,ya=dlg->pR.top,xb=dlg->pR.right,yb=dlg->pR.bottom;
	   int xa=dlg->line[0].x,ya=dlg->line[0].y,xb=dlg->line[1].x,yb=dlg->line[1].y;
	   float delta_x, delta_y, x, y,steps;
	   int dx,dy, k;
	   dx=abs(xb-xa);
	   dy=abs(yb-ya);
		x=xa;
		y=ya;
		dlg->set_Point(x,y,4,2);  //��ʼ�� 4Ϊ�뾶 2Ϊ��ʾ������
		int n=(dx+dy)/(float)4,i,f;
		for(i=0,f=0;i<n;i++)
		{
			Sleep(100);
		   if (f>=0)
		   {
			    x+=4;
				dlg->set_Point(x,y,4,2);
				f-=dy;
		   } 
		   else
		   {
			    y+=4;
				dlg->set_Point(x,y,4,2);
				f+=dx;
		   }
		   dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
		}
		dlg->pDC->SelectObject(dlg->pOldBrush);  // �ָ���ˢ
		brush.DeleteObject();
		return 0;
}

UINT drawBresenhamLine(LPVOID lpParam)   // Bresenham����ֱ��  �̺߳��� 
{
	// ������ˢ ��������ʷ��ˢ
		C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(25,255,20));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//���Ƚ�dlg->line[0].x,ya=dlg->line[0].y,xb=dlg->line[1].x,yb=dlg->line[1].y;
		int x1=dlg->line[0].x,y1=dlg->line[0].y,x2=dlg->line[1].x,y2=dlg->line[1].y;
		float delta_x, delta_y, x=x1, y=y1,steps;
		int dx,dy;
		dx=x2-x1;
		dy=y2-y1;
		int p;
	    int const1,const2,inc=4;
	    dlg->set_Point(x,y,4,2);  //��ʼ�� 4Ϊ�뾶 2Ϊ��ʾ������
        
		p=2*dy-dx;
        const1=2*dy;            /*ע���ʱ����*/
        const2=2*(dy-dx);       /*�仯����ȡֵ. */
        while (x<x2)
        {
			Sleep(100);
            x+=4;
            if (p<0)
                p+=const1;
            else
			{
				y+=inc;
				p+=const2;
				dlg->set_Point(x,y,4,2);
			}
			dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
        }

		dlg->pDC->SelectObject(dlg->pOldBrush);  // �ָ���ˢ
		brush.DeleteObject();
		return 0;
}
UINT drawDDACircle(LPVOID lpParam)        //DDAԲ
{
	   // ������ˢ ��������ʷ��ˢ
		C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(255,60,80));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//DDAԲ
		int x0=(dlg->pR.right+dlg->pR.left)/2,y0=(dlg->pR.top+dlg->pR.bottom)/2,f=0,r=y0-10;  //Բ����뾶
		int x=r+x0,y=y0;
		while(abs(x)>=x0)
			{
				Sleep(200);
				dlg->set_Point(x,y,4,2);
				dlg->set_Point(-x+2*x0,y,4,2);
				dlg->set_Point(-x+2*x0,-y+2*y0,4,2);
				dlg->set_Point(x,-y+2*y0,4,2);
				if(f>=0)
				{
					x-=8;
					f-=2*(x-x0)+8;
				}
				else
				{
					y+=8;
					f+=2*(y-y0)+8;
				}

				dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
			}
		dlg->pDC->SelectObject(dlg->pOldBrush);  // �ָ���ˢ
		brush.DeleteObject();
		return 0;
}
UINT drawZhudianCircle(LPVOID lpParam)        //���Ƚ�
{
	// ������ˢ ��������ʷ��ˢ
		C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(25,50,250));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//DDAԲ
		int x0=(dlg->pR.right+dlg->pR.left)/2,y0=(dlg->pR.top+dlg->pR.bottom)/2,r=y0-10;  //Բ����뾶
		  int x=x0+r,y=r;
		  float f=0.0,F;
		  float dx=6,dy=6;
		  while(x>=x0)
		  {
			Sleep(200);
			if(f>=0)
			{
					x=x-dx;
					y=y;
					f=f-2*dx*(x-x0)+dx*dx;
			}
			else
			{
					x=x;
					y=y+dy;
					f=f+2*dy*(y-y0)+dy*dy;
			}
			dlg->set_Point(x,y,4,2);
			dlg->set_Point(x,2*y0-y,4,2);
			dlg->set_Point(2*x0-x,y,4,2);
			dlg->set_Point(2*x0-x,2*y0-y,4,2);

			dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
		  }
		dlg->pDC->SelectObject(dlg->pOldBrush);  // �ָ���ˢ
		brush.DeleteObject();
		return 0;
}
UINT drawBresenhamCircle(LPVOID lpParam)        //���Ƚ�
{
	C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(25,50,250));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//DDAԲ
		int x0=(dlg->pR.right+dlg->pR.left)/2,y0=(dlg->pR.top+dlg->pR.bottom)/2,r=y0-10;  //Բ����뾶
		//  int x=x0+r,y=r;
		int x, y, p;  
		x=0;
	    y=r;  
	    p=3-2*r;
	    while (x<y)
		{
			Sleep(200);
			dlg->set_Point(x0+x, y0+y,4,2);
			dlg->set_Point(x0-x, y0+y,4,2);
			dlg->set_Point(x0+x, y0-y,4,2);
			dlg->set_Point(x0-x, y0-y,4,2);
			dlg->set_Point(x0+y, y0+x,4,2);
			dlg->set_Point(x0+y, y0+x,4,2);

			dlg->set_Point(x0-y, y0+x,4,2);
			dlg->set_Point(x0+y, y0-x,4,2);
			dlg->set_Point(x0-y, y0-x,4,2);

		    if (p<0) p=p+4*x+6;
			else
			{
				p=p+4*(x-y)+10;
				y-=4;
			}
			x+=4;
			dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
		}

		dlg->pDC->SelectObject(dlg->pOldBrush);  // �ָ���ˢ
		brush.DeleteObject();
		return 0;
}
UINT fillPolygon(LPVOID lpParam)       //�������
{
	C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
    CPen pen,*poldPen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(25,25,255));
	poldPen=dlg->pDC->SelectObject(&pen);
	//��������
   int i,j,k,h;
   int ymax=5000,ymin=0;
   float xjd[10];
   for(j=0;j<=8;j++)  /*�������ζ���������Сֵ*/
	{
		if(dlg->yy[j]>ymax) ymax=dlg->yy[j]; 
		if(dlg->yy[j]<ymin)  ymin=dlg->yy[j];
	}
	
    for(h=ymin;h<=ymax;h+=5)   /*ɨ����ѭ��*/
    {
		Sleep(100);
        k=0;
		for(i=0;i<3;i++)    // ������С������Ƿ��н���
		{
		j=i+1;
		if(j==3) j=0;
			
		if(h>dlg->yy[i]&&h<dlg->yy[j]||h>dlg->yy[j]&&h<dlg->yy[i])    /*ɨ����h����н���*/
        {/*���㽻��*/
            xjd[k++]=(h-dlg->yy[i])*((float)(dlg->xx[i]-dlg->xx[j])/(float)(dlg->yy[i]-dlg->yy[j]))+dlg->xx[i];	
        }
			
		}
		for(i=3;i<9;i++)    // �����ʹ������Ƿ��н���
		{
		j=i+1;
		if(j==9) j=3;
		if(h>dlg->yy[i]&&h<dlg->yy[j]||h>dlg->yy[j]&&h<dlg->yy[i])    /*ɨ����h����н���*/
        {              /*���㽻��*/
            xjd[k++]=(h-dlg->yy[i])*((float)(dlg->xx[i]-dlg->xx[j])/(float)(dlg->yy[i]-dlg->yy[j]))+dlg->xx[i];
        }
		}
		if(k<2) continue;
        for(i=0;i<k-1;i++)  /*��������*/ //ð�ݰ�
        {
            for(j=i+1;j<k;j++)
                if(xjd[i]>xjd[j])
				{
				float t=xjd[i];
				xjd[i]=xjd[j];
				xjd[j]=t;
				}
        }
		 
        for(i=0;i<=k-1;i+=2)   /*ֱ�����*/
        {
			dlg->pDC->MoveTo(xjd[i],h);
			dlg->pDC->LineTo(xjd[i],h); dlg->pDC->LineTo(xjd[i+1],h);

			dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
        }
    }
	dlg->pDC->SelectObject(poldPen);  // �ָ�����
	pen.DeleteObject();
	poldPen=NULL;
	return 0;
}
UINT xianduancaijian(LPVOID lpParam)        //�߶βü��߳�
{
	C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
	Sleep(500);
	CPoint p[5];  // ��������
	p[0].x=dlg->pR.left+50;p[1].x=dlg->pR.right-50;p[2].x=p[1].x;p[3].x=p[0].x;
	p[0].y=dlg->pR.top+40;p[1].y=p[0].y;p[2].y=dlg->pR.bottom-40;p[3].y=p[2].y;p[4]=p[0];
	dlg->pDC->Polyline(p,5);  // �����

	Sleep(500);
	CPoint pline[2];
	pline[0].x=dlg->pR.left;pline[0].y=p[0].y+20;pline[1].x=p[1].x+30;pline[1].y=dlg->pR.bottom;
	dlg->pDC->MoveTo(pline[0]);
	dlg->pDC->LineTo(pline[0]);
	dlg->pDC->LineTo(pline[1]);

	
	Sleep(500);
	dlg->OnBnClickedclear();
	dlg->pDC->Polyline(p,5);  // �����

	CPen pen,*poldPen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,3,RGB(250,25,55));
	poldPen=dlg->pDC->SelectObject(&pen);

	// ����ֱ��
	float k=(float)(pline[1].y-pline[0].y)/(float)(pline[1].x-pline[0].x);  // б��
	float b=pline[1].y-k*pline[1].x;  // b
	
	//�󽻵�
	CPoint p1,p2;  //��������
	p1.x=p[0].x; p1.y=k*p1.x+b;
	p2.y=p[2].y;p2.x=(p2.y-b)/k;
	
	dlg->pDC->MoveTo(p1);
	dlg->pDC->LineTo(p1);
	dlg->pDC->LineTo(p2);


	dlg->pDC->SelectObject(poldPen);  // �ָ�����
	pen.DeleteObject();
	poldPen=NULL;
	return 0;
}
UINT hermitCurve(LPVOID lpParam)        //hermit����
{
	C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(50,25,255));
	dlg->pDC->SelectObject(&pen);

	  int x0=50,y0=50,x1=250,y1=130,x01=200,y01=100,x11=-200,y11=200;
	  float xs=x0,ys=y0;
	  float fh[4];
	  float t=0;
	  float xe,ye;
	  while(t<=1.0001)
		 {
			Sleep(100);					   /*����4�������ǵ��ͺ���*/
			fh[0]=2*t*t*t-3*t*t+1;
			fh[1]=-2*t*t*t+3*t*t;
			fh[2]=t*t*t-2*t*t+t;
			fh[3]=t*t*t-t*t;       /* ���Ӷϵ�*/
			xe=fh[0]*x0+fh[1]*x1+fh[2]*x01+fh[3]*x11;
			ye=fh[0]*y0+fh[1]*y1+fh[2]*y01+fh[3]*y11;
			dlg->pDC->MoveTo(xs,ys);
			dlg->pDC->LineTo(xs,ys);
			dlg->pDC->LineTo(xe,ye);
			xs=xe;
			ys=ye;
			t+=0.05;
			dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
		 }
	pen.DeleteObject();
	return 0;
}
UINT splineCurve(LPVOID lpParam)        //spline���� 
{
	C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(50,25,255));
	dlg->pDC->SelectObject(&pen);
	int x[7]={10,88,146,203,245,282,324};
    int y[7]={10,138,180,42,106,150,90};
	int n=7;
	float a[50],b[50],r[50],t[50],c[50],h[50],u2,u3,v2,v3;
   register int i,x0,y0,x1,y1,j;
   for(i=0;i<n-1;++i)
      h[i]=(float)(x[i+1]-x[i]);
   r[0]=1.0;
   r[n-1]=0.0;
   t[0]=(float)(y[1]-y[0])*3.0/h[0];
   t[n-1]=(float)(y[n-1]-y[n-2])*3.0/h[n-2];
   for(i=1;i<n-1;++i)
      {
         r[i]=h[i-1]/(h[i-1]+h[i]);
         t[i]=3.0*((1-r[i])*(float)(y[i]-y[i-1])/h[i-1]+r[i]*(float)(y[i+1]-y[i])/h[i]);
       }
   a[0]=-r[0]/2.0;
   b[0]=t[0]/2.0;
   for(i=1;i<n;++i)
      {
        a[i]=-r[i]/(2.0+(1.0-r[i])*a[i-1]);
        b[i]=(t[i]-(1.0-r[i])*b[i-1])/(2.0+(1.0-r[i])*a[i-1]);
      }
   c[n-1]=b[n-1];
   for(i=1;i<n;++i)
       {
	 j=n-1-i;
         c[j]=a[j]*c[j+1]+b[j];
       }
   for(i=0;i<n-1;++i)
   {
		if(x[i]+1>=x[i+1])
		{
			dlg->pDC->MoveTo(x[i],y[i]);
			dlg->pDC->LineTo(x[i],y[i]);
			dlg->pDC->LineTo(x[i+1],y[i+1]);
		}
		else
		{
			x0=x[i];
			y0=y[i];
			for(j=x[i]+1;j<=x[i+1];++j)
				{
					Sleep(10);
					u2=((float)(x[i+1]-j)/h[i])*((float)(x[i+1]-j)/h[i]);
					u3=u2*((float)(x[i+1]-j)/h[i]);
					v2=((float)(j-x[i])/h[i])*((float)(j-x[i])/h[i]);
					v3=v2*((float)(j-x[i])/h[i]);
					y1=(int)((3.0*u2-2.0*u3)*y[i]+(3.0*v2-2.0*v3)*y[i+1]+h[i]*c[i]*(u2-u3)-h[i]*c[i+1]*(v2-v3));
   					x1=j;
					dlg->pDC->MoveTo(x0,y0);
					dlg->pDC->LineTo(x0,y0);
					dlg->pDC->LineTo(x1,y1);
					x0=x1;
					y0=y1;
					
					dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
				}
			}
    }
	pen.DeleteObject();
	return 0;
}
void C�����ͼ��ѧͼ����ʾϵͳDlg::drawaline(float x1,float y1,float x2,float y2)  //��һ��ֱ��
{
	pDC->MoveTo(x1,y1);
	pDC->LineTo(x1,y1);
	pDC->LineTo(x2,y2);
}
void C�����ͼ��ѧͼ����ʾϵͳDlg::drawcircle()  //���Ƶ�
{
	int x[7]={10,88,146,203,245,282,324};
	int y[7]={10,138,180,42,106,150,90};
	for(int i=0;i<7;i++)
		set_Point(x[i],y[i],3,2);   // ���
}
float bb(int i,int n,float t)
{
   int k;
   float a=1.0,b=1.0,bh;
   for(k=i+1;i<=n;i++)
     a*=k;
   for(k=1;k<=n-i;k++)
     b*=k;
   bh=a/b;
   for(k=1;k<=i;k++)
      bh*=t;
   for(k=1;k<=n-i;k++)
      bh*=(1.0-t);
   return bh;
}
UINT bezierCurve(LPVOID lpParam)       //bezier����
{
	C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
	int i;
	int x[6]={50,120,180,220,240,280};
	int y[6]={50,130,160,80,60,150};
	for(i=0;i<5;i++)
		dlg->drawaline(x[i], y[i],x[i+1],y[i+1]);

	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,2,RGB(rand()%255,rand()%255,rand()%255));
	dlg->pDC->SelectObject(&pen);
    float px,py,oldpx,oldpy,dt,t,n=200.0;
    dt=1/n;
    for(i=0;i<=n;i++)
    {
		Sleep(30);
        t=i*dt;
		px=x[0]*(1-t)*(1-t)*(1-t)*(1-t)*(1-t)+x[1]*5*(1-t)*(1-t)*(1-t)*(1-t)*t+
			x[2]*10*(1-t)*(1-t)*(1-t)*t*t+x[3]*10*(1-t)*(1-t)*t*t*t+
			x[4]*5*(1-t)*t*t*t*t+x[5]*t*t*t*t*t;
		py=y[0]*(1-t)*(1-t)*(1-t)*(1-t)*(1-t)+y[1]*5*(1-t)*(1-t)*(1-t)*(1-t)*t+
			y[2]*10*(1-t)*(1-t)*(1-t)*t*t+y[3]*10*(1-t)*(1-t)*t*t*t+
			y[4]*5*(1-t)*t*t*t*t+y[5]*t*t*t*t*t;
        if(i==0)
		{
			dlg->pDC->MoveTo(px,py);
			oldpx=px;oldpy=py;
		} else
		{
			dlg->pDC->SelectObject(&pen);
			dlg->drawaline(oldpx,oldpy,px,py);
			oldpx=px;oldpy=py;
		}

		dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
    }
	pen.DeleteObject();
	return 0;
}
float turnx(float x)
{
	return x*3/7+10;
}
float turny(float y)
{
	return y*2/3+10;
}
UINT byangtiaoCurve(LPVOID lpParam)        //b��������
{
	// ������̵߳�ָ��
	C�����ͼ��ѧͼ����ʾϵͳDlg* dlg=(C�����ͼ��ѧͼ����ʾϵͳDlg*)lpParam;
	
	// ��ͼ�Ķ���ε�
	float px[10]={60,95,152,117,225,302,380,318,449,502};
	float py[10]={98,65,54,152,243,98,102,202,248,130};
	float a0,a1,a2,a3,b0,b1,b2,b3;
   int k,x,y,oldx,oldy;
   float i,t,dt;

   // ���ƶ���ο��Ƶ�
   for(k=0;k<10;k++)
   {
     if(k==0)
		dlg->pDC->MoveTo(turnx(px[k]+100),turny(300-py[k]));
     dlg->pDC->LineTo(turnx(px[k]+100),turny(300-py[k]));
   }
   dt=1/(float)10;
   CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,2,RGB(250,125,25));
	dlg->pDC->SelectObject(&pen);
	// B�����㷨
   for(k=0;k<7;k++)
   {
      a0=(px[k]+4*px[k+1]+px[k+2])/6;
      a1=(px[k+2]-px[k])/2;
      a2=(px[k]-2*px[k+1]+px[k+2])/2;
      a3=-(px[k]-3*px[k+1]+3*px[k+2]-px[k+3])/6;

      b0=(py[k]+4*py[k+1]+py[k+2])/6;
      b1=(py[k+2]-py[k])/2;
      b2=(py[k]-2*py[k+1]+py[k+2])/2;
      b3=-(py[k]-3*py[k+1]+3*py[k+2]-py[k+3])/6;

      for(i=0;i<10;i+=0.1)
      {
		 Sleep(15);
         t=i*dt;
         x=100+a0+a1*t+a2*t*t+a3*t*t*t;
         y=300-(b0+b1*t+b2*t*t+b3*t*t*t);
         
		 if(i==0)
		 {
			dlg->pDC->MoveTo(turnx(x),turny(y));
			oldx=x;oldy=y;
		 } else
		 {
			dlg->pDC->SelectObject(&pen);
			dlg->drawaline(turnx(oldx),turny(oldy),turnx(x),turny(y));
			oldx=x;oldy=y;
		 }
		 dlg->SendMessage(MY_MSG,0,0);  //�߳�  ������Ϣ�������� �������Ի�������
      }
    }
	pen.DeleteObject();
	
	return 0;
}



void C�����ͼ��ѧͼ����ʾϵͳDlg::codeview()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	if(selectid>=22||selectid<0) return;  // ������Ч
	CStdioFile file(_T("C���Դ���\\")+m_ccodepath[selectid]+_T(".txt"),CFile::modeRead);  //���ļ�
	CString temp;
	m_codeview=_T("");
	char* old_locale = _strdup( setlocale(LC_CTYPE,NULL) ); 
	setlocale( LC_CTYPE, "chs" );
	while( file.ReadString(temp) )
	{
		m_codeview=m_codeview+temp+_T("\r\n");
	}
	file.Close();
	setlocale( LC_CTYPE, old_locale ); 
	UpdateData(false);
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedstop()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	if(MyThread==NULL) return;
	UpdateData(true);
	CString text;
	GetDlgItemText(IDC_stop,text);
	if(text==_T("ֹͣ"))
	{
		MyThread->SuspendThread();  // ֹͣ�߳�
		SetDlgItemText(IDC_stop,_T("�ָ�"));
	} else if(text==_T("�ָ�"))
	{
		MyThread->ResumeThread(); //�����߳�
		SetDlgItemText(IDC_stop,_T("ֹͣ"));
	}
	UpdateData(false);
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedup()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	OnBnClickedclear();
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	center.y-=10;
	set_Point(center.x,center.y,50,2);
	pen.DeleteObject();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickeddown()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	OnBnClickedclear();
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	center.y+=10;
	set_Point(center.x,center.y,50,2);
	pen.DeleteObject();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedleft()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	OnBnClickedclear();
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	center.x-=10;
	set_Point(center.x,center.y,50,2);
	pen.DeleteObject();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedright()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	OnBnClickedclear();
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	center.x+=10;
	set_Point(center.x,center.y,50,2);
	pen.DeleteObject();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedsmaller()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	OnBnClickedclear();
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	bilir-=10;
	set_Point(center.x,center.y,bilir,2);
	pen.DeleteObject();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::xuanzhuanbianhuan()
{
		OnBnClickedclear();
		int x0=150,y0=100,x1,y1,x2,y2,x3,y3;
		int i,k;
		double rad=0.0174533,ts1;
		double a1[3]={110,60,1},a2[3]={150,20,1},a3[3]={190,60,1};
		double b[3][3];
		CString s;
		GetDlgItem(IDC_show)->GetWindowTextW(s);
		CPen pen; ////����һ����������󣬹���ʱ���û�������
		pen.CreatePen(PS_SOLID,2,RGB(255,0,0));
		pDC->SelectObject(&pen);
		drawaline(x0,y0,a1[0],a1[1]);
		drawaline(a1[0],a1[1],a2[0],a2[1]);
		drawaline(a2[0],a2[1],a3[0],a3[1]);
		drawaline(a3[0],a3[1],x0,y0);
		pen.DeleteObject();
		GetDlgItem(IDC_show)->SetWindowTextW(_T("��ת"));
		if(s==_T("��ת"))
		{
			CPen pen; ////����һ����������󣬹���ʱ���û�������
			pen.CreatePen(PS_SOLID,2,RGB(0,0,0));
			pDC->SelectObject(&pen);
			dx+=90;
			if(dx==360) dx=0;
			x1=a1[0]-x0;y1=a1[1]-y0;x2=a2[0]-x0;y2=a2[1]-y0;x3=a3[0]-x0;y3=a3[1]-y0;
			switch(dx)
			{
				case 90:		
					x1=x3;x2=-y2;y2=0;y3=-y3;
					break;
				case 180:
					x1=-x1;y1=-y1;y2=-y2;y3=-y3;x3=-x3;		
					break;
				case 270:		
					x3=x1;y1=-y1;x2=y2;y2=0;			
					break;
				default:
					break;
			}
			x1+=x0;y1+=y0;x2+=x0;y2+=y0;x3+=x0;y3+=y0;
			drawaline(x0,y0,x1,y1);
			drawaline(x1,y1,x2,y2);
			drawaline(x2,y2,x3,y3);
			drawaline(x3,y3,x0,y0);
			pen.DeleteObject();
		}		
}

void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedbigger()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	OnBnClickedclear();
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	bilir+=10;
	set_Point(center.x,center.y,bilir,2);
	pen.DeleteObject();
}

void C�����ͼ��ѧͼ����ʾϵͳDlg::yuandianduicheng()  //ԭ��ԳƱ任
{
	//ԭ��任
	yuandianp[0].x=-yuandianp[0].x;yuandianp[0].y=-yuandianp[0].y;
	yuandianp[1].x=-yuandianp[1].x;yuandianp[1].y=-yuandianp[1].y;
	yuandianp[2].x=-yuandianp[2].x;yuandianp[2].y=-yuandianp[2].y;
	OnBnClickedclear();
	drawaline(center.x,pR.top,center.x,pR.bottom);
	drawaline(pR.left,center.y,pR.right,center.y);
	CPen pen; ////����һ����������󣬹���ʱ���û�������
	pen.CreatePen(PS_SOLID,2,RGB(155,0,50));
	pDC->SelectObject(&pen);
	drawaline(yuandianp[0].x+center.x,yuandianp[0].y+center.y,yuandianp[1].x+center.x,yuandianp[1].y+center.y);
	drawaline(yuandianp[0].x+center.x,yuandianp[0].y+center.y,yuandianp[2].x+center.x,yuandianp[2].y+center.y);
	drawaline(yuandianp[2].x+center.x,yuandianp[2].y+center.y,yuandianp[1].x+center.x,yuandianp[1].y+center.y);
	pen.DeleteObject();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedview()  // ϵͳ����ֱ�ӻ���
{
	//OnBnClickedclear();  // ����
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	//b�����߶����
	float px[10]={60,95,152,117,225,302,380,318,449,502};
	float py[10]={98,65,54,152,243,98,102,202,248,130};
	//bezier���߶����
	int x[6]={50,120,180,220,240,280};
	int y[6]={50,130,160,80,60,150};
	CPen pen;pen.CreatePen(PS_SOLID,1,RGB(0,0,0));
	switch(selectid)
	{
		case 0:
		case 1:
		case 2:
			drawLine(); //ϵͳ��ֱ��
			break;
		case 6:  // ���ƶ����
			drawPolygon();   // �������
			break;
		case 8:  // ���ƶ����
			set_Point(50,50,4,2);   // ���
			set_Point(250,130,4,2);   // ���
			break;
		case 9: 
			drawcircle();  //���Ƶ�
			break;
		case 11:
			pDC->SelectObject(pen);
			if(MyThread!=NULL)
				MyThread->SuspendThread();  // ֹͣ�߳�
			for(int k=0;k<9;k++)
			{
				drawaline(turnx(px[k]+100),turny(300-py[k]),turnx(px[k+1]+100),turny(300-py[k+1]));
			}
			if(MyThread!=NULL)
				MyThread->ResumeThread();  // ֹͣ�߳�
			break;
		case 10:
			pDC->SelectObject(pen);
			if(MyThread!=NULL)
				MyThread->SuspendThread();  // ֹͣ�߳�
			for(int i=0;i<5;i++)
				drawaline(x[i], y[i],x[i+1],y[i+1]);
			if(MyThread!=NULL)
				MyThread->ResumeThread();  // ֹͣ�߳�
			break;
		default:
			break;
	}
	pen.DeleteObject();
}


CPoint C�����ͼ��ѧͼ����ʾϵͳDlg::cross(CPoint p1,CPoint p2,CPoint p3,CPoint p4)  //������ֱ�߽���
{
	float k1,b1,k2,b2;
	k1=(p1.y-p2.y)/(p1.x-p2.x);  // ��ֱ��1б��
	b1=p1.y-k1*p1.x;   // ��ֱ��1��b

	k2=(p3.y-p4.y)/(p3.x-p4.x);  // ��ֱ��2б��
	b2=p3.y-k2*p3.x;   // ��ֱ��2��b

	float x1,y1;
	x1=(b2-b1)/(k1-k2);
	y1=k1*x1+b1;
	return CPoint(x1,y1);
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBnClickedshow()
{
	//GetDlgItem(IDC_show)->EnableWindow(false);
	switch(selectid)
	{
		case 0:  
			if(line.size()<2) {
				MessageBox(_T("��ѡ����ʼ�����ֹ��(������)"));
				return;
			}
			MyThread=::AfxBeginThread(drawDDALine,this);  // DDA��ֱ��  �����Ի����this�����̲߳���
			break;
		case 1:
			if(line.size()<2) {
				MessageBox(_T("��ѡ����ʼ�����ֹ��(������)"));
				return;
			}
			MyThread=::AfxBeginThread(drawZhudianLine,this);  //���Ƚ�line  
			break;
		case 2:
			if(line.size()<2) {
				MessageBox(_T("��ѡ����ʼ�����ֹ��(������)"));
				return;
			}
			MyThread=::AfxBeginThread(drawBresenhamLine,this);  //BresenhamLine�߳� drawDDACircle
			break;
		case 3:
			MyThread=::AfxBeginThread(drawDDACircle,this);  //drawDDACircle�߳� 
			break;
		case 4:
			MyThread=::AfxBeginThread(drawZhudianCircle,this);  //����߳�  drawBresenhamCircle
			break;
		case 5:
			MyThread=::AfxBeginThread(drawBresenhamCircle,this);  //BresenhamCircle�߳� fillPolygon 
			break;
		case 6:
			drawPolygon();  // �������
			MyThread=::AfxBeginThread(fillPolygon,this);  //fillPolygon�߳�  xianduancaijian
			break;
		case 7:
			MyThread=::AfxBeginThread(xianduancaijian,this);  //xianduancaijian�߳�  hermitCurve
			break;
		case 8:
			MyThread=::AfxBeginThread(hermitCurve,this);  //hermitCurve�߳�  splineCurve 
			break;
		case 9:
			MyThread=::AfxBeginThread(splineCurve,this);  //splineCurve�߳�  bezierCurve  
			break;
		case 10:
			MyThread=::AfxBeginThread(bezierCurve,this);  //bezierCurve�߳�    
			break;
		case 11:
			MyThread=::AfxBeginThread(byangtiaoCurve,this);  //byangtiaoCurve�߳�     
			break;
		case 12:
			GetDlgItem(IDC_up)->ShowWindow(TRUE);
			GetDlgItem(IDC_down)->ShowWindow(TRUE);
			GetDlgItem(IDC_left)->ShowWindow(TRUE);
			GetDlgItem(IDC_right)->ShowWindow(TRUE);
			GetDlgItem(IDC_show)->ShowWindow(false);
			set_Point(center.x,center.y,50,2);
			break;
		case 13:
			GetDlgItem(IDC_bigger)->ShowWindow(TRUE);
			GetDlgItem(IDC_smaller)->ShowWindow(TRUE);
			GetDlgItem(IDC_show)->ShowWindow(false);
			set_Point(center.x,center.y,bilir,2);
			break;
		case 14:
			xuanzhuanbianhuan();  // ��ת�任
			break;
		case 15:
			yuandianduicheng();  // ԭ��Գ�
			break;
		default:
			MessageBox(_T("��ѡ��˵�"));
			break;
	}
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnDDAֱ��()
{
	// TODO: �ڴ���������������
	selectid=0;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::On���ֱ��()
{
	// TODO: �ڴ���������������
	selectid=1;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBresenhamֱ��()
{
	// TODO: �ڴ���������������
	selectid=2;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnDDAԲ()
{
	// TODO: �ڴ���������������
	selectid=3;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::On���ȽϷ�Բ()
{
	// TODO: �ڴ���������������
	selectid=4;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBresenhamԲ()
{
	// TODO: �ڴ���������������
	selectid=5;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::Onɨ�������()
{
	// TODO: �ڴ���������������
	selectid=6;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::On�߶βü�()
{
	// TODO: �ڴ���������������
	selectid=7;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnHermite����()
{
	// TODO: �ڴ���������������
	selectid=8;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnSpline����()
{
	// TODO: �ڴ���������������
	selectid=9;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnBezier����()
{
	// TODO: �ڴ���������������
	selectid=10;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnB��������()
{
	// TODO: �ڴ���������������
	selectid=11;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::Onƽ��()
{
	// TODO: �ڴ���������������
	selectid=12;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::On����()
{
	// TODO: �ڴ���������������
	selectid=13;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::Onԭ��Գ�()
{
	// TODO: �ڴ���������������
	selectid=15;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::On��ת�任()
{
	// TODO: �ڴ���������������
	selectid=14;
	controlfunction();
}


void C�����ͼ��ѧͼ����ʾϵͳDlg::OnLButtonUp(UINT nFlags, CPoint point)
{
	// TODO: �ڴ������Ϣ�����������/�����Ĭ��ֵ
	if(!(selectid==0||selectid==1||selectid==2))
		return;
	if(line.size()>=2)return;  //ֻ��ѡ��������
	UpdateData(true);
	CRect rect;
	pWin->GetWindowRect(&rect);
	this->ScreenToClient(&rect);
	CPoint p(point.x-rect.left,point.y-rect.top);
	if(p.x>pR.left&&p.x<pR.right&&p.y>pR.top&&p.y<pR.bottom)
	{
		set_Point(p.x,p.y,5,0);
		line.push_back(p);
	}
	CDialogEx::OnLButtonUp(nFlags, point);
}
