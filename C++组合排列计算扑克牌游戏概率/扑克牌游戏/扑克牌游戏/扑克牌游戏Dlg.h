
// 扑克牌游戏Dlg.h : 头文件
//

#pragma once
#include<vector>
#include <numeric>
#include <cstdint>
// C扑克牌游戏Dlg 对话框
class C扑克牌游戏Dlg : public CDialogEx
{
// 构造
public:
	C扑克牌游戏Dlg(CWnd* pParent = NULL);	// 标准构造函数

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
	std::vector<int> red;  // 红组
	std::vector<int> blue;  // 蓝组
	std::vector<int> yellow;  // 黄组
	int currentindex;  // 当前索引
	CFont m_editFont;   // 字体
	void clearData();  // 清空数据
	void addData(CString data);  // 添加数据
	void enableButton(bool flag);  // 使能按键
	afx_msg void OnBnClickedButton12();
	afx_msg void OnEnChangeEdit80();
	afx_msg void OnBnClickedButton1();
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedButton3();
	afx_msg void OnBnClickedButton4();
	afx_msg void OnBnClickedButton5();
	afx_msg void OnBnClickedButton6();
	afx_msg void OnBnClickedButton7();
	afx_msg void OnBnClickedButton8();
	afx_msg void OnBnClickedButton9();
	afx_msg void OnBnClickedButton10();
	afx_msg void OnBnClickedButton13();
	afx_msg void OnBnClickedButton11();

	bool redrun, bluerun, yellowrun;  // 标识线程是否运行结束
	afx_msg LRESULT myMess(WPARAM wParam, LPARAM lParam);  // 自定义消息
	std::uint64_t heji1, heji2,heji3;
	afx_msg void OnBnClickedButton14();
	//	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	virtual BOOL PreTranslateMessage(MSG* pMsg);
};
UINT countRed(LPVOID lpParam);   // 红组
UINT countBlue(LPVOID lpParam);   // 蓝组
UINT countYellow(LPVOID lpParam);   // 黄组