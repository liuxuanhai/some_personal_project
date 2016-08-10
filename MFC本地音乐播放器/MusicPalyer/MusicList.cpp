// MusicList.cpp : implementation file
//

#include "stdafx.h"
#include "MusicPalyer.h"
#include "MusicList.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMusicList

CMusicList::CMusicList()
{
}

CMusicList::~CMusicList()
{
	//m_StringArray.RemoveAll();
	m_vecArray.clear();
}


BEGIN_MESSAGE_MAP(CMusicList, CListBox)
	//{{AFX_MSG_MAP(CMusicList)
	ON_WM_RBUTTONDOWN()
	//}}AFX_MSG_MAP
	ON_COMMAND(IDM_OpenCurrentPath, OnMenuOpenCurrentPath)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMusicList message handlers
//将歌曲添加到列表
void CMusicList::AddToList(CString strFilePath, int nTimes, std::string time = " ")
{
	MusicInfo mTmp(strFilePath, nTimes, time);
	m_vecArray.push_back(mTmp);
	CString strFileName = GetName(strFilePath);
	AddString(FormatTitle(strFileName));
}

//得到歌曲名
CString CMusicList::GetName(CString strFilePath)
{
	CString str;

	int nPos=-1;
	int nOldPos=-1;
	while((nPos=strFilePath.Find("\\",nPos+1))>0)
		nOldPos=nPos;
	str=strFilePath.Right(strFilePath.GetLength()-nOldPos-1);
	strFilePath=str.Left(str.GetLength()-4);  
	
	return strFilePath;
}

//格式化歌曲名
CString CMusicList::FormatTitle(CString strFileName)
{
	CString strTmp;
	int size = m_vecArray.size();
	if (size >= 1 && size <= 9)
		strTmp.Format("0%d  ", size);
	else if (size >= 10 && size <= 99)
		strTmp.Format("%d  ", size);
	else
		strTmp.Format("%d ", size);
	return strTmp + strFileName;
}

//要播放的路径
CString CMusicList::GetMusicName(int iIndex)
{
	if (iIndex < 0)
		iIndex = 0;
	return m_vecArray.at(iIndex).strMusic;
}

//获得歌曲数量
int CMusicList::GetCount()
{
	return m_vecArray.size();
}

//上一曲、下一曲是否能用（多余了）
BOOL CMusicList::IsEnable()
{
	return m_vecArray.size() > 1 ? TRUE :FALSE;
}

//初始化歌曲列表
void CMusicList::InitFile()
{
	m_strExePath = GetWorkPath();
	CString m_strLstPath;
	m_strLstPath = m_strExePath + "\\musiclist.lst";
	std::ifstream ifile(m_strLstPath);
	if (!ifile)
		return ;
	std::string strTmp;
	CString strTmpFilePath;
	int nTimes;
	std::string time;
	int select = 0;
	while (std::getline(ifile, strTmp))
	{
		switch (select)
		{
		case 0:
			strTmpFilePath.Format("%s", strTmp.c_str());
			select = 1;
			break;
		case 1:
			nTimes = atoi(strTmp.c_str());
			select = 2;
			break;
		case 2:
			time = strTmp;
			select = 0;
			break;
		}
		if (select == 0)
			AddToList(strTmpFilePath, nTimes, time);
	}
	ifile.close();
}

//将歌曲路径添加到文件
void CMusicList::AddToFile(CString str, int nTimes = 0)
{
	SYSTEMTIME st;
	GetLocalTime(&st);
	CString strDate, strTime;
	strDate.Format("%4d-%2d-%2d", st.wYear, st.wMonth, st.wDay);
	strTime.Format(" %2d-%2d-%2d", st.wHour, st.wMinute, st.wSecond);
	strTime = strDate + strTime;
	std::string time;
	time = (LPCTSTR)strTime;
	m_vecArray.at(m_vecArray.size()-1).strTime = time;
	CString strLstPath;
	strLstPath = m_strExePath + "\\musiclist.lst";
	std::ofstream ofile(strLstPath, std::ios::app);
	ofile << (LPSTR)(LPCTSTR)str;
	ofile << std::endl;
	ofile << nTimes;
	ofile << std::endl;
	ofile << time;
	ofile << std::endl;
	ofile.close();
}

//获得exe工作路径
CString CMusicList::GetWorkPath()
{
	char path[MAX_PATH];
	GetCurrentDirectory(MAX_PATH, path);
	CString strTmp;
	strTmp.Format("%s", path);
	return strTmp;
}

