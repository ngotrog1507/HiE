USE [IDGROUP]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertToNoSigned]    Script Date: 1/27/2018 8:37:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ConvertToNoSigned]
(
      @strInput NVARCHAR(4000)
)
RETURNS NVARCHAR(4000)
AS
BEGIN    
    IF @strInput IS NULL RETURN @strInput
    IF @strInput = '' RETURN @strInput
    DECLARE @RT NVARCHAR(4000)
    DECLARE @SIGN_CHARS NCHAR(136)
    DECLARE @UNSIGN_CHARS NCHAR (136)
 
   -- SET @SIGN_CHARS = N'áà?ã?â?????a?????déè???ê?????íì?i?óò?õ?ô?????o?????úù?u?u?????ý????ÁÀ?Ã?Â?????A?????ÐÉÈ???Ê?????ÍÌ?I?ÓÒ?Õ?Ô?????O?????ÚÙ?U?U?????Ý????'
   -- SET @UNSIGN_CHARS = N'aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyAAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYY'
   SET @SIGN_CHARS = N'aĂăÂâĐđEeÊêIiOoÔôƠơUuƯưYyÀàẰằẦầÈèỀềÌìÒòỒồỜờÙùỪừỲỳÁáẮắẤấÉéẾếÍíÓóỐốỚớÚúỨứÝýẢảẲẳẨẩẺẻỂểỈỉỎỏỔổỞởỦủỬửỶỷÃãẴẵẪẫẼẽỄễĨĩÕõỖỗỠỡŨũỮữỸỹẠạẶặẬậẸẹỆệỊịỌọỘộỢợỤụựỰỴỵ'
   SET @UNSIGN_CHARS = N'aAaAaDdEeEeIiOoOoOoUuUuYyAaAaAaEeEeIiOoOoOoUuUuYyAaAaAaEeEeIiOoOoOoUuUuYyAaAaAaEeEeIiOoOoOoUuUuYyAaAaAaEeEeIiOoOoOoUuUuYyAaAaAaEeEeIiOoOoOoUuuUYy'
 
    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
    SET @COUNTER = 1

    WHILE (@COUNTER <=LEN(@strInput))
    BEGIN  
      SET @COUNTER1 = 1
      --Tìm trong chuoi moi
       WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1)
       BEGIN
     IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1))
            = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
     BEGIN          
          IF @COUNTER=1
              SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
              + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)                  
          ELSE
              SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1)
              +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1)
              + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)
              BREAK
               END
             SET @COUNTER1 = @COUNTER1 +1
       END
      --Tìm tiep
       SET @COUNTER = @COUNTER +1
    END
   
    SET @strInput = replace(@strInput,' ','-')
    RETURN @strInput
END

