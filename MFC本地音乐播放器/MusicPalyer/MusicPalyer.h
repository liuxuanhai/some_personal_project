// MusicPalyer.h : main header file for the MUSICPALYER application
//

#if !defined(AFX_MUSICPALYER_H__33A29FAA_B562_41A1_8ED2_13978A669E86__INCLUDED_)
#define AFX_MUSICPALYER_H__33A29FAA_B562_41A1_8ED2_13978A669E86__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols
#include <iostream>
#include <fstream>
#include <string>
#include <process.h>
#include <time.h>
#include <vector>
#include <algorithm>
#include <map> //排序用
#include "SkinButton.h"
#include "MyStatic.h"


#define WM_PLAY			WM_USER + 1
#define WM_ICON			WM_USER + 2
#define WM_NOTIFYMESSAGE WM_USER + 3
#define TIP_ID			1
/////////////////////////////////////////////////////////////////////////////
// CMusicPalyerApp:
// See MusicPalyer.cpp for the implementation of this class
//
//保存歌曲信息结构体
typedef struct _MusicInfo
{
	CString strMusic;
	int     nTimes;
	std::string     strTime;
	_MusicInfo(){};
	_MusicInfo(CString str, int times = 0, std::string time = "")
		: strMusic(str)
		, nTimes(times)
		, strTime(time)
	{};
}MusicInfo, *pMusicInfo;

//按名称排序用的结构体
typedef struct _NameInfo
{
	int nTimes;
	std::string strTime;
	_NameInfo(int times = 0, std::string time = " ")
		: nTimes(times)
		, strTime(time)
	{};
}NameInfo, *pNameInfo;

//按播放次数排序用的结构体
typedef struct _TimesInfo
{
	CString strMusic;
	std::string strTime;
	_TimesInfo(){};
	_TimesInfo(CString str, std::string time = "")
		: strMusic(str)
		, strTime(time)
	{};
}TimesInfo, *pTimesInfo;

//按添加时间排序用的结构体
typedef struct _TimeInfo
{
	CString strMusic;
	int     nTimes;
	_TimeInfo(){};
	_TimeInfo(CString str, int times = 0)
		: strMusic(str)
		, nTimes(times)
	{};
}TimeInfo, *pTimeInfo;

class CMusicPalyerApp : public CWinApp
{
public:
	CMusicPalyerApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMusicPalyerApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CMusicPalyerApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	HANDLE m_hMutex;
		
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MUSICPALYER_H__33A29FAA_B562_41A1_8ED2_13978A669E86__INCLUDED_)
