
// �����ͼ��ѧͼ����ʾϵͳDlg.h : ͷ�ļ�
//

#pragma once
#include<cmath>
#include<vector>
#include <locale.h>
// C�����ͼ��ѧͼ����ʾϵͳDlg �Ի���
class C�����ͼ��ѧͼ����ʾϵͳDlg : public CDialogEx
{
// ����
public:
	C�����ͼ��ѧͼ����ʾϵͳDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_MY_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��


// ʵ��
protected:
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
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
	int selectid;   //ѡ�е�ͼ��  -1��ʾѡ����Ч
	int getselectid(CString selectstring);  // ��ѡ�е��ַ����ж����ĸ�id  ʹ��id������Ϊ�˷���
	CString m_ccodepath[22];
	afx_msg void OnBnClickedshow();
	void drawLine();   // ����ϵͳ������ֱ�� 
	void drawaline(float x1,float y1,float x2,float y2);  //��һ��ֱ��
	void drawcircle();  //���Ƶ�
	void set_Point(float x,float y,float r,int type);  // ���հ뾶��Բ
	afx_msg void OnBnClickedview();
	CWnd *pWin;   // ͼƬ�ռ�Ĵ���
	CDC *pDC;     //ͼƬ�ؼ���CDC ��ͼ�õ�
	CRect  pR;    //ͼƬ�ؼ��� ���������С
	CBrush *pOldBrush;  // ������ˢ�ͱ�����ʷ��ˢ
	
	afx_msg void OnBnClickedclear();
	void codeview();          // ��ʾ����
	CWinThread* MyThread;   //���� �߳�
//	afx_msg void OnBnClickedcode();
	afx_msg void OnBnClickedstop();
	afx_msg LRESULT myMess(WPARAM wParam,LPARAM lParam);  // �Զ�����Ϣ
	afx_msg LRESULT updateMess(WPARAM wParam,LPARAM lParam);  // �Զ�����Ϣ
	void controlfunction();   // ���ƹ��ܲ���״̬
	int xx[9],yy[9];  // ����εĵ�洢
	void drawPolygon();   // ����ϵͳ�����������
	CPoint center;        //ƽ�Ʊ任��Բ��
	std::vector<CPoint> line;  //ֱ�ߵĵ�
	void drawpingyibianhuanyuan();   //ƽ�Ʊ任��Բ
	afx_msg void OnBnClickedup();
	afx_msg void OnBnClickeddown();
	afx_msg void OnBnClickedleft();
	afx_msg void OnBnClickedright();
	int bilir;      //�����任�İ뾶
	afx_msg void OnBnClickedsmaller();
	afx_msg void OnBnClickedbigger();
	int dx;
	void xuanzhuanbianhuan();   // ��ת�任
	CPoint yuandianp[3];
	void yuandianduicheng();  //ԭ��ԳƱ任
	CPoint cross(CPoint p1,CPoint p2,CPoint p3,CPoint p4);  //������ֱ�߽���
	afx_msg void OnDDAֱ��();
	afx_msg void On���ֱ��();
	afx_msg void OnBresenhamֱ��();
	afx_msg void OnDDAԲ();
	afx_msg void On���ȽϷ�Բ();
	afx_msg void OnBresenhamԲ();
	afx_msg void Onɨ�������();
	afx_msg void On�߶βü�();
	afx_msg void OnHermite����();
	afx_msg void OnSpline����();
	afx_msg void OnBezier����();
	afx_msg void OnB��������();
	afx_msg void Onƽ��();
	afx_msg void On����();
	afx_msg void Onԭ��Գ�();
	afx_msg void On��ת�任();
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
};
UINT drawDDALine(LPVOID lpParam);   // ����DDALINE  �̺߳���
UINT drawZhudianLine(LPVOID lpParam);   // ���Ƚ�line  �̺߳��� 
UINT drawBresenhamLine(LPVOID lpParam);   // Bresenham����ֱ��  �̺߳��� 
UINT drawDDACircle(LPVOID lpParam);        //DDAԲ
UINT drawZhudianCircle(LPVOID lpParam);        //���Ƚ�
UINT drawBresenhamCircle(LPVOID lpParam);        //���Ƚ�
UINT fillPolygon(LPVOID lpParam);        //�������
UINT xianduancaijian(LPVOID lpParam);    //�߶βü�
UINT hermitCurve(LPVOID lpParam);        //hermit���� 
UINT splineCurve(LPVOID lpParam);        //spline���� 
UINT bezierCurve(LPVOID lpParam);        //bezier���� 
UINT byangtiaoCurve(LPVOID lpParam);        //b��������
UINT zhengpingxingtouyingThread(LPVOID lpParam);  //��ƽ��ͶӰ
UINT xiepingxingtouyingThread(LPVOID lpParam);  //бƽ��ͶӰ
UINT yidiantoushi(LPVOID lpParam);        //һ��͸��ͶӰ