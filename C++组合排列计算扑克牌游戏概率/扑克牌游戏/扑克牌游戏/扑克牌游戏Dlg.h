
// �˿�����ϷDlg.h : ͷ�ļ�
//

#pragma once
#include<vector>
#include <numeric>
#include <cstdint>
// C�˿�����ϷDlg �Ի���
class C�˿�����ϷDlg : public CDialogEx
{
// ����
public:
	C�˿�����ϷDlg(CWnd* pParent = NULL);	// ��׼���캯��

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
	std::vector<int> red;  // ����
	std::vector<int> blue;  // ����
	std::vector<int> yellow;  // ����
	int currentindex;  // ��ǰ����
	CFont m_editFont;   // ����
	void clearData();  // �������
	void addData(CString data);  // �������
	void enableButton(bool flag);  // ʹ�ܰ���
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

	bool redrun, bluerun, yellowrun;  // ��ʶ�߳��Ƿ����н���
	afx_msg LRESULT myMess(WPARAM wParam, LPARAM lParam);  // �Զ�����Ϣ
	std::uint64_t heji1, heji2,heji3;
	afx_msg void OnBnClickedButton14();
	//	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	virtual BOOL PreTranslateMessage(MSG* pMsg);
};
UINT countRed(LPVOID lpParam);   // ����
UINT countBlue(LPVOID lpParam);   // ����
UINT countYellow(LPVOID lpParam);   // ����