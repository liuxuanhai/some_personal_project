
// �����ͼ��ѧͼ����ʾϵͳ.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// C�����ͼ��ѧͼ����ʾϵͳApp:
// �йش����ʵ�֣������ �����ͼ��ѧͼ����ʾϵͳ.cpp
//

class C�����ͼ��ѧͼ����ʾϵͳApp : public CWinApp
{
public:
	C�����ͼ��ѧͼ����ʾϵͳApp();

// ��д
public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern C�����ͼ��ѧͼ����ʾϵͳApp theApp;