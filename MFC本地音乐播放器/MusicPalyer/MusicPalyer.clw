; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CMusicPalyerDlg
LastTemplate=CStatic
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "MusicPalyer.h"

ClassCount=6
Class1=CMusicPalyerApp
Class2=CMusicPalyerDlg
Class3=CAboutDlg

ResourceCount=4
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Class4=CMusicList
Resource3=IDD_MUSICPALYER_DIALOG
Class5=CSkinButton
Class6=CMyStatic
Resource4=IDR_MainMenu

[CLS:CMusicPalyerApp]
Type=0
HeaderFile=MusicPalyer.h
ImplementationFile=MusicPalyer.cpp
Filter=N

[CLS:CMusicPalyerDlg]
Type=0
HeaderFile=MusicPalyerDlg.h
ImplementationFile=MusicPalyerDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=CMusicPalyerDlg

[CLS:CAboutDlg]
Type=0
HeaderFile=MusicPalyerDlg.h
ImplementationFile=MusicPalyerDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_MUSICPALYER_DIALOG]
Type=1
Class=CMusicPalyerDlg
ControlCount=15
Control1=IDC_MainMenu,button,1342242827
Control2=IDC_Play,button,1342242827
Control3=IDC_Stop,button,1342242827
Control4=IDC_Volume,msctls_trackbar32,1342242840
Control5=IDC_Progress,msctls_trackbar32,1342242840
Control6=IDC_MusicList,listbox,1345388801
Control7=IDC_AddMusic,button,1342242827
Control8=IDC_DeleteMusic,button,1342242827
Control9=IDC_BtnPre,button,1342242827
Control10=IDC_BtnNext,button,1342242827
Control11=IDC_BtnSort,button,1342242827
Control12=IDC_StaticPlayMode,static,1342308608
Control13=IDC_BtnExit,button,1342242827
Control14=IDC_BtnHide,button,1342242827
Control15=IDC_BtnMinSize,button,1342242827

[CLS:CMusicList]
Type=0
HeaderFile=MusicList.h
ImplementationFile=MusicList.cpp
BaseClass=CListBox
Filter=W
LastObject=IDM_MainAboutApp
VirtualFilter=bWC

[MNU:IDR_MainMenu]
Type=1
Class=?
Command1=IDM_MainAboutApp
Command2=IDM_SubStop
Command3=IDM_SubPre
Command4=IDM_SubNext
Command5=IDM_SubAddFile
Command6=IDM_SubAdd
Command7=IDM_SubPlus
Command8=IDM_SubQuiet
Command9=IDM_SubSeq
Command10=IDM_SubLoop
Command11=IDM_SubRandom
Command12=IDM_MainExit
CommandCount=12

[CLS:CSkinButton]
Type=0
HeaderFile=SkinButton.h
ImplementationFile=SkinButton.cpp
BaseClass=CButton
Filter=W
VirtualFilter=BWC
LastObject=CSkinButton

[CLS:CMyStatic]
Type=0
HeaderFile=MyStatic.h
ImplementationFile=MyStatic.cpp
BaseClass=CStatic
Filter=W
LastObject=CMyStatic
VirtualFilter=WC