//将歌曲路径同时添加到文件和列表
void CMusicList::AddToFileAndList(CString strFilePath, int nTimes = 0)
{
	AddToList(strFilePath, nTimes);
	AddToFile(strFilePath, nTimes);
}

//从列表中删除文件
void CMusicList::DeleteFile(int nSel)
{
	m_it = m_vecArray.begin() + nSel;
	m_vecArray.erase(m_it);

	int sup = m_vecArray.size();
	for (int i = nSel; i <= sup; ++ i)
		DeleteString(nSel);
	CString strTmp;
	CString strFilePath;
	CString strFileName;
 	for (int i = nSel; i < sup; ++ i)
 	{
		strFilePath = m_vecArray.at(i).strMusic;
		strFileName = GetName(strFilePath);
		if (i + 1 >= 1 && i + 1 <= 9)
		{
			strTmp.Format("0%d   ", i + 1);
			strFileName = strTmp + strFileName;
			AddString(strFileName);
		}
		else
		{
			strTmp.Format("%d   ", i + 1);
			strFileName = strTmp + strFileName;
			AddString((strFileName));
		}
 	}
}

void CMusicList::DeleteAll()
{
	m_vecArray.clear();
	ResetContent();
}

UINT WINAPI ThreadDelete(void*);

//删除重复的歌曲 并按歌曲名称排序 2014-3-14
//对比而言用map的效率高了不止一点点
void CMusicList::DeleteRepeat()
{
// 	HANDLE hThread;
// 	hThread = (HANDLE)_beginthreadex(NULL, 0, ThreadDelete, (void*)this, 0, NULL);
// 	CloseHandle(hThread);
// 	int nSup = m_vecArray.size();
// 	for (int i = 0; i < nSup; ++ i)
// 	{
// 		for (int j = i + 1; j < nSup; ++ j)
// 		{
// 		//	if (m_StringArray.GetAt(j).Compare(m_StringArray.GetAt(i)) == 0)
// 			if (m_vecArray.at(j).strMusic.Compare(m_vecArray.at(i).strMusic) == 0)
// 			{
// 				DeleteFile(j);
// 				-- nSup;
// 				-- j;
// 			}
// 		}
// 	}
	for (int i = 0; i < m_vecArray.size(); ++ i)
	{
		NameInfo nTmp(m_vecArray.at(i).nTimes, m_vecArray.at(i).strTime);
		m_SingleNameInfo.insert(std::make_pair((LPCTSTR)m_vecArray.at(i).strMusic, nTmp));
	}
	m_vecArray.clear();
	ResetContent();
	std::map<std::string, NameInfo>::iterator it = m_SingleNameInfo.begin();
	for (; it != m_SingleNameInfo.end(); ++ it)
	{	
		CString strTmp;
		strTmp.Format((it->first).c_str());
		AddToList(strTmp, (it->second).nTimes, (it->second).strTime);
	}
	m_SingleNameInfo.clear();
}

//why not???
// UINT WINAPI ThreadDelete(void* lParam)
// {
// 	CMusicList* pList = (CMusicList*)lParam;
// 	int nSup = pList->m_vecArray.size();
// 	for (int i = 0; i < nSup; ++ i)
// 	{
// 		for (int j = i + 1; j < nSup; ++ j)
// 		{
// 			if (pList->m_vecArray.at(j).strMusic.Compare(pList->m_vecArray.at(i).strMusic) == 0)
// 			{
// 				pList->DeleteFile(j);
// 				-- nSup;
// 				-- j;
// 			}
// 		}
// 	}
// 	return 0;
// }

void CMusicList::AddFolder(CString szBuffer)
{
	_chdir(szBuffer);

	HANDLE hFind;
	WIN32_FIND_DATA wfd;
	if ((hFind = FindFirstFile(_T("*.*"), &wfd)) == INVALID_HANDLE_VALUE)
		return ;

	CString strTmp;
	if (!(wfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
	{
		if (IsSupportName(wfd.cFileName))
		{
			strTmp = szBuffer + "\\" + wfd.cFileName;
			AddToFileAndList(strTmp);
		}
	}

	while (FindNextFile(hFind, &wfd))
	{
		if (!(wfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
		{
			if (IsSupportName(wfd.cFileName))
			{
				strTmp = szBuffer + "\\" + wfd.cFileName;//路径要加斜杠
				AddToFileAndList(strTmp);
			}
		}
	}
	FindClose(hFind);
}

BOOL CMusicList::IsSupportName(CString strFilePath)
{
	CString strTmp = strFilePath.Right(4);
	if (strTmp.Compare(".mp3") == 0 || strTmp.Compare(".wav") == 0 || strTmp.Compare(".wma") == 0)//字符串的比较可是区分大小的
		return TRUE;
	return FALSE;
}

void CMusicList::OnRButtonDown(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	SendMessage(WM_LBUTTONDOWN, 0, MAKELPARAM(point.x, point.y));
	SendMessage(WM_LBUTTONUP, 0, MAKELPARAM(point.x, point.y));

	CMenu PopMenu;
	PopMenu.CreatePopupMenu();
	PopMenu.AppendMenu(MF_STRING, IDM_OpenCurrentPath, "打开当前文件路径");
	this->ClientToScreen(&point);
	PopMenu.TrackPopupMenu(TPM_RIGHTBUTTON, point.x, point.y, this);//注意要有父类指针，否则怎么响应消息呢？
	CListBox::OnRButtonDown(nFlags, point);
}

void CMusicList::OnMenuOpenCurrentPath()
{
	int nSel = GetCurSel();
	if (nSel < 0)
		return ;
	CString strPath = GetMusicName(nSel);
	CString strFileName = GetName(strPath);
	int nPos = strFileName.GetLength();
	strPath = strPath.Left(strPath.GetLength() - nPos - 4);
	ShellExecute(NULL, "open", strPath, " ", NULL, SW_SHOW);//如何打开再找到?
}

//2014-3-14 按名称排序
void CMusicList::SortInName()
{
	for (int i = 0; i < m_vecArray.size(); ++ i)
	{
		NameInfo nTmp(m_vecArray.at(i).nTimes, m_vecArray.at(i).strTime);
		m_NameInfo.insert(std::make_pair((LPCTSTR)m_vecArray.at(i).strMusic, nTmp));
	}
	m_vecArray.clear();
	ResetContent();
	std::multimap<std::string, NameInfo>::iterator it = m_NameInfo.begin();
	for (; it != m_NameInfo.end(); ++ it)
	{
		CString strTmp;
		strTmp.Format("%s", (it->first).c_str());
		AddToList(strTmp, (it->second).nTimes, (it->second).strTime);
	}
	m_NameInfo.clear();
}

//2014-3-14 按播放次数排序
void CMusicList::SortInTimes()
{
	for (int i = 0; i < m_vecArray.size(); ++ i)
	{
		TimesInfo tTmp(m_vecArray.at(i).strMusic, m_vecArray.at(i).strTime);
		m_TimesInfo.insert(std::make_pair(m_vecArray.at(i).nTimes, tTmp));
	}
	std::multimap<int, TimesInfo>::reverse_iterator it = m_TimesInfo.rbegin();
	m_vecArray.clear();
	ResetContent();
	for (; it != m_TimesInfo.rend(); ++ it)
		AddToList((it->second).strMusic, it->first, (it->second).strTime);
	m_TimesInfo.clear();
}

//2014-3-14 按添加时间排序
void CMusicList::SortInTime()
{
	for (int i = 0; i < m_vecArray.size(); ++ i)
	{
		TimeInfo tTmp(m_vecArray.at(i).strMusic, m_vecArray.at(i).nTimes);
		m_TimeInfo.insert(std::make_pair(m_vecArray.at(i).strTime, tTmp));
	}
	m_vecArray.clear();
	ResetContent();
	std::multimap<std::string, TimeInfo>::iterator it = m_TimeInfo.begin();
	for (; it != m_TimeInfo.end(); ++ it)
	{
		AddToList((it->second).strMusic, (it->second).nTimes, it->first);
	}
	m_TimeInfo.clear();
}

int CMusicList::GetTimes(int nIndex)
{
	return m_vecArray.at(nIndex).nTimes;
}

std::string CMusicList::GetTime(int nIndex)
{
	return m_vecArray.at(nIndex).strTime;
}

void CMusicList::SetTimes(int nIndex)
{
	++ m_vecArray.at(nIndex).nTimes;
}

//嘿，只有刚初始化时用一次
void CMusicList::ReduceTimes(int nIndex)
{
	-- m_vecArray.at(nIndex).nTimes;
}
