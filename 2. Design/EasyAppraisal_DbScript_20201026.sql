USE [EasyAppraisalDb]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCategoryNameById]    Script Date: 26/10/2020 4:35:00 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Win Ei Khaing
-- Create date: 2020-10-23
-- Description:	for getting category name by Id
-- =============================================
CREATE FUNCTION [dbo].[GetCategoryNameById]
(
	@categoryId int
)
RETURNS nvarchar(50)
AS
BEGIN	
	DECLARE @categoryName nvarchar(50)

	SELECT @categoryName = CategoryName FROM tblCategory WITH (NOLOCK) WHERE CategoryID=@categoryId;

	RETURN @categoryName
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetPositionById]    Script Date: 26/10/2020 4:35:00 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Win Ei Khaing
-- Create date: 2020-10-23
-- Description:	for getting position by Id
-- =============================================
CREATE FUNCTION [dbo].[GetPositionById]
(
	@userId int
)
RETURNS nvarchar(50)
AS
BEGIN	
	DECLARE @position nvarchar(50)

	SELECT @position = Position FROM tblUser WITH (NOLOCK) WHERE UserID=@userId;

	RETURN @position
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetUserIDByCode]    Script Date: 26/10/2020 4:35:00 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Win Ei Khaing
-- Create date: 2020-10-23
-- Description:	for getting user id by code
-- =============================================
CREATE FUNCTION [dbo].[GetUserIDByCode]
(
	@userCode nvarchar(50)
)
RETURNS int
AS
BEGIN	
	DECLARE @userID int

	SELECT @userID = UserID FROM tblUser WITH (NOLOCK) WHERE UserCode=@userCode;

	RETURN @userID
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetUserNameById]    Script Date: 26/10/2020 4:35:00 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Win Ei Khaing
-- Create date: 2020-10-23
-- Description:	for getting user name by Id
-- =============================================
CREATE FUNCTION [dbo].[GetUserNameById]
(
	@userId int
)
RETURNS nvarchar(50)
AS
BEGIN	
	DECLARE @userName nvarchar(50)

	SELECT @userName = UserName FROM tblUser WITH (NOLOCK) WHERE UserID=@userId;

	RETURN @userName
END
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 26/10/2020 4:35:00 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_TBLCATEGORY] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMarkHistory]    Script Date: 26/10/2020 4:35:00 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMarkHistory](
	[MarkHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Mark] [int] NOT NULL,
	[GivenBy] [int] NOT NULL,
	[GivenOn] [datetime] NOT NULL,
 CONSTRAINT [PK_TBLMARKHISTORY] PRIMARY KEY CLUSTERED 
(
	[MarkHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 26/10/2020 4:35:00 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserCode] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[Position] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_TBLUSER] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUserMark]    Script Date: 26/10/2020 4:35:00 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserMark](
	[UserMarkID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Mark] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_TBLUSERMARK] PRIMARY KEY CLUSTERED 
(
	[UserMarkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCategory] ON 

INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (1, N'Attendance')
INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (2, N'Team Work')
INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (3, N'Discipline')
INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (4, N'IT Skill')
INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (5, N'Commitment to work')
INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (6, N'Communication')
INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (7, N'Positive Attitude')
SET IDENTITY_INSERT [dbo].[tblCategory] OFF
SET IDENTITY_INSERT [dbo].[tblMarkHistory] ON 

INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (176, 4, 1, 0, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (177, 4, 2, 1, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (178, 4, 3, 1, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (179, 4, 4, 1, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (180, 4, 5, 1, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (181, 4, 6, 1, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (182, 4, 7, 1, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (183, 5, 1, 0, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (184, 5, 2, 2, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (185, 5, 3, 2, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (186, 5, 4, 2, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (187, 5, 5, 2, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (188, 5, 6, 2, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (189, 5, 7, 2, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (190, 6, 1, 0, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (191, 6, 2, 3, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (192, 6, 3, 3, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (193, 6, 4, 3, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (194, 6, 5, 3, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (195, 6, 6, 3, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (196, 6, 7, 3, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (197, 7, 1, 0, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (198, 7, 2, 4, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (199, 7, 3, 4, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (200, 7, 4, 4, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (201, 7, 5, 4, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (202, 7, 6, 4, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (203, 7, 7, 4, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (204, 9, 1, 0, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (205, 9, 2, 5, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (206, 9, 3, 5, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (207, 9, 4, 5, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (208, 9, 5, 5, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (209, 9, 6, 5, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (210, 9, 7, 5, 8, CAST(N'2020-10-01T02:56:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (211, 5, 1, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (212, 5, 2, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (213, 5, 3, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (214, 5, 4, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (215, 5, 5, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (216, 5, 6, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (217, 5, 7, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (218, 6, 1, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (219, 6, 2, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (220, 6, 3, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (221, 6, 4, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (222, 6, 5, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (223, 6, 6, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (224, 6, 7, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (225, 7, 1, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (226, 7, 2, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (227, 7, 3, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (228, 7, 4, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (229, 7, 5, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (230, 7, 6, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (231, 7, 7, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (232, 8, 1, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (233, 8, 2, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (234, 8, 3, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (235, 8, 4, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (236, 8, 5, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (237, 8, 6, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (238, 8, 7, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (239, 9, 1, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (240, 9, 2, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (241, 9, 3, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (242, 9, 4, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (243, 9, 5, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (244, 9, 6, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
INSERT [dbo].[tblMarkHistory] ([MarkHistoryID], [UserID], [CategoryID], [Mark], [GivenBy], [GivenOn]) VALUES (245, 9, 7, 2, 4, CAST(N'2020-10-02T03:10:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblMarkHistory] OFF
SET IDENTITY_INSERT [dbo].[tblUser] ON 

INSERT [dbo].[tblUser] ([UserID], [UserCode], [UserName], [Position], [Password]) VALUES (4, N'M001', N'Nwe', N'Manager', N'12345')
INSERT [dbo].[tblUser] ([UserID], [UserCode], [UserName], [Position], [Password]) VALUES (5, N'E001', N'Thurein', N'Software Engineer', N'12345')
INSERT [dbo].[tblUser] ([UserID], [UserCode], [UserName], [Position], [Password]) VALUES (6, N'E002', N'Moe', N'Software Engineer', N'12345')
INSERT [dbo].[tblUser] ([UserID], [UserCode], [UserName], [Position], [Password]) VALUES (7, N'E003', N'Khant', N'Software Engineer', N'12345')
INSERT [dbo].[tblUser] ([UserID], [UserCode], [UserName], [Position], [Password]) VALUES (8, N'E004', N'Win', N'Software Engineer', N'12345')
INSERT [dbo].[tblUser] ([UserID], [UserCode], [UserName], [Position], [Password]) VALUES (9, N'E005', N'Than', N'Software Engineer', N'12345')
SET IDENTITY_INSERT [dbo].[tblUser] OFF
SET IDENTITY_INSERT [dbo].[tblUserMark] ON 

INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (1, 4, 1, CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (2, 4, 2, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (3, 4, 3, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (4, 4, 4, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (5, 4, 5, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (6, 4, 6, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (7, 4, 7, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (8, 5, 1, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (9, 5, 2, CAST(4 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (10, 5, 3, CAST(4 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (11, 5, 4, CAST(4 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (12, 5, 5, CAST(4 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (13, 5, 6, CAST(4 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (14, 5, 7, CAST(4 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (15, 6, 1, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (16, 6, 2, CAST(5 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (17, 6, 3, CAST(5 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (18, 6, 4, CAST(5 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (19, 6, 5, CAST(5 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (20, 6, 6, CAST(5 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (21, 6, 7, CAST(5 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (22, 7, 1, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (23, 7, 2, CAST(6 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (24, 7, 3, CAST(6 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (25, 7, 4, CAST(6 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (26, 7, 5, CAST(6 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (27, 7, 6, CAST(6 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (28, 7, 7, CAST(6 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (29, 8, 1, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (30, 8, 2, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (31, 8, 3, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (32, 8, 4, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (33, 8, 5, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (34, 8, 6, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (35, 8, 7, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (36, 9, 1, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (37, 9, 2, CAST(7 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (38, 9, 3, CAST(7 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (39, 9, 4, CAST(7 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (40, 9, 5, CAST(7 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (41, 9, 6, CAST(7 AS Decimal(18, 0)))
INSERT [dbo].[tblUserMark] ([UserMarkID], [UserID], [CategoryID], [Mark]) VALUES (42, 9, 7, CAST(7 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[tblUserMark] OFF
ALTER TABLE [dbo].[tblMarkHistory]  WITH CHECK ADD  CONSTRAINT [tblMarkHistory_fk0] FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUser] ([UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblMarkHistory] CHECK CONSTRAINT [tblMarkHistory_fk0]
GO
ALTER TABLE [dbo].[tblMarkHistory]  WITH CHECK ADD  CONSTRAINT [tblMarkHistory_fk1] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[tblCategory] ([CategoryID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblMarkHistory] CHECK CONSTRAINT [tblMarkHistory_fk1]
GO
ALTER TABLE [dbo].[tblUserMark]  WITH CHECK ADD  CONSTRAINT [tblUserMark_fk0] FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUser] ([UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblUserMark] CHECK CONSTRAINT [tblUserMark_fk0]
GO
ALTER TABLE [dbo].[tblUserMark]  WITH CHECK ADD  CONSTRAINT [tblUserMark_fk1] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[tblCategory] ([CategoryID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblUserMark] CHECK CONSTRAINT [tblUserMark_fk1]
GO