GO
/****** Object:  Table [dbo].[CmsCategory]    Script Date: 1/27/2018 8:37:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Link] [varchar](250) NULL,
	[Summary] [nvarchar](500) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsEmail]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsIntroduce]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CmsIntroduce](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Summary] [nvarchar](4000) NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsIntroduce] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CmsService]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsService](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Image] [varchar](250) NULL,
	[Title] [nvarchar](250) NULL,
	[Orders] [int] NULL,
	[Summary] [nvarchar](4000) NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsService] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsSlide]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsSlide](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Image] [varchar](500) NULL,
	[Title] [nvarchar](550) NULL,
	[Alt] [varchar](550) NULL,
	[Summary] [nvarchar](500) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsSlide] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsSociety]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsSociety](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NULL,
	[Name] [varchar](50) NULL,
	[Link] [varchar](250) NULL,
	[Icon] [varchar](250) NULL,
	[Image] [varchar](250) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsSociety] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SysGroup]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Summary] [nvarchar](500) NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_SysGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysGroupMenu]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysGroupMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NULL,
	[MenuId] [int] NULL,
	[RoleId] [int] NULL,
	[RoleName] [nvarchar](10) NULL,
	[UsedState] [int] NULL,
	[Orders] [int] NULL,
	[CreatedDate] [date] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_SysGroupMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysGroupUser]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysGroupUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NULL,
	[UserId] [int] NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedDate] [date] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_SysGroupUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysMenu]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Link] [nvarchar](150) NULL,
	[ParentId] [int] NULL,
	[Name] [nvarchar](150) NULL,
	[Icon] [nvarchar](150) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedDate] [date] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_SysMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysUser]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SysUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[UserName] [nvarchar](150) NULL,
	[FullName] [nvarchar](150) NULL,
	[Host] [bit] NULL,
	[Role] [int] NULL,
	[Gender] [nvarchar](3) NULL,
	[Orders] [int] NULL,
	[ImageUrl] [nvarchar](200) NULL,
	[Phone] [varchar](50) NULL,
	[Email] [nvarchar](150) NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_SysUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](56) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL DEFAULT ((0)),
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL DEFAULT ((0)),
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[CmsCategory] ON 

INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'GIỚI THIỆU', N'/gioi-thieu', N'c', 2, 1, 1, CAST(N'2017-02-02' AS Date), NULL, CAST(N'2018-01-24' AS Date))
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'TRANG CHỦ', N'/', NULL, 1, 1, -1, CAST(N'2018-01-24' AS Date), 3, CAST(N'2018-01-25' AS Date))
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'DỊCH VỤ', N'/dich-vu', NULL, 3, 1, -1, CAST(N'2018-01-24' AS Date), NULL, NULL)
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'SẢN PHẨM', N'/san-pham', NULL, 4, 1, -1, CAST(N'2018-01-24' AS Date), NULL, NULL)
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'BLOG', N'/blog', NULL, 5, 1, -1, CAST(N'2018-01-24' AS Date), NULL, NULL)
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'LIÊN HỆ', N'/lien-he', NULL, 6, 1, -1, CAST(N'2018-01-24' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[CmsCategory] OFF
SET IDENTITY_INSERT [dbo].[CmsEmail] ON 

INSERT [dbo].[CmsEmail] ([Id], [Email], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'admin@gmail.com', 1, 1, 5, CAST(N'2018-01-25' AS Date), 5, CAST(N'2018-01-25' AS Date))
INSERT [dbo].[CmsEmail] ([Id], [Email], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'host@gmail.com', 1, 0, 5, CAST(N'2018-01-25' AS Date), 3, CAST(N'2018-01-25' AS Date))
INSERT [dbo].[CmsEmail] ([Id], [Email], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'DEMO@TEST', 1, 0, 5, CAST(N'2018-01-25' AS Date), 3, CAST(N'2018-01-25' AS Date))
SET IDENTITY_INSERT [dbo].[CmsEmail] OFF
SET IDENTITY_INSERT [dbo].[CmsSlide] ON 

INSERT [dbo].[CmsSlide] ([Id], [Image], [Title], [Alt], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'/Uploads/3/2018/1/27/27120181947193564516.png', N'Slide 2', N'hinh-anh-mang-tinh-chat-minh-hoa', NULL, 2, 1, 3, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-27' AS Date))
INSERT [dbo].[CmsSlide] ([Id], [Image], [Title], [Alt], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'/Uploads/3/2018/1/27/27120182004056972966.png', N'Slide1', N'hinh-anh-1', NULL, 1, 1, 3, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-27' AS Date))
INSERT [dbo].[CmsSlide] ([Id], [Image], [Title], [Alt], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'/Uploads/3/2018/1/27/27120182011336471269.png', N'slide3', N'hinh-anh3', NULL, 3, 1, 3, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-27' AS Date))
INSERT [dbo].[CmsSlide] ([Id], [Image], [Title], [Alt], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'/Uploads/3/2018/1/27/2712018201298818919.png', N'Slide4', N'hinh-anh4', NULL, 4, 1, 3, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-27' AS Date))
SET IDENTITY_INSERT [dbo].[CmsSlide] OFF
SET IDENTITY_INSERT [dbo].[CmsSociety] ON 

INSERT [dbo].[CmsSociety] ([Id], [Type], [Name], [Link], [Icon], [Image], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, 1, N'Facebook', N'https://www.facebook.com', NULL, NULL, 1, 1, 1, CAST(N'2017-02-02' AS Date), NULL, NULL)
INSERT [dbo].[CmsSociety] ([Id], [Type], [Name], [Link], [Icon], [Image], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, 2, N'Youtube', N'https://www.facebook.com', NULL, NULL, 2, 1, 1, CAST(N'2017-02-02' AS Date), NULL, NULL)
INSERT [dbo].[CmsSociety] ([Id], [Type], [Name], [Link], [Icon], [Image], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, 3, N'Google C++', N'https://www.facebook.com', NULL, NULL, 3, 1, 1, CAST(N'2017-02-02' AS Date), NULL, NULL)
INSERT [dbo].[CmsSociety] ([Id], [Type], [Name], [Link], [Icon], [Image], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, 4, N'Twitter', N'https://www.facebook.comccccc', NULL, NULL, 1, -1, 1, CAST(N'2017-02-02' AS Date), 3, CAST(N'2018-01-26' AS Date))
SET IDENTITY_INSERT [dbo].[CmsSociety] OFF
SET IDENTITY_INSERT [dbo].[SysGroup] ON 

INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Nhóm 111111', N'bv', -1, 1, CAST(N'2017-02-02' AS Date), NULL, NULL)
INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, N'Nhom 1777777', N'<p>cascascascasc sa <b>asd asd asd&nbsp; &nbsp;</b></p><p><b><u>a</u></b></p><p><b><u>câcc</u></b></p><p><b><u>âccac</u></b></p>', 0, 3, CAST(N'2018-01-17' AS Date), NULL, CAST(N'2018-01-17' AS Date))
INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'Nhom Test', N'<p>cascascascasc sa <b>asd asd asd&nbsp; &nbsp;</b></p><p><b><u>a</u></b></p><p><b><u>câcc</u></b></p><p><b><u>âccac</u></b></p>', 1, 3, CAST(N'2018-01-17' AS Date), 2, CAST(N'2018-01-24' AS Date))
INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'Nhóm admin', N'<p>cascascascasc sa <b>asd asd asd&nbsp; &nbsp;</b></p><p><b><u>a</u></b></p><p><b><u>câcccccccccc</u></b></p><p><b><u>âccac</u></b></p>', 1, 3, CAST(N'2018-01-17' AS Date), 3, CAST(N'2018-01-24' AS Date))
INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'Nhom 123ccc', N'<p>cascascascasc sa <b>asd asd asd&nbsp; &nbsp;</b></p><p><b><u>a</u></b></p><p><b><u>câcc</u></b></p><p><b><u>âccac</u></b></p>', 0, 3, CAST(N'2018-01-17' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysGroup] OFF
SET IDENTITY_INSERT [dbo].[SysGroupMenu] ON 

INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (36, 17, 4, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (37, 17, 1, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (38, 17, 2, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (40, 17, 5, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (41, 17, 6, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (42, 17, 4, 1, N'Add', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (43, 17, 4, 2, N'Edit', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (44, 17, 4, 3, N'Delete', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (45, 17, 1, 2, N'Edit', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (47, 1, 7, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (48, 1, 8, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (51, 18, 4, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (53, 18, 1, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (59, 19, 7, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (60, 19, 8, 4, N'View', 1, 1, CAST(N'2018-01-24' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (65, 19, 4, 4, N'View', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (66, 19, 5, 4, N'View', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (67, 19, 6, 4, N'View', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (68, 19, 5, 1, N'Add', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (69, 19, 5, 2, N'Edit', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (70, 19, 5, 3, N'Delete', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (71, 19, 5, 0, N'Admin', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (72, 19, 7, 1, N'Add', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (73, 19, 8, 3, N'Delete', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (74, 19, 7, 3, N'Delete', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (75, 19, 7, 2, N'Edit', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (77, 17, 10, 4, N'View', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (78, 19, 1, 4, N'View', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (79, 19, 1, 3, N'Delete', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (80, 19, 1, 0, N'Admin', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (81, 19, 7, 0, N'Admin', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (82, 19, 10, 4, N'View', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (83, 19, 10, 0, N'Admin', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (84, 19, 6, 0, N'Admin', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (85, 17, 6, 3, N'Delete', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (87, 17, 6, 1, N'Add', 1, 1, CAST(N'2018-01-25' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (88, 17, 10, 3, N'Delete', 1, 1, CAST(N'2018-01-26' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (89, 17, 2, 0, N'Admin', 1, 1, CAST(N'2018-01-26' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (90, 17, 5, 0, N'Admin', 1, 1, CAST(N'2018-01-26' AS Date), 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysGroupMenu] OFF
SET IDENTITY_INSERT [dbo].[SysGroupUser] ON 

INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (3, 17, 1, 2, 1, CAST(N'2018-01-23' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, 1, 1, 2, 1, CAST(N'2018-01-23' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, 18, 2, 2, 1, CAST(N'2018-01-24' AS Date), 2, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, 19, 5, 2, 1, CAST(N'2018-01-24' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, 21, 5, 2, 1, CAST(N'2018-01-24' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (11, 17, 4, 2, 1, CAST(N'2018-01-25' AS Date), 3, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysGroupUser] OFF
SET IDENTITY_INSERT [dbo].[SysMenu] ON 

INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'/System/SysMenu', 4, N'Quản lý Menu', NULL, 1, 1, CAST(N'2017-02-02' AS Date), 1, CAST(N'2018-01-24 00:47:29.613' AS DateTime), NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'/System/SysGroupMenu', 4, N'Quản lý nhóm quyền Menu', NULL, 1, 1, CAST(N'2017-02-02' AS Date), 1, CAST(N'2018-01-25 23:05:25.387' AS DateTime), 5)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (4, N'#', NULL, N'Quản lý hệ thống', N'fa fa-cog', 1, 1, CAST(N'2018-01-21' AS Date), 1, CAST(N'2018-01-26 22:40:34.080' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, N'/System/SysGroup', 4, N'Quản lý nhóm', NULL, 1, 1, CAST(N'2018-01-21' AS Date), 1, CAST(N'2018-01-24 00:46:48.943' AS DateTime), NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, N'/System/SysUser', 4, N'Quản lý người dùng', NULL, 1, 1, CAST(N'2018-01-21' AS Date), 1, CAST(N'2018-01-24 00:47:10.283' AS DateTime), NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, N'/System/CmsCategory', 16, N'Quản lý danh mục', N'fa fa-minus-square-o ', 2, 1, CAST(N'2018-01-24' AS Date), 2, CAST(N'2018-01-26 22:42:34.327' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, N'/System/CmsService', 16, N'Quản lý dịch vụ', N'fa fa-minus-square-o ', 3, 1, CAST(N'2018-01-24' AS Date), 3, CAST(N'2018-01-26 22:42:24.463' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, N'/System/CmsEmail', 10, N'Quản lý Email', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-25' AS Date), 3, CAST(N'2018-01-26 22:38:07.983' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (12, N'/System/CmsSlide', 15, N'Quản lý Slide', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:37:51.950' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (13, N'/System/CmsSociety', 15, N'Quản lý mạng xã hội', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:37:58.913' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (14, N'/System/CmsArticles', 16, N'Quản lý bài viết', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:46:27.537' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (15, N'#', NULL, N'Tiện ích', N'fa fa-cc-discover', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:46:15.663' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (16, N'#', NULL, N'Quản trị nội dung', N'fa fa-th-large', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:46:09.523' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (17, N'/System/CmsBlog', 16, N'Quản lý Blog', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (18, N'/System/CmsIntroduce', 16, N'Quản lý giới thiệu', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:45:15.660' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (19, N'/System/CmsProducts', 16, N'Quản lý sản phẩm', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (20, N'/System/CmsEmail', 15, N'Quản lý email gửi', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysMenu] OFF
SET IDENTITY_INSERT [dbo].[SysUser] ON 

INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, 1, N'trongnv1507', N'HOST FULLNAME', 1, NULL, N'0', 0, NULL, N'213123123', N'host@gmail.com', 1, 1, CAST(N'2018-01-22' AS Date), NULL, CAST(N'2018-01-22' AS Date))
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, 2, N'trongnv1', N'trongngngg123123', 1, NULL, N'1', 1, NULL, N'213123123', N'trongnv1507@gmail.com', 1, 1, CAST(N'2018-01-22' AS Date), NULL, CAST(N'2018-01-22' AS Date))
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, 3, N'host', N'Quản trị cấp cao', 1, NULL, N'1', NULL, NULL, NULL, N'host@gmail.com', 1, 1, CAST(N'2018-01-24' AS Date), NULL, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, 4, N'trongnv', N'Ngô Văn Trọng', 0, NULL, N'1', NULL, NULL, NULL, N'trongnv1507@gmail.com', 1, 3, CAST(N'2018-01-24' AS Date), NULL, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, 5, N'admin', N'Quản trị hệ thống', 0, NULL, N'1', NULL, NULL, NULL, N'admin@gmail.com', 1, 3, CAST(N'2018-01-24' AS Date), NULL, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, 6, N'aa', N'aa', 0, NULL, N'1', NULL, NULL, NULL, N'aa@aa', 1, 3, CAST(N'2018-01-25' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysUser] OFF
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (6, N'aa')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (5, N'admin')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (3, N'host')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (4, N'trongnv')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (2, N'trongnv1')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (1, N'trongnv1507')
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(N'2018-01-23 19:11:39.037' AS DateTime), NULL, 1, NULL, 0, N'APQX3rkCXd1JUuXGcTrFtgEb/+tRfzrDW7i2GaMbonFuyZ3KBhh2vd+I1nwnSWPvkw==', CAST(N'2018-01-23 19:11:39.037' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (2, CAST(N'2018-01-23 19:12:14.827' AS DateTime), NULL, 1, CAST(N'2018-01-25 16:45:04.037' AS DateTime), 0, N'AMDQdsJO1vAlrLG1w1ihaVnEriGuI5Y/kcsRa13MBpRivkPVdiEzeaSte2pPkJxFWg==', CAST(N'2018-01-23 19:12:14.827' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (3, CAST(N'2018-01-24 15:58:01.640' AS DateTime), NULL, 1, NULL, 0, N'AAcrxXqoLYKjwZs5M4khnh3l/Ssx+6l+gnTvQzdfe+KjVMCVusHTdIUqsIlZPDBZlg==', CAST(N'2018-01-24 15:58:01.640' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (4, CAST(N'2018-01-24 16:16:53.140' AS DateTime), NULL, 1, NULL, 0, N'AMPAFx0NuVPPTjdSxl5JZ4oZdJzUHdaz+ERgDqslaWEvUbUSxySyMAxZYRAPcmCcJA==', CAST(N'2018-01-24 16:16:53.140' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (5, CAST(N'2018-01-24 16:20:08.993' AS DateTime), NULL, 1, NULL, 0, N'APqUPUH5DKEK4/endHx709VBhQeqdBMip7u469b5gICNDctqkZ911TNbgpWWFGXqXQ==', CAST(N'2018-01-24 16:20:08.993' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (6, CAST(N'2018-01-25 15:58:07.180' AS DateTime), NULL, 1, NULL, 0, N'AP0p+aJMuND/MVMV/45OrBDpYiJ9ayecI8tRqR1tmBfSBOP6VXzy3WJ73L+u1096mg==', CAST(N'2018-01-25 15:58:07.180' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (7, CAST(N'2018-01-25 16:50:27.067' AS DateTime), NULL, 1, NULL, 0, N'AJLX40TeIB3f0mDm6gpP6caP/oIcCS6VULutc0SV1Vt/fZ6hb7yJKQQGP2wfe3trFg==', CAST(N'2018-01-25 16:50:27.067' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (8, CAST(N'2018-01-25 16:58:53.913' AS DateTime), NULL, 1, NULL, 0, N'AMk6dKWWkHtPsAlSB0V0oeTcIfehgc4DHyzcvSERTycVaxWYoMRGZq/n1+oYeGAfOA==', CAST(N'2018-01-25 16:58:53.913' AS DateTime), N'', NULL, NULL)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F2845655148427]    Script Date: 1/27/2018 8:37:10 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F2845675270C7F]    Script Date: 1/27/2018 8:37:10 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F28456C08ECDFA]    Script Date: 1/27/2018 8:37:10 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B616032FDEC00]    Script Date: 1/27/2018 8:37:10 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B61603FAA17F9]    Script Date: 1/27/2018 8:37:10 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B6160A44E3C50]    Script Date: 1/27/2018 8:37:10 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
/****** Object:  StoredProcedure [dbo].[CmsCategory_Deletes]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsCategory_Deletes]
	@sWhere nvarchar(4000)
AS
DECLARE @sSQL nvarchar(max)
BEGIN
SET @sSQL = 'DELETE FROM CmsCategory WHERE ' + @sWhere
EXECUTE sp_executesql @sSQL;
SELECT @@RowCount
END

GO
/****** Object:  StoredProcedure [dbo].[CmsCategory_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsCategory_Insert]
		@Link nvarchar(256), 	
	@Name nvarchar(256),   
	@Orders int,
	@UsedState int,  
		@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsCategory (
[Link],[Name]	
		,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
	@Link,@Name
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()


GO
/****** Object:  StoredProcedure [dbo].[CmsCategory_List_Paging]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsCategory_List_Paging]
	@sWhere nvarchar(1000) ,	
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0,@role INT, @areaId INT = 0; 
BEGIN
		
	IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere= ' '
	ELSE SET @sWhere = ' WHERE '+ @sWhere

	IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
	ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

	IF (@PageSize <= 0 ) 
		BEGIN
			SET @toRow = 0 
		END
	ELSE
		BEGIN
			SET @fromRow = @PageIndex*@PageSize + 1;
			SET  @toRow = @PageIndex*@PageSize + @PageSize;
		END
	BEGIN --ROW_NUMBER() OVER (ORDER BY [PageID] ASC) AS [STT]
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [CmsCategory] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [CmsCategory] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END


GO
/****** Object:  StoredProcedure [dbo].[CmsCategory_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsCategory_Update]
	@Id int, 
	@Link nvarchar(256), 	
	@Name nvarchar(256),  		 
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsCategory SET
	   [Link] = @Link
	  
	   ,[Name] = @Name
	  
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsCategory].[Id] = @Id
SELECT @@RowCount



GO
/****** Object:  StoredProcedure [dbo].[CmsCategory_Updates]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsCategory_Updates]
	@sSet nvarchar(4000),
	@sWhere nvarchar(4000)
AS
DECLARE @sSQL nvarchar(max)
BEGIN
SET @sSQL = 'UPDATE CmsCategory SET ' + 	@sSet + ' WHERE ' + @sWhere
EXECUTE sp_executesql @sSQL;
SELECT @@RowCount
END

GO
/****** Object:  StoredProcedure [dbo].[CmsEmail_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsEmail_Insert]
		@Email varchar(50),   
	@Orders int,
	@UsedState int,  
		@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsEmail (
[Email]	
		,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
	@Email
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()


GO
/****** Object:  StoredProcedure [dbo].[CmsEmail_List_Paging]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsEmail_List_Paging]
	@sWhere nvarchar(1000) ,	
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0,@role INT, @areaId INT = 0; 
BEGIN
		
	IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere= ' '
	ELSE SET @sWhere = ' WHERE '+ @sWhere

	IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
	ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

	IF (@PageSize <= 0 ) 
		BEGIN
			SET @toRow = 0 
		END
	ELSE
		BEGIN
			SET @fromRow = @PageIndex*@PageSize + 1;
			SET  @toRow = @PageIndex*@PageSize + @PageSize;
		END
	BEGIN --ROW_NUMBER() OVER (ORDER BY [PageID] ASC) AS [STT]
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [CmsEmail] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [CmsEmail] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END


GO
/****** Object:  StoredProcedure [dbo].[CmsEmail_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsEmail_Update]
	@Id int, 
	@Email varchar(50),  		 
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsEmail SET
	   
	   [Email] = @Email
	  
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsEmail].[Id] = @Id
SELECT @@RowCount



GO
/****** Object:  StoredProcedure [dbo].[CmsService_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsService_Insert]
	@Image varchar(500),   
	@Title nvarchar(250), 
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsService (
		 [Image]	
		,[Title]
		,[Name]
		,[Summary]
		 ,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
		@Image
		,@Title		
		,@Name
		,@Summary
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()


GO
/****** Object:  StoredProcedure [dbo].[CmsService_List_Paging]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsService_List_Paging]
	@sWhere nvarchar(1000) ,	
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0,@role INT, @areaId INT = 0; 
BEGIN
		
	IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere= ' '
	ELSE SET @sWhere = ' WHERE '+ @sWhere

	IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
	ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

	IF (@PageSize <= 0 ) 
		BEGIN
			SET @toRow = 0 
		END
	ELSE
		BEGIN
			SET @fromRow = @PageIndex*@PageSize + 1;
			SET  @toRow = @PageIndex*@PageSize + @PageSize;
		END
	BEGIN --ROW_NUMBER() OVER (ORDER BY [PageID] ASC) AS [STT]
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [CmsService] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [CmsService] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END


GO
/****** Object:  StoredProcedure [dbo].[CmsService_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsService_Update]
	@Id int,
	@Image varchar(500),   
	@Title nvarchar(250), 
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsService SET
	   
	   [Image ] = @Image 
	   ,[Title] = @Title 
	   ,[Name ] = @Name 
	   ,[Summary ] = @Summary 
	  
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsService].[Id] = @Id
SELECT @@RowCount



GO
/****** Object:  StoredProcedure [dbo].[CmsSlide_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsSlide_Insert]
	@Image varchar(500),   
	@Title varchar(500), 
	@Alt varchar(500), 
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsSlide (
		 [Image]	
		,[Title]
		,[Alt]
		 ,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
		@Image
		,@Title		
		,@Alt
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()


GO
/****** Object:  StoredProcedure [dbo].[CmsSlide_List_Paging]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsSlide_List_Paging]
	@sWhere nvarchar(1000) ,	
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0,@role INT, @areaId INT = 0; 
BEGIN
		
	IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere= ' '
	ELSE SET @sWhere = ' WHERE '+ @sWhere

	IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
	ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

	IF (@PageSize <= 0 ) 
		BEGIN
			SET @toRow = 0 
		END
	ELSE
		BEGIN
			SET @fromRow = @PageIndex*@PageSize + 1;
			SET  @toRow = @PageIndex*@PageSize + @PageSize;
		END
	BEGIN --ROW_NUMBER() OVER (ORDER BY [PageID] ASC) AS [STT]
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [CmsSlide] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [CmsSlide] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END


GO
/****** Object:  StoredProcedure [dbo].[CmsSlide_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsSlide_Update]
	@Id int, 
	@Image varchar(500),   
	@Title varchar(500), 
	@Alt varchar(500),  
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsSlide SET
	   
	   [Image] = @Image
	  ,[Title] = @Title
	  ,[Alt] = @Alt
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsSlide].[Id] = @Id
SELECT @@RowCount



GO
/****** Object:  StoredProcedure [dbo].[CmsSociety_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsSociety_Insert]
	@Type int,   
	@Name varchar(50), 
	@Link varchar(250), 
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsSociety (
		 [Type]	
		,[Name ]
		,[Link]
		 ,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
		@Type
		,@Name		
		,@Link
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()


GO
/****** Object:  StoredProcedure [dbo].[CmsSociety_List_Paging]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsSociety_List_Paging]
	@sWhere nvarchar(1000) ,	
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0,@role INT, @areaId INT = 0; 
BEGIN
		
	IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere= ' '
	ELSE SET @sWhere = ' WHERE '+ @sWhere

	IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
	ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

	IF (@PageSize <= 0 ) 
		BEGIN
			SET @toRow = 0 
		END
	ELSE
		BEGIN
			SET @fromRow = @PageIndex*@PageSize + 1;
			SET  @toRow = @PageIndex*@PageSize + @PageSize;
		END
	BEGIN --ROW_NUMBER() OVER (ORDER BY [PageID] ASC) AS [STT]
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [CmsSociety] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [CmsSociety] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END


GO
/****** Object:  StoredProcedure [dbo].[CmsSociety_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsSociety_Update]
	@Id int, 
	@Type int,   
	@Name varchar(50), 
	@Link varchar(250), 
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsSociety SET
	   
	   [Type] = @Type
	  ,[Name] = @Name
	  ,[Link] = @Link
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsSociety].[Id] = @Id
SELECT @@RowCount



GO
/****** Object:  StoredProcedure [dbo].[SysGroup_GetById]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SysGroup_GetById]
@Id int
as
select * from SysGroup where Id=@Id


GO
/****** Object:  StoredProcedure [dbo].[SysGroup_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysGroup_Insert]
	@Name nvarchar(256)
	,@Summary nvarchar(256)	
	,@UsedState int	
	,@CreatedDate datetime
	,@CreatedBy int
	,@ModifiedDate datetime
	,@ModifiedBy int
AS

INSERT INTO SysGroup (
	[Name]
		,[Summary]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
	@Name
		,@Summary
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()


GO
/****** Object:  StoredProcedure [dbo].[SysGroup_List]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysGroup_List]
	@sWhere nvarchar(1000) ,	
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0,@role INT, @areaId INT = 0; 
BEGIN
		
	IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere= ' '
	ELSE SET @sWhere = ' WHERE '+ @sWhere

	IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
	ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

	IF (@PageSize <= 0 ) 
		BEGIN
			SET @toRow = 0 
		END
	ELSE
		BEGIN
			SET @fromRow = @PageIndex*@PageSize + 1;
			SET  @toRow = @PageIndex*@PageSize + @PageSize;
		END
	BEGIN --ROW_NUMBER() OVER (ORDER BY [PageID] ASC) AS [STT]
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [SysGroup] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [SysGroup] a '+ @sWhere;
	
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END


GO
/****** Object:  StoredProcedure [dbo].[SysGroup_List_Reference]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysGroup_List_Reference]
	@sWhere nvarchar(1000) ,	
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0,@role INT, @areaId INT = 0; 
BEGIN
		
	IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere= ' '
	ELSE SET @sWhere = ' WHERE '+ @sWhere

	IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
	ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

	IF (@PageSize <= 0 ) 
		BEGIN
			SET @toRow = 0 
		END
	ELSE
		BEGIN
			SET @fromRow = @PageIndex*@PageSize + 1;
			SET  @toRow = @PageIndex*@PageSize + @PageSize;
		END
	BEGIN --ROW_NUMBER() OVER (ORDER BY [PageID] ASC) AS [STT]
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [SysGroup] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [SysGroup] a '+ @sWhere;
	
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END


GO
/****** Object:  StoredProcedure [dbo].[SysGroup_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysGroup_Update]
	@Id int, 
	@Name nvarchar(256), 
	@Summary nvarchar(256),  
	@UsedState int,  
	@CreatedDate datetime, 
	@CreatedBy int, 
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE SysGroup SET
	   [Name] = @Name
	   ,[Summary] = @Summary
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[SysGroup].[Id] = @Id
SELECT @@RowCount



GO
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_GetBy_GroupId]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SysGroupMenu_GetBy_GroupId]
	@GroupId int
	,@usedState INT 
AS

BEGIN
	WITH Recursives (Id,Name,Levels,ParentId,Orders,MenuId)
	AS(
			--Bản ghi 1 Nối với bản ghi 2 thông qua Union All
			--Bản ghi 2 được tạo bởi phép inner join giữa bảng dữ liệu và bản Đệ quy (ON p.UnitID  = c.ParentUnitID ) 
			SELECT r.Id,r.Name,0 Levels,r.ParentId,
				convert(varchar(max),right(row_number() over (order by r.Id),10)) Orders,r.Id
				FROM SysMenu r
				WHERE
				 (
				 r.ParentId  IS NULL) 
				 				
		UNION ALL 
			SELECT a.Id,a.Name,Rec.Levels + 1 AS Levels,a.ParentId,
				Rec.Orders + '/' + convert(varchar(max),right(row_number() over (order by Rec.Id),10)),a.Id
				FROM   SysMenu a 
			INNER JOIN Recursives Rec 
				ON Rec.Id  = a.ParentId 
				AND (@usedState  IS NULL OR a.UsedState =@usedState)
							
	) 
		SELECT Id,REPLICATE('|——', R.Levels) + R.Name AS Name,R.ParentId,R.Levels,R.MenuId,CASE WHEN c.MenuId IS NOT NULL THEN 'True' ELSE 'False' END AS Choosed 
		FROM Recursives R
		LEFT JOIN
			(SELECT  a.GroupId,a.MenuId,count(*) AS soLuong FROM SysGroupMenu a
			where a.GroupId=@GroupId
			GROUP BY a.GroupId,a.MenuId) C ON C.MenuId=R.Id
		
		ORDER BY R.Orders


END

GO
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SysGroupMenu_Insert]
	@GroupId int,
	@MenuId int,
	@RoleId int,
	@RoleName nvarchar(10),
	@UsedState int,
	@Orders int,
	@CreatedDate date,
	@CreatedBy int,
	@ModifiedDate date,
	@ModifiedBy int
AS

SET NOCOUNT ON

INSERT INTO [dbo].[SysGroupMenu] (
	[GroupId],
	[MenuId],
	[RoleId],
	[RoleName],
	[UsedState],
	[Orders],
	[CreatedDate],
	[CreatedBy],
	[ModifiedDate],
	[ModifiedBy]
) VALUES (
	@GroupId,
	@MenuId,
	@RoleId,
	@RoleName,
	@UsedState,
	@Orders,
	@CreatedDate,
	@CreatedBy,
	@ModifiedDate,
	@ModifiedBy
)

select SCOPE_IDENTITY()

--endregion


GO
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_List]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SysGroupMenu_List]
	  
	
	@sWhere nvarchar(1000) ,
	@sOrder nvarchar(1000),
	@fromRow int ,
	@toRow int
AS
DECLARE @SQL NVARCHAR(4000)
BEGIN
IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere=' '
ELSE SET @sWhere = ' WHERE ' + @sWhere+' '

IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

IF @toRow <= 0
	BEGIN
		SET @SQL = 'SELECT a.* FROM [SysGroupMenu] a '+ @sWhere+ @sOrder;
		EXECUTE sp_executesql @SQL;
	END
ELSE
	BEGIN
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber
			FROM [SysGroupMenu] a '+@sWhere+')
			SELECT * FROM PagingTable WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[sp_SysGroupMenuUpdateSysGroupMenu]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   ngotrog using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[sp_SysGroupMenuUpdateSysGroupMenu]
-- Date Generated: Friday, December 1, 2017
------------------------------------------------------------------------------------------------------------------------

create PROCEDURE [dbo].[SysGroupMenu_Update]
	@Id int,
	@GroupId int,
	@MenuId int,
	@RoleId int,
	@RoleName nvarchar(10),
	@UsedState int,
	@Orders int,
	@CreatedDate date,
	@CreatedBy int,
	@ModifiedDate date,
	@ModifiedBy int
AS

SET NOCOUNT ON

UPDATE [dbo].[SysGroupMenu] SET
	[GroupId] = @GroupId,
	[MenuId] = @MenuId,
	[RoleId] = @RoleId,
	[RoleName] = @RoleName,
	[UsedState] = @UsedState,
	[Orders] = @Orders,
	[CreatedDate] = @CreatedDate,
	[CreatedBy] = @CreatedBy,
	[ModifiedDate] = @ModifiedDate,
	[ModifiedBy] = @ModifiedBy
WHERE
	[Id] = @Id

--endregion


GO
/****** Object:  StoredProcedure [dbo].[SysGroupUser_GetUserInGroup]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SysGroupUser_GetUserInGroup]
@groupId int,
@name nvarchar(1000)=null
AS
SELECT B.* FROM SYSUSER B LEFT JOIN SYSGROUPUSER A ON A.USERID = B.UserID WHERE A.GROUPID = @groupId
and  (@name = '' OR @name IS NULL OR B.FullName LIKE '%' + @name +'%' OR B.UserName LIKE '%' + @name +'%')
GO
/****** Object:  StoredProcedure [dbo].[SysGroupUser_GetUserNotInGroup]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SysGroupUser_GetUserNotInGroup]
@groupId int,
@name nvarchar(1000)=null
AS
SELECT * FROM SYSUSER B WHERE B.ID NOT IN
(SELECT B.Id FROM SYSUSER B 
LEFT JOIN SYSGROUPUSER A ON A.USERID=B.UserID
 WHERE A.GROUPID=@groupId)
and  (@name = '' OR @name IS NULL OR B.FullName LIKE '%' + @name +'%' OR B.UserName LIKE '%' + @name +'%')
GO
/****** Object:  StoredProcedure [dbo].[SysGroupUser_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SysGroupUser_Insert]
	@GroupId int,
	@UserId int,
	@Orders int,
	@UsedState int,
	@CreatedDate date,
	@CreatedBy int,
	@ModifiedDate datetime,
	@ModifiedBy int
AS

SET NOCOUNT ON

INSERT INTO [dbo].[SysGroupUser] (
	[GroupId],
	[UserId],
	[Orders],
	[UsedState],
	[CreatedDate],
	[CreatedBy],
	[ModifiedDate],
	[ModifiedBy]
) VALUES (
	@GroupId,
	@UserId,
	@Orders,
	@UsedState,
	@CreatedDate,
	@CreatedBy,
	@ModifiedDate,
	@ModifiedBy
)

SELECT SCOPE_IDENTITY()

--endregion


GO
/****** Object:  StoredProcedure [dbo].[SysGroupUser_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[sp_SysGroupUser_Update]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   ngotrog using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[sp_SysGroupUser_Update]
-- Date Generated: Monday, December 11, 2017
------------------------------------------------------------------------------------------------------------------------

create PROCEDURE [dbo].[SysGroupUser_Update]
	@Id int,
	@GroupId int,
	@UserId int,
	@Orders int,
	@UsedState int,
	@CreatedDate date,
	@CreatedBy int,
	@ModifiedDate datetime,
	@ModifiedBy int
AS


UPDATE [dbo].[SysGroupUser] SET
	[GroupId] = @GroupId,
	[UserId] = @UserId,
	[Orders] = @Orders,
	[UsedState] = @UsedState,
	[CreatedDate] = @CreatedDate,
	[CreatedBy] = @CreatedBy,
	[ModifiedDate] = @ModifiedDate,
	[ModifiedBy] = @ModifiedBy
WHERE
	[Id] = @Id
	SELECT @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[SysMenu_GetById]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SysMenu_GetById]
@Id int
as
select * from SysMenu where Id=@Id


GO
/****** Object:  StoredProcedure [dbo].[SysMenu_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysMenu_Insert]
		@Link nvarchar(256), 
	@ParentId int,
	@Name nvarchar(256),  
	@Icon  nvarchar(150),  
	@Orders int,
	@UsedState int,  
		@CreatedBy int,
	@CreatedDate datetime, 
 
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO SysMenu (
[Link],[ParentId],[Name],
	[Icon]
		,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
	@Link,@ParentId,@Name,@Icon
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()


GO
/****** Object:  StoredProcedure [dbo].[SysMenu_List]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysMenu_List]
	@sWhere nvarchar(1000) ,
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0; 
BEGIN
IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere=' '
ELSE SET @sWhere = ' WHERE ' + @sWhere+' '

IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

SET @fromRow = @PageIndex*@PageSize + 1;
SET  @toRow = @PageIndex*@PageSize + @PageSize;
	BEGIN
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [SysMenu] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [SysMenu] a '+ @sWhere;
	print @SQL;
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END

GO
/****** Object:  StoredProcedure [dbo].[SysMenu_List_Paging]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysMenu_List_Paging]
	@sWhere nvarchar(1000) ,	
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0,@role INT, @areaId INT = 0; 
BEGIN
		
	IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere= ' '
	ELSE SET @sWhere = ' WHERE '+ @sWhere

	IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
	ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

	IF (@PageSize <= 0 ) 
		BEGIN
			SET @toRow = 0 
		END
	ELSE
		BEGIN
			SET @fromRow = @PageIndex*@PageSize + 1;
			SET  @toRow = @PageIndex*@PageSize + @PageSize;
		END
	BEGIN --ROW_NUMBER() OVER (ORDER BY [PageID] ASC) AS [STT]
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [SysMenu] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [SysMenu] a '+ @sWhere;
	
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END


GO
/****** Object:  StoredProcedure [dbo].[SysMenu_List_Recursive]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SysMenu_List_Recursive]
	@iParentId INT = NULL,
	@iMenuId INT = NULL,		
	@usedState INT 
AS

BEGIN
	WITH Recursives (Id,Name,Levels,ParentId,Orders)
	AS(
			--Bản ghi 1 Nối với bản ghi 2 thông qua Union All
			--Bản ghi 2 được tạo bởi phép inner join giữa bảng dữ liệu và bản Đệ quy (ON p.UnitID  = c.ParentUnitID ) 
			SELECT r.Id,r.Name,0 Levels,r.ParentId,
				convert(varchar(max),right(row_number() over (order by r.Id),10)) Orders
				FROM SysMenu r
				WHERE
				 (
				 r.ParentId  IS NULL) 
				 				
		UNION ALL 
			SELECT a.Id,a.Name,Rec.Levels + 1 AS Levels,a.ParentId,
				Rec.Orders + '/' + convert(varchar(max),right(row_number() over (order by Rec.Id),10))
				FROM   SysMenu a 
			INNER JOIN Recursives Rec 
				ON Rec.Id  = a.ParentId 
				AND (@usedState  IS NULL OR a.UsedState =@usedState)
							
	) 
		SELECT Id,REPLICATE('|——', Levels) + Name AS Name,ParentId,Levels
		FROM Recursives
		ORDER BY Orders

		


END
GO
/****** Object:  StoredProcedure [dbo].[SysMenu_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysMenu_Update]
	@Id int, 
	@Link nvarchar(256), 
	@ParentId int,
	@Name nvarchar(256),  
	@Icon  nvarchar(150),  
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE SysMenu SET
	   [Link] = @Link
	   ,[ParentId] = @ParentId
	   ,[Name] = @Name
	   ,[Icon] = @Icon
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[SysMenu].[Id] = @Id
SELECT @@RowCount



GO
/****** Object:  StoredProcedure [dbo].[SysMenu_Updates]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SysMenu_Updates]
	@sSet nvarchar(4000),
	@sWhere nvarchar(4000)
AS
DECLARE @sSQL nvarchar(max)
BEGIN
SET @sSQL = 'UPDATE SysMenu SET ' + 	@sSet + ' WHERE ' + @sWhere
EXECUTE sp_executesql @sSQL;
SELECT @@RowCount
END

GO
/****** Object:  StoredProcedure [dbo].[SysUser_Insert]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysUser_Insert]
	@UserId int,
	@FullName nvarchar(150),
	@UserName nvarchar(150),
	@Email nvarchar(150),	
	@Phone varchar(50),
	@Host bit,
	@Gender nvarchar(3),
		
	@UsedState int,
	@CreatedBy int,
	@CreatedDate date,
	@ModifiedBy int,
	@ModifiedDate date
AS

SET NOCOUNT ON

INSERT INTO [dbo].[SysUser] (
	[UserId],
	[UserName],
	[FullName],
	[Host],
	[Gender],
	
	[Phone],
	[Email],
	
	[UsedState],
	[CreatedBy],
	[CreatedDate],
	[ModifiedBy],
	[ModifiedDate]
) VALUES (
	@UserId,
	@UserName,
	@FullName,
	@Host,
	@Gender,
	
	@Phone,
	@Email,
	
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate
)

SELECT SCOPE_IDENTITY()

--endregion


GO
/****** Object:  StoredProcedure [dbo].[SysUser_List]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SysUser_List]
	  
	
	@sWhere nvarchar(1000) ,
	@sOrder nvarchar(1000),
	@fromRow int ,
	@toRow int
AS
DECLARE @SQL NVARCHAR(4000)
BEGIN
IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere=' '
ELSE SET @sWhere = ' WHERE ' + @sWhere+' '

IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '

IF @toRow <= 0
	BEGIN
		SET @SQL = 'SELECT a.* FROM [SysUser] a '+ @sWhere+ @sOrder;
		EXECUTE sp_executesql @SQL;
	END
ELSE
	BEGIN
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber
			FROM [SysUser] a '+@sWhere+')
			SELECT * FROM PagingTable WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SysUser_List_Paging]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysUser_List_Paging]
	@sWhere nvarchar(1000) ,	
	@sOrder nvarchar(1000),
	@PageIndex int ,
	@PageSize int,
	@TotalRow INT = 0 OUT 
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @fromRow INT = 0,@toRow INT = 0,@role INT, @areaId INT = 0; 
BEGIN
IF (@sWhere IS NULL OR @sWhere='')  SET @sWhere=' '
ELSE SET @sWhere = ' WHERE ' + @sWhere+' '

IF (@sOrder IS NULL OR @sOrder='')  SET @sOrder=' '
ELSE SET @sOrder = ' ORDER BY ' + @sOrder+' '
IF (@PageSize <= 0 ) 
		BEGIN
			SET @toRow = 0 
		END
	ELSE
		BEGIN
			SET @fromRow = @PageIndex*@PageSize + 1;
			SET  @toRow = @PageIndex*@PageSize + @PageSize;
		END
	BEGIN --ROW_NUMBER() OVER (ORDER BY [PageID] ASC) AS [STT]
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM [SysUser] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [SysUser] a '+ @sWhere;
	
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END

GO
/****** Object:  StoredProcedure [dbo].[SysUser_ListByFK]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysUser_ListByFK]
	@name nvarchar(255)=NULL,
	@pageIndex int=NULL,
	@pageSize int=NULL,
	@usedState int=NULL,
	@totalRecords int = 0 output 
	
AS 
	--select * from Blog
	SELECT
		@totalRecords = COUNT(A.Id)
		
	FROM 
			SysUser A WITH (NOLOCK) 
	WHERE 
			(@name = '' OR @name IS NULL OR A.UserName LIKE '%' + @name +'%')
			and A.UsedState =(@usedState)
			
	DECLARE @StartRowIndex int
	SET @StartRowIndex = (@pageIndex* @pageSize) + 1;
	
	WITH [sp_SysUser_Search_Paging] AS
	(
		  SELECT 
				ROW_NUMBER() OVER (ORDER BY A.Id DESC) AS [STT], 
				A.*
		  FROM 
				SysUser A WITH (NOLOCK) 
		  WHERE 
				(@name = '' OR @name IS NULL OR 	A.UserName LIKE '%' + @name +'%' )
				and A.UsedState =(@usedState)
	)
			
	SELECT 
		*
	FROM 
		[sp_SysUser_Search_Paging] PSFS WITH (NOLOCK) 
	WHERE 
		PSFS.[STT] BETWEEN @StartRowIndex AND @StartRowIndex + @pageSize - 1 
	ORDER BY PSFS.[STT] 



GO
/****** Object:  StoredProcedure [dbo].[SysUser_Update]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysUser_Update]
	@UserId int,
	@UserName nvarchar(256)
	,@FullName nvarchar(256)	
	,@Host bit
	,@Gender nvarchar(3)
	,@Orders int
	
	,@ImageUrl nvarchar(152)	
	,@Phone nvarchar(256)
	,@Email nvarchar(256)

	,@UsedState int
	,@CreatedBy int
	,@CreatedDate datetime
	,@ModifiedDate datetime
	,@ModifiedBy int

AS

UPDATE SysUser SET
	   [UserName] = @UserName
	   ,[FullName] = @FullName	 
	   ,[Host] = @Host
	  ,[Gender] = @Gender
	   ,[Orders] = @Orders
	   
	   ,[ImageUrl] = @ImageUrl	   
	   ,[Phone] = @Phone
	   ,[Email] = @Email
	    ,[UsedState] = @UsedState
	   	   ,[CreatedBy] = @CreatedBy
	   ,[CreatedDate] = @CreatedDate

	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
	   
	 
WHERE
    
	[SysUser].[UserId ] = @UserId 
SELECT @@RowCount
GO
/****** Object:  StoredProcedure [dbo].[Table_Deletes]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Table_Deletes]
	@tableName nvarchar(100),
	@sWhere nvarchar(4000)
AS
DECLARE @sSQL nvarchar(max)
BEGIN
SET @sSQL = 'DELETE FROM '+@tableName+' WHERE ' + @sWhere
EXECUTE sp_executesql @sSQL;
SELECT @@RowCount
END

GO
/****** Object:  StoredProcedure [dbo].[Table_Updates]    Script Date: 1/27/2018 8:37:10 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Table_Updates]
	@tableName varchar(100),
	@sSet nvarchar(4000),
	@sWhere nvarchar(4000)
AS
DECLARE @sSQL nvarchar(max)
BEGIN
SET @sSQL = 'UPDATE '+@tableName+' SET ' + 	@sSet + ' WHERE ' + @sWhere
EXECUTE sp_executesql @sSQL;
SELECT @@RowCount
END

GO
