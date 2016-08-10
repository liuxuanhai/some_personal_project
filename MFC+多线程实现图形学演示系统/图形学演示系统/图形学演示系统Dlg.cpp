
// 计算机图形学图形演示系统Dlg.cpp : 实现文件
//

#include "stdafx.h"
#include "图形学演示系统.h"
#include "图形学演示系统Dlg.h"
#include "afxdialogex.h"

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


// C计算机图形学图形演示系统Dlg 对话框




C计算机图形学图形演示系统Dlg::C计算机图形学图形演示系统Dlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(C计算机图形学图形演示系统Dlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_codeview = _T("");
}

void C计算机图形学图形演示系统Dlg::DoDataExchange(CDataExchange* pDX)
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

BEGIN_MESSAGE_MAP(C计算机图形学图形演示系统Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_show, &C计算机图形学图形演示系统Dlg::OnBnClickedshow)
	ON_BN_CLICKED(IDC_clear, &C计算机图形学图形演示系统Dlg::OnBnClickedclear)
	ON_BN_CLICKED(IDC_stop, &C计算机图形学图形演示系统Dlg::OnBnClickedstop)
	ON_MESSAGE(MY_MSG, &C计算机图形学图形演示系统Dlg::myMess)  //自定义消息
	ON_MESSAGE(UPDATE_MSG, &C计算机图形学图形演示系统Dlg::updateMess)  //自定义消息
	ON_BN_CLICKED(IDC_up, &C计算机图形学图形演示系统Dlg::OnBnClickedup)
	ON_BN_CLICKED(IDC_down, &C计算机图形学图形演示系统Dlg::OnBnClickeddown)
	ON_BN_CLICKED(IDC_left, &C计算机图形学图形演示系统Dlg::OnBnClickedleft)
	ON_BN_CLICKED(IDC_right, &C计算机图形学图形演示系统Dlg::OnBnClickedright)
	ON_BN_CLICKED(IDC_smaller, &C计算机图形学图形演示系统Dlg::OnBnClickedsmaller)
	ON_BN_CLICKED(IDC_bigger, &C计算机图形学图形演示系统Dlg::OnBnClickedbigger)

	ON_COMMAND(ID_32771, &C计算机图形学图形演示系统Dlg::OnDDA直线)
	ON_COMMAND(ID_32772, &C计算机图形学图形演示系统Dlg::On逐点直线)
	ON_COMMAND(ID_32773, &C计算机图形学图形演示系统Dlg::OnBresenham直线)
	ON_COMMAND(ID_32774, &C计算机图形学图形演示系统Dlg::OnDDA圆)
	ON_COMMAND(ID_32775, &C计算机图形学图形演示系统Dlg::On逐点比较法圆)
	ON_COMMAND(ID_32776, &C计算机图形学图形演示系统Dlg::OnBresenham圆)
	ON_COMMAND(ID_32777, &C计算机图形学图形演示系统Dlg::On扫描线填充)
	ON_COMMAND(ID_32778, &C计算机图形学图形演示系统Dlg::On线段裁剪)
	ON_COMMAND(ID_32779, &C计算机图形学图形演示系统Dlg::OnHermite曲线)
	ON_COMMAND(ID_32780, &C计算机图形学图形演示系统Dlg::OnSpline曲线)
	ON_COMMAND(ID_32781, &C计算机图形学图形演示系统Dlg::OnBezier曲线)
	ON_COMMAND(ID_32782, &C计算机图形学图形演示系统Dlg::OnB样条曲线)
	ON_COMMAND(ID_32783, &C计算机图形学图形演示系统Dlg::On平移)
	ON_COMMAND(ID_32784, &C计算机图形学图形演示系统Dlg::On比例)
	ON_COMMAND(ID_32785, &C计算机图形学图形演示系统Dlg::On原点对称)
	ON_COMMAND(ID_32786, &C计算机图形学图形演示系统Dlg::On旋转变换)
	ON_WM_LBUTTONUP()
END_MESSAGE_MAP()


// C计算机图形学图形演示系统Dlg 消息处理程序

