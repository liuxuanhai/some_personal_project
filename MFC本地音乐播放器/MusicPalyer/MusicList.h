#if !defined(AFX_MUSICLIST_H__8BD22400_A1E5_4EFA_BD1A_49D0DD2CB7DE__INCLUDED_)
#define AFX_MUSICLIST_H__8BD22400_A1E5_4EFA_BD1A_49D0DD2CB7DE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MusicList.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CMusicList window

class CMusicList : public CListBox
{
// Construction
public:
	CMusicList();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMusicList)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMusicList();
	void	AddToList(CString strFilePath, int nTimes, std::string time);
	void	AddToFile(CString str, int nTimes/* = 0*/);
	void	AddToFileAndList(CString strFilePath, int nTimes/* = 0*/);
	void    DeleteFile(int nSel);
	void	DeleteAll();
	void	DeleteRepeat();
	void    AddFolder(CString szBuffer);

	void	SortInName();
	void	SortInTimes();
	void	SortInTime();

	CString GetName(CString strFilePath);
	CString GetMusicName(int iIndex);
	int		GetCount();
	CString GetWorkPath();
	int     GetTimes(int nIndex);
	std::string GetTime(int nIndex);

	void	SetTimes(int nIndex);
	void    ReduceTimes(int nIndex);
	BOOL	IsEnable();
	void    InitFile();
	BOOL    IsSupportName(CString strFilePath);

	CString			m_strExePath;//保存当前工作路径
	CStringArray	m_StringArray;

	std::vector<MusicInfo> m_vecArray;
	// Generated message map functions
protected:
	//{{AFX_MSG(CMusicList)
	afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
	//}}AFX_MSG
	afx_msg void OnMenuOpenCurrentPath();
	DECLARE_MESSAGE_MAP()

private:
	std::vector<MusicInfo>::iterator m_it;

	std::multimap<std::string, NameInfo>		m_NameInfo;
	std::multimap<int, TimesInfo>				m_TimesInfo;
	std::multimap<std::string, TimeInfo>		m_TimeInfo;
	std::map<std::string, NameInfo>				m_SingleNameInfo;

	CString FormatTitle(CString strFileName);


};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MUSICLIST_H__8BD22400_A1E5_4EFA_BD1A_49D0DD2CB7DE__INCLUDED_)
