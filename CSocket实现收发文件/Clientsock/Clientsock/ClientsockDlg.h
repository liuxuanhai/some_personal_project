// ClientsockDlg.h : ͷ�ļ�
//ѧ�ţ�113320081001010 
//רҵ��11ͨ������Ϣϵͳ���ֵ��Ӽ��� 
//������������

#pragma once

UINT Thread_Send(LPVOID lpParam);
UINT Thread_Recv(LPVOID lpParam);

// CClientsockDlg �Ի���
class CClientsockDlg : public CDialog
{
// ����
public:
	CClientsockDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_CLIENTSOCK_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��


// ʵ��
protected:
	CWinThread *pThreadSend;
	CWinThread *pThreadRecv;
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
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