BOOL C计算机图形学图形演示系统Dlg::OnInitDialog()
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

	selectid=-1;
	CString allstring[22]={
    _T("DDALine"),_T("逐点比较法Line"),_T("BresenhamLine"),  _T("DDACircle"),_T("MiddleCircle"),
	_T("BresenhamCircle"),_T("扫描填充算法"),_T("直线裁剪"),_T("Hermite曲线"),_T("spline曲线"), 
	_T("n次Bezier曲线"), _T("B样条曲线"),_T("平移变换"),_T("比例变换"),_T("旋转变换"),
	_T("原点对称变换"),_T("错切变换"),_T("正轴测投影"),_T("斜测投影"),_T("一点透视"),
	_T("二点透视"),_T("动画演示")};
	for(int i=0;i<22;i++) m_ccodepath[i]=allstring[i];

	//初始化图片控件的窗口 CDC 区域
	pWin = GetDlgItem(IDC_drawarea);  // 获得窗口
	pWin->GetClientRect(pR);
	pR.left+=10;pR.top+=10;pR.bottom-=10;pR.right-=10;   // 画图区域
    pDC = pWin->GetDC();   // 获得CDC绘图
	MyThread=NULL;  // 线程初始化为0
	srand((unsigned)time( NULL ));   // 随机数种子初始化
	//初始化多边形 构造多边形
	xx[0]=(pR.left+pR.right)/2-50;xx[1]=xx[0]+30;xx[2]=xx[1]+50;xx[3]=pR.left;xx[4]=xx[2]-20;
	xx[5]=xx[4]+40;xx[6]=xx[5]+40;xx[7]=xx[1]-10;xx[8]=xx[0]-20;
	yy[0]=(pR.bottom+pR.top)/2-30;yy[1]=yy[0]-20;yy[2]=yy[0]+30;yy[3]=pR.top;yy[4]=yy[1]-30;yy[5]=yy[2]-30;
	yy[6]=pR.bottom-30;yy[7]=yy[2]-10;yy[8]=yy[7]+15;
	controlfunction();
	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

int C计算机图形学图形演示系统Dlg::getselectid(CString selectstring)  // 由选中的字符串判断是哪个id  使用id纯粹是为了方便
{
	// 插入一级节点   
    CString allstring[22]={
    _T("DDA直线生成"),_T("逐点比较法直线"),_T("Bresenham生成直线"),  _T("圆的DDA算法"),_T("圆的逐点比较算法"),
	_T("圆的Bresenham算法"),_T("扫描线填充"),_T("线段裁剪"),_T("Hermite曲线"),_T("spline曲线"), 
	_T("n次Bezier曲线"), _T("三次B样条曲线"),_T("平移变换"),_T("比例变换"),_T("旋转变换"),
	_T("原点对称变换"),_T("错切变换"),_T("正平行投影"),_T("斜平行投影"),_T("一点透视"),
	_T("二点透视"),_T("动画演示")};
	for(int i=0;i<22;i++)
	{
		if(selectstring==allstring[i])
		{
			return i;
		}
	}
	return -1;
}
void C计算机图形学图形演示系统Dlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void C计算机图形学图形演示系统Dlg::OnPaint()
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
HCURSOR C计算机图形学图形演示系统Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


void C计算机图形学图形演示系统Dlg::controlfunction()
{
	OnBnClickedclear();
	m_codeview=_T("");
	codeview();
	if(MyThread!=NULL)   // 线程存在则终止线程
	{
		TerminateThread(MyThread->m_hThread , 0);  //终止线程
		MyThread=NULL;
	}
	SetDlgItemText(IDC_stop,_T("停止"));
	GetDlgItem(IDC_show)->EnableWindow(true);
	GetDlgItem(IDC_up)->ShowWindow(false);
	GetDlgItem(IDC_down)->ShowWindow(false);
	GetDlgItem(IDC_left)->ShowWindow(false);
	GetDlgItem(IDC_right)->ShowWindow(false);
	GetDlgItem(IDC_bigger)->ShowWindow(false);
	GetDlgItem(IDC_smaller)->ShowWindow(false);
	GetDlgItem(IDC_show)->ShowWindow(true);  //
	GetDlgItem(IDC_stop)->ShowWindow(true);
	center.x=(pR.left+pR.right)/2; //平移变换的初始圆心
	center.y=(pR.top+pR.bottom)/2;
	bilir=50;  // 比例变化的初始半径
	dx=0;   //旋转变换的初始角度
	GetDlgItem(IDC_show)->SetWindowTextW(_T("演示"));

	//原点对称点初始化
	yuandianp[0].x=-20;yuandianp[0].y=35;yuandianp[1].x=-50;yuandianp[1].y=15;yuandianp[2].x=-70;yuandianp[2].y=55;
	line.clear();
	UpdateData(false);
}
void C计算机图形学图形演示系统Dlg::OnBnClickedclear()  // 清屏
{
	// TODO: 在此添加控件通知处理程序代码
	//RedrawWindow();
	CBrush brush;
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,1,RGB(0,0,0));
	pDC->SelectObject(&pen);
	brush.CreateSolidBrush(RGB(255,255,255));
	pOldBrush=pDC->SelectObject(&brush);
	pDC->Rectangle(pR.left-10,pR.top-10,pR.right+10,pR.bottom+10);
	pDC->SelectObject(pOldBrush);  // 恢复画刷
	brush.DeleteObject();
	pen.DeleteObject();
}

