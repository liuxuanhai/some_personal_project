// MusicPalyerDlg.h : header file
//

#if !defined(AFX_MUSICPALYERDLG_H__1A01BF7E_E30E_4C88_9E39_AEE35C8D144A__INCLUDED_)
#define AFX_MUSICPALYERDLG_H__1A01BF7E_E30E_4C88_9E39_AEE35C8D144A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "PlayControl.h"
#include "MusicList.h"

/////////////////////////////////////////////////////////////////////////////
// CMusicPalyerDlg dialog

class CMusicPalyerDlg : public CDialog
{
// Construction
public:
	CMusicPalyerDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CMusicPalyerDlg)
	enum { IDD = IDD_MUSICPALYER_DIALOG };
	CSkinButton	m_BtnMainMenu;
	CSkinButton	m_BtnMin;
	CSkinButton	m_BtnHide;
	CSkinButton	m_BtnExit;
	CSkinButton	m_BtnSort;
	CSkinButton	m_BtnDeleteMusic;
	CSkinButton	m_BtnAddMusic;
	CMyStatic	m_StaticPlayMode;
	CSkinButton	m_BtnPlay;
	CSkinButton	m_BtnNext;
	CSkinButton	m_BtnPre;
	CSkinButton	m_BtnStop;
	CMusicList	m_MusicList;
	CSliderCtrl	m_SliderVolume;
	CSliderCtrl	m_SliderProgress;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMusicPalyerDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	virtual LRESULT WindowProc(UINT message, WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CMusicPalyerDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnPlay();
	afx_msg void OnStop();
	afx_msg void OnCustomdrawVolume(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnCustomdrawProgress(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnAddMusic();
	afx_msg void OnDeleteMusic();
	afx_msg void OnDblclkMusicList();
	afx_msg void OnBtnPre();
	afx_msg void OnBtnNext();
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnBtnSort();
	afx_msg void OnMainMnue();
	afx_msg void OnMainAboutApp();
	afx_msg void OnSubStop();
	afx_msg void OnSubPre();
	afx_msg void OnSubNext();
	afx_msg void OnSubAddFile();
	afx_msg void OnSubAdd();
	afx_msg void OnSubPlus();
	afx_msg void OnSubQuiet();
	afx_msg void OnSubSeq();
	afx_msg void OnSubLoop();
	afx_msg void OnSubRandom();
	afx_msg void OnMainExit();
	afx_msg void OnSubContinue();
	afx_msg void OnStaticPlayMode();
	afx_msg void OnBtnExit();
	afx_msg void OnBtnHide();
	afx_msg void OnBtnMinSize();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	//}}AFX_MSG
	afx_msg void OnAddSingle();
	afx_msg void OnMenuAddFile();
	afx_msg LRESULT OnMessagePlay(WPARAM wParam, LPARAM lParam);
	afx_msg void OnMenuDeleteSelect();
	afx_msg void OnMenuDeleteAll();
	afx_msg void OnMenuDeleteRepeat();
	afx_msg void OnMenuSortInName();
	afx_msg void OnMenuSortInTimes();//播放次数
	afx_msg void OnMenuSortInTime(); //播放时间
	afx_msg LRESULT OnMessageNotify(WPARAM wParam, LPARAM lParam);
	DECLARE_MESSAGE_MAP()


private:
	CPlayControl m_PlayControl;		//音乐控制类
	CString m_strFilePath;			//音乐路径
	CString m_strFileName;			//音乐名
	int		m_nCurrentPos;          //当前播放索引
	int		m_nVolume;              //声音大小
	CRect	m_RectCount;
	CRect	m_RectRemain;
	CRect	m_RectMusicName;
	CRect	m_RectPlayMode;
	enum __PlayMode{Single, Seq, Rand}PlayMode;
	enum __PlayControl{Play, Pause, Continue}PlayControl;

	void DrawMyText(CPaintDC& dc);
	void DrawPicture(CPaintDC& dc);
	void InitSize();
	void InitInfo();
	void CreateNotifyIcon();
	void DeleteNotifyIcon();
	void InitButtons();
	int  GetRandomNum();
	void SaveList();
	void GetDropFiles(HDROP hDrop);
	void SaveConfig();
	void ReadConfig();
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MUSICPALYERDLG_H__1A01BF7E_E30E_4C88_9E39_AEE35C8D144A__INCLUDED_)
