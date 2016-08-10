#include "StdAfx.h"
#include "vfw.h"
#pragma comment(lib, "vfw32.lib")
#include "PlayControl.h"

CPlayControl::CPlayControl(): m_hAudio(NULL)
, m_bIsPlaying(FALSE)
{
}

CPlayControl::~CPlayControl()
{
	Reset();
}

void CPlayControl::Play(CString& strPathName)
{
	if (strPathName.Compare("") == 0)
	{
		Reset();
		m_bIsPlaying = FALSE;
		return ;
	}
	if (!m_bIsPlaying)
	{
		Reset();
		m_bIsPlaying = TRUE;
	}

	try
	{
		m_hAudio = MCIWndCreateA(AfxGetMainWnd()->GetSafeHwnd(), AfxGetInstanceHandle(), WS_CHILD | MCIWNDF_NOMENU, strPathName);
	}
	catch(...)
	{
		Reset();
	}

	if (m_hAudio != NULL)
		MCIWndPlay(m_hAudio);
}

void CPlayControl::Resume()
{
	if (m_hAudio != NULL)
		MCIWndResume(m_hAudio);
}

void CPlayControl::Pause()
{
	if (m_hAudio != NULL)
		MCIWndPause(m_hAudio);
}


void CPlayControl::SetVolume(int iVolume)
{
	if (m_hAudio == NULL)
		return ;
	iVolume = iVolume < 0 ? 0 : iVolume;
	iVolume = iVolume > 1000 ? 1000 : iVolume;
	MCIWndSetVolume(m_hAudio, iVolume);
}

void CPlayControl::Stop()
{
	if (m_hAudio != NULL)
		MCIWndStop(m_hAudio);
	m_bIsPlaying = FALSE;
	MCIWndSeek(m_hAudio, 0);
}

void CPlayControl::Reset()
{
	if (m_hAudio != NULL)
	{
		MCIWndDestroy(m_hAudio);
		m_hAudio = NULL;
		m_bIsPlaying = FALSE;
	}
}

HWND CPlayControl::GetSafeHwnd()
{
	return m_hAudio;
} 

void CPlayControl::SetProgress(int iProgress)
{
	if (m_hAudio == NULL)
		return ;
	if (iProgress < 0)
		iProgress = 0;
	MCIWndSeek(m_hAudio, iProgress);
	MCIWndPlay(m_hAudio);
}

int CPlayControl::GetLength()
{
	if (m_hAudio == NULL)
		return 0;
	return MCIWndGetLength(m_hAudio);
}

int CPlayControl::GetCurrentLength()
{
	if (m_hAudio == NULL)
		return 0;
	return MCIWndGetPosition(m_hAudio);
}

//得到当前时间
CString CPlayControl::CountTime()
{
	if (m_hAudio == NULL)
		return "00:00";
	int nTime = MCIWndGetPosition(m_hAudio) / MCIWndGetSpeed(m_hAudio);
	int nMinute = nTime / 60;
	int nSecond = nTime % 60;
	CString strTime;
	if (nMinute < 10)
	{
		if (nSecond < 10)
			strTime.Format("0%d:0%d", nMinute, nSecond);
		else
			strTime.Format("0%d:%d", nMinute, nSecond);
	}
	else
	{
		if (nSecond < 10)
			strTime.Format("%d:0%d", nMinute, nSecond);
		else
			strTime.Format("%d:%d", nMinute, nSecond);
	}
	return strTime;
}

int CPlayControl::GetTimeSize()
{
	return MCIWndGetLength(m_hAudio) / MCIWndGetSpeed(m_hAudio);
}

CString CPlayControl::RemainTime()
{
	if (m_hAudio == NULL)
		return "00:00";
	int nTime = (MCIWndGetLength(m_hAudio) - MCIWndGetPosition(m_hAudio)) / MCIWndGetSpeed(m_hAudio);
	int nMinute = nTime / 60;
	int nSecond = nTime % 60;
	CString strTime;
	if (nMinute < 10)
	{
		if (nSecond < 10)
			strTime.Format("0%d:0%d", nMinute, nSecond);
		else
			strTime.Format("0%d:%d", nMinute, nSecond);
	}
	else
	{
		if (nSecond < 10)
			strTime.Format("%d:0%d", nMinute, nSecond);
		else
			strTime.Format("%d:%d", nMinute, nSecond);
	}
	return strTime;
}