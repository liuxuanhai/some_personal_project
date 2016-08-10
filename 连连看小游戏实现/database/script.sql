create database [连连看]
go
USE [连连看]
GO
/****** Object:  Table [dbo].[t_score]    Script Date: 2016/3/30 15:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[t_score](
	[scoretime] [datetime] NULL,
	[score] [int] NULL,
	[type] [varchar](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[t_score] ([scoretime], [score], [type]) VALUES (CAST(N'2016-03-30 02:06:55.000' AS DateTime), 360, N'0')
INSERT [dbo].[t_score] ([scoretime], [score], [type]) VALUES (CAST(N'2016-03-30 02:19:30.000' AS DateTime), 310, N'0')
INSERT [dbo].[t_score] ([scoretime], [score], [type]) VALUES (CAST(N'2016-03-30 02:53:27.000' AS DateTime), 185, N'1')
INSERT [dbo].[t_score] ([scoretime], [score], [type]) VALUES (CAST(N'2016-03-30 03:07:09.000' AS DateTime), 370, N'0')
INSERT [dbo].[t_score] ([scoretime], [score], [type]) VALUES (CAST(N'2016-03-30 03:08:46.000' AS DateTime), 280, N'1')
INSERT [dbo].[t_score] ([scoretime], [score], [type]) VALUES (CAST(N'2016-03-30 03:36:56.000' AS DateTime), 365, N'1')
INSERT [dbo].[t_score] ([scoretime], [score], [type]) VALUES (CAST(N'2016-03-30 03:38:22.000' AS DateTime), 455, N'1')
INSERT [dbo].[t_score] ([scoretime], [score], [type]) VALUES (CAST(N'2016-03-30 03:25:34.000' AS DateTime), 305, N'1')
INSERT [dbo].[t_score] ([scoretime], [score], [type]) VALUES (CAST(N'2016-03-30 03:27:14.000' AS DateTime), 395, N'1')
