// ClientsockDlg.h : 头文件
//学号：113320081001010 
//专业：11通信与信息系统数字电视技术 
//姓名：雷霄骅

#pragma once

UINT Thread_Send(LPVOID lpParam);
UINT Thread_Recv(LPVOID lpParam);

// CClientsockDlg 对话框
class CClientsockDlg : public CDialog
{
// 构造
public:
	CClientsockDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_CLIENTSOCK_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	CWinThread *pThreadSend;
	CWinThread *pThreadRecv;
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	CSocket Clientsock;
	afx_msg void OnBnClickedConnect();
	afx_msg void OnBnClickedRecv();
	afx_msg void OnBnClickedSend();
	afx_msg void OnBnClickedReadini();
	afx_msg void OnBnClickedAbout();
	CString m_ip;
	int m_port;
	afx_msg void OnBnClickedWriteini();
};
