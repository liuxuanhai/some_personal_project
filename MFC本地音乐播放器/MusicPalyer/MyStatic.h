#if !defined(AFX_MYSTATIC_H__FB72B086_F6A9_4610_B140_2FB03997F85C__INCLUDED_)
#define AFX_MYSTATIC_H__FB72B086_F6A9_4610_B140_2FB03997F85C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MyStatic.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CMyStatic window

class CMyStatic : public CStatic
{
// Construction
public:
	CMyStatic();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMyStatic)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	protected:
	virtual void PreSubclassWindow();
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMyStatic();
	void SetTipText(CString strTipText);

	// Generated message map functions
protected:
	//{{AFX_MSG(CMyStatic)
	afx_msg BOOL OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message);
	afx_msg HBRUSH CtlColor(CDC* pDC, UINT nCtlColor);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()

private:
	HCURSOR		m_hCursor;
	CToolTipCtrl m_Tip;
	CFont m_Font;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MYSTATIC_H__FB72B086_F6A9_4610_B140_2FB03997F85C__INCLUDED_)