void C计算机图形学图形演示系统Dlg::drawLine()   // 利用系统函数画直线
{
	UpdateData(true);
	pDC->MoveTo(pR.left,pR.top);
	pDC->LineTo(pR.left,pR.top);
	pDC->LineTo(pR.right,pR.bottom);
	UpdateData(false);
}
void C计算机图形学图形演示系统Dlg::drawPolygon()   // 利用系统函数画多边形
{
	UpdateData(true);
	//画三边形
	CPoint p[4];
	for(int i=0;i<3;i++)
	{
		p[i].x=xx[i];
		p[i].y=yy[i];
	}
	p[3]=p[0];
	pDC->Polyline(p,4);  // 无填充

	//画六边形
	CPoint pp[7];
	for(int i=3;i<9;i++)
	{
		pp[i-3].x=xx[i];
		pp[i-3].y=yy[i];
	}
	pp[6]=pp[0];
	pDC->Polyline(pp,7);  // 无填充 Polygon这个有填充
	UpdateData(false);
}
void C计算机图形学图形演示系统Dlg::set_Point(float x,float y,float r,int type)  // 按照半径画圆  type为点的类型
{
	float px=x,py=y;
	switch(type)
	{
		case 0:  //点在线上
			px=x-r/sqrt(2.0);
			py=y+r/sqrt(2.0);
			pDC->Ellipse(px-r,py-r,px+r,py+r);  //画圆
			break;
		case 1: //点与线上切
			px=x+r/sqrt(2.0);
			py=y-r/sqrt(2.0);
			pDC->Ellipse(px-r,py-r,px+r,py+r);  //画圆
			break;
		case 2: //点与线下切
			pDC->Ellipse(px-r,py-r,px+r,py+r);  //画圆
			break;
		default:
			break;
	}
}

LRESULT C计算机图形学图形演示系统Dlg::myMess(WPARAM wParam,LPARAM lParam) // 自定义消息 用来更新点的实时值
{
	return 0;
}
LRESULT C计算机图形学图形演示系统Dlg::updateMess(WPARAM wParam,LPARAM lParam) // 自定义消息 用来更新点的实时值
{
	UpdateData(false);
	return 0;
}

UINT drawDDALine(LPVOID lpParam)   // 绘制DDALINE
{
	    // TODO: 在此添加控件通知处理程序代码
	// 创建画刷 并保存历史画刷
		C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(255,55,200));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
	//DDA算法

	   int xa=dlg->line[0].x,ya=dlg->line[0].y,xb=dlg->line[1].x,yb=dlg->line[1].y;
	   float delta_x, delta_y, x, y,steps;
	   int dx,dy, k;
	   dx=xb-xa;
	   dy=yb-ya;
	   if (abs(dx)>abs(dy))   /*判断步长1的方向*/
		  steps=abs(dx)/(float)6;      /*steps作为控制数*/
		else 	
		  steps=abs (dy)/(float)6;
		delta_x=(float)dx / (float)steps;  /* 值为±1或±1/m*/
		delta_y=(float)dy / (float)steps;  /* 值为±1或±m*/
		x=xa;
		y=ya;
		dlg->set_Point(x,y,4,rand()%3);  //起始点
		for (k=1; k<=steps; k++)   /*循环画点成直线*/
		{
			Sleep(100);
			x+=delta_x;
			y+=delta_y;
			/*if(k%2==0) dlg->set_Point(x,y,4,rand()%2);  //相切
			else dlg->set_Point(x,y,4,2);  //在线上*/
			dlg->set_Point(x,y,4,2);  //在线上 
			dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
		}
		dlg->pDC->SelectObject(dlg->pOldBrush);  // 恢复画刷
		brush.DeleteObject();
		return 0;
}
UINT drawZhudianLine(LPVOID lpParam)  // 逐点比较line  线程函数
{
	// 创建画刷 并保存历史画刷
		C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(25,255,200));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//逐点比较xa=dlg->pR.left,ya=dlg->pR.top,xb=dlg->pR.right,yb=dlg->pR.bottom;
	   int xa=dlg->line[0].x,ya=dlg->line[0].y,xb=dlg->line[1].x,yb=dlg->line[1].y;
	   float delta_x, delta_y, x, y,steps;
	   int dx,dy, k;
	   dx=abs(xb-xa);
	   dy=abs(yb-ya);
		x=xa;
		y=ya;
		dlg->set_Point(x,y,4,2);  //起始点 4为半径 2为表示在线上
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
		   dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
		}
		dlg->pDC->SelectObject(dlg->pOldBrush);  // 恢复画刷
		brush.DeleteObject();
		return 0;
}

