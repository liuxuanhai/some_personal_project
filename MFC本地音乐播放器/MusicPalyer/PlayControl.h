#pragma once 

class CPlayControl
{
public:
	CPlayControl();
	~CPlayControl();
	void Play(CString& strPathName);
	void Resume();
	void Stop();
	void Pause();
	void SetVolume(int iVolume);
	void Reset();
	void SetProgress(int iProgress);
	int  GetLength();
	int  GetCurrentLength();
	CString		CountTime();
	CString		RemainTime();
	HWND GetSafeHwnd();
	int GetTimeSize();

private:
	HWND	m_hAudio;
	BOOL	m_bIsPlaying;
//	CWnd*	m_pMainWnd;
};