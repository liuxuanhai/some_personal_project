// MusicPalyer.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "MusicPalyer.h"
#include "MusicPalyerDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMusicPalyerApp

BEGIN_MESSAGE_MAP(CMusicPalyerApp, CWinApp)
	//{{AFX_MSG_MAP(CMusicPalyerApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMusicPalyerApp construction

CMusicPalyerApp::CMusicPalyerApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CMusicPalyerApp object

CMusicPalyerApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CMusicPalyerApp initialization

BOOL CMusicPalyerApp::InitInstance()
{
	AfxEnableControlContainer();

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.
	m_hMutex = CreateMutex(NULL, FALSE, "“Ù¿÷≤•∑≈∆˜");
	if (GetLastError() == ERROR_ALREADY_EXISTS)
	{
		HWND hwnd = FindWindow(NULL, "“Ù¿÷≤•∑≈∆˜");
		if (hwnd != NULL)
		{
			if (IsWindowVisible(hwnd))
				return FALSE;
			SendMessage(hwnd, WM_NOTIFYMESSAGE, NULL, (LPARAM)WM_LBUTTONDOWN);
			return FALSE;
		}
	}
#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	CMusicPalyerDlg dlg;
	m_pMainWnd = &dlg;
	int nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with OK
	}
	else if (nResponse == IDCANCEL)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with Cancel
	}

	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}
