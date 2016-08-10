// MyStatic.cpp : implementation file
//

#include "stdafx.h"
#include "MusicPalyer.h"
#include "MyStatic.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMyStatic

CMyStatic::CMyStatic()
{
}

CMyStatic::~CMyStatic()
{
}


BEGIN_MESSAGE_MAP(CMyStatic, CStatic)
	//{{AFX_MSG_MAP(CMyStatic)
	ON_WM_SETCURSOR()
	ON_WM_CTLCOLOR_REFLECT()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMyStatic message handlers

void CMyStatic::PreSubclassWindow() 
{
	// TODO: Add your specialized code here and/or call the base class
	m_hCursor = ::LoadCursor(NULL, MAKEINTRESOURCE(32649));
	m_Font.CreatePointFont(110, "¿¬Ìå_GB2312", NULL);

	CRect rect;
	GetClientRect(&rect);
	m_Tip.Create(this);
	m_Tip.SetDelayTime(100);
	m_Tip.SetMaxTipWidth(200);
	m_Tip.AddTool(this, "", rect, TIP_ID);
	CStatic::PreSubclassWindow();
}

BOOL CMyStatic::OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message) 
{
	// TODO: Add your message handler code here and/or call default
	::SetCursor(m_hCursor);
	return TRUE;
}

void CMyStatic::SetTipText(CString strTipText)
{
	m_Tip.UpdateTipText(strTipText, this, TIP_ID);
}

BOOL CMyStatic::PreTranslateMessage(MSG* pMsg) 
{
	// TODO: Add your specialized code here and/or call the base class
	m_Tip.RelayEvent(pMsg);
	return CStatic::PreTranslateMessage(pMsg);
}

HBRUSH CMyStatic::CtlColor(CDC* pDC, UINT nCtlColor) 
{
	// TODO: Change any attributes of the DC here
	pDC->SelectObject(&m_Font);
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(0, 255,255));
	// TODO: Return a non-NULL brush if the parent's handler should not be called
	return (HBRUSH)GetStockObject(NULL_BRUSH);
}