UINT drawBresenhamLine(LPVOID lpParam)   // Bresenham生成直线  线程函数 
{
	// 创建画刷 并保存历史画刷
		C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(25,255,20));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//逐点比较dlg->line[0].x,ya=dlg->line[0].y,xb=dlg->line[1].x,yb=dlg->line[1].y;
		int x1=dlg->line[0].x,y1=dlg->line[0].y,x2=dlg->line[1].x,y2=dlg->line[1].y;
		float delta_x, delta_y, x=x1, y=y1,steps;
		int dx,dy;
		dx=x2-x1;
		dy=y2-y1;
		int p;
	    int const1,const2,inc=4;
	    dlg->set_Point(x,y,4,2);  //起始点 4为半径 2为表示在线上
        
		p=2*dy-dx;
        const1=2*dy;            /*注意此时误差的*/
        const2=2*(dy-dx);       /*变化参数取值. */
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
			dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
        }

		dlg->pDC->SelectObject(dlg->pOldBrush);  // 恢复画刷
		brush.DeleteObject();
		return 0;
}
UINT drawDDACircle(LPVOID lpParam)        //DDA圆
{
	   // 创建画刷 并保存历史画刷
		C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(255,60,80));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//DDA圆
		int x0=(dlg->pR.right+dlg->pR.left)/2,y0=(dlg->pR.top+dlg->pR.bottom)/2,f=0,r=y0-10;  //圆心与半径
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

				dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
			}
		dlg->pDC->SelectObject(dlg->pOldBrush);  // 恢复画刷
		brush.DeleteObject();
		return 0;
}
UINT drawZhudianCircle(LPVOID lpParam)        //逐点比较
{
	// 创建画刷 并保存历史画刷
		C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(25,50,250));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//DDA圆
		int x0=(dlg->pR.right+dlg->pR.left)/2,y0=(dlg->pR.top+dlg->pR.bottom)/2,r=y0-10;  //圆心与半径
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

			dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
		  }
		dlg->pDC->SelectObject(dlg->pOldBrush);  // 恢复画刷
		brush.DeleteObject();
		return 0;
}
UINT drawBresenhamCircle(LPVOID lpParam)        //逐点比较
{
	C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
		CBrush brush;
		brush.CreateSolidBrush(RGB(25,50,250));
		dlg->pOldBrush=dlg->pDC->SelectObject(&brush); 
		//DDA圆
		int x0=(dlg->pR.right+dlg->pR.left)/2,y0=(dlg->pR.top+dlg->pR.bottom)/2,r=y0-10;  //圆心与半径
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
			dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
		}

		dlg->pDC->SelectObject(dlg->pOldBrush);  // 恢复画刷
		brush.DeleteObject();
		return 0;
}
UINT fillPolygon(LPVOID lpParam)       //填充多边形
{
	C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
    CPen pen,*poldPen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,1,RGB(25,25,255));
	poldPen=dlg->pDC->SelectObject(&pen);
	//多边形填充
   int i,j,k,h;
   int ymax=5000,ymin=0;
   float xjd[10];
   for(j=0;j<=8;j++)  /*计算多边形顶点的最大最小值*/
	{
		if(dlg->yy[j]>ymax) ymax=dlg->yy[j]; 
		if(dlg->yy[j]<ymin)  ymin=dlg->yy[j];
	}
	
    for(h=ymin;h<=ymax;h+=5)   /*扫描线循环*/
    {
		Sleep(100);
        k=0;
		for(i=0;i<3;i++)    // 看看和小多边形是否有交点
		{
		j=i+1;
		if(j==3) j=0;
			
		if(h>dlg->yy[i]&&h<dlg->yy[j]||h>dlg->yy[j]&&h<dlg->yy[i])    /*扫描线h与边有交点*/
        {/*计算交点*/
            xjd[k++]=(h-dlg->yy[i])*((float)(dlg->xx[i]-dlg->xx[j])/(float)(dlg->yy[i]-dlg->yy[j]))+dlg->xx[i];	
        }
			
		}
		for(i=3;i<9;i++)    // 看看和大多边形是否有交点
		{
		j=i+1;
		if(j==9) j=3;
		if(h>dlg->yy[i]&&h<dlg->yy[j]||h>dlg->yy[j]&&h<dlg->yy[i])    /*扫描线h与边有交点*/
        {              /*计算交点*/
            xjd[k++]=(h-dlg->yy[i])*((float)(dlg->xx[i]-dlg->xx[j])/(float)(dlg->yy[i]-dlg->yy[j]))+dlg->xx[i];
        }
		}
		if(k<2) continue;
        for(i=0;i<k-1;i++)  /*交点排序*/ //冒泡吧
        {
            for(j=i+1;j<k;j++)
                if(xjd[i]>xjd[j])
				{
				float t=xjd[i];
				xjd[i]=xjd[j];
				xjd[j]=t;
				}
        }
		 
        for(i=0;i<=k-1;i+=2)   /*直线填充*/
        {
			dlg->pDC->MoveTo(xjd[i],h);
			dlg->pDC->LineTo(xjd[i],h); dlg->pDC->LineTo(xjd[i+1],h);

			dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
        }
    }
	dlg->pDC->SelectObject(poldPen);  // 恢复画笔
	pen.DeleteObject();
	poldPen=NULL;
	return 0;
}
UINT xianduancaijian(LPVOID lpParam)        //线段裁剪线程
{
	C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
	Sleep(500);
	CPoint p[5];  // 画长方形
	p[0].x=dlg->pR.left+50;p[1].x=dlg->pR.right-50;p[2].x=p[1].x;p[3].x=p[0].x;
	p[0].y=dlg->pR.top+40;p[1].y=p[0].y;p[2].y=dlg->pR.bottom-40;p[3].y=p[2].y;p[4]=p[0];
	dlg->pDC->Polyline(p,5);  // 无填充

	Sleep(500);
	CPoint pline[2];
	pline[0].x=dlg->pR.left;pline[0].y=p[0].y+20;pline[1].x=p[1].x+30;pline[1].y=dlg->pR.bottom;
	dlg->pDC->MoveTo(pline[0]);
	dlg->pDC->LineTo(pline[0]);
	dlg->pDC->LineTo(pline[1]);

	
	Sleep(500);
	dlg->OnBnClickedclear();
	dlg->pDC->Polyline(p,5);  // 无填充

	CPen pen,*poldPen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,3,RGB(250,25,55));
	poldPen=dlg->pDC->SelectObject(&pen);

	// 构造直线
	float k=(float)(pline[1].y-pline[0].y)/(float)(pline[1].x-pline[0].x);  // 斜率
	float b=pline[1].y-k*pline[1].x;  // b
	
	//求交点
	CPoint p1,p2;  //两个交点
	p1.x=p[0].x; p1.y=k*p1.x+b;
	p2.y=p[2].y;p2.x=(p2.y-b)/k;
	
	dlg->pDC->MoveTo(p1);
	dlg->pDC->LineTo(p1);
	dlg->pDC->LineTo(p2);


	dlg->pDC->SelectObject(poldPen);  // 恢复画笔
	pen.DeleteObject();
	poldPen=NULL;
	return 0;
}
UINT hermitCurve(LPVOID lpParam)        //hermit曲线
{
	C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,1,RGB(50,25,255));
	dlg->pDC->SelectObject(&pen);

	  int x0=50,y0=50,x1=250,y1=130,x01=200,y01=100,x11=-200,y11=200;
	  float xs=x0,ys=y0;
	  float fh[4];
	  float t=0;
	  float xe,ye;
	  while(t<=1.0001)
		 {
			Sleep(100);					   /*下面4个方程是调和函数*/
			fh[0]=2*t*t*t-3*t*t+1;
			fh[1]=-2*t*t*t+3*t*t;
			fh[2]=t*t*t-2*t*t+t;
			fh[3]=t*t*t-t*t;       /* 连接断点*/
			xe=fh[0]*x0+fh[1]*x1+fh[2]*x01+fh[3]*x11;
			ye=fh[0]*y0+fh[1]*y1+fh[2]*y01+fh[3]*y11;
			dlg->pDC->MoveTo(xs,ys);
			dlg->pDC->LineTo(xs,ys);
			dlg->pDC->LineTo(xe,ye);
			xs=xe;
			ys=ye;
			t+=0.05;
			dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
		 }
	pen.DeleteObject();
	return 0;
}
UINT splineCurve(LPVOID lpParam)        //spline曲线 
{
	C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
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
					
					dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
				}
			}
    }
	pen.DeleteObject();
	return 0;
}
void C计算机图形学图形演示系统Dlg::drawaline(float x1,float y1,float x2,float y2)  //画一条直线
{
	pDC->MoveTo(x1,y1);
	pDC->LineTo(x1,y1);
	pDC->LineTo(x2,y2);
}
void C计算机图形学图形演示系统Dlg::drawcircle()  //绘制点
{
	int x[7]={10,88,146,203,245,282,324};
	int y[7]={10,138,180,42,106,150,90};
	for(int i=0;i<7;i++)
		set_Point(x[i],y[i],3,2);   // 绘点
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
UINT bezierCurve(LPVOID lpParam)       //bezier曲线
{
	C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
	int i;
	int x[6]={50,120,180,220,240,280};
	int y[6]={50,130,160,80,60,150};
	for(i=0;i<5;i++)
		dlg->drawaline(x[i], y[i],x[i+1],y[i+1]);

	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
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

		dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
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
UINT byangtiaoCurve(LPVOID lpParam)        //b样条曲线
{
	// 获得主线程的指针
	C计算机图形学图形演示系统Dlg* dlg=(C计算机图形学图形演示系统Dlg*)lpParam;
	
	// 绘图的多边形点
	float px[10]={60,95,152,117,225,302,380,318,449,502};
	float py[10]={98,65,54,152,243,98,102,202,248,130};
	float a0,a1,a2,a3,b0,b1,b2,b3;
   int k,x,y,oldx,oldy;
   float i,t,dt;

   // 绘制多边形控制点
   for(k=0;k<10;k++)
   {
     if(k==0)
		dlg->pDC->MoveTo(turnx(px[k]+100),turny(300-py[k]));
     dlg->pDC->LineTo(turnx(px[k]+100),turny(300-py[k]));
   }
   dt=1/(float)10;
   CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,2,RGB(250,125,25));
	dlg->pDC->SelectObject(&pen);
	// B样条算法
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
		 dlg->SendMessage(MY_MSG,0,0);  //线程  发送消息给主窗口 更新主对话框数据
      }
    }
	pen.DeleteObject();
	
	return 0;
}



