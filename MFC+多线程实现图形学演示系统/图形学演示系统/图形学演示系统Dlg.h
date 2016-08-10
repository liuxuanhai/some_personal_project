
// 计算机图形学图形演示系统Dlg.h : 头文件
//

#pragma once
#include<cmath>
#include<vector>
#include <locale.h>
// C计算机图形学图形演示系统Dlg 对话框
class C计算机图形学图形演示系统Dlg : public CDialogEx
{
// 构造
public:
	C计算机图形学图形演示系统Dlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_MY_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	CButton m_clear;
	CStatic m_drewarea;
	CButton m_show;
	CButton m_stop;

	CString m_codeview;
	int selectid;   //选中的图形  -1表示选中无效
	int getselectid(CString selectstring);  // 由选中的字符串判断是哪个id  使用id纯粹是为了方便
	CString m_ccodepath[22];
	afx_msg void OnBnClickedshow();
	void drawLine();   // 利用系统函数画直线 
	void drawaline(float x1,float y1,float x2,float y2);  //画一条直线
	void drawcircle();  //绘制点
	void set_Point(float x,float y,float r,int type);  // 按照半径画圆
	afx_msg void OnBnClickedview();
	CWnd *pWin;   // 图片空间的窗口
	CDC *pDC;     //图片控件的CDC 绘图用到
	CRect  pR;    //图片控件的 矩形区域大小
	CBrush *pOldBrush;  // 创建画刷和保存历史画刷
	
	afx_msg void OnBnClickedclear();
	void codeview();          // 显示代码
	CWinThread* MyThread;   //保存 线程
//	afx_msg void OnBnClickedcode();
	afx_msg void OnBnClickedstop();
	afx_msg LRESULT myMess(WPARAM wParam,LPARAM lParam);  // 自定义消息
	afx_msg LRESULT updateMess(WPARAM wParam,LPARAM lParam);  // 自定义消息
	void controlfunction();   // 控制功能操作状态
	int xx[9],yy[9];  // 多边形的点存储
	void drawPolygon();   // 利用系统函数画多边形
	CPoint center;        //平移变换的圆心
	std::vector<CPoint> line;  //直线的点
	void drawpingyibianhuanyuan();   //平移变换画圆
	afx_msg void OnBnClickedup();
	afx_msg void OnBnClickeddown();
	afx_msg void OnBnClickedleft();
	afx_msg void OnBnClickedright();
	int bilir;      //比例变换的半径
	afx_msg void OnBnClickedsmaller();
	afx_msg void OnBnClickedbigger();
	int dx;
	void xuanzhuanbianhuan();   // 旋转变换
	CPoint yuandianp[3];
	void yuandianduicheng();  //原点对称变换
	CPoint cross(CPoint p1,CPoint p2,CPoint p3,CPoint p4);  //求两条直线交点
	afx_msg void OnDDA直线();
	afx_msg void On逐点直线();
	afx_msg void OnBresenham直线();
	afx_msg void OnDDA圆();
	afx_msg void On逐点比较法圆();
	afx_msg void OnBresenham圆();
	afx_msg void On扫描线填充();
	afx_msg void On线段裁剪();
	afx_msg void OnHermite曲线();
	afx_msg void OnSpline曲线();
	afx_msg void OnBezier曲线();
	afx_msg void OnB样条曲线();
	afx_msg void On平移();
	afx_msg void On比例();
	afx_msg void On原点对称();
	afx_msg void On旋转变换();
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
};
UINT drawDDALine(LPVOID lpParam);   // 绘制DDALINE  线程函数
UINT drawZhudianLine(LPVOID lpParam);   // 逐点比较line  线程函数 
UINT drawBresenhamLine(LPVOID lpParam);   // Bresenham生成直线  线程函数 
UINT drawDDACircle(LPVOID lpParam);        //DDA圆
UINT drawZhudianCircle(LPVOID lpParam);        //逐点比较
UINT drawBresenhamCircle(LPVOID lpParam);        //逐点比较
UINT fillPolygon(LPVOID lpParam);        //填充多边形
UINT xianduancaijian(LPVOID lpParam);    //线段裁剪
UINT hermitCurve(LPVOID lpParam);        //hermit曲线 
UINT splineCurve(LPVOID lpParam);        //spline曲线 
UINT bezierCurve(LPVOID lpParam);        //bezier曲线 
UINT byangtiaoCurve(LPVOID lpParam);        //b样条曲线
UINT zhengpingxingtouyingThread(LPVOID lpParam);  //正平行投影
UINT xiepingxingtouyingThread(LPVOID lpParam);  //斜平行投影
UINT yidiantoushi(LPVOID lpParam);        //一点透视投影