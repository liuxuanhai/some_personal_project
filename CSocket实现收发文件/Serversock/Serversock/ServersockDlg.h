// ServersockDlg.h : ͷ�ļ�
//

#pragma once
//#include "winsock2.h"
#include "afxsock.h"
#include "windows.h"

//#pragma comment(lib,"WS2_32.lib");

UINT ThreadFunc(LPVOID lpParam);
UINT Thread_Func(LPVOID lpParam);

// CServersockDlg �Ի���
class CServersockDlg : public CDialog
{
// ����
public:
	CServersockDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_SERVERSOCK_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��

// ʵ��
protected:
	CWinThread *pThread;
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
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