void C计算机图形学图形演示系统Dlg::codeview()
{
	// TODO: 在此添加控件通知处理程序代码
	if(selectid>=22||selectid<0) return;  // 控制有效
	CStdioFile file(_T("C语言代码\\")+m_ccodepath[selectid]+_T(".txt"),CFile::modeRead);  //打开文件
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


void C计算机图形学图形演示系统Dlg::OnBnClickedstop()
{
	// TODO: 在此添加控件通知处理程序代码
	if(MyThread==NULL) return;
	UpdateData(true);
	CString text;
	GetDlgItemText(IDC_stop,text);
	if(text==_T("停止"))
	{
		MyThread->SuspendThread();  // 停止线程
		SetDlgItemText(IDC_stop,_T("恢复"));
	} else if(text==_T("恢复"))
	{
		MyThread->ResumeThread(); //唤醒线程
		SetDlgItemText(IDC_stop,_T("停止"));
	}
	UpdateData(false);
}


void C计算机图形学图形演示系统Dlg::OnBnClickedup()
{
	// TODO: 在此添加控件通知处理程序代码
	OnBnClickedclear();
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	center.y-=10;
	set_Point(center.x,center.y,50,2);
	pen.DeleteObject();
}


void C计算机图形学图形演示系统Dlg::OnBnClickeddown()
{
	// TODO: 在此添加控件通知处理程序代码
	OnBnClickedclear();
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	center.y+=10;
	set_Point(center.x,center.y,50,2);
	pen.DeleteObject();
}


void C计算机图形学图形演示系统Dlg::OnBnClickedleft()
{
	// TODO: 在此添加控件通知处理程序代码
	OnBnClickedclear();
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	center.x-=10;
	set_Point(center.x,center.y,50,2);
	pen.DeleteObject();
}


void C计算机图形学图形演示系统Dlg::OnBnClickedright()
{
	// TODO: 在此添加控件通知处理程序代码
	OnBnClickedclear();
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	center.x+=10;
	set_Point(center.x,center.y,50,2);
	pen.DeleteObject();
}


void C计算机图形学图形演示系统Dlg::OnBnClickedsmaller()
{
	// TODO: 在此添加控件通知处理程序代码
	OnBnClickedclear();
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	bilir-=10;
	set_Point(center.x,center.y,bilir,2);
	pen.DeleteObject();
}


void C计算机图形学图形演示系统Dlg::xuanzhuanbianhuan()
{
		OnBnClickedclear();
		int x0=150,y0=100,x1,y1,x2,y2,x3,y3;
		int i,k;
		double rad=0.0174533,ts1;
		double a1[3]={110,60,1},a2[3]={150,20,1},a3[3]={190,60,1};
		double b[3][3];
		CString s;
		GetDlgItem(IDC_show)->GetWindowTextW(s);
		CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
		pen.CreatePen(PS_SOLID,2,RGB(255,0,0));
		pDC->SelectObject(&pen);
		drawaline(x0,y0,a1[0],a1[1]);
		drawaline(a1[0],a1[1],a2[0],a2[1]);
		drawaline(a2[0],a2[1],a3[0],a3[1]);
		drawaline(a3[0],a3[1],x0,y0);
		pen.DeleteObject();
		GetDlgItem(IDC_show)->SetWindowTextW(_T("旋转"));
		if(s==_T("旋转"))
		{
			CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
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

void C计算机图形学图形演示系统Dlg::OnBnClickedbigger()
{
	// TODO: 在此添加控件通知处理程序代码
	OnBnClickedclear();
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,1,RGB(255,0,0));
	pDC->SelectObject(&pen);
	bilir+=10;
	set_Point(center.x,center.y,bilir,2);
	pen.DeleteObject();
}

void C计算机图形学图形演示系统Dlg::yuandianduicheng()  //原点对称变换
{
	//原点变换
	yuandianp[0].x=-yuandianp[0].x;yuandianp[0].y=-yuandianp[0].y;
	yuandianp[1].x=-yuandianp[1].x;yuandianp[1].y=-yuandianp[1].y;
	yuandianp[2].x=-yuandianp[2].x;yuandianp[2].y=-yuandianp[2].y;
	OnBnClickedclear();
	drawaline(center.x,pR.top,center.x,pR.bottom);
	drawaline(pR.left,center.y,pR.right,center.y);
	CPen pen; ////建立一个画笔类对象，构造时设置画笔属性
	pen.CreatePen(PS_SOLID,2,RGB(155,0,50));
	pDC->SelectObject(&pen);
	drawaline(yuandianp[0].x+center.x,yuandianp[0].y+center.y,yuandianp[1].x+center.x,yuandianp[1].y+center.y);
	drawaline(yuandianp[0].x+center.x,yuandianp[0].y+center.y,yuandianp[2].x+center.x,yuandianp[2].y+center.y);
	drawaline(yuandianp[2].x+center.x,yuandianp[2].y+center.y,yuandianp[1].x+center.x,yuandianp[1].y+center.y);
	pen.DeleteObject();
}


void C计算机图形学图形演示系统Dlg::OnBnClickedview()  // 系统函数直接绘制
{
	//OnBnClickedclear();  // 清屏
	// TODO: 在此添加控件通知处理程序代码
	//b样曲线多边形
	float px[10]={60,95,152,117,225,302,380,318,449,502};
	float py[10]={98,65,54,152,243,98,102,202,248,130};
	//bezier曲线多边形
	int x[6]={50,120,180,220,240,280};
	int y[6]={50,130,160,80,60,150};
	CPen pen;pen.CreatePen(PS_SOLID,1,RGB(0,0,0));
	switch(selectid)
	{
		case 0:
		case 1:
		case 2:
			drawLine(); //系统画直线
			break;
		case 6:  // 绘制多边形
			drawPolygon();   // 画多边形
			break;
		case 8:  // 绘制多边形
			set_Point(50,50,4,2);   // 绘点
			set_Point(250,130,4,2);   // 绘点
			break;
		case 9: 
			drawcircle();  //绘制点
			break;
		case 11:
			pDC->SelectObject(pen);
			if(MyThread!=NULL)
				MyThread->SuspendThread();  // 停止线程
			for(int k=0;k<9;k++)
			{
				drawaline(turnx(px[k]+100),turny(300-py[k]),turnx(px[k+1]+100),turny(300-py[k+1]));
			}
			if(MyThread!=NULL)
				MyThread->ResumeThread();  // 停止线程
			break;
		case 10:
			pDC->SelectObject(pen);
			if(MyThread!=NULL)
				MyThread->SuspendThread();  // 停止线程
			for(int i=0;i<5;i++)
				drawaline(x[i], y[i],x[i+1],y[i+1]);
			if(MyThread!=NULL)
				MyThread->ResumeThread();  // 停止线程
			break;
		default:
			break;
	}
	pen.DeleteObject();
}


CPoint C计算机图形学图形演示系统Dlg::cross(CPoint p1,CPoint p2,CPoint p3,CPoint p4)  //求两条直线交点
{
	float k1,b1,k2,b2;
	k1=(p1.y-p2.y)/(p1.x-p2.x);  // 求直线1斜率
	b1=p1.y-k1*p1.x;   // 求直线1的b

	k2=(p3.y-p4.y)/(p3.x-p4.x);  // 求直线2斜率
	b2=p3.y-k2*p3.x;   // 求直线2的b

	float x1,y1;
	x1=(b2-b1)/(k1-k2);
	y1=k1*x1+b1;
	return CPoint(x1,y1);
}


void C计算机图形学图形演示系统Dlg::OnBnClickedshow()
{
	//GetDlgItem(IDC_show)->EnableWindow(false);
	switch(selectid)
	{
		case 0:  
			if(line.size()<2) {
				MessageBox(_T("请选择起始点和终止点(鼠标左键)"));
				return;
			}
			MyThread=::AfxBeginThread(drawDDALine,this);  // DDA画直线  把主对话框的this传给线程操作
			break;
		case 1:
			if(line.size()<2) {
				MessageBox(_T("请选择起始点和终止点(鼠标左键)"));
				return;
			}
			MyThread=::AfxBeginThread(drawZhudianLine,this);  //逐点比较line  
			break;
		case 2:
			if(line.size()<2) {
				MessageBox(_T("请选择起始点和终止点(鼠标左键)"));
				return;
			}
			MyThread=::AfxBeginThread(drawBresenhamLine,this);  //BresenhamLine线程 drawDDACircle
			break;
		case 3:
			MyThread=::AfxBeginThread(drawDDACircle,this);  //drawDDACircle线程 
			break;
		case 4:
			MyThread=::AfxBeginThread(drawZhudianCircle,this);  //逐点线程  drawBresenhamCircle
			break;
		case 5:
			MyThread=::AfxBeginThread(drawBresenhamCircle,this);  //BresenhamCircle线程 fillPolygon 
			break;
		case 6:
			drawPolygon();  // 画多边形
			MyThread=::AfxBeginThread(fillPolygon,this);  //fillPolygon线程  xianduancaijian
			break;
		case 7:
			MyThread=::AfxBeginThread(xianduancaijian,this);  //xianduancaijian线程  hermitCurve
			break;
		case 8:
			MyThread=::AfxBeginThread(hermitCurve,this);  //hermitCurve线程  splineCurve 
			break;
		case 9:
			MyThread=::AfxBeginThread(splineCurve,this);  //splineCurve线程  bezierCurve  
			break;
		case 10:
			MyThread=::AfxBeginThread(bezierCurve,this);  //bezierCurve线程    
			break;
		case 11:
			MyThread=::AfxBeginThread(byangtiaoCurve,this);  //byangtiaoCurve线程     
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
			xuanzhuanbianhuan();  // 旋转变换
			break;
		case 15:
			yuandianduicheng();  // 原点对称
			break;
		default:
			MessageBox(_T("请选择菜单"));
			break;
	}
}


void C计算机图形学图形演示系统Dlg::OnDDA直线()
{
	// TODO: 在此添加命令处理程序代码
	selectid=0;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::On逐点直线()
{
	// TODO: 在此添加命令处理程序代码
	selectid=1;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::OnBresenham直线()
{
	// TODO: 在此添加命令处理程序代码
	selectid=2;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::OnDDA圆()
{
	// TODO: 在此添加命令处理程序代码
	selectid=3;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::On逐点比较法圆()
{
	// TODO: 在此添加命令处理程序代码
	selectid=4;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::OnBresenham圆()
{
	// TODO: 在此添加命令处理程序代码
	selectid=5;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::On扫描线填充()
{
	// TODO: 在此添加命令处理程序代码
	selectid=6;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::On线段裁剪()
{
	// TODO: 在此添加命令处理程序代码
	selectid=7;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::OnHermite曲线()
{
	// TODO: 在此添加命令处理程序代码
	selectid=8;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::OnSpline曲线()
{
	// TODO: 在此添加命令处理程序代码
	selectid=9;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::OnBezier曲线()
{
	// TODO: 在此添加命令处理程序代码
	selectid=10;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::OnB样条曲线()
{
	// TODO: 在此添加命令处理程序代码
	selectid=11;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::On平移()
{
	// TODO: 在此添加命令处理程序代码
	selectid=12;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::On比例()
{
	// TODO: 在此添加命令处理程序代码
	selectid=13;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::On原点对称()
{
	// TODO: 在此添加命令处理程序代码
	selectid=15;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::On旋转变换()
{
	// TODO: 在此添加命令处理程序代码
	selectid=14;
	controlfunction();
}


void C计算机图形学图形演示系统Dlg::OnLButtonUp(UINT nFlags, CPoint point)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值
	if(!(selectid==0||selectid==1||selectid==2))
		return;
	if(line.size()>=2)return;  //只能选择两个点
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
