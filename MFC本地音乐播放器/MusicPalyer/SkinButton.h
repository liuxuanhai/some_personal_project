#if !defined(AFX_SKINBUTTON_H__D71A7C88_79F4_4C79_B94C_9D5DE7B2E7C7__INCLUDED_)
#define AFX_SKINBUTTON_H__D71A7C88_79F4_4C79_B94C_9D5DE7B2E7C7__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SkinButton.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSkinButton window

class CSkinButton : public CButton
{
// Construction
public:
	CSkinButton();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSkinButton)
	public:
	virtual void DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct);
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	protected:
	virtual void PreSubclassWindow();
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CSkinButton();
	void Init(UINT nNormalID, UINT nOverID, CString strTipText);
	void SetMyBitmap(UINT nNormalID, UINT nOverID);
	void SetTipText(CString strTipText);

	// Generated message map functions
protected:
	//{{AFX_MSG(CSkinButton)
	afx_msg BOOL OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnTimer(UINT nIDEvent);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()

private:
	UINT		m_nNormalID;
	UINT		m_nOverID;
	CWnd*		m_pParentWnd;
	CToolTipCtrl m_Tip;
	BOOL		m_bMouseOver;
	CBitmap     m_bitmap;
	BITMAP		m_bmp;
	HCURSOR		m_hCursor;

	void AdjustPosition();
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SKINBUTTON_H__D71A7C88_79F4_4C79_B94C_9D5DE7B2E7C7__INCLUDED_)
