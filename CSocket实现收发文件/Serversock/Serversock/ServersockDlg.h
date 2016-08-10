// ServersockDlg.h : 头文件
//

#pragma once
//#include "winsock2.h"
#include "afxsock.h"
#include "windows.h"

//#pragma comment(lib,"WS2_32.lib");

UINT ThreadFunc(LPVOID lpParam);
UINT Thread_Func(LPVOID lpParam);

// CServersockDlg 对话框
class CServersockDlg : public CDialog
{
// 构造
public:
	CServersockDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_SERVERSOCK_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持

// 实现
protected:
	CWinThread *pThread;
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	
	afx_msg void OnBnClickedStart();
	afx_msg void OnBnClickedButton4();
	afx_msg void OnBnClickedChoose();
	afx_msg void OnBnClickedSend();
	afx_msg void OnBnClickedRecvdata();
	afx_msg void OnBnClickedAbout();
	int m_port;
	CString m_ip;
	afx_msg void OnBnClickedWriteini();
	afx_msg void OnBnClickedReadini();
};
