// SkinButton.cpp : implementation file
//

#include "stdafx.h"
#include "MusicPalyer.h"
#include "SkinButton.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSkinButton

CSkinButton::CSkinButton()
{
}

CSkinButton::~CSkinButton()
{
}


BEGIN_MESSAGE_MAP(CSkinButton, CButton)
	//{{AFX_MSG_MAP(CSkinButton)
	ON_WM_SETCURSOR()
	ON_WM_MOUSEMOVE()
	ON_WM_TIMER()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSkinButton message handlers
void CSkinButton::Init(UINT nNormalID, UINT nOverID, CString strTipText)
{
	m_nNormalID = nNormalID;
	m_nOverID = nOverID;
	m_pParentWnd = this->GetParent();
	m_Tip.UpdateTipText(strTipText, this, TIP_ID);
	AdjustPosition();
	m_bMouseOver = FALSE;
}

void CSkinButton::SetMyBitmap(UINT nNormalID, UINT nOverID)
{
	m_nNormalID = nNormalID;
	m_nOverID = nOverID;
	Invalidate();
}

void CSkinButton::SetTipText(CString strTipText)
{
	m_Tip.UpdateTipText(strTipText, this, TIP_ID);
}

void CSkinButton::AdjustPosition()
{
	m_bitmap.LoadBitmap(m_nNormalID);
	m_bitmap.GetBitmap(&m_bmp);
	CRect rect;
	GetWindowRect(&rect);
	m_pParentWnd->ScreenToClient(&rect);
	rect.right = rect.left + m_bmp.bmWidth;
	rect.bottom = rect.top + m_bmp.bmHeight;
	MoveWindow(rect, TRUE);
	m_bitmap.DeleteObject();
}


void CSkinButton::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct) 
{
	// TODO: Add your code to draw the specified item
	UINT nID;
	CDC* pDC;
	pDC = CDC::FromHandle(lpDrawItemStruct->hDC);
	UINT nState = lpDrawItemStruct->itemState;

	if (m_bMouseOver && (!(nState & ODS_SELECTED)))
		nID = m_nNormalID;
	else
		nID = m_nOverID;

	CDC memDC;

	memDC.CreateCompatibleDC(pDC);
	m_bitmap.LoadBitmap(nID);
	m_bitmap.GetBitmap(&m_bmp);
	CBitmap* pOldBitmap = memDC.SelectObject(&m_bitmap);
	pDC->BitBlt(0, 0, m_bmp.bmWidth, m_bmp.bmHeight, &memDC, 0, 0, SRCCOPY);
	memDC.SelectObject(pOldBitmap);
	memDC.DeleteDC();
	m_bitmap.DeleteObject();
}

void CSkinButton::PreSubclassWindow() 
{
	// TODO: Add your specialized code here and/or call the base class
	m_hCursor = LoadCursor(NULL, MAKEINTRESOURCE(32649));
	CRect rect(0, 0, 100, 100);

	m_Tip.Create(this);
	m_Tip.SetDelayTime(100);
	m_Tip.SetMaxTipWidth(200);
	m_Tip.AddTool(this, "", rect, TIP_ID);

	CButton::PreSubclassWindow();
}

BOOL CSkinButton::OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message) 
{
	// TODO: Add your message handler code here and/or call default
	::SetCursor(m_hCursor);
	return TRUE;
//	return CButton::OnSetCursor(pWnd, nHitTest, message);
}

BOOL CSkinButton::PreTranslateMessage(MSG* pMsg) 
{
	// TODO: Add your specialized code here and/or call the base class
	m_Tip.RelayEvent(pMsg);
	return CButton::PreTranslateMessage(pMsg);
}

void CSkinButton::OnMouseMove(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	m_bMouseOver = TRUE;
	SetTimer(1, 100, NULL);
	Invalidate();
	OnTimer(1);
	CButton::OnMouseMove(nFlags, point);
}

void CSkinButton::OnTimer(UINT nIDEvent) 
{
	// TODO: Add your message handler code here and/or call default
	POINT point;
	GetCursorPos(&point);
	ScreenToClient(&point);
	CRect rect;
	GetClientRect(rect);
	if (!rect.PtInRect(point))
	{
		KillTimer(1);
		m_bMouseOver = FALSE;
		Invalidate();
	}
	CButton::OnTimer(nIDEvent);
}
