USE [IDGROUP2]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertToNoSigned]    Script Date: 2/11/2018 11:43:03 PM ******/
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
/****** Object:  Table [dbo].[CmsBlog]    Script Date: 2/11/2018 11:43:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsBlog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TypeId] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[Image] [varchar](250) NULL,
	[Title] [nvarchar](1500) NULL,
	[NumberView] [int] NULL,
	[Orders] [int] NULL,
	[Summary] [nvarchar](max) NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsBlog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsCategory]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[CmsEmail]    Script Date: 2/11/2018 11:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NULL,
	[Address] [nvarchar](500) NULL,
	[Phone] [varchar](250) NULL,
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
/****** Object:  Table [dbo].[CmsEvent]    Script Date: 2/11/2018 11:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsEvent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[TypeId] [int] NULL,
	[Image] [varchar](250) NULL,
	[Title] [nvarchar](250) NULL,
	[NumberView] [int] NULL,
	[Orders] [int] NULL,
	[Summary] [nvarchar](4000) NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsIntroduce]    Script Date: 2/11/2018 11:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CmsIntroduce](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HomeContent] [nvarchar](max) NULL,
	[PageIntroduce] [nvarchar](max) NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsIntroduce] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CmsProducts]    Script Date: 2/11/2018 11:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsProducts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TypeId] [int] NULL,
	[Image] [varchar](150) NULL,
	[Name] [nvarchar](500) NULL,
	[Link] [nvarchar](150) NULL,
	[NumberView] [int] NULL,
	[Title] [nvarchar](max) NULL,
	[Summary] [nvarchar](max) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsService]    Script Date: 2/11/2018 11:43:04 PM ******/
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
	[Title] [nvarchar](max) NULL,
	[Orders] [int] NULL,
	[Summary] [nvarchar](max) NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsService] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsSlide]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[CmsSociety]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[CmsSupport]    Script Date: 2/11/2018 11:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CmsSupport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Email] [varchar](250) NULL,
	[Phone] [nvarchar](250) NULL,
	[IsRead] [bit] NULL,
	[ContentSent] [nvarchar](max) NULL,
	[IsConfirm] [bit] NULL,
	[ContentConfirm] [nvarchar](max) NULL,
	[ConfirmBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_CmsSupport] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsType]    Script Date: 2/11/2018 11:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CmsType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NULL,
	[Type] [int] NULL,
	[ShortUrl] [nvarchar](500) NULL,
	[Summary] [ntext] NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysGroup]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[SysGroupMenu]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[SysGroupUser]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[SysMenu]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[SysUser]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[UserProfile]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 2/11/2018 11:43:04 PM ******/
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
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 2/11/2018 11:43:04 PM ******/
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
SET IDENTITY_INSERT [dbo].[CmsBlog] ON 

INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, 2, N'ĐỘT NHẬP THẾ GIỚI PHIM HOẠT HÌNH STOP-MOTION ĐỈNH CAO TẠI STUDIO LAIKA', N'/Uploads/CKFinder/images/02-1428918186_300x300.jpg', N'Laika đang và sẽ tiếp tục là cái tên gây nhiều chú ý trong giới làm phim cũng như công đồng người yêu thích phim hoạt hình bởi những tác phẩm stop-motion cực kỳ xuất sắc.', 27, 1, N'<div>
	<span style="color: rgb(51, 51, 51); font-family: sans-serif, Tahoma, Geneva, sans-serif; font-size: 13px; text-align: justify;">Những ng&agrave;y gần đ&acirc;y, khi trailer ch&iacute;nh thức của bộ phim hoạt h&igrave;nh Kubo and the Two Strings đang g&acirc;y b&atilde;o v&igrave; h&igrave;nh ảnh tr&aacute;ng lệ tuyệt đẹp, người ta bắt đầu để &yacute; hơn c&aacute;i t&ecirc;n&nbsp;</span><span style="box-sizing: border-box; font-weight: 700; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(51, 51, 51); font-family: sans-serif, Tahoma, Geneva, sans-serif; font-size: 13px; text-align: justify;">Laika Entertainment</span><span style="color: rgb(51, 51, 51); font-family: sans-serif, Tahoma, Geneva, sans-serif; font-size: 13px; text-align: justify;">. Mặc d&ugrave; l&agrave; &ldquo;l&iacute;nh mới&rdquo; của l&agrave;ng phim hoạt h&igrave;nh thế giới nhưng Laika đ&atilde; nắm trong tay một bảng th&agrave;nh t&iacute;ch đ&aacute;ng nể khi ra mắt 3 phim hoạt h&igrave;nh th&igrave; cả 3 đều được đề cử Oscar v&agrave; thắng lớn tr&ecirc;n c&aacute;c mặt trận ph&ograve;ng v&eacute;. Ch&igrave;a kho&aacute; th&agrave;nh c&ocirc;ng của h&atilde;ng phim lại nằm ở một kỹ thuật l&agrave;m phim &ldquo;cũ kỹ&rdquo; tưởng như đ&atilde; bị c&ocirc;ng nghệ h&igrave;nh ảnh 3D mượt m&agrave; nuốt chửng: stop-motion. cccc</span><br />
	&nbsp;</div>
<div style="text-align: center;">
	<span style="color: rgb(51, 51, 51); font-family: sans-serif, Tahoma, Geneva, sans-serif; font-size: 13px; text-align: justify;"><img alt="" src="/Uploads/CKFinder/images/Blog/sddefault.jpg" style="width: 600px; height: 400px;" /></span><br />
	&nbsp;</div>
<div>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(51, 51, 51); font-family: sans-serif, Tahoma, Geneva, sans-serif; font-size: 13px; text-align: justify;">
		Mỗi h&atilde;ng phim hoạt h&igrave;nh danh tiếng đều sở hữu một m&agrave;u sắc ri&ecirc;ng trong phong c&aacute;ch l&agrave;m phim của m&igrave;nh. Nếu nhắc đến&nbsp;<span style="box-sizing: border-box; font-weight: 700; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased;">Disney</span>&nbsp;sẽ nghĩ đến c&acirc;u chuyện về những n&agrave;ng c&ocirc;ng ch&uacute;a xinh đẹp, Pixar &ldquo;thống trị&rdquo; l&agrave;ng phim hoạt h&igrave;nh với những t&aacute;c phẩm 3D trau chuốt tỉ mỉ v&agrave; sự s&aacute;ng tạo kh&ocirc;ng bi&ecirc;n giới, studio đến từ Nhật Bản Ghibli lại nổi tiếng với những tuyệt phẩm lay động sử dụng kỹ thuật vẽ tay với m&agrave;u nước trong trẻo, kho&aacute;ng đạt, mang đậm tinh thần nước Nhật,&hellip;th&igrave; Laika lại &ldquo;một m&igrave;nh một ngựa&rdquo; với c&ocirc;ng nghệ l&agrave;m phim stop-motion độc đ&aacute;o.</p>
	<p style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(51, 51, 51); font-family: sans-serif, Tahoma, Geneva, sans-serif; font-size: 13px; text-align: justify;">
		Định hướng theo đuổi c&aacute;c nghệ thuật truyền thống l&acirc;u đời, Laika chỉ tập trung ph&aacute;t triển, mở rộng kỹ thuật l&agrave;m phim đ&atilde; 120 năm tuổi n&agrave;y. Tất cả quy tr&igrave;nh sản xuất c&aacute;c bộ phim của Laika đều được l&agrave;m bằng tay, từng bộ phận của c&aacute;c b&uacute;p b&ecirc; tạo h&igrave;nh nh&acirc;n vật cũng được tỉa t&oacute;t thủ c&ocirc;ng rất tỉ mỉ.</p>
</div>
<br />
', 1, 5, CAST(N'2018-01-30 00:00:00.000' AS DateTime), 3, CAST(N'2018-01-30' AS Date))
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, 2, N'Phần 2 của ‘Những chú chim giận dữ’ chính thức được sản xuất', N'/Uploads/CKFinder/images/Blog/80-angrybirdsmovie-2016-08-25-1475224467_500x500.jpg', N'Không nhận được nhiều sự kỳ vọng từ khi công bố dự án, nhưng thành công nhất định trong mùa hè vừa qua của The angry birds Movie đã khiến những nhà sản xuất tự tin làm tiếp phần 2 cho ‘Những chú chim giận dữ‘.', 6, 1, N'<div style="text-align: center;">
	<img alt="" src="/Uploads/CKFinder/images/Blog/80-angry-birds-movie-sequel-2016-08-25.jpg" style="width: 600px; height: 300px;" /><br />
	<br />
	<div style="text-align: left;">
		&nbsp;</div>
	<div style="text-align: left;">
		<span style="color: rgb(0, 0, 0); font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify;">Thu được 100 triệu đ&ocirc; la ở thị trường nước Mỹ n&oacute;i ri&ecirc;ng v&agrave; 347 triệu đ&ocirc; la tr&ecirc;n to&agrave;n cầu, d&ugrave; kh&ocirc;ng phải l&agrave; một con số lợi nhuận qu&aacute; ấn tượng, nhưng nếu x&eacute;t ở bối cảnh phải đối đầu với những &ldquo;h&agrave;ng&nbsp;</span><span style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify; color: rgb(0, 0, 0);">khủng&rdquo; như Finding Dory, Zootopia hay The&nbsp;</span><a href="http://molo.vn/database-phim/dang-cap-thu-cung/" rel="no" style="box-sizing: border-box; color: rgb(230, 93, 79); margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify; text-decoration-line: none !important;" target="no"><span style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(0, 0, 0);">secret pets of life</span></a><span style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify; color: rgb(0, 0, 0);">, những g&igrave; The Angry Birds Movie đạt được vẫn đ&aacute;ng được khen ngợi v&agrave; kh&iacute;ch lệ</span></div>
	<div>
		<img alt="" src="/Uploads/CKFinder/images/Blog/sddefault.jpg" style="width: 1000px; height: 667px;" /></div>
	<div style="text-align: left;">
		<span style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify; color: rgb(0, 0, 0);">CEO của Rovio Entertainment, Kati Levoranta, c&ocirc;ng ty đến từ Phần Lan đ&atilde; sản xuất n&ecirc;n Angry Birds, đ&atilde; ch&iacute;nh thức x&aacute;c nhận về kế hoạch sản xuất phần tiếp theo của bộ phim n&agrave;y&nbsp;</span><span style="color: rgb(0, 0, 0); font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify;">Rovio từ l&acirc;u đ&atilde; theo đuổi kế hoạch biến game được mọi người y&ecirc;u th&iacute;ch n&agrave;y trở th&agrave;nh một c&acirc;u chuyện phim. V&agrave; khi những cố gắng của họ trong phần phim đầu ti&ecirc;n đ&atilde; g&acirc;y được một sự ảnh hưởng kh&ocirc;ng&nbsp;&nbsp;</span><span style="color: rgb(0, 0, 0); font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify;">nhỏ, sản xuất phần tiếp theo kh&ocirc;ng phải l&agrave; điều g&igrave; qu&aacute; kh&oacute; hiểu.</span></div>
	<div>
		<img alt="" src="/Uploads/CKFinder/images/Blog/80-angrybirdsmovie-2016-08-2520(1).jpg" style="width: 600px; height: 369px;" /></div>
	<div>
		<img alt="" src="/Uploads/CKFinder/images/Blog/80-angrybirdsmovie-2016-08-2520(1).jpg" style="width: 1000px; height: 615px;" /></div>
	<div style="text-align: left;">
		<span style="color: rgb(0, 0, 0); font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify;">D&ugrave; rất h&aacute;o hức, nhưng kh&aacute;n giả phải chờ đến tận 4 năm nữa để được lại nh&igrave;n thấy&nbsp;</span><span style="box-sizing: border-box; font-weight: 700; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(0, 0, 0); font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify;">những ch&uacute; chim giận dữ</span><span style="color: rgb(0, 0, 0); font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify;">&nbsp;n&agrave;y tr&ecirc;n m&agrave;n ảnh rộng. H&atilde;y c&ugrave;ng chờ đợi xem c&acirc;u chuyện của phần tiếp theo sẽ c&oacute; những điểm t</span><span style="color: rgb(0, 0, 0); font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify;">h&uacute; vị v&agrave; hấp dẫn n&agrave;o.</span><br />
		<span style="color: rgb(0, 0, 0); font-family: &quot;times new roman&quot;, times, serif; font-size: 16px; text-align: justify;">Những th&ocirc;ng tin mới nhất về The Angry Birds Movie 2 sẽ được cập nhật ngay khi c&oacute; thể.</span></div>
	<div class="ui-draggable" style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(115, 115, 115); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 16px;">
		<div class="row clearfix" style="box-sizing: border-box; margin: 0px -15px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased;">
			&nbsp;</div>
	</div>
</div>
<br />
', 1, 5, CAST(N'2017-01-30 00:00:00.000' AS DateTime), 5, CAST(N'2018-01-30' AS Date))
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, 2, N'ĐỘT NHẬP THẾ GIỚI PHIM HOẠT HÌNH STOP-MOTION ĐỈNH CAO TẠI STUDIO LAIKA', N'/Uploads/CKFinder/images/02-1428918186_300x300.jpg', N'Laika đang và sẽ tiếp tục là cái tên gây nhiều chú ý trong giới làm phim cũng như công đồng người yêu thích phim hoạt hình bởi những tác phẩm stop-motion cực kỳ xuất sắc.', 97, 1, N'<div>', 1, 5, CAST(N'2016-04-03 00:00:00.000' AS DateTime), 5, NULL)
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, 2, N'Phần 2 của ‘Những chú chim giận dữ’ chính thức được sản xuất', N'/Uploads/CKFinder/images/Blog/80-angrybirdsmovie-2016-08-25-1475224467_500x500.jpg', N'Không nhận được nhiều sự kỳ vọng từ khi công bố dự án, nhưng thành công nhất định trong mùa hè vừa qua của The angry birds Movie đã khiến những nhà sản xuất tự tin làm tiếp phần 2 cho ‘Những chú chim giận dữ‘.', 10, 1, N'<div style="text-align: center;">', 1, 5, CAST(N'2018-01-04 00:00:00.000' AS DateTime), 5, NULL)
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, 2, N'ĐỘT NHẬP THẾ GIỚI PHIM HOẠT HÌNH STOP-MOTION ĐỈNH CAO TẠI STUDIO LAIKA', N'/Uploads/CKFinder/images/02-1428918186_300x300.jpg', N'Laika đang và sẽ tiếp tục là cái tên gây nhiều chú ý trong giới làm phim cũng như công đồng người yêu thích phim hoạt hình bởi những tác phẩm stop-motion cực kỳ xuất sắc.', 102, 1, N'<div>', 1, 5, CAST(N'2018-01-30 00:00:00.000' AS DateTime), 5, NULL)
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, 2, N'Phần 2 của ‘Những chú chim giận dữ’ chính thức được sản xuất', N'/Uploads/CKFinder/images/Blog/80-angrybirdsmovie-2016-08-25-1475224467_500x500.jpg', N'Không nhận được nhiều sự kỳ vọng từ khi công bố dự án, nhưng thành công nhất định trong mùa hè vừa qua của The angry birds Movie đã khiến những nhà sản xuất tự tin làm tiếp phần 2 cho ‘Những chú chim giận dữ‘.', 6, 1, N'<div style="text-align: center;">', 1, 5, CAST(N'2016-01-30 00:00:00.000' AS DateTime), 5, NULL)
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, 2, N'Phần 2 của ‘Những chú chim giận dữ’ chính thức được sản xuất', N'/Uploads/CKFinder/images/Blog/80-angrybirdsmovie-2016-08-25-1475224467_500x500.jpg', N'Không nhận được nhiều sự kỳ vọng từ khi công bố dự án, nhưng thành công nhất định trong mùa hè vừa qua của The angry birds Movie đã khiến những nhà sản xuất tự tin làm tiếp phần 2 cho ‘Những chú chim giận dữ‘.', 3, 1, N'<div style="text-align: center;">', 1, 5, CAST(N'2018-01-30 00:00:00.000' AS DateTime), 5, NULL)
SET IDENTITY_INSERT [dbo].[CmsBlog] OFF
SET IDENTITY_INSERT [dbo].[CmsCategory] ON 

INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'GIỚI THIỆU', N'gioi-thieu', N'c', 2, 1, 1, CAST(N'2017-02-02' AS Date), NULL, CAST(N'2018-01-24' AS Date))
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'TRANG CHỦ', N' ', NULL, 1, 1, -1, CAST(N'2018-01-24' AS Date), 3, CAST(N'2018-01-25' AS Date))
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'DỊCH VỤ', N'dich-vu', NULL, 3, 1, -1, CAST(N'2018-01-24' AS Date), NULL, NULL)
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'VIDEO', N'san-pham', NULL, 4, 1, -1, CAST(N'2018-01-24' AS Date), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'TIN TỨC', N'blog', NULL, 5, 1, -1, CAST(N'2018-01-24' AS Date), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsCategory] ([Id], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'LIÊN HỆ', N'/lien-he', NULL, 6, 1, -1, CAST(N'2018-01-24' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[CmsCategory] OFF
SET IDENTITY_INSERT [dbo].[CmsEmail] ON 

INSERT [dbo].[CmsEmail] ([Id], [Email], [Address], [Phone], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'bookidvn@gmail.com', N'Phòng 1701 tầng 17, tòa nhà Cảnh sát 113, ngõ 299, Trung Kính, quận Cầu Giấy, Hà Nội', N'01222208180', 1, 1, 5, CAST(N'2018-01-25' AS Date), 5, CAST(N'2018-01-31' AS Date))
INSERT [dbo].[CmsEmail] ([Id], [Email], [Address], [Phone], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'host@gmail.com', N'25123', N'21', 1, 0, 5, CAST(N'2018-01-25' AS Date), 5, CAST(N'2018-01-31' AS Date))
INSERT [dbo].[CmsEmail] ([Id], [Email], [Address], [Phone], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'DEMO@TEST', N'233', N'213', 1, 0, 5, CAST(N'2018-01-25' AS Date), 5, CAST(N'2018-01-31' AS Date))
SET IDENTITY_INSERT [dbo].[CmsEmail] OFF
SET IDENTITY_INSERT [dbo].[CmsEvent] ON 

INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Sản phẩm', 13, N'/Uploads/CKFinder/images/Su_kien/08-1428918118_300x300.png', N'Slide2 yutuygf', 18, 2, N'﻿Th&agrave;nh lập v&agrave; ph&aacute;t triển bộ phận sản xuất phi<strong>m hoạt h&igrave;nh 2D</strong>', 1, 5, CAST(N'2018-01-28 00:00:00.000' AS DateTime), 3, CAST(N'2018-02-11' AS Date))
INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'02.07.2014', 13, N'/Uploads/CKFinder/images/Su_kien/02-1428918186_300x300.jpg', N'Hi Pencil Studio chính thức ra mắt trụ sở mới', 7, 1, N'
﻿Thành lập và phát triển bộ phận sản xuất phim hoạt hình 2D', 1, 5, CAST(N'2018-01-28 00:00:00.000' AS DateTime), 5, CAST(N'2018-01-29' AS Date))
INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'03.08.2014', 13, N'/Uploads/CKFinder/images/Su_kien/08-1428918118_300x300.png', N'Slide2', 3, 1, N'﻿Th&agrave;nh lập v&agrave; ph&aacute;t triển bộ phận sản xuất phim hoạt h&igrave;nh 2D', 1, 5, CAST(N'2018-01-28 00:00:00.000' AS DateTime), 3, CAST(N'2018-02-11' AS Date))
INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'SP một', 13, N'/Uploads/CKFinder/images/Su_kien/02-1428918186_300x300.jpg', N'Hi Pencil Studio chính thức ra mắt trụ sở mới', 0, 1, N'﻿Th&agrave;nh lập v&agrave; ph&aacute;t triển bộ phận sản xuất phim hoạt h&igrave;nh 2D', 1, 5, CAST(N'2018-01-28 00:00:00.000' AS DateTime), 3, CAST(N'2018-02-11' AS Date))
INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'03.08.2014', 13, N'/Uploads/CKFinder/images/Su_kien/08-1428918118_300x300.png', N'Slide2', 1, 7, N'﻿Th&agrave;nh lập v&agrave; ph&aacute;t triển bộ phận sản xuất phim hoạt h&igrave;nh 2D', 1, 5, CAST(N'2018-01-28 00:00:00.000' AS DateTime), 3, CAST(N'2018-02-11' AS Date))
INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'SP ba', 14, N'/Uploads/CKFinder/images/Su_kien/02-1428918186_300x300.jpg', N'Hi Pencil Studio chính thức ra mắt trụ sở mới', 0, 3, N'<p>
	Hi Pencil Studio ch&iacute;nh thức ra mắt trụ sở mới</p>
<p>
	&nbsp;</p>
', 1, 5, CAST(N'2018-01-28 00:00:00.000' AS DateTime), 3, CAST(N'2018-02-11' AS Date))
INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'SP hai', 14, N'/Uploads/CKFinder/images/Su_kien/02-1428918186_300x300.jpg', N'Hi Pencil Studio chính thức ra mắt trụ sở mới', 1, 2, N'<p>
	Hi Pencil Studio ch&iacute;nh thức ra mắt trụ sở mới</p>
<p>
	&nbsp;</p>
', 1, 5, CAST(N'2018-01-28 00:00:00.000' AS DateTime), 3, CAST(N'2018-02-11' AS Date))
INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'02.07.2014', 13, N'/Uploads/CKFinder/images/Su_kien/02-1428918186_300x300.jpg', N'Hi Pencil Studio chính thức ra mắt trụ sở mới', 0, 1, N'<p>

﻿Thành lập và phát triển bộ phận sản xuất phim hoạt hình 2D<strong>
</strong></p>', 1, 5, CAST(N'2018-01-28 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'SP bốn', 14, N'/Uploads/CKFinder/images/Su_kien/02-1428918186_300x300.jpg', N'Hi Pencil Studio chính thức ra mắt trụ sở mới', 0, 4, N'<p>
	﻿Th&agrave;nh lập v&agrave; ph&aacute;t triển bộ phận sản xuất phim hoạt h&igrave;nh 2D<strong> </strong></p>
', 1, 5, CAST(N'2018-01-28 00:00:00.000' AS DateTime), 3, CAST(N'2018-02-11' AS Date))
INSERT [dbo].[CmsEvent] ([Id], [Name], [TypeId], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'test', 14, N'/Uploads/CKFinder/images/Su_kien/08-1428918118_300x300.png', N'c', 12, 1, N'ca', 1, 3, CAST(N'2018-02-11 21:47:27.000' AS DateTime), 3, CAST(N'2018-02-11' AS Date))
SET IDENTITY_INSERT [dbo].[CmsEvent] OFF
SET IDENTITY_INSERT [dbo].[CmsIntroduce] ON 

INSERT [dbo].[CmsIntroduce] ([Id], [HomeContent], [PageIntroduce], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'<span style="font-size:16px;"><span style="font-family:tahoma,geneva,sans-serif;"><span style="color: rgb(51, 51, 51);">Được th&agrave;nh lập từ năm 2015 bởi những con người t&agrave;i hoa v&agrave; t&acirc;m huyết, BOOKID l&agrave; một đơn vị thiết kế s&aacute;ng tạo c&aacute;c nội dung truyền th&ocirc;ng chất lượng cao. Ch&uacute;ng t&ocirc;i lu&ocirc;n hướng đến tạo ra c&aacute;c gi&aacute; trị đ&iacute;ch thực cho kh&aacute;ch h&agrave;ng của m&igrave;nh. BOOKID sản xuất v&agrave; cung cấp c&aacute;c g&oacute;i nội dung phim hoạt h&igrave;nh 2D; c&aacute;c chương tr&igrave;nh, phần mềm gi&aacute;o dục to&agrave;n diện d&agrave;nh cho thiếu nhi; c&aacute;c ấn phẩm nhận diện thương hiệu v&agrave; quảng c&aacute;o độc đ&aacute;o ri&ecirc;ng biệt... C&aacute;c g&oacute;i dịch vụ được ch&uacute;ng t&ocirc;i đẩy mạnh x&acirc;y dựng cho kh&aacute;ch h&agrave;ng bao gồm c&aacute;c lĩnh vực: Animation, Illustration, Web design,&nbsp; App Design, Graphic Design... Với đội ngũ nh&acirc;n sự năng động v&agrave; đầy s&aacute;ng tạo, BOOKID tạo ra m&ocirc;i trường l&agrave;m việc th&acirc;n thiện, phong c&aacute;ch chuy&ecirc;n nghiệp, &yacute; thức tr&aacute;ch nhiệm l&agrave;m h&agrave;i l&ograve;ng mọi nhu cầu d&ugrave; l&agrave; khắt khe nhất của kh&aacute;ch h&agrave;ng cũng như c&aacute;c đối t&aacute;c.</span></span></span><br style="color: rgb(51, 51, 51); font-family: &quot;r0c0i Linotte&quot;; font-size: 17px; box-sizing: border-box; -webkit-font-smoothing: antialiased;" />
<span aria-labelledby="cke_editor1_arialbl" dir="ltr" id="cke_editor1" lang="vi" role="application" tabindex="0" title=""><span role="presentation"><span role="presentation">
<style type="text/css">
.cke_skin_kama{visibility:hidden;}</style>
</span></span></span>', N'<div>
	<div style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(51, 51, 51); font-family: &quot;r0c0i Linotte&quot;; font-size: 17px;">
		<span style="font-size:16px;"><span style="font-family:tahoma,geneva,sans-serif;">Được th&agrave;nh lập từ năm 2015 bởi những con người t&agrave;i hoa v&agrave; t&acirc;m huyết, BOOKID l&agrave; một đơn vị thiết kế s&aacute;ng tạo c&aacute;c nội dung truyền th&ocirc;ng chất lượng cao. Ch&uacute;ng t&ocirc;i lu&ocirc;n hướng đến tạo ra c&aacute;c gi&aacute; trị đ&iacute;ch thực cho kh&aacute;ch h&agrave;ng của m&igrave;nh. BOOKID sản xuất v&agrave; cung cấp c&aacute;c g&oacute;i nội dung phim hoạt h&igrave;nh 2D; c&aacute;c chương tr&igrave;nh, phần mềm gi&aacute;o dục to&agrave;n diện d&agrave;nh cho thiếu nhi; c&aacute;c ấn phẩm nhận diện thương hiệu v&agrave; quảng c&aacute;o độc đ&aacute;o ri&ecirc;ng biệt... C&aacute;c g&oacute;i dịch vụ được ch&uacute;ng t&ocirc;i đẩy mạnh x&acirc;y dựng cho kh&aacute;ch h&agrave;ng bao gồm c&aacute;c lĩnh vực: Animation, Illustration, Game Design, App Design, Graphic Design... Với đội ngũ nh&acirc;n sự năng động v&agrave; đầy s&aacute;ng tạo, BOOKID tạo ra m&ocirc;i trường l&agrave;m việc th&acirc;n thiện, phong c&aacute;ch chuy&ecirc;n nghiệp, &yacute; thức tr&aacute;ch nhiệm l&agrave;m h&agrave;i l&ograve;ng mọi nhu cầu d&ugrave; l&agrave; khắt khe nhất của kh&aacute;ch h&agrave;ng cũng như c&aacute;c đối t&aacute;c.</span></span><br style="box-sizing: border-box; -webkit-font-smoothing: antialiased;" />
		&nbsp;</div>
	<div style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(51, 51, 51); font-family: &quot;r0c0i Linotte&quot;; font-size: 17px;">
		<span style="font-size:16px;"><span style="font-family:tahoma,geneva,sans-serif;"><strong>Ch&uacute;ng t&ocirc;i tự tin cung cấp cho kh&aacute;ch h&agrave;ng c&aacute;c dịch vụ:</strong></span></span></div>
	<div style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(51, 51, 51); font-family: &quot;r0c0i Linotte&quot;; font-size: 17px;">
		<span style="font-size:16px;"><span style="font-family:tahoma,geneva,sans-serif;">&bull; Thiết kế giao diện game, app, phần mềm gi&aacute;o dục tương t&aacute;c người d&ugrave;ng.</span></span></div>
	<div style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(51, 51, 51); font-family: &quot;r0c0i Linotte&quot;; font-size: 17px;">
		<span style="font-size:16px;"><span style="font-family:tahoma,geneva,sans-serif;">&bull; Thiết kế video gi&aacute;o dục, clip ca nhạc, quảng c&aacute;o, chuyển động 2D.</span></span></div>
	<div style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(51, 51, 51); font-family: &quot;r0c0i Linotte&quot;; font-size: 17px;">
		<span style="font-size:16px;"><span style="font-family:tahoma,geneva,sans-serif;">&bull; Thiết kế minh họa, x&acirc;y dựng nh&acirc;n vật, lập storyboard.</span></span></div>
	<div style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; -webkit-font-smoothing: antialiased; color: rgb(51, 51, 51); font-family: &quot;r0c0i Linotte&quot;; font-size: 17px;">
		<span style="font-size:16px;"><span style="font-family:tahoma,geneva,sans-serif;">&bull; Thiết kế sản phẩm in ấn.</span></span></div>
</div>
<br />
', 1, 1, CAST(N'2017-02-02' AS Date), 5, CAST(N'2018-02-10' AS Date))
SET IDENTITY_INSERT [dbo].[CmsIntroduce] OFF
SET IDENTITY_INSERT [dbo].[CmsProducts] ON 

INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, 1, N'/Uploads/CKFinder/images/San_pham/canh-1-2b-1472116898_500x500.jpg', N'Thơ Cho Bé | Bài Thơ BÉ CHÚC TẾT ÔNG BÀ| Thơ Mầm Non | Thơ Thiếu Nhi | BOOKID 💞', N'https://www.youtube.com/watch?v=3P0ak5UQs6c', 20, NULL, N'Khi tết đến, ch&uacute;ng m&igrave;nh thường đi ch&uacute;c tết &ocirc;ng b&agrave; đ&uacute;ng kh&ocirc;ng n&agrave;o! B&agrave;i thơ &ldquo;B&eacute; ch&uacute;c tết &ocirc;ng b&agrave;&rdquo; chắc chắn sẽ l&agrave;m vui l&ograve;ng &ocirc;ng b&agrave; đấy!<br />
B&agrave;i thơ B&eacute; ch&uacute;c Tết &ocirc;ng b&agrave; ★<br />
Năm cũ vừa qua<br />
Bước sang năm mới<br />
H&ocirc;m nay con tới<br />
K&iacute;nh ch&uacute;c &ocirc;ng b&agrave;<br />
Sống l&acirc;u sức khỏe,<br />
Trẻ m&atilde;i kh&ocirc;ng gi&agrave;<br />
Y&ecirc;u thương thuận h&ograve;a<br />
Cửa nh&agrave; sung t&uacute;c<br />
Hạnh ph&uacute;c an khang<br />
Ơn tr&ecirc;n thương ban<br />
Suốt năm may mắn<br />
L&agrave;m ăn phấn chấn<br />
Ph&uacute;c, lộc, thọ, t&agrave;i<br />
&Ocirc;ng b&agrave; hưởng trọn<br />
Đ&ocirc;i lời con mọn<br />
Xin k&iacute;nh d&acirc;ng l&ecirc;n.<br />
&Ocirc;ng b&agrave; đừng qu&ecirc;n<br />
L&igrave; x&igrave; cho con<br />
Năm mới lấy h&ecirc;n<br />
Con xin c&aacute;m ơn &ocirc;ng b&agrave;.', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, 1, N'/Uploads/CKFinder/images/San_pham/canh-1-3-1472116654_500x500.jpg', N'Bài thơ ÔNG MẶT TRỜI CỦA BÉ | Thơ cho bé | Thơ thiếu nhi | Thơ mầm non | Bookid', N'https://www.youtube.com/watch?v=WT8Pan6B_zI&t=82s', 6, NULL, N'Các bạn nhỏ ơi! Ông mặt trời thường xuất hiện khi nào nhỉ? Có bạn nhỏ nào trả lời được luôn không? À…đúng rồi, ông mặt trời xuất hiện vào buổi sáng sớm chiếu sáng giúp mọi người làm việc đấy! 
Bây giờ, chúng mình cùng <a target="_blank" rel="nofollow" href="https://www.youtube.com/results?search_query=%23BooKid">#BooKid</a> học bài thơ “Ông mặt trời của bé” nhé!&nbsp;<div><br></div><div>★ Bài thơ ÔNG MẶT TRỜI CỦA BÉ ★
Một đêm đã qua đi
Ông mặt trời thức giấc
Bé dậy tập thể dục
Ông mặt trời lên cao
Bé thấy lòng nôn nao
Đi học trễ chưa nhỉ?
Ông mặt trời thỏ thẻ:
Chưa đâu bé đi đi!

﻿</div>', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-01-31' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, 3, N'/Uploads/CKFinder/images/San_pham/JINGLE-BELL-01.png', N'Jingle Bell - Christmas Song - Kids Songs - Nursery Rhymes - BooKid', N'https://www.youtube.com/watch?v=kpIZLgYFKVk', 23, N'"Bells are ringing, ringing, ringing..." Red-nose reindeer is calling you! He will ride the cart to bring you all around the town. Join their trip to visit #Bookid in the winter. ', N'<p>
	<strong><span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;">&nbsp;★ Lyrics: 🌟JINGLE BELL</span></span></strong></p>
<p>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;">Dashing through the snow<br />
	In a one-horse open sleigh<br />
	O&rsquo;er the fields we go<br />
	Laughing all the way<br />
	Bells on bobtails ring<br />
	Making spirits bright<br />
	What fun it is to ride and sing<br />
	A sleighing song tonight.<br />
	<br />
	Jingle bells, jingle bells<br />
	Jingle all the way<br />
	Oh what fun it is to ride<br />
	In a one-horse open sleigh, hey<br />
	Jingle bells, jingle bells<br />
	Jingle all the way<br />
	Oh what fun it is to ride<br />
	In a one-horse open sleigh.<br />
	<br />
	A day or two ago<br />
	I thought I&rsquo;d take a ride and soon,<br />
	Miss Fanny Bright Was<br />
	Seated by my side<br />
	The horse was lean and lank<br />
	Misfortune seemed his lot<br />
	He got into a drifted bank<br />
	And then we got upsot.<br />
	<br />
	Jingle bells, jingle bells<br />
	Jingle all the way<br />
	Oh what fun it is to ride<br />
	In a one-horse open sleigh, hey<br />
	Jingle bells, jingle bells<br />
	Jingle all the way<br />
	Oh what fun it is to ride<br />
	In a one-horse open sleigh.&nbsp;<br />
	<br />
	<a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23nurseryrhymes" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#nurseryrhymes</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23kidssongs" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#kidssongs</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23childrensongs" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#childrensongs</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23christmassongs" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#christmassongs</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23xmas" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#xmas</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23christmassongsforkids" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#christmassongsforkids</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23christmas" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#christmas</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23christmascarol" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#christmascarol</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23wewishyou" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#wewishyou</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23wewish" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#wewish</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23jinglebell" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#jinglebell</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23deckthehalls" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#deckthehalls</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23happynewyear" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#happynewyear</a><br style="font-family: tahoma, geneva, sans-serif; font-size: 14px;" />
	<br style="font-family: tahoma, geneva, sans-serif; font-size: 14px;" />
	<span style="color: rgb(17, 17, 17); white-space: pre-wrap;">★ Nhấn SUBSCRIBE để cập nhật c&aacute;c video mới nhất từ Bookid bạn nh&eacute;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/BooKidvn" style="font-size: 14px; display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://www.youtube.com/BooKidvn</a></span></span><br />
	<br />
	&nbsp;</p>
<p>
	&nbsp;</p>
', 1, 1, 3, CAST(N'2018-01-28 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, 3, N'/Uploads/CKFinder/images/San_pham/DECK-THE-HALL-01.png', N'Deck The Halls - Christmas Song - Kids Songs - Nursery Rhymes - BooKid', N'https://www.youtube.com/watch?v=QSBiM7B3hXg', 19, N'Here is another song for Christmas Time!!! Today #Bookid Little Baby Team will decorate their house to welcome upcoming holiday, let''s watch what they do! ', N'<p>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><strong>&nbsp;★ Lyrics: 🎄Deck The Halls</strong></span></span></p>
<p>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;">Deck the halls with boughs of holly, Fa la la la la la la la!<br />
	Tis the season to be jolly, Fa la la la la la la la!<br />
	Don we now our gay apparel, Fa la la la la la la la!<br />
	Troll the ancient Yuletide carol, Fa la la la la la la la!<br />
	<br />
	Fast away the old year passes, Fa la la la la la la la!<br />
	Hail the new, ye lads and lasses, Fa la la la la la la la!<br />
	Sing we joyous all together! Fa la la la la la la la!<br />
	Heedless of the wind and weather, Fa la la la la la la la!<br />
	<br />
	<a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23nurseryrhymes" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#nurseryrhymes</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23kidssongs" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#kidssongs</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23childrensongs" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#childrensongs</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23christmassongs" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#christmassongs</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23xmas" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#xmas</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23christmassongsforkids" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#christmassongsforkids</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23christmas" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#christmas</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23christmascarol" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#christmascarol</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23wewishyou" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#wewishyou</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23wewish" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#wewish</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23jinglebell" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#jinglebell</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23deckthehalls" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#deckthehalls</a><span style="color: rgb(17, 17, 17); white-space: pre-wrap;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23happynewyear" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#happynewyear</a><br />
	<br />
	<span style="color: rgb(17, 17, 17); white-space: pre-wrap;">★ Nhấn SUBSCRIBE để cập nhật c&aacute;c video mới nhất từ Bookid bạn nh&eacute;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/BooKidvn" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://www.youtube.com/BooKidvn</a></span></span></p>
', 1, 1, 5, CAST(N'2018-01-29 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, 1, N'/Uploads/CKFinder/images/San_pham/canh-1-2b-1472116898_500x500.jpg', N'Thơ Cho Bé | Bài Thơ VÈ CHÚC TẾT | Thơ Mầm Non | Thơ Thiếu Nhi | BOOKID', N'https://www.youtube.com/watch?v=ZaGW8wCgRqU', 3, NULL, N'Chào các bạn nhỏ yêu quý! Có một bài vè chúc tết rất sôi động mà chúng mình có thể học để đi chúc tết mọi người. Cùng nghe <a target="_blank" rel="nofollow" href="https://www.youtube.com/results?search_query=%23BooKid">#BooKid</a> đọc “Vè chúc tết” nhé!&nbsp;<div><br></div><div>&nbsp;★ Vè chúc Tết ★
Nghe vẻ nghe ve
Nghe vè Tết đến
Bạn bè thân mến
Cùng nhau sum vầy
Sức khỏe tràn đầy
Gia đình hạnh phúc
Nhà nhà sung túc
Mừng đón xuân sang
Một nhành mai vàng
Bên mâm ngũ quả
Tiếng cười rộn rã
Vang khắp mọi nhà
Đây đó gần xa
Tiếng cười trẻ nhỏ
Rộn ràng ngoài ngỏ
Mừng tuổi ông bà
Kính chúc mẹ cha
Sống lâu hạnh phúc
Cháu con xin chúc
Làm ăn phát tài
An khang thịnh vượng

﻿</div>', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-01-31' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, 1, N'/Uploads/CKFinder/images/San_pham/canh-1-2b-1472116898_500x500.jpg', N'Thơ Cho Bé | Bài Thơ NĂM MỚI BÉ CHÚC | Thơ Mầm Non | Thơ Thiếu Nhi | BOOKID', N'https://www.youtube.com/watch?v=9MI0X9QEpUE', 10, NULL, N'Chắc chắn bạn nhỏ nào cũng mong chờ tết đến đúng không, đặc biệt ai cũng muốn được nhận tiền lì xì và những lời chúc từ ông bà, bố mẹ. Hôm nay, hãy cùng <a target="_blank" rel="nofollow" href="https://www.youtube.com/results?search_query=%23BooKid">#BooKid</a> đọc một bài thơ về những lời chúc ngọt ngào ngày tết nhé!&nbsp;<div>﻿&nbsp;</div><div>★ Bài thơ Năm mới bé chúc ★
Năm mới con chúc
Ba luôn hoan hỉ
Sức khỏe bền bỉ
Công danh hết ý
Tiền vào bạc tỉ
Tiền ra ri rỉ
Như giọt cà phê.
Con chúc…
Chúc ông bà một tô như ý
Chúc cô chú một chén an khang
Chúc anh chị một dĩa tài lộc.

﻿</div>', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-01-31' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, 1, N'/Uploads/CKFinder/images/San_pham/canh-1-2b-1472116898_500x500.jpg', N'Thơ Cho Bé | Bài Thơ NĂM MỚI BÉ CHÚC | Thơ Mầm Non | Thơ Thiếu Nhi | BOOKID', N'https://www.youtube.com/watch?v=Ffj0QIqAauI&t=161s', 2, NULL, N'Tết đến, chắc hẳn bạn nhỏ nào cũng rất thích đi chúc tết mọi người đúng không nào? Vậy, chúng mình chúc như thế nào để mọi người đều vui nhỉ? Mình cùng đọc bài thơ “Năm mới bé chúc” nhé! 
<br>

<div><br></div><div>

★ Bài thơ Năm mới bé chúc ★
Năm mới bé chúc
Cả nhà sung túc
Vạn sự khang an
Phước tràn lộc sang
Mọi ngày may mắn
Bé cười tươi tắn
Kính chúc mọi người
Hạnh phúc xuân ngời
Như gia đình nhà bé.
Kính chúc! Kính chúc!
<br>

<br></div>', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-01-31' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, 1, N'/Uploads/CKFinder/images/San_pham/canh-1-2b-1472116898_500x500.jpg', N'Thơ Cho Bé | Bài Thơ XUÂN SANG | Thơ Mầm Non | Thơ Thiếu Nhi | BOOKID', N'https://www.youtube.com/watch?v=4HdacX2Ho84&t=5s', 2, NULL, N'Tết Tết Tết Tết đến rồi! Tết Tết Tết Tết đến rồi! 
Chắc chắn các bạn nhỏ đang rất mong chờ ngày tết đúng không? Tết được mua quần áo mới, được đi chơi chúc tết ông bà và còn được lì xì nữa. Hôm nay chúng mình cùng <a target="_blank" rel="nofollow" href="https://www.youtube.com/results?search_query=%23BooKid">#BooKid</a>
 đọc bài thơ “Xuân sang” nhé!

<div><br></div><div>

★ Bài thơ Xuân sang ★
Xuân sang tết đến mọi nhà
Con chúc ông bà sức khỏe, an khang
Chúc cô chú bác giàu sang
Một năm sung túc cười vang mỗi ngày
Chúc anh chúc chị học hay
Con ngoan trò giỏi đợi ngày công danh
Chúc cho vạn sự tốt lành
Mậu Tuất năm mới bức tranh xuân ngời.
<br>

<br></div>', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-01-31' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, 5, N'/Uploads/CKFinder/images/San_pham/canh-1-2b-1472116898_500x500.jpg', N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 10 | BooKid', N'https://www.youtube.com/watch?v=_-Ltiu0umPI', 2, N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 10 | BooKid', N'&nbsp;V&igrave; sao c&oacute; lo&agrave;i c&acirc;y th&iacute;ch phơi nắng, c&oacute; lo&agrave;i lại kh&ocirc;ng th&iacute;ch?', 1, -1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, 4, N'/Uploads/CKFinder/images/San_pham/BA-BA-TIM-NHA-01.png', N'Ba Ba Tìm Nhà | Truyện cổ tích | Truyện kể bé nghe | Truyện Ngụ Ngôn | BooKid', N'https://www.youtube.com/watch?v=CsoN7wXv_QM&t=2s', 5, N'Ba Ba Tìm Nhà | Truyện cổ tích | Truyện kể bé nghe | Truyện Ngụ Ngôn | BooKid', NULL, 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, 3, N'/Uploads/CKFinder/images/San_pham/canh-1-2b-1472116898_500x500.jpg', N'The Muffin Man | Kid Songs | Nursery Rhymes | English Songs | BooKid', N'https://www.youtube.com/watch?v=ytt64dXRM6Q&t=5s', 5, N'The Muffin Man | Kid Songs | Nursery Rhymes | English Songs | BooKid', N'It&#39;s nursery rhyme time! Do you know the Muffin Man? Sing along with one of our favorite kids songs! 😘😘😘&nbsp;<br />
<br />
<div>
	&nbsp;★ Lyrics: The muffin man<br />
	<br />
	Do you know the muffin man,<br />
	The muffin man, the muffin man?<br />
	Do you know the muffin man,<br />
	Who lives on Drury Lane?<br />
	<br />
	Yes, we know seen the muffin man,<br />
	The muffin man, the muffin man.<br />
	Yes, we know seen the muffin man,<br />
	Who lives on Drury Lane.<br />
	<div>
		<a target="_blank" rel="nofollow" href="https://www.youtube.com/redirect?redir_token=LOjkt98sc-83hCfDeP2msDaBFtV8MTUxNzQ4MzQ5OUAxNTE3Mzk3MDk5&amp;q=https3A2F2Fgoo.gl2FXjnqer&amp;v=WwlKd_hTtzU&amp;event=video_description" title="Link: https://www.youtube.com/redirect?redir_token=LOjkt98sc-83hCfDeP2msDaBFtV8MTUxNzQ4MzQ5OUAxNTE3Mzk3MDk5&amp;q=https3A2F2Fgoo.gl2FXjnqer&amp;v=WwlKd_hTtzU&amp;event=video_description"></a></div>
</div>
<br />
', 1, -1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, 3, N'/Uploads/CKFinder/images/San_pham/canh-1-2b-1472116898_500x500.jpg', N'The Wheels On The Bus | Kids Songs | Nursery Rhymes | BooKid ', N'https://www.youtube.com/watch?v=AegtUhE0L7A&t=6s', 12, N'The Wheels On The Bus | Kids Songs | Nursery Rhymes | BooKid ', N'&nbsp;Let&#39;s join the trip through <a href="https://www.youtube.com/results?search_query=23Bookid" rel="nofollow" target="_blank" title="Link: https://www.youtube.com/results?search_query=23Bookid">#Bookid</a> galaxy with Chubby Pig and his lovely friends. ✨✨✨&nbsp;<br />
<div>
	&nbsp;<br />
	★ Lyrics: The Wheels On The Bus<br />
	<br />
	He wheels on the bus<br />
	go round and round,<br />
	round and round,<br />
	round and round.<br />
	The wheels on the bus<br />
	go round and round,<br />
	all through the town.<br />
	The doors on the bus<br />
	go open and shut;<br />
	Open and shut;<br />
	Open and shut.<br />
	The doors on the bus<br />
	go open and shut;<br />
	all through the town.<br />
	<br />
	The wipers on the bus go<br />
	Swish, swish, swish;<br />
	Swish, swish,swish;<br />
	Swish, swish, swish.<br />
	The wipers on the bus go<br />
	Swish, swish, swish,<br />
	all through the town.<br />
	He driver on the bus says<br />
	&ldquo;Move on back,<br />
	move on back, move on back;&rdquo;<br />
	The Driver on the bus says<br />
	&ldquo;Move on back&rdquo;,<br />
	all through the town.<br />
	<br />
	The mommies on the bus says<br />
	&ldquo;Shush, shush, shush;<br />
	Shush, shush, shush;<br />
	Shush, shush, shush.&rdquo;<br />
	The mommies on the bus says<br />
	&ldquo;Shush, shush, shush&rdquo;<br />
	all through the town.<br />
	<br />
	Friends on the bus says<br />
	&lsquo;&rsquo; How are you,<br />
	how are you, how are you?&lsquo;&rsquo;<br />
	Friends on the bus says &lsquo; &rsquo;<br />
	How are you?&lsquo;&rsquo;<br />
	all through the town<br />
	The horn on the bus goes<br />
	Beep, beep, beep;<br />
	Beep, beep, beep;<br />
	Beep, beep, beep.<br />
	The horn on the bus goes<br />
	Beep, beep, beep,<br />
	all through the town.</div>
', 1, -1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, 3, N'/Uploads/CKFinder/images/San_pham/canh-1-2b-1472116898_500x500.jpg', N'Best Carols for Kids | Christmas Carols | +Compilation | Christmas Song | BooKid 🎄🎉🌟', N'https://www.youtube.com/watch?v=o95Z1aFwp6g', 3, N'Best Carols for Kids | Christmas Carols | +Compilation | Christmas Song | BooKid 🎄🎉🌟', N'<a href="https://www.youtube.com/results?search_query=23Bookid" rel="nofollow" target="_blank">#Bookid</a> today brings you one of the most typical songs on Christmas. Let&#39;s sing together!<br />
<br />
★ Best Christmas Carols for Kids🌟🎄💕&nbsp;<br />
<br />
<div>
	1. Jingle Bell<br />
	2. Are You Sleeping Brother John?<br />
	3. We Wish You A Merry Christmas<br />
	4. Christmas Day<br />
	5. Silent Night<br />
	6. O Christmas Tree</div>
', 1, -1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, 3, N'/Uploads/CKFinder/images/San_pham/XMAS-TREE-01.png', N'Christmas Tree | Christmas Song | Kids Songs | Nursery Rhymes | BooKid 🎄🎄💕', N'https://www.youtube.com/watch?v=RPnCbRWxe94', 2, N'Smooth rhymes of Christmas tree will complete your feelings in upcoming event. Enjoy the video from #Bookid. ', N'<div>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><strong>★ Lyrics: 🌟 O CHRISTMAS TREE O</strong><br />
	<br />
	Christmas Tree! O Christmas Tree!<br />
	Thy leaves are so unchanging;<br />
	O Christmas Tree! O Christmas Tree!<br />
	Thy leaves are so unchanging;<br />
	Not only green when summer&rsquo;s here,<br />
	But also when &rsquo;tis cold and drear.<br />
	<br />
	O Christmas Tree! O Christmas Tree!<br />
	Thy leaves are so unchanging!<br />
	O Christmas Tree! O Christmas Tree!<br />
	Much pleasure thou can&rsquo;st give me;<br />
	O Christmas Tree! O Christmas Tree!<br />
	<br />
	Much pleasure thou can&rsquo;st give me;<br />
	How often has the Christmas tree<br />
	Afforded me the greatest glee!<br />
	O Christmas Tree! O Christmas Tree!<br />
	<br />
	Much pleasure thou can&rsquo;st give me.<br />
	O Christmas Tree! O Christmas Tree!<br />
	Thy candles shine so brightly!<br />
	There&rsquo;s only splendor for the sight<br />
	<br />
	O Christmas Tree! O Christmas Tree!<br />
	Thy candles shine so brightly!<br />
	O Christmas Tree! O Christmas Tree!<br />
	How richly God had decked thee.</span></span><br />
	<br />
	&nbsp;</div>
', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, 3, N'/Uploads/CKFinder/images/San_pham/WE-WISH-YOU-A-MERRY-XMAS-01.png', N'🎄We Wish You A Merry Christmas | Christmas Song | Kids Songs | Nursery Rhymes | BooKid 🎅🎁🎉', N'https://www.youtube.com/watch?v=0yENwhRn71A', 3, N'With this song, #Bookid "Wish you a merry christmas". Hope you have a memorable holiday.', N'<div>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><strong>&nbsp;★ Lyrics: We wish you a merry christmas🎉</strong><br />
	<br />
	We wish you a merry Christmas,<br />
	We wish you a merry Christmas,<br />
	We wish you a merry Christmas,<br />
	and a happy New Year!<br />
	<br />
	Good tidings we bring to you and your kin;<br />
	We wish you a merry Christmas and a happy New Year.<br />
	<br />
	Oh bring us some figgy pudding,<br />
	Oh bring us some figgy pudding,<br />
	Oh bring us some figgy pudding<br />
	and bring it right here.<br />
	<br />
	We all like our figgy pudding,<br />
	We all like our figgy pudding,<br />
	We all like our figgy pudding,<br />
	and bring it right here.</span></span></div>
', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, 3, N'/Uploads/CKFinder/images/San_pham/SILENT-NIGHT-01.png', N'Silent Night | Christmas Song | Kids Songs | Nursery Rhymes | BooKid 😴🎄', N'https://www.youtube.com/watch?v=s4pYSHepIZc', 2, N'This song is really calm and peaceful. Feeling like there is no other song more suitable for a night sleep than "Silent Night". Enjoy the music and tell #Bookid whether you agree with us.', N'<div>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><strong>&nbsp;★ Lyrics: 😴 SILENT NIGHT</strong><br />
	<br />
	Silent night! Holy night!<br />
	All is calm, all is bright,<br />
	Round yon Virgin Mother and Child!<br />
	Holy Infant, so tender and mild,<br />
	Sleep in heavenly peace!<br />
	Sleep in heavenly peace!<br />
	<br />
	Silent night! Holy night!<br />
	Son of God, love&rsquo;s pure light<br />
	Radiant beams from Thy Holy Face<br />
	With the dawn of redeeming grace,<br />
	Jesus, Lord, at Thy Birth!<br />
	Jesus, Lord, at Thy Birth!</span></span></div>
', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, 3, N'/Uploads/CKFinder/images/San_pham/XMAS-DAY-01.png', N'Christmas Day | Christmas Song | Kids Songs | Nursery Rhymes | BooKid 🎄🎄🎄', N'https://www.youtube.com/watch?v=n8C8PgkOIrQ', 2, N'Christmas time is a chance to be with family and friends. Let''s hang out with #Bookid. ', N'<div>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;">&nbsp;★ Lyrics: Christmas Day🎉<br />
	<br />
	Christmas day, christmas day<br />
	All the day we pray and play<br />
	Till the sun goes down, lah lah lah<br />
	Christmas day, we celebrate.</span></span></div>
', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, 3, N'/Uploads/CKFinder/images/San_pham/ARE-YOU-SLEEPING-01.png', N'Are You Sleeping Brother John | Christmas Song | Kids Songs | Nursery Rhymes | BooKid 😴🎄', N'https://www.youtube.com/watch?v=RGciwmd6UWo', 2, N'In winter day, there is nothing attractive more than sleep over noon :))), are you agree with #Bookid? Stripes Bee and Floral Rabbit have tried a lot to wake up Chubby Pig. ', N'<div>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><strong>★ Lyrics: 😴 Are You Sleeping (Brother John)</strong><br />
	<br />
	Are you sleeping?<br />
	Are you sleeping?<br />
	Brother John! Brother John!<br />
	Morning bells are ringing<br />
	Morning bells are ringing<br />
	Ding, dang, dong!<br />
	Ding, dang, dong!</span></span></div>
', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, 3, N'/Uploads/CKFinder/images/San_pham/ROW-ROW-ROW-YOUR-BOAT-01.png', N'Row Row Row Your Boat | Rapunzel | Kid Songs | Nursery Rhymes | English Songs | BooKid', N'https://www.youtube.com/watch?v=tEuNGdj2n3s', 2, N'Have you ever rowed a boat? It is really a fun thing to do! “Row row your boat” is a calm rhyme which gives you feelings of magic of life. To Bookid, this song is also a romantic and wonderful story of love. So, let’s enjoy this love song! ', N'<div>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><strong>★ Lyrics: Row row row your boat</strong><br />
	<br />
	Row, row, row your boat<br />
	Gently down the stream<br />
	Merrily, merrily, merrily, merrily<br />
	Life is but a dream.</span></span></div>
', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, 3, N'/Uploads/CKFinder/images/San_pham/THE-ITSY-SPIDER-01.png', N'The Isty Bitsy Spider | Kid Songs | Nursery Rhymes | English Songs | BooKid', N'https://www.youtube.com/watch?v=Lh0bCYsZ-Dg&t=23s', 3, N'Why is Itsy Bitsy Spider trying to climb up the waterspout? Is he going to reach the rooftop? Find out in this fun video! Children all over the world absolutely adore Itsy Bitsy Spider, also known as Incy Wincy Spider. In this popular nursery rhyme, a spider climbs up the waterspout, but rain keeps pushing him down. Who can help Itsy Bitsy? Is he going to succeed? ', N'<div>
	<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><strong>&nbsp;★ Lyrics: The itsy bitsy spider</strong><br />
	<br />
	The itsy-bitsy spider<br />
	Climbed up the water spout<br />
	Down came the rain<br />
	And washed the spider out<br />
	Out came the sun<br />
	And dried up all the rain<br />
	And the itsy-bitsy spider<br />
	Climbed up the spout again.</span></span></div>
', 1, 1, 1, CAST(N'2017-07-07 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (31, 5, N'/Uploads/CKFinder/images/San_pham/TAP1-01.png', N'Khoa học cho bé - Những câu hỏi ngộ nghĩnh - Tập 1 - BooKid', N'https://www.youtube.com/watch?v=Wab7QqcXXZQ&t=15s', 41, N'Vì sao trời vừa sáng gà trống đã gáy?', N'<div>
	<div>
		<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><span id="docs-internal-guid-791983e9-7e6b-f76b-2781-016f1ed496b6"><span style="color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Mỗi khi trời vừa s&aacute;ng, g&agrave; trống lại bắt đầu g&aacute;y &ldquo;&ograve; &oacute; o&rdquo;. C&aacute;c em c&oacute; biết v&igrave; sao kh&ocirc;ng?</span></span><br />
		<span id="docs-internal-guid-791983e9-7e6c-1473-3efb-206bb3cc354a"><span style="color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Th&igrave; ra, đ&oacute; l&agrave; do &ldquo;đồng hồ sinh học&rdquo; trong n&atilde;o g&agrave; trống đấy.</span></span><br />
		<span id="docs-internal-guid-791983e9-7e6c-3d33-3cd2-90e51be0e485"><span style="color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Trong n&atilde;o của g&agrave; trống c&oacute; một cơ quan nội tiết gọi l&agrave; tuyển y&ecirc;n. Tuyến y&ecirc;n n&agrave;y tiết ra một loại chất k&iacute;ch th&iacute;ch dựa v&agrave;o cường độ &aacute;nh s&aacute;ng tự nhi&ecirc;n hằng ng&agrave;y, khiến g&agrave; trống nhớ được quy luật ng&agrave;y v&agrave; đ&ecirc;m, đồng thời k&iacute;ch th&iacute;ch g&agrave; trống cất tiếng g&aacute;y khi trời vừa s&aacute;ng.</span></span><br />
		<br />
		<strong>Quiz:&nbsp;</strong></span></span></div>
	<p dir="ltr" style="line-height:1.3800000000000001;margin-top:0pt;margin-bottom:10pt;">
		<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><span id="docs-internal-guid-5465673c-7e6c-7da8-8ee4-c86eb8216f7a"><span style="color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Đố c&aacute;c bạn biết g&agrave; được sinh ra từ đ&acirc;u?<br />
		A. Đ&ocirc;i c&aacute;nh<br />
		B. Quả trứng<br />
		C. Cổ</span></span></span></span></p>
	<div>
		<div>
			<span id="docs-internal-guid-b6100a6d-7e82-60bc-cb69-cfaabcf077f5"><span style="font-size: 14pt; font-family: &quot;Times New Roman&quot;; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span id="docs-internal-guid-b6100a6d-7e82-7eaa-8e38-3e42de68c86c"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span id="docs-internal-guid-b6100a6d-7e82-9f5e-a229-867852f4bf38"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span style="font-size: 14px;"><span style="font-family: tahoma, geneva, sans-serif;"><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23bookid" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#bookid</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23bookidvn" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#bookidvn</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23nhungcauhoingonghinh" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#nhungcauhoingonghinh</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23khoahocdieuky" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#khoahocdieuky</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23khoahocchobe" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#khoahocchobe</a></span></span></span></span></span></span></span></span></div>
	</div>
	<p dir="ltr" style="line-height:1.3800000000000001;margin-top:0pt;margin-bottom:10pt;">
		<br />
		<span style="font-size: 14px;"><span style="font-family: tahoma, geneva, sans-serif;"><span style="color: rgb(17, 17, 17); white-space: pre-wrap;">★ Nhấn SUBSCRIBE để cập nhật c&aacute;c video mới nhất từ BooKid bạn nh&eacute;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/BooKidvn" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://www.youtube.com/BooKidvn</a></span></span></p>
	<div>
		&nbsp;</div>
	<div>
		&nbsp;</div>
</div>
<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (32, 5, N'/Uploads/CKFinder/images/San_pham/TAP2-01.png', N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 2 | BooKid', N'https://www.youtube.com/watch?v=pn98wfx6ftw&t=47s', 6, N'Vì sao kiến không bị lạc đường?
', N'<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><span id="docs-internal-guid-1f89caa6-7e75-1cdc-8f31-c6d15f2dd0d5"><span style="color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Hằng ng&agrave;y, kiến phải đi rất xa để t&igrave;m thức ăn. Kh&ocirc;ng biết ch&uacute;ng c&oacute; bị lạc đường, rồi kh&ocirc;ng t&igrave;m thấy nh&agrave; kh&ocirc;ng nhỉ?<br />
<span id="docs-internal-guid-1f89caa6-7e75-389b-2aaf-606bf57b27b6"><span style="background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;">Kh&ocirc;ng đ&acirc;u c&aacute;c bạn ạ! Thị lực của kiến rất tốt, kh&ocirc;ng những nhận biết đường qua cảnh vật b&ecirc;n đường, m&agrave; c&ograve;n qua vị tr&iacute; mặt trời v&agrave; &aacute;nh s&aacute;ng.<br />
<span id="docs-internal-guid-1f89caa6-7e75-6018-4fce-9b89192258f0"><span style="background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;">Đồng thời, mỗi khi kiến b&ograve; qua nơi n&agrave;o đ&oacute;, n&oacute; đều lưu lại một m&ugrave;i đặc biệt, khi quay lại chỉ cần đi theo m&ugrave;i n&agrave;y th&igrave; sẽ kh&ocirc;ng lạc đường. Cũng c&oacute; khi kiến kh&ocirc;ng để lại m&ugrave;i g&igrave; tr&ecirc;n đường nhưng ch&uacute;ng c&oacute; thể nhớ được m&ugrave;i tự nhi&ecirc;n của đường đi, cho n&ecirc;n cũng kh&ocirc;ng bị lạc.<br />
<br />
<strong>Quiz: </strong><br />
<span id="docs-internal-guid-5f7dd21f-7e75-aee3-e316-8b1749455c7f"><span style="background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;">Th&iacute;nh gi&aacute;c của kiến thế n&agrave;o? C&oacute; &yacute; kiến cho rằng, kiến kh&ocirc;ng c&oacute; tai, theo c&aacute;c bạn đ&uacute;ng hay sai?<br />
A. Đ&uacute;ng<br />
B. Sai</span></span></span></span></span></span></span></span></span></span><br />
<br />
<div>
	<div>
		<span id="docs-internal-guid-b6100a6d-7e82-60bc-cb69-cfaabcf077f5"><span style="font-size: 14pt; font-family: &quot;Times New Roman&quot;; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span id="docs-internal-guid-b6100a6d-7e82-7eaa-8e38-3e42de68c86c"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span id="docs-internal-guid-b6100a6d-7e82-9f5e-a229-867852f4bf38"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span style="font-size: 14px;"><span style="font-family: tahoma, geneva, sans-serif;"><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23bookid" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#bookid</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23bookidvn" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#bookidvn</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23nhungcauhoingonghinh" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#nhungcauhoingonghinh</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23khoahocdieuky" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#khoahocdieuky</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23khoahocchobe" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#khoahocchobe</a></span></span></span></span></span></span></span></span></div>
</div>
<br />
<span style="font-size: 14px;"><span style="font-family: tahoma, geneva, sans-serif;"><span style="color: rgb(17, 17, 17); white-space: pre-wrap;">★ Nhấn SUBSCRIBE để cập nhật c&aacute;c video mới nhất từ BooKid bạn nh&eacute;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/BooKidvn" style="display: inline-block; cursor: pointer; text-decoration-line: none; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://www.youtube.com/BooKidvn</a></span></span>', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (33, 5, N'/Uploads/CKFinder/images/San_pham/TAP3-01.png', N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 3 | BooKid', N'https://www.youtube.com/watch?v=dwRuGPIf0mo', 4, N'Vì sao một số loài cây rụng lá vào mùa đông?
', N'<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><span style="color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">V&igrave; sao một số lo&agrave;i c&acirc;y rụng l&aacute; v&agrave;o m&ugrave;a đ&ocirc;ng? Đ&oacute; ch&iacute;nh l&agrave; c&acirc;u hỏi m&agrave; Boss sẽ giải đ&aacute;p cho Kem, May v&agrave; c&aacute;c bạn nhỏ ng&agrave;y h&ocirc;m nay.<br />
<span style="background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;">M&ugrave;a thu đến, l&aacute; c&acirc;y bắt đầu rụng dần. V&agrave; khi đến m&ugrave;a đ&ocirc;ng th&igrave; c&acirc;y chỉ c&ograve;n trơ lại c&agrave;nh.<br />
<span style="background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;">Hiện tượng c&acirc;y rụng l&aacute; l&agrave; do tr&ecirc;n bề mặt của l&aacute; c&acirc;y c&oacute; rất nhiều lỗ nhỏ m&agrave; mắt thường kh&ocirc;ng thấy được. Th&ocirc;ng qua c&aacute;c lỗ kh&iacute; nhỏ n&agrave;y, hơi nước trong l&aacute; c&acirc;y bốc hơi v&agrave;o kh&ocirc;ng kh&iacute;.</span></span></span></span></span><br />
<p dir="ltr" style="line-height:1.2;margin-top:0pt;margin-bottom:0pt;">
	<span id="docs-internal-guid-b6100a6d-7e82-60bc-cb69-cfaabcf077f5"><span style="font-size: 14pt; font-family: &quot;Times New Roman&quot;; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span id="docs-internal-guid-b6100a6d-7e82-7eaa-8e38-3e42de68c86c"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span id="docs-internal-guid-b6100a6d-7e82-9f5e-a229-867852f4bf38"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><span id="docs-internal-guid-b6100a6d-7e82-c246-cc65-6b6132c760b0"><span style="background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;">M&ugrave;a h&egrave; mưa nhiều, c&acirc;y kh&ocirc;ng sợ thiếu nước. M&ugrave;a đ&ocirc;ng l&agrave; m&ugrave;a kh&ocirc;, mưa &iacute;t đi, l&aacute; c&acirc;y rụng để giữ lại nước cho c&acirc;y, tr&aacute;nh cho c&acirc;y bị kh&ocirc; h&eacute;o.</span></span></span></span></span></span></span></span></span></span></p>
<p dir="ltr" style="line-height:1.2;margin-top:0pt;margin-bottom:0pt;">
	<span id="docs-internal-guid-b6100a6d-7e82-60bc-cb69-cfaabcf077f5"><span style="font-size: 14pt; font-family: &quot;Times New Roman&quot;; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span id="docs-internal-guid-b6100a6d-7e82-7eaa-8e38-3e42de68c86c"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span id="docs-internal-guid-b6100a6d-7e82-9f5e-a229-867852f4bf38"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><span id="docs-internal-guid-b6100a6d-7e82-c246-cc65-6b6132c760b0"><span style="background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;">Kh&ocirc;ng c&oacute; l&aacute; c&acirc;y tho&aacute;t nước, c&acirc;y kh&ocirc;ng mất nước n&ecirc;n rễ c&acirc;y kh&ocirc;ng cần phải cung cấp nhiều nước nữa, như vậy, c&acirc;y sẽ an to&agrave;n sống qua m&ugrave;a đ&ocirc;ng.</span></span></span></span></span></span></span></span></span></span></p>
<div>
	<br />
	<span id="docs-internal-guid-b6100a6d-7e82-60bc-cb69-cfaabcf077f5"><span style="font-size: 14pt; font-family: &quot;Times New Roman&quot;; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span id="docs-internal-guid-b6100a6d-7e82-7eaa-8e38-3e42de68c86c"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span id="docs-internal-guid-b6100a6d-7e82-9f5e-a229-867852f4bf38"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><strong>Quiz:</strong></span></span></span></span></span></span></span></span><br />
	<p dir="ltr" style="line-height:1.3800000000000001;margin-top:0pt;margin-bottom:10pt;">
		<span id="docs-internal-guid-b6100a6d-7e82-60bc-cb69-cfaabcf077f5"><span style="font-size: 14pt; font-family: &quot;Times New Roman&quot;; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span id="docs-internal-guid-b6100a6d-7e82-7eaa-8e38-3e42de68c86c"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span id="docs-internal-guid-b6100a6d-7e82-9f5e-a229-867852f4bf38"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><span id="docs-internal-guid-99c43938-7e82-fd21-d482-c6e95db3df28"><span style="background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;">Đố c&aacute;c bạn nhỏ, m&agrave;u xanh của l&aacute; c&acirc;y do chất g&igrave; tạo n&ecirc;n?<br />
		A. Nước v&agrave; ion kho&aacute;ng &nbsp;<br />
		B. Chất hữu cơ<br />
		C. Chất diệp lục.</span></span></span></span></span></span></span></span></span></span></p>
	<div>
		<span id="docs-internal-guid-b6100a6d-7e82-60bc-cb69-cfaabcf077f5"><span style="font-size: 14pt; font-family: &quot;Times New Roman&quot;; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span id="docs-internal-guid-b6100a6d-7e82-7eaa-8e38-3e42de68c86c"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span id="docs-internal-guid-b6100a6d-7e82-9f5e-a229-867852f4bf38"><span style="font-size: 14pt; background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline;"><span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23bookid" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#bookid</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23bookidvn" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#bookidvn</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23nhungcauhoingonghinh" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#nhungcauhoingonghinh</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23khoahocdieuky" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#khoahocdieuky</a><span style="color: rgb(17, 17, 17);"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23khoahocchobe" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif;">#khoahocchobe</a></span></span></span></span></span></span></span></span></div>
</div>
<br />
<span style="font-size:14px;"><span style="font-family:tahoma,geneva,sans-serif;"><span style="color: rgb(17, 17, 17); white-space: pre-wrap;">★ Nhấn SUBSCRIBE để cập nhật c&aacute;c video mới nhất từ BooKid bạn nh&eacute;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/BooKidvn" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://www.youtube.com/BooKidvn</a></span></span>', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (34, 5, N'/Uploads/CKFinder/images/San_pham/TAP4-01.png', N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 4 | BooKid', N'https://www.youtube.com/watch?v=JipvZ_rcNWg&t=17s', 4, N'Vì sao thân cây đều là hình tròn?', N'<span style="font-family:tahoma,geneva,sans-serif;"><span style="font-size:14px;"><span id="docs-internal-guid-4adde6fa-7e8a-e5b6-7bb9-d87270a88202"><span style="font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span style="background-color:#ffffff;">Ch&uacute;ng ta quan s&aacute;t kĩ th&igrave; thấy tất cả c&aacute;c loại c&acirc;y đều kh&aacute;c nhau ở h&igrave;nh d&aacute;ng: c&acirc;y th&igrave; cao, c&acirc;y th&igrave; thấp, c&acirc;y th&igrave; sai quả, c&acirc;y lại &iacute;t quả. Mỗi c&acirc;y một loại l&aacute;, một loại c&agrave;nh. Nhưng ch&uacute;ng lại c&oacute; một đặc điểm chung, đ&oacute; l&agrave; th&acirc;n h&igrave;nh tr&ograve;n. V&igrave; sao kh&ocirc;ng l&agrave; h&igrave;nh vu&ocirc;ng hay h&igrave;nh tam gi&aacute;c nhỉ?</span></span></span></span></span><br />
<p dir="ltr" style="line-height:1.2;margin-top:0pt;margin-bottom:0pt;text-align: justify;">
	<span style="font-family:tahoma,geneva,sans-serif;"><span style="font-size:14px;"><span id="docs-internal-guid-4adde6fa-7e8b-2c13-a96e-d6b6eb28aabe"><span style="font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span style="background-color:#ffffff;">V&igrave; th&acirc;n c&acirc;y tr&ograve;n th&igrave; </span></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span style="background-color:#ffffff;">dễ d&agrave;ng</span></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span style="background-color:#ffffff;"> chống đỡ l&aacute; v&agrave; c&agrave;nh tr&ecirc;n cao, c&ograve;n c&oacute; thể chịu đựng được gi&oacute; to mưa lớn. </span></span></span></span></span></p>
<span style="font-family:tahoma,geneva,sans-serif;"><span style="font-size:14px;"><span id="docs-internal-guid-4adde6fa-7e8b-2c13-a96e-d6b6eb28aabe"><span style="font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span style="background-color:#ffffff;">N</span></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span style="background-color:#ffffff;">ếu h&igrave;nh vu&ocirc;ng hoặc tam gi&aacute;c, th&acirc;n c&acirc;y ắt sẽ c&oacute; c&aacute;c g&oacute;c cạnh, dễ l&agrave;m mồi cho động vật gặm nhấm. Th&acirc;n c&acirc;y h&igrave;nh tr&ograve;n chống được những t&aacute;c hại từ b&ecirc;n ngo&agrave;i.</span></span></span><br />
<span id="docs-internal-guid-4adde6fa-7e8b-4e96-2e47-a6c7409032e0"><span style="font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span style="background-color:#ffffff;">C&aacute;c đồ vật m&agrave; ch&uacute;ng ta thấy trong cuộc sống như cột điện hay ống dẫn nước đều l&agrave; dạng ống tr&ograve;n. Th&igrave; ra, ch&uacute;ng được l&agrave;m dựa theo nguy&ecirc;n l&iacute; n&agrave;y đấy.</span></span></span><br />
<br />
<strong><span style="background-color:#ffffff;">Quiz:</span></strong></span></span><br />
<p dir="ltr" style="line-height:1.3800000000000001;margin-top:0pt;margin-bottom:10pt;text-align: justify;">
	<span style="font-family:tahoma,geneva,sans-serif;"><span style="font-size:14px;"><span id="docs-internal-guid-4adde6fa-7e8b-8354-a9fb-f73508080e63"><span style="font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span style="background-color:#ffffff;">Những v&ograve;ng tr&ograve;n tr&ecirc;n mặt cắt th&acirc;n c&acirc;y thể hiện điều g&igrave;? </span></span></span></span></span></p>
<p dir="ltr" style="line-height:1.3800000000000001;margin-top:0pt;margin-bottom:10pt;text-align: justify;">
	<span style="font-family:tahoma,geneva,sans-serif;"><span style="font-size:14px;"><span id="docs-internal-guid-4adde6fa-7e8b-8354-a9fb-f73508080e63"><span style="font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"><span style="background-color:#ffffff;">A. Tuổi của c&acirc;y. </span><br />
	<span style="background-color:#ffffff;">B. K&iacute;ch thước của c&acirc;y. </span><br />
	<span style="background-color:#ffffff;">C. Chất dinh dưỡng của c&acirc;y.</span></span></span></span></span><br />
	&nbsp;</p>
<div class="style-scope ytd-expander" id="content" style="word-wrap: break-word; min-width: 0px; margin: 0px; padding: 0px; border: 0px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; color: rgb(0, 0, 0); font-family: Roboto, Arial, sans-serif; font-size: 14px;">
	<yt-formatted-string class="content style-scope ytd-video-secondary-info-renderer" id="description" slot="content" split-lines="" style="white-space: pre-wrap; color: var(--yt-primary-text-color); --yt-endpoint-color:hsl(206.1, 79.3, 52.7);"><span style="font-family:tahoma,geneva,sans-serif;"><span style="font-size:14px;"><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23bookid" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: var(--yt-formatted-string-endpoint_-_font-size); font-weight: var(--yt-formatted-string-endpoint_-_font-weight); line-height: var(--yt-formatted-string-endpoint_-_line-height);"><span style="background-color:#ffffff;">#bookid</span></a><span style="background-color:#ffffff;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23bookidvn" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: var(--yt-formatted-string-endpoint_-_font-size); font-weight: var(--yt-formatted-string-endpoint_-_font-weight); line-height: var(--yt-formatted-string-endpoint_-_line-height);"><span style="background-color:#ffffff;">#bookidvn</span></a><span style="background-color:#ffffff;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23nhungcauhoingonghinh" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: var(--yt-formatted-string-endpoint_-_font-size); font-weight: var(--yt-formatted-string-endpoint_-_font-weight); line-height: var(--yt-formatted-string-endpoint_-_line-height);"><span style="background-color:#ffffff;">#nhungcauhoingonghinh</span></a><span style="background-color:#ffffff;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23khoahocdieuky" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: var(--yt-formatted-string-endpoint_-_font-size); font-weight: var(--yt-formatted-string-endpoint_-_font-weight); line-height: var(--yt-formatted-string-endpoint_-_line-height);"><span style="background-color:#ffffff;">#khoahocdieuky</span></a><span style="background-color:#ffffff;"> </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=23khoahocchobe" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: var(--yt-formatted-string-endpoint_-_font-size); font-weight: var(--yt-formatted-string-endpoint_-_font-weight); line-height: var(--yt-formatted-string-endpoint_-_line-height);"><span style="background-color:#ffffff;">#khoahocchobe</span></a></span></span></yt-formatted-string></div>
<div class="style-scope ytd-metadata-row-container-renderer" id="always-shown" style="margin: 0px; padding: 0px; border: 0px; background: transparent;">
	<br />
	<span style="font-family:tahoma,geneva,sans-serif;"><span style="font-size:14px;"><span style="white-space: pre-wrap;"><span style="background-color:#ffffff;">★ Nhấn SUBSCRIBE để cập nhật c&aacute;c video mới nhất từ BooKid bạn nh&eacute;: </span></span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/BooKidvn" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;"><span style="background-color:#ffffff;">https://www.youtube.com/BooKidvn</span></a></span></span></div>
<div>
	&nbsp;</div>
<div>
	&nbsp;</div>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (35, 5, N'/Uploads/CKFinder/images/San_pham/TAP5-01.png', N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 5 | BooKid', N'https://www.youtube.com/watch?v=mccJ947klrM', 1, N'Vì sao rừng có thể chắn gió?', N'<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (36, 5, N'/Uploads/CKFinder/images/San_pham/TAP6-01.png', N'Khoa Học Cho Bé | Những Câu Hỏi Ngộ Nghĩnh | Tập 6 | BooKid', N'https://www.youtube.com/watch?v=BPmiHui_2H0', 1, N'Vì sao chim cánh cụt có cánh mà lại không bay được?', N'<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (37, 5, N'/Uploads/CKFinder/images/San_pham/TAP7-01.png', N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 7 | BooKid', N'https://www.youtube.com/watch?v=NgIdB69r46o', 1, N'Vì sao khi trời mưa, ta nhìn thấy chớp trước rồi mới nghe thấy tiếng sấm?', N'<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (38, 5, N'/Uploads/CKFinder/images/San_pham/TAP8-01.png', N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 8 | BooKid', N'https://www.youtube.com/watch?v=uwRFrvcekPM', 0, N'Vì sao dơi lại treo ngược mình trên cành cây để ngủ?', N'<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (39, 5, N'/Uploads/CKFinder/images/San_pham/TAP9-01.png', N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 9 | BooKid', N'https://www.youtube.com/watch?v=ndMfJc5Zfpk', 0, N'Làm sao để cho một quả táo to thật to vào chiếc lọ?', N'<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (40, 4, N'/Uploads/CKFinder/images/San_pham/CA-DIEC-CON-01.png', N'Cá diếc con | Truyện cổ tích | Truyện kể bé nghe | Truyện ngụ ngôn | BooKid', N'https://www.youtube.com/watch?v=eCEARezkNLk&t=94s', 0, N'Chào các em nhỏ yêu quý! Có bạn nào biết con cá diếc có đặc điểm gì không? À…cá diếc là cá trắng nước ngọt, đầu và đuôi thuôn, mắt có viền màu đỏ đấy các em ạ! Hôm nay, Susu sẽ kể cho chúng ta nghe câu chuyện “Cá diếc con” , các em cùng lắng nghe nhé!', N'<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Trong c&acirc;u chuyện n&agrave;y, B&aacute;c r&ugrave;a th&igrave; lu&ocirc;n sẵn s&agrave;ng gi&uacute;p đỡ người kh&aacute;c, diếc con đ&atilde; biết sửa sai khi nghĩ xấu về b&aacute;c r&ugrave;a, mẹ diếc con l&agrave; một người mẹ v&ocirc; c&ugrave;ng tuyệt vời phải kh&ocirc;ng n&agrave;o? C&aacute;c em nhớ học tập những nh&acirc;n vật tr&ecirc;n nh&eacute;! </span>', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (41, 4, N'/Uploads/CKFinder/images/San_pham/HAT-DO-SOT-01.png', N'Hạt đỗ sót | Truyện cổ tích | Truyện kể bé nghe | Quà tặng cuộc sống | BooKid', N'https://www.youtube.com/watch?v=nZ4sLhE6WcM&t=102s', 1, N'Mặc dù bị bỏ quên ở đáy lọ nhưng Đỗ Sót vẫn luôn mong muốn được ra ngoài và được phát triển bình thường như bao bạn đỗ khác. Cuối cùng, nhờ sự giúp đỡ của những chú kiến và sự cố gắng của bản thân, Đỗ Sót không chỉ được ra ngoài mà còn vươn cao và nở ra những nụ hoa xinh đẹp. Chỉ cần cố gắng và nỗ lực, chúng ta sẽ đạt được điều mình muốn phải không các bạn?', N'<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (42, 4, N'/Uploads/CKFinder/images/San_pham/BA-CHU-CHUOT-HAM-AN-01.png', N'Ba con chuột | Truyện cổ tích | Truyện ngụ ngôn | Truyện kể bé nghe | BooKid', N'https://www.youtube.com/watch?v=int4X7ns5TU', 0, N'Ba con chuột | Truyện cổ tích | Truyện ngụ ngôn | Truyện kể bé nghe | BooKid', N'<br />
<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (43, 4, N'/Uploads/CKFinder/images/San_pham/DOM-DOM-CAM-DEN-LONG-01.png', N'Đom Đóm Cầm Đèn Lồng | Truyện cổ tích | Truyện kể bé nghe | BooKid', N'https://www.youtube.com/watch?v=FlnMngZxAe4', 0, N'Đom Đóm Cầm Đèn Lồng | Truyện cổ tích | Truyện kể bé nghe | BooKid', N'<br />
<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (44, 4, N'/Uploads/CKFinder/images/San_pham/MAT-HOA-THOM-NGOT-01.png', N'Mật hoa thơm ngọt | Truyện cổ tích | Truyện kể bé nghe | BooKid', N'https://www.youtube.com/watch?v=nXHATzD5M4M', 0, N'Mật hoa thơm ngọt | Truyện cổ tích | Truyện kể bé nghe | BooKid', N'<br />
<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (45, 4, N'/Uploads/CKFinder/images/San_pham/CAU-CHUYEN-GIOT-NUOC-01.png', N'Câu chuyện về giọt nước | Truyện cổ tích | Truyện kể bé nghe | BooKid', N'https://www.youtube.com/watch?v=g4GJq8Ii1vk', 0, N'Câu chuyện về giọt nước | Truyện cổ tích | Truyện kể bé nghe | BooKid', N'<br />
<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (46, 4, N'/Uploads/CKFinder/images/San_pham/NHANH-CO-NON-VA-CAY-THONG-NHO-01.png', N'Nhành cỏ non và cây thông nhỏ | Truyện cổ tích | Truyện kể bé nghe | BooKid', N'https://www.youtube.com/watch?v=sgrMPZuGQGY', 0, N'Nhành cỏ non và cây thông nhỏ | Truyện cổ tích | Truyện kể bé nghe | BooKid', N'<br />
<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Chỉ cần ch&uacute;ng ta c&oacute; nghị lực ki&ecirc;n cường th&igrave; sẽ chiến thắng mọi kh&oacute; khăn.</span>', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (47, 6, NULL, N'Bé Khéo tay Gấp Xe Đưa Bánh Pizza | Thủ Công Cho Bé | Made By Me | BOOKID', N'https://www.youtube.com/watch?v=G5QyyaljYKU&t=57s', 0, N'Bé Khéo tay Gấp Xe Đưa Bánh Pizza | Thủ Công Cho Bé | Made By Me | BOOKID', N'<br />
<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Bộ sưu tập &ocirc; t&ocirc; của b&eacute; c&oacute; xe đưa b&aacute;nh Pizza chưa? H&atilde;y c&ugrave;ng BooKid cắt d&aacute;n chiếc xe n&agrave;y nh&eacute;!<br />
<br />
🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?redir_token=id3o4IFWJ5TgOmyg7HDJV1H4l5R8MTUxODMyMjY2OEAxNTE4MjM2MjY4&amp;q=https%3A%2F%2Fgoo.gl%2FWeq58a&amp;event=video_description&amp;v=G5QyyaljYKU" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/Weq58a</a>', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (48, 6, NULL, N'Bé Khéo tay Gấp Xe Ô Tô Buýt | Thủ Công Cho Bé | Made By Me | BOOKID', N'https://www.youtube.com/watch?v=beNnMcQ-c0U&t=83s', 0, N'Bé Khéo tay Gấp Xe Ô Tô Buýt | Thủ Công Cho Bé | Made By Me | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Bộ sưu tập &ocirc; t&ocirc; của b&eacute; c&oacute; chiếc &Ocirc; T&Ocirc; BU&Yacute;T chưa? Bookid nghĩ l&agrave; c&aacute;c b&eacute; chưa c&oacute; đ&acirc;u.<br />
	<br />
	Vậy h&atilde;y tự tay l&agrave;m cho m&igrave;nh chiếc &ocirc; t&ocirc; bu&yacute;t với những trạm dừng dễ thương như thế n&agrave;y nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?v=beNnMcQ-c0U&amp;redir_token=SFbwtsWy68nRceFa9Tj3KiVWGrF8MTUxODMyMjg0NEAxNTE4MjM2NDQ0&amp;event=video_description&amp;q=https3A2F2Fgoo.gl2FUufFD3" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/UufFD3</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (49, 6, NULL, N'Bé Khéo tay Gấp Xe Bán Kem Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'https://www.youtube.com/watch?v=beNnMcQ-c0U&t=83s', 0, N'Bé Khéo tay Gấp Xe Bán Kem Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">KEM đ&acirc;y, KEM đ&acirc;y!. Những que kem m&aacute;t lạnh n&agrave;o! B&eacute; c&oacute; th&iacute;ch ăn kem kh&ocirc;ng?<br />
	Những que kem si&ecirc;u ngon được mang đến từ một chiếc xe VAN chuy&ecirc;n b&aacute;n kem dạo.<br />
	<br />
	C&ugrave;ng BOOKID gấp chiếc xe b&aacute;n kem n&agrave;y nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2FPLMxZx&amp;redir_token=OgmuLC33lnsVlC92_UJKEIERU3N8MTUxODMyMjkyOEAxNTE4MjM2NTI4&amp;event=video_description&amp;v=1CVkirbYi9Q" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/PLMxZx</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (50, 6, NULL, N'Bé Khéo tay Gấp Xe Taxi Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'https://www.youtube.com/watch?v=-jcqN7aVyto', 0, N'Bé Khéo tay Gấp Xe Taxi Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Ch&agrave;o c&aacute;c bạn nhỏ!<br />
	H&ocirc;m nay BooKid sẽ hướng dẫn c&aacute;c bạn gấp xe Taxi nh&eacute;!<br />
	<br />
	H&atilde;y download bản in ở link dưới, in ra rồi ch&uacute;ng ta c&ugrave;ng bắt đầu gấp chiếc xe n&agrave;o!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?v=-jcqN7aVyto&amp;redir_token=gAIdrfszSoj2K_kVv8lTiVnmxL18MTUxODMyMzAzOUAxNTE4MjM2NjM5&amp;event=video_description&amp;q=https%3A%2F%2Fgoo.gl%2FJ3a4Kk" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/J3a4Kk</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (51, 6, NULL, N'Bé Khéo tay Gấp Xe Cấp Cứu Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'https://www.youtube.com/watch?v=G5UzctQIaYU', 0, N'Bé Khéo tay Gấp Xe Cấp Cứu Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Ch&agrave;o c&aacute;c bạn nhỏ!<br />
	<br />
	H&ocirc;m nay BooKid sẽ hướng dẫn c&aacute;c bạn gấp xe cấp cứu nh&eacute;!.<br />
	<br />
	H&atilde;y download bản in ở link dưới rồi ch&uacute;ng ta c&ugrave;ng bắt đầu gấp chiếc xe n&agrave;o!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?v=G5UzctQIaYU&amp;redir_token=JTL-JrY_B2W0yvlqciynek-_Sy98MTUxODMyMzExNkAxNTE4MjM2NzE2&amp;event=video_description&amp;q=https%3A%2F%2Fgoo.gl%2Fk2Zxq7" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/k2Zxq7</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (52, 6, NULL, N'Bé Khéo tay Gấp Xe Cảnh Sát Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'https://www.youtube.com/watch?v=lBjpJAm1dpQ', 0, N'Bé Khéo tay Gấp Xe Cảnh Sát Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Ch&agrave;o c&aacute;c bạn nhỏ!<br />
	<br />
	Chắc hẳn, ch&uacute;ng ta kh&ocirc;ng c&ograve;n xa la g&igrave; với những chiếc &ocirc; t&ocirc; đồ chơi.<br />
	H&ocirc;m nay, </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23Bookid" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#Bookid</a><span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;"> sẽ đem đến cho c&aacute;c bạn nhỏ những chiếc &ocirc; t&ocirc; nhiều sắc m&agrave;u, nhiều kiểu d&aacute;ng v&agrave; đặc biệt l&agrave; ch&uacute;ng được l&agrave;m từ giấy.<br />
	C&aacute;c bạn c&oacute; nhận ra đ&acirc;y l&agrave; loại xe g&igrave; kh&ocirc;ng? Ch&iacute;nh l&agrave; một chiếc xe cảnh s&aacute;t đấy.<br />
	<br />
	H&atilde;y c&ugrave;ng </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23Bookid" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#Bookid</a><span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;"> tự tay cắt d&aacute;n chiếc &ocirc; t&ocirc; ngộ nghĩnh, dễ thương n&agrave;y n&agrave;o!<br />
	<br />
	C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở link b&ecirc;n dưới nh&eacute;! 🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?event=video_description&amp;v=lBjpJAm1dpQ&amp;q=https%3A%2F%2Fgoo.gl%2FwTPxPw&amp;redir_token=WQkaK5dhq5XUcnuEkOc6feryCk58MTUxODMyMzI0NUAxNTE4MjM2ODQ1" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/wTPxPw</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (53, 6, NULL, N'Bé Khéo tay Gấp Xe Cứu Hỏa Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'https://www.youtube.com/watch?v=41d_V4daFJI&t=9s', 0, N'Bé Khéo tay Gấp Xe Cứu Hỏa Bằng Giấy I Thủ Công Cho Bé I Made By Me I BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Ch&agrave;o c&aacute;c bạn nhỏ! </span><br />
	<br />
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Chắc hẳn, ch&uacute;ng ta kh&ocirc;ng c&ograve;n xa la g&igrave; với những chiếc &ocirc; t&ocirc; đồ chơi.<br />
	<br />
	H&ocirc;m nay, </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23Bookid" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#Bookid</a><span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;"> sẽ đem đến cho c&aacute;c bạn nhỏ những chiếc &ocirc; t&ocirc; nhiều sắc m&agrave;u, nhiều kiểu d&aacute;ng v&agrave; đặc biệt l&agrave; ch&uacute;ng được l&agrave;m từ giấy.C&aacute;c bạn c&oacute; nhận ra đ&acirc;y l&agrave; loại xe g&igrave; kh&ocirc;ng? Ch&iacute;nh l&agrave; một chiếc xe cứu hỏa.<br />
	<br />
	H&atilde;y c&ugrave;ng </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23Bookid" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#Bookid</a><span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;"> tự tay cắt d&aacute;n chiếc &ocirc; t&ocirc; ngộ nghĩnh, dễ thương n&agrave;y n&agrave;o!<br />
	<br />
	C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở link b&ecirc;n dưới nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?redir_token=Wud5L32DqfW4werHc3ig9fja9sd8MTUxODMyMzQyMkAxNTE4MjM3MDIy&amp;q=https%3A%2F%2Fgoo.gl%2FDZx4fh&amp;event=video_description&amp;v=41d_V4daFJI" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/DZx4fh</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (54, 6, NULL, N'Bé Khéo Tay Gấp Bao Lì Xì | Thủ Công Cho Bé | Made By Me | BOOKID 💝', N'https://www.youtube.com/watch?v=2e9Ju9zYnmk', 1, N'Bé Khéo Tay Gấp Bao Lì Xì | Thủ Công Cho Bé | Made By Me | BOOKID 💝', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">L&igrave; x&igrave; l&agrave; một tục lệ hay v&agrave; đẹp trong những ng&agrave;y Tết v&igrave; n&oacute; thể hiện sự quan t&acirc;m, chăm s&oacute;c của ch&uacute;ng ta với thế hệ trẻ cũng như thể hiện sự ph&oacute;ng kho&aacute;ng, rộng r&atilde;i của m&igrave;nh khi mở l&ograve;ng ra chia sẻ những nguồn lợi của m&igrave;nh c&oacute; được từ năm ngo&aacute;i cho những người xung quanh. Chia c&aacute;i lộc của m&igrave;nh cho mọi người đồng nghĩa l&agrave; m&igrave;nh sẽ c&oacute; th&ecirc;m được nhiều lộc.<br />
	<br />
	H&atilde;y c&ugrave;ng </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/results?search_query=%23BooKid" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">#BooKid</a><span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;"> học c&aacute;ch l&agrave;m phong bao l&igrave; x&igrave; handmade xinh xắn v&agrave; độc đ&aacute;o cho ng&agrave;y Tết n&agrave;y nh&eacute;, tự l&agrave;m phong bao l&igrave; x&igrave; th&igrave; người nhận sẽ cảm thấy &yacute; nghĩa v&agrave; tr&acirc;n trọng hơn rất nhiều đấy!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2F6Eqge7&amp;v=2e9Ju9zYnmk&amp;redir_token=MSqadusC4fFRA39rO003WnfaLnx8MTUxODMyMzU0NUAxNTE4MjM3MTQ1&amp;event=video_description" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/6Eqge7</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (55, 6, NULL, N'Bé Khéo Tay Gấp Con Ma Bí Ngô Đón Halloween I Thủ Công Cho Bé I Made By Me I BOOKID', N'https://www.youtube.com/watch?v=5-kLoFN_HoM&t=25s', 0, N'Bé Khéo Tay Gấp Con Ma Bí Ngô Đón Halloween I Thủ Công Cho Bé I Made By Me I BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Halloween sắp đến rồi c&aacute;c bạn nhỏ ơi! BooKid sẽ hướng dẫn c&aacute;c bạn c&aacute;ch l&agrave;m con ma b&iacute; ng&ocirc; đ&oacute;n lễ Halloween nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?event=video_description&amp;v=5-kLoFN_HoM&amp;q=https%3A%2F%2Fgoo.gl%2FRbFneD&amp;redir_token=6t79-A8_U6zKEZnTkef1qGEn7GJ8MTUxODMyMzYwOUAxNTE4MjM3MjA5" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/RbFneD</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (56, 6, NULL, N'Bé Khéo Tay Cắt Mặt Nạ Đầu Lâu | Thủ Công Cho Bé | Made By Me | BOOKID 🎃 🎃 🎃', N'https://www.youtube.com/watch?v=wZlCCgOrEWg', 0, N'Bé Khéo Tay Cắt Mặt Nạ Đầu Lâu | Thủ Công Cho Bé | Made By Me | BOOKID 🎃 🎃 🎃', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Halloween sắp đến rồi c&aacute;c bạn nhỏ ơi! BooKid sẽ hướng dẫn c&aacute;c bạn c&aacute;ch l&agrave;m một chiếc mặt nạ để đ&oacute;n lễ Halloween nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2FTrD6S8&amp;v=wZlCCgOrEWg&amp;event=video_description&amp;redir_token=okz4x6X7t0rlx6rPnghSYu6xpOp8MTUxODMyMzc1MEAxNTE4MjM3MzUw" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/TrD6S8</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (57, 6, NULL, N'Bé Khéo Tay Làm Mặt Nạ Frankenstein | Thủ Công Cho Bé | Made By Me | BOOKID 🎃 🎃 🎃', N'https://www.youtube.com/watch?v=Sgv5cJsiY1M', 0, N'Bé Khéo Tay Làm Mặt Nạ Frankenstein | Thủ Công Cho Bé | Made By Me | BOOKID 🎃 🎃 🎃', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Halloween sắp đến rồi c&aacute;c bạn nhỏ ơi!. C&aacute;c bạn c&oacute; biết nh&acirc;n vật Frankenstein kh&ocirc;ng?<br />
	BooKid sẽ hướng dẫn c&aacute;c bạn c&aacute;ch l&agrave;m mặt nạ nh&acirc;n vật n&agrave;y nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?event=video_description&amp;v=Sgv5cJsiY1M&amp;q=https%3A%2F%2Fgoo.gl%2Fidse3j&amp;redir_token=2fLUWzFyqomLaErHOrDc5aigBUZ8MTUxODMyMzk3NkAxNTE4MjM3NTc2" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/idse3j</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (58, 6, NULL, N'Bé Khéo Tay Gấp Mắt Kính Thiên Thần Đón Trung Thu | Thủ Công Cho Bé | BOOKID', N'https://www.youtube.com/watch?v=o0YMAmVHF-E', 0, N'Bé Khéo Tay Gấp Mắt Kính Thiên Thần Đón Trung Thu | Thủ Công Cho Bé | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">C&aacute;c bạn nhỏ ơi! C&aacute;c bạn đ&atilde; c&oacute; mặt nạ để đ&oacute;n Trung Thu chưa nhỉ. H&atilde;y để BooKid hướng dẫn bạn c&aacute;ch l&agrave;m những chiếc mặt nạ rực rỡ nh&eacute;. Chỉ cần in ra, cắt l&agrave; c&oacute; ngay một chiếc mặt nạ rồi!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?event=video_description&amp;v=o0YMAmVHF-E&amp;q=https%3A%2F%2Fgoo.gl%2FJffBHS&amp;redir_token=_EUQwuU1RYiMb4j7fGZu1hgWyUd8MTUxODMyNDExMUAxNTE4MjM3NzEx" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/JffBHS</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (59, 6, NULL, N'Bé Khéo Tay Cắt Mặt Nạ Dơi | Thủ Công Cho Bé | Made By Me | BOOKID', N'https://www.youtube.com/watch?v=H8qudgG9n2E&t=1s', 0, N'Bé Khéo Tay Cắt Mặt Nạ Dơi | Thủ Công Cho Bé | Made By Me | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Halloween sắp đến rồi c&aacute;c bạn nhỏ ơi!. C&aacute;c bạn c&oacute; biết l&agrave;m một chiếc mặt nạ để h&oacute;a trang trong ng&agrave;y lễ n&agrave;y kh&ocirc;ng? BooKid sẽ giới thiệu với c&aacute;c bạn một chiếc mặt nạ dơi si&ecirc;u ngầu m&agrave; l&agrave;m lại cực đơn giản nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?redir_token=yAifyujvgXDWsWALh3lRe0qhTbJ8MTUxODMyNDE4NkAxNTE4MjM3Nzg2&amp;event=video_description&amp;v=H8qudgG9n2E&amp;q=https%3A%2F%2Fgoo.gl%2F8bzvbu" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/8bzvbu</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (60, 6, NULL, N'Bé Khéo Tay Gấp Thỏ Trên Cung Trăng | Thủ Công Cho Bé | Made By Me | BOOKID', N'https://www.youtube.com/watch?v=C7RGuuapYTI', 0, N'Bé Khéo Tay Gấp Thỏ Trên Cung Trăng | Thủ Công Cho Bé | Made By Me | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Trung thu n&agrave;y c&aacute;c bạn nhỏ c&oacute; dự định g&igrave; chưa? H&atilde;y c&ugrave;ng c&aacute;c bạn Thỏ kh&aacute;m ph&aacute; Mặt Trăng n&agrave;o! Sẽ c&oacute; thật nhiều điều kỳ th&uacute; đang chờ đợi ch&uacute;ng ta. C&ugrave;ng cắt d&aacute;n Thỏ chơi bập b&ecirc;nh tr&ecirc;n Cung Trăng nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2FXofcQW&amp;v=C7RGuuapYTI&amp;event=video_description&amp;redir_token=dpX595RZWQYdpZc338tzRSBk7ux8MTUxODMyNDQ2NkAxNTE4MjM4MDY2" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/XofcQW</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (61, 6, NULL, N'Bé Khéo Tay Gấp Chú Mèo | Thủ Công Cho Bé | Made By Me | BOOKID💖💖💖', N'https://www.youtube.com/watch?v=EzqKSBiTEzw', 0, N'Bé Khéo Tay Gấp Chú Mèo | Thủ Công Cho Bé | Made By Me | BOOKID💖💖💖', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Ch&agrave;o c&aacute;c bạn nhỏ! C&aacute;c bạn c&oacute; biết gấp một ch&uacute; m&egrave;o từ giấy kh&ocirc;ng? H&atilde;y theo d&otilde;i video để xem hướng dẫn nh&eacute;. Chỉ cần v&agrave;i ph&uacute;t l&agrave; ch&uacute;ng m&igrave;nh đ&atilde; c&oacute; ngay một ch&uacute; m&egrave;o si&ecirc;u đ&aacute;ng y&ecirc;u rồi. Kh&ocirc;ng những thế c&ograve;n c&oacute; cả m&oacute;n ăn y&ecirc;u th&iacute;ch của m&egrave;o l&agrave; 1 con c&aacute; m&agrave;u xanh nữa<br />
	<br />
	😀 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?redir_token=i-LClXI1nrYZN_nA_P7YuHegJ6t8MTUxODMyNDUyMUAxNTE4MjM4MTIx&amp;event=video_description&amp;v=EzqKSBiTEzw&amp;q=https%3A%2F%2Fgoo.gl%2FqkBGsx" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/qkBGsx</a><span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;"> </span></p>
<div>
	&nbsp;</div>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (62, 6, NULL, N'Bé Khéo Tay Gấp Chú Mèo Và Cá Bằng Giấy | Thủ Công Cho Bé | Made By Me | BOOKID', N'https://www.youtube.com/watch?v=UyLUmA0rMNE', 0, N'Bé Khéo Tay Gấp Chú Mèo Và Cá Bằng Giấy | Thủ Công Cho Bé | Made By Me | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Ch&agrave;o c&aacute;c bạn! Bookid h&ocirc;m nay sẽ cho c&aacute;c bạn xem một m&agrave;n ảo thuật từ giấy nh&eacute;!. Từ h&igrave;nh vẽ mặt của 1 ch&uacute; m&egrave;o, BooKid h&ocirc; biến l&agrave; đ&atilde; th&agrave;nh một ch&uacute; c&aacute; rồi 😜😜😜 C&aacute;c bạn h&atilde;y xem video nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?v=UyLUmA0rMNE&amp;redir_token=weSvdkOOmqGBrm22XUyG8fCW3u98MTUxODMyNDU4MUAxNTE4MjM4MTgx&amp;event=video_description&amp;q=https%3A%2F%2Fgoo.gl%2F6ST7KW" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/6ST7KW</a></p>
<div>
	&nbsp;</div>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (63, 6, NULL, N'Bé Khéo Tay Gấp Chú Sư Tử Bằng Giấy | Thủ công cho bé | Made by me | BOOKID', N'https://www.youtube.com/watch?v=qCfdw4yD91I', 0, N'Bé Khéo Tay Gấp Chú Sư Tử Bằng Giấy | Thủ công cho bé | Made by me | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">😜 Ch&agrave;o c&aacute;c bạn! Bookid đ&atilde; quay lại rồi đ&acirc;y!!! 😜😜😜 H&ocirc;m nay, ch&uacute;ng ta c&ugrave;ng l&agrave;m một ch&uacute; sư tử để b&agrave;n si&ecirc;u si&ecirc;u dễ thương nh&eacute; 😘😘😘 Bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở link b&ecirc;n dưới nh&eacute;!<br />
	<br />
	🍃 Link download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2FuVif8P&amp;redir_token=qbTdykuTwPtI7S-YA2ZkFH8w-P18MTUxODMyNDY5NkAxNTE4MjM4Mjk2&amp;event=video_description&amp;v=qCfdw4yD91I" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/uVif8P</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (64, 6, NULL, N'Bé Khéo Tay Gấp Chú Mèo May Mắn | Thủ Công Cho Bé | Made By Me | BOOKID', N'https://www.youtube.com/watch?v=k0UvriOqD6U', 0, N'Bé Khéo Tay Gấp Chú Mèo May Mắn | Thủ Công Cho Bé | Made By Me | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">C&aacute;c b&eacute; c&oacute; biết ch&uacute; m&egrave;o may mắn Maneki Neko kh&ocirc;ng? BooKid sẽ giới thiệu cho c&aacute;c em biết c&aacute;ch gấp ch&uacute; m&egrave;o n&agrave;y nh&eacute; ~~ 😘😘😘<br />
	<br />
	🍄 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2F63er3P&amp;redir_token=HF-Z9IhTEWPI6qUKTRVenYT_p1V8MTUxODMyNDc2MUAxNTE4MjM4MzYx&amp;event=video_description&amp;v=k0UvriOqD6U" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/63er3P</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (65, 6, NULL, N'Bé Khéo Tay Gấp Con Chim Bằng Giấy | Thủ Công Cho Bé | BOOKID', N'https://www.youtube.com/watch?v=eQUBlpqW-AY', 0, N'Bé Khéo Tay Gấp Con Chim Bằng Giấy | Thủ Công Cho Bé | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Chiếp chiếp..chiếp chiếp... Cạnh Bookid b&acirc;y giờ đang c&oacute; một bạn chim xinh xắn n&agrave;y 🐦🐦🐦 Bạn c&oacute; muốn c&oacute; một ch&uacute; chim như vậy kh&ocirc;ng n&agrave;o?<br />
	<br />
	Bookid đ&atilde; cẩn thận quay lại to&agrave;n bộ qu&aacute; tr&igrave;nh tạo ra ch&uacute; chim n&agrave;y rồi đấy, bạn thử l&agrave;m theo nh&eacute; 😜 😜😜 🍃<br />
	<br />
	Link free download bản in ở đ&acirc;y n&egrave;: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2Frj8uk4&amp;redir_token=hGEmMRmzcYAoh4R1oaT2MbA19I98MTUxODMyNDgyNkAxNTE4MjM4NDI2&amp;event=video_description&amp;v=eQUBlpqW-AY" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/rj8uk4</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (66, 6, NULL, N'Bé Khéo Tay Gấp Hộp Hình Thỏ Siêu Đáng Yêu | Thủ Công Cho Bé | BOOKID', N'https://www.youtube.com/watch?v=c6YLRDKi_ec', 0, N'Bé Khéo Tay Gấp Hộp Hình Thỏ Siêu Đáng Yêu | Thủ Công Cho Bé | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">C&aacute;c em c&oacute; biết gấp chiếc hộp đựng những đồ vật nhỏ xinh từ giấy kh&ocirc;ng? 🐰🐰🐰 BooKid sẽ giới thiệu cho c&aacute;c em biết c&aacute;ch gấp một chiếc hộp m&agrave;u hồng h&igrave;nh thỏ con si&ecirc;u đ&aacute;ng y&ecirc;u nh&eacute;~~<br />
	<br />
	😘😘😘 🍄 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?redir_token=PFutqyChGPXxl-8h6OEHSs6CRgV8MTUxODMyNDkwMkAxNTE4MjM4NTAy&amp;v=c6YLRDKi_ec&amp;q=https%3A%2F%2Fgoo.gl%2Fz6uXHa&amp;event=video_description" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/z6uXHa</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (67, 6, NULL, N'Bé Khéo Tay Gấp Chú Voi và Hà Mã Bằng Giấy | Thủ Công Cho Bé | Made By Me | BOOKID', N'https://www.youtube.com/watch?v=zC7iy0Z1df4', 0, N'Bé Khéo Tay Gấp Chú Voi và Hà Mã Bằng Giấy | Thủ Công Cho Bé | Made By Me | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Voi v&agrave; H&agrave; M&atilde; l&agrave; đ&ocirc;i bạn th&acirc;n ở khu rừng của Bookid đấy c&aacute;c b&eacute; ạ 🐘🦏🐘🦏 C&ugrave;ng l&agrave;m cặp bạn th&acirc;n n&agrave;y rồi chia sẻ với c&aacute;c bạn nh&eacute;, c&aacute;c bạn của b&eacute; sẽ rất vui đấy 😘😘😘<br />
	<br />
	🍁 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?event=video_description&amp;v=zC7iy0Z1df4&amp;q=https%3A%2F%2Fgoo.gl%2FaswZkg&amp;redir_token=eKu3U6dbDWBI9wniMpUdTPvmqxx8MTUxODMyNDk2NUAxNTE4MjM4NTY1" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/aswZkg</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (68, 6, NULL, N'Bé Khéo Tay Gấp Con Rắn | Thủ Công Cho Bé | Made By Me | BOOKID', N'https://www.youtube.com/watch?v=rKAXwZgl_xE', 0, N'Bé Khéo Tay Gấp Con Rắn | Thủ Công Cho Bé | Made By Me | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Tớ l&agrave; ch&uacute; rắn xanh. C&aacute;c bạn c&oacute; sợ tớ kh&ocirc;ng n&agrave;o?<br />
	<br />
	😀 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2F4JMZsC&amp;event=video_description&amp;v=rKAXwZgl_xE&amp;redir_token=6sXGNUreO88C0u8p0nTdlLhxTUd8MTUxODMyNTIwNEAxNTE4MjM4ODA0" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/4JMZsC</a><span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;"> </span></p>
<div>
	&nbsp;</div>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (69, 6, NULL, N'Bé Khéo Tay Gấp Chú Lợn Ham Ăn Bằng Giấy | Thủ Công Cho Bé | Made By Me | BOOKID', N'https://www.youtube.com/watch?v=0ufshbQ0rrs', 0, N'Bé Khéo Tay Gấp Chú Lợn Ham Ăn Bằng Giấy | Thủ Công Cho Bé | Made By Me | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Tớ l&agrave; ch&uacute; heo ham ăn, ăn ho&agrave;i m&agrave; kh&ocirc;ng sợ b&eacute;o. C&aacute;c bạn nhỏ c&oacute; muốn nu&ocirc;i tớ trong nh&agrave; kh&ocirc;ng?<br />
	Vậy h&atilde;y tải file về, in ra v&agrave; l&agrave;m theo hướng dẫn nh&eacute;!<br />
	<br />
	😀 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2FMDNoNw&amp;redir_token=gKR7c3pboEr84o2iHYjdnYsoSeV8MTUxODMyNTI3MUAxNTE4MjM4ODcx&amp;event=video_description&amp;v=0ufshbQ0rrs" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/MDNoNw</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (70, 6, NULL, N'Bé Khéo Tay | Thủ Công Cho Bé | Made By Me | Gấp Con Ếch Bằng Giấy | BOOKID', N'https://www.youtube.com/watch?v=m-XCVg5CbR8', 0, N'Bé Khéo Tay | Thủ Công Cho Bé | Made By Me | Gấp Con Ếch Bằng Giấy | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">C&oacute; bạn nhỏ n&agrave;o biết gấp một ch&uacute; ếch bằng giấy kh&ocirc;ng? H&atilde;y xem video nh&eacute;. Cực dễ phải kh&ocirc;ng n&agrave;o!<br />
	<br />
	😀 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?event=video_description&amp;v=m-XCVg5CbR8&amp;redir_token=IVD111WVRd9WmJr_Zx6DCNjg6hJ8MTUxODMyNTMzMUAxNTE4MjM4OTMx&amp;q=https%3A%2F%2Fgoo.gl%2FXtu6bx" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/Xtu6bx</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (71, 6, NULL, N'Bé Khéo Tay | Thủ Công Cho Bé | Made By Me | Gấp Mặt Mèo | BOOKID', N'https://www.youtube.com/watch?v=ZPKXD5Goe9o', 0, N'Bé Khéo Tay | Thủ Công Cho Bé | Made By Me | Gấp Mặt Mèo | BOOKID', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Ch&agrave;o c&aacute;c bạn nhỏ! C&aacute;c bạn c&oacute; biết gấp mặt một ch&uacute; m&egrave;o từ giấy kh&ocirc;ng? H&atilde;y theo d&otilde;i video để xem hướng dẫn nh&eacute;. Chỉ cần v&agrave;i ph&uacute;t l&agrave; ch&uacute;ng m&igrave;nh đ&atilde; c&oacute; ngay một c&aacute;i mặt của ch&uacute; m&egrave;o rồi. Meoo meoo!<br />
	<br />
	😀 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?v=ZPKXD5Goe9o&amp;redir_token=30GKxuec5t2i5gYhCbHY5FGrHwR8MTUxODMyNTQwMkAxNTE4MjM5MDAy&amp;event=video_description&amp;q=https%3A%2F%2Fgoo.gl%2FLsCrZd" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/LsCrZd</a><span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;"> </span></p>
<div>
	&nbsp;</div>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (72, 6, NULL, N'Bé Khéo Tay | Thủ Công Cho Bé | Made By Me | Gấu ăn Sushi | BOOKID', N'https://www.youtube.com/watch?v=A48WobAtnK4', 0, N'Bé Khéo Tay | Thủ Công Cho Bé | Made By Me | Gấu ăn Sushi | BOOKID
', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Ting! Ting! Ting! Tớ l&agrave; ch&uacute; gấu cực th&iacute;ch ăn sushi. C&aacute;c bạn nhỏ c&oacute; muốn chơi với tớ kh&ocirc;ng? Nếu c&oacute; th&igrave; h&atilde;y in file ra rồi chơi nh&eacute;!<br />
	<br />
	😀 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?event=video_description&amp;v=A48WobAtnK4&amp;redir_token=Dhz3hpOpIm_gwewKPc8L8NlqB_N8MTUxODMyNTQ2OUAxNTE4MjM5MDY5&amp;q=https%3A%2F%2Fgoo.gl%2FcZKhPP" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/cZKhPP</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (73, 6, NULL, N'Bé Khéo Tay | Thủ Công Cho Bé | Hướng Dẫn Làm Đu Quay Bằng Giấy | BOOKID', N'https://www.youtube.com/watch?v=KH9dozqNOUM', 0, N'Bé Khéo Tay | Thủ Công Cho Bé | Hướng Dẫn Làm Đu Quay Bằng Giấy | BOOKID
', N'<p>
	<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">Ch&agrave;o c&aacute;c bạn nhỏ! Tớ l&agrave; chiếc đu quay. Xoay xoay tr&ograve;n, xoay xoay tr&ograve;n, t&ocirc;i với bạn c&ugrave;ng quay, quay. Giờ c&aacute;c bạn nhỏ h&atilde;y tự thiết kế cho ri&ecirc;ng m&igrave;nh một chiếc đu quay nh&eacute;!<br />
	<br />
	😀 C&aacute;c bạn c&oacute; thể tải bản in ho&agrave;n to&agrave;n miễn ph&iacute; ở đ&acirc;y: </span><a class="yt-simple-endpoint style-scope yt-formatted-string" href="https://www.youtube.com/redirect?q=https%3A%2F%2Fgoo.gl%2FmCbA4L&amp;event=video_description&amp;redir_token=sFPcIN5vd2q8K4FBbZphyBUaHz98MTUxODMyNTU5N0AxNTE4MjM5MTk3&amp;v=KH9dozqNOUM" style="display: inline-block; cursor: pointer; text-decoration-line: none; font-size: 14px; line-height: var(--yt-formatted-string-endpoint_-_line-height); font-family: Roboto, Arial, sans-serif; white-space: pre-wrap;">https://goo.gl/mCbA4L</a></p>
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (74, 5, NULL, N'Khoa học cho bé | Những câu hỏi ngộ nghĩnh | Tập 10 | BooKid', N'https://www.youtube.com/watch?v=_-Ltiu0umPI&list=PLmo7IrZTZfJsxurwqmk3R3jrc1pPYtMEm&index=1', 0, NULL, N'<span style="color: rgb(17, 17, 17); font-family: Roboto, Arial, sans-serif; font-size: 14px; white-space: pre-wrap;">V&igrave; sao trời vừa s&aacute;ng g&agrave; trống đ&atilde; g&aacute;y?</span>', 1, -1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[CmsProducts] ([Id], [TypeId], [Image], [Name], [Link], [NumberView], [Title], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (75, 5, N'/Uploads/CKFinder/images/San_pham/TAP10-01.png', N'Khoa học cho bé - Những câu hỏi ngộ nghĩnh - Tập 10 - BooKid', N'https://www.youtube.com/watch?v=_-Ltiu0umPI&t=89s', 0, N' Vì sao có loài cây thích phơi nắng, có loài lại không thích?', N'<br />
', 1, 1, 5, CAST(N'2018-02-10 00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[CmsProducts] OFF
SET IDENTITY_INSERT [dbo].[CmsService] ON 

INSERT [dbo].[CmsService] ([Id], [Name], [Image], [Title], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'PHIM HOẠT HÌNH', N'/Uploads/CKFinder/images/Dich_vu/dv1-1428920005_500x500.jpg', N'/ cccccc', 1, N'Sản xuất v&agrave; ph&acirc;n phối phim hoạt h&igrave;nh, chương tr&igrave;nh thiếu nhi trong v&agrave; ngo&agrave;i nước. C&aacute;c TV series đ&atilde; thực hiện: Xin ch&agrave;o B&uacute;t Ch&igrave;, Điều ch&uacute;ng m&igrave;nh chưa biết. Ph&aacute;t s&oacute;ng l&uacute;c 17h20, thứ 7 v&agrave; chủ nhật h&agrave;ng tuần tr&ecirc;n HTV7 c', 1, 3, CAST(N'2018-01-28' AS Date), 3, CAST(N'2018-02-11' AS Date))
INSERT [dbo].[CmsService] ([Id], [Name], [Image], [Title], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'PHIM QUẢNG CÁO', N'/Uploads/CKFinder/images/Dich_vu/dv2-1428920017_500x500.jpg', N'phim-quang-cao', 1, N'﻿Sản xuất phim quảng cáo, phim tự giới thiệu bằng kỹ thuật hoạt hình.
', 1, 3, CAST(N'2018-01-28' AS Date), 5, CAST(N'2018-02-02' AS Date))
INSERT [dbo].[CmsService] ([Id], [Name], [Image], [Title], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'PHIM MA THUAT', N'/Uploads/CKFinder/images/Dich_vu/dv1-1428920005_500x500.jpg', N'V', 1, N'Noi dung mo ta', 1, 5, CAST(N'2018-01-29' AS Date), 5, CAST(N'2018-02-02' AS Date))
INSERT [dbo].[CmsService] ([Id], [Name], [Image], [Title], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'HOAT HINH', N'/Uploads/CKFinder/images/Dich_vu/dv2-1428920017_500x500.jpg', N'V', 1, N'BBB', 0, 5, CAST(N'2018-01-29' AS Date), 5, CAST(N'2018-02-02' AS Date))
SET IDENTITY_INSERT [dbo].[CmsService] OFF
SET IDENTITY_INSERT [dbo].[CmsSlide] ON 

INSERT [dbo].[CmsSlide] ([Id], [Image], [Title], [Alt], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'/Uploads/CKFinder/images/Slide/SLIDE-01.png', N'Slide 2', N'hinh-anh-mang-tinh-chat-minh-hoa', NULL, 2, 1, 3, CAST(N'2018-01-27' AS Date), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsSlide] ([Id], [Image], [Title], [Alt], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'/Uploads/CKFinder/images/Slide/SLIDE-01-01.png', N'Slide1', N'hinh-anh-1', NULL, 1, 1, 3, CAST(N'2018-01-27' AS Date), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsSlide] ([Id], [Image], [Title], [Alt], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'/Uploads/CKFinder/images/Slide/SLIDE-01-01-01-01.png', N'slide3', N'hinh-anh3', NULL, 3, 1, 3, CAST(N'2018-01-27' AS Date), 5, CAST(N'2018-02-10' AS Date))
INSERT [dbo].[CmsSlide] ([Id], [Image], [Title], [Alt], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'/Uploads/CKFinder/images/Slide/SLIDE-01-01-01.png', N'Slide4', N'hinh-anh4', NULL, 4, 1, 3, CAST(N'2018-01-27' AS Date), 5, CAST(N'2018-02-10' AS Date))
SET IDENTITY_INSERT [dbo].[CmsSlide] OFF
SET IDENTITY_INSERT [dbo].[CmsSociety] ON 

INSERT [dbo].[CmsSociety] ([Id], [Type], [Name], [Link], [Icon], [Image], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, 2, N'Youtube', N'https://www.youtube.com/bookidvn', NULL, NULL, 2, 1, 1, CAST(N'2017-02-02' AS Date), 5, CAST(N'2018-02-03' AS Date))
INSERT [dbo].[CmsSociety] ([Id], [Type], [Name], [Link], [Icon], [Image], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, 3, N'Google-plus', N'https://plus.google.com/u/1/b/109826951178713302889/', NULL, NULL, 2, 1, 1, CAST(N'2017-02-02' AS Date), 5, CAST(N'2018-02-03' AS Date))
INSERT [dbo].[CmsSociety] ([Id], [Type], [Name], [Link], [Icon], [Image], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, 4, N'Twitter', N'https://www.facebook.comccccc', NULL, NULL, 1, -1, 1, CAST(N'2017-02-02' AS Date), 3, CAST(N'2018-01-26' AS Date))
INSERT [dbo].[CmsSociety] ([Id], [Type], [Name], [Link], [Icon], [Image], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, 1, N'Facebook', N'https://www.facebook.com/bookid.vn', NULL, NULL, 1, 1, 5, CAST(N'2016-01-03' AS Date), 5, CAST(N'2018-02-03' AS Date))
SET IDENTITY_INSERT [dbo].[CmsSociety] OFF
SET IDENTITY_INSERT [dbo].[CmsSupport] ON 

INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (1, N'Ngô Văn Trọng', N'trongnv@gmail.com', N'097244242424', 1, NULL, 1, NULL, 2, CAST(N'2007-04-02 00:00:00.000' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (2, N'Ngô Văn Trọng 2', N'trongnv@gmail.com', N'097244242424', 0, N'Definition and Usage. The length property returns the length of a string (number of characters). The length of an empty string is 0. Browser Support. Property. length, Yes, Yes, Yes, Yes, Yes. Syntax. string.length. Technical Details. Return Value: The length of a string. JavaScript Version: 1.0. ❮ JavaScript String Reference ...', 0, NULL, 2, CAST(N'2007-02-02 00:00:00.000' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (3, N'Ngô Văn Trọng 4', N'trongnv@gmail.com', N'097244242424', 0, NULL, 0, NULL, 2, CAST(N'2007-02-02 00:00:00.000' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (4, N'Ngô Văn Trọng 24', N'trongnv@gmail.com', N'097244242424', 1, NULL, 0, NULL, 2, CAST(N'2007-02-02 00:00:00.000' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (5, N'1', N'2@gmail.com', N'3', 1, N'444', 0, NULL, 0, CAST(N'2018-02-01 22:52:10.210' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (6, N'1', N'2@gmail.com', N'3', 1, N'444', 0, NULL, 0, CAST(N'2018-02-01 22:55:05.783' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (7, N'Ngô Van Tr?ng', N'trongnv1507@gmail.com', N'0973002521', 1, N'Nội dung tin nhắn chưa được phản hồi', 0, NULL, 0, CAST(N'2018-02-02 23:22:40.753' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (8, N'D?CH V?', N'host@gmail.com', N'34234', 1, N'Nội dung tin nhắn chưa được phản hồi', 0, NULL, 0, CAST(N'2018-02-02 23:24:09.003' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (9, N'Ngô Văn Trọng', N'host@gmail.com', N'34234', 1, N'Nội dung tin nhắn chưa được phản hồi', 0, NULL, 0, CAST(N'2018-02-03 00:23:48.537' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (10, N'Ngô Văn Trọng', N'host@gmail.com', N'34234', 1, N'

So I have a view called index that lays out all of the threads in my database. Then inside that view I''m loading all the comments on the threads. When I call on my form that is supposed to create a new comment it keeps telling me that my model state is invalid. It tells me that it cannot convert from type string to type profile or comment or tag. Originally I had this as my code:', 0, NULL, 0, CAST(N'2018-02-03 00:26:52.747' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (11, N'DỊCH VỤ', N'host@gmail.com', N'3', 1, N'

So I have a view called index that lays out all of the threads in my database. Then inside that view I''m loading all the comments on the threads. When I call on my form that is supposed to create a new comment it keeps telling me that my model state is invalid. It tells me that it cannot convert from type string to type profile or comment or tag. Originally I had this as my code:', 0, NULL, 0, CAST(N'2018-02-03 00:29:27.877' AS DateTime))
INSERT [dbo].[CmsSupport] ([Id], [Name], [Email], [Phone], [IsRead], [ContentSent], [IsConfirm], [ContentConfirm], [ConfirmBy], [CreatedDate]) VALUES (12, N'tr', N'trongnv1507@gmail.com', NULL, 1, N'ADDRESS:
 Phòng 1701 tầng 17, tòa nhà Cảnh sát 113, ngõ 299, Trung Kính, quận Cầu Giấy, Hà Nội', 0, NULL, 0, CAST(N'2018-02-11 14:20:52.387' AS DateTime))
SET IDENTITY_INSERT [dbo].[CmsSupport] OFF
SET IDENTITY_INSERT [dbo].[CmsType] ON 

INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Thơ Cho Bé', 1, N'tho-cho-be', NULL, 1, 1, 1, CAST(N'2017-02-02' AS Date), 5, CAST(N'2018-02-09' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Phim Cuối tuần ', 2, N'phim-cuoi-tuan', NULL, 1, 1, 5, CAST(N'2018-01-28' AS Date), 5, CAST(N'2018-01-30' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Nhạc Thiếu Nhi', 1, N'nhac-thieu-nhi', NULL, 1, 1, 5, CAST(N'2018-01-28' AS Date), 5, CAST(N'2018-02-09' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Truyện Cổ Tích', 1, N'truyen-co-tich', NULL, 1, 1, 5, CAST(N'2018-01-30' AS Date), 5, CAST(N'2018-02-09' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Những Câu Hỏi Ngộ Nghĩnh', 1, N'nhung-cau-hoi-ngo-nghinh', NULL, 1, 1, 5, CAST(N'2018-01-30' AS Date), 5, CAST(N'2018-02-09' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Bé Khéo tay', 1, N'be-kheo-tay', NULL, 1, 1, 5, CAST(N'2018-01-30' AS Date), 5, CAST(N'2018-02-09' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Tiếng Việt', 1, N'tieng-viet', NULL, 1, 1, 5, CAST(N'2018-01-30' AS Date), 5, CAST(N'2018-02-09' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Mỗi tuần 1 phim', 2, N'moi-tuan-1-phim', NULL, 1, 1, 5, CAST(N'2018-01-30' AS Date), 5, CAST(N'2018-01-30' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Khám phá', 2, N'kham-pha', NULL, 1, 1, 5, CAST(N'2018-01-30' AS Date), 5, CAST(N'2018-01-30' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, N'Kỹ thuật làm phim', 2, N'ky-thuat-lam-phim', NULL, 1, 1, 5, CAST(N'2018-01-30' AS Date), NULL, NULL)
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'Tiếng Anh', 1, N'tieng-anh', NULL, 1, 1, 5, CAST(N'2018-01-30' AS Date), 5, CAST(N'2018-02-09' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'Toán Học', 1, N'toan-hoc', NULL, 1, 1, 5, CAST(N'2018-01-30' AS Date), 5, CAST(N'2018-02-09' AS Date))
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'Sản phẩm', 3, N'san-pham', NULL, 1, 1, 3, CAST(N'2018-02-11' AS Date), NULL, NULL)
INSERT [dbo].[CmsType] ([Id], [Name], [Type], [ShortUrl], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'Sản phẩm tiếp', 3, N'san-pham-tiep', NULL, 1, 1, 3, CAST(N'2018-02-11' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[CmsType] OFF
SET IDENTITY_INSERT [dbo].[SysGroup] ON 

INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'Nhom Test', N'<p>cascascascasc sa <b>asd asd asd&nbsp; &nbsp;</b></p><p><b><u>a</u></b></p><p><b><u>câcc</u></b></p><p><b><u>âccac</u></b></p>', 1, 3, CAST(N'2018-01-17' AS Date), 2, CAST(N'2018-01-24' AS Date))
INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'Nhóm admin', N'<p>cascascascasc sa <b>asd asd asd&nbsp; &nbsp;</b></p><p><b><u>a</u></b></p><p><b><u>câcccccccccc</u></b></p><p><b><u>âccac</u></b></p>', 1, 3, CAST(N'2018-01-17' AS Date), 3, CAST(N'2018-01-24' AS Date))
SET IDENTITY_INSERT [dbo].[SysGroup] OFF
SET IDENTITY_INSERT [dbo].[SysGroupMenu] ON 

INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (114, 19, 4, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (115, 19, 5, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (116, 19, 6, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (117, 19, 15, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (118, 19, 12, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (119, 19, 13, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (120, 19, 20, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (121, 19, 16, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (123, 19, 8, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (124, 19, 17, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (125, 19, 18, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (126, 19, 19, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (127, 19, 21, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (128, 19, 22, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (129, 19, 4, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (130, 19, 5, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (131, 19, 6, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (132, 19, 12, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (133, 19, 13, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (134, 19, 20, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (136, 19, 8, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (137, 19, 17, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (138, 19, 18, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (139, 19, 19, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (140, 19, 21, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (141, 19, 22, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (142, 19, 23, 4, N'View', 1, 1, CAST(N'2018-02-02' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (143, 19, 23, 0, N'Admin', 1, 1, CAST(N'2018-02-02' AS Date), 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysGroupMenu] OFF
SET IDENTITY_INSERT [dbo].[SysGroupUser] ON 

INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, 18, 2, 2, 1, CAST(N'2018-01-24' AS Date), 2, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, 19, 5, 2, 1, CAST(N'2018-01-24' AS Date), 3, NULL, NULL)
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
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (15, N'#', NULL, N'Tiện ích', N'fa fa-cc-discover', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:46:15.663' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (16, N'#', NULL, N'Quản trị nội dung', N'fa fa-th-large', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:46:09.523' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (17, N'/System/CmsBlog', 16, N'Quản lý Tin tức', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-02-11 14:52:29.887' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (18, N'/System/CmsIntroduce', 16, N'Quản lý giới thiệu', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:45:15.660' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (19, N'/System/CmsProducts', 16, N'Quản lý Video', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-02-11 14:52:46.177' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (20, N'/System/CmsEmail', 15, N'Quản lý email hệ thống', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-02-02 16:59:59.437' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (21, N'/System/CmsEvent', 16, N'Quản lý sản phẩm', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-29' AS Date), 3, CAST(N'2018-02-11 14:56:56.217' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (22, N'/System/CmsType', 16, N'Quản lý chuyên mục ', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-29' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (23, N'/System/CmsSupport', 15, N'Danh sách liên hệ', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-02-03' AS Date), 3, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysMenu] OFF
SET IDENTITY_INSERT [dbo].[SysUser] ON 

INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, 1, N'trongnv1507', N'HOST FULLNAME', 1, NULL, N'0', 0, NULL, N'213123123', N'host@gmail.com', 1, 1, CAST(N'2018-01-22' AS Date), NULL, CAST(N'2018-01-22' AS Date))
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, 3, N'host', N'Quản trị cấp cao', 1, NULL, N'1', NULL, NULL, NULL, N'host@gmail.com', 1, 1, CAST(N'2018-01-24' AS Date), NULL, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, 4, N'trongnv', N'Ngô Văn Trọng', 0, NULL, N'1', NULL, NULL, NULL, N'trongnv1507@gmail.com', 1, 3, CAST(N'2018-01-24' AS Date), NULL, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, 5, N'admin', N'Quản trị hệ thống', 0, NULL, N'1', NULL, NULL, NULL, N'admin@gmail.com', 1, 3, CAST(N'2018-01-24' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysUser] OFF
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (5, N'admin')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (3, N'host')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (4, N'trongnv')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (1, N'trongnv1507')
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(N'2018-01-23 19:11:39.037' AS DateTime), NULL, 1, NULL, 0, N'APQX3rkCXd1JUuXGcTrFtgEb/+tRfzrDW7i2GaMbonFuyZ3KBhh2vd+I1nwnSWPvkw==', CAST(N'2018-01-23 19:11:39.037' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (2, CAST(N'2018-01-23 19:12:14.827' AS DateTime), NULL, 1, CAST(N'2018-01-25 16:45:04.037' AS DateTime), 0, N'AMDQdsJO1vAlrLG1w1ihaVnEriGuI5Y/kcsRa13MBpRivkPVdiEzeaSte2pPkJxFWg==', CAST(N'2018-01-23 19:12:14.827' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (3, CAST(N'2018-01-24 15:58:01.640' AS DateTime), NULL, 1, NULL, 0, N'AAcrxXqoLYKjwZs5M4khnh3l/Ssx+6l+gnTvQzdfe+KjVMCVusHTdIUqsIlZPDBZlg==', CAST(N'2018-01-24 15:58:01.640' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (4, CAST(N'2018-01-24 16:16:53.140' AS DateTime), NULL, 1, NULL, 0, N'AMPAFx0NuVPPTjdSxl5JZ4oZdJzUHdaz+ERgDqslaWEvUbUSxySyMAxZYRAPcmCcJA==', CAST(N'2018-01-24 16:16:53.140' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (5, CAST(N'2018-01-24 16:20:08.993' AS DateTime), NULL, 1, CAST(N'2018-02-10 05:38:22.323' AS DateTime), 0, N'APqUPUH5DKEK4/endHx709VBhQeqdBMip7u469b5gICNDctqkZ911TNbgpWWFGXqXQ==', CAST(N'2018-01-24 16:20:08.993' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (6, CAST(N'2018-01-25 15:58:07.180' AS DateTime), NULL, 1, NULL, 0, N'AP0p+aJMuND/MVMV/45OrBDpYiJ9ayecI8tRqR1tmBfSBOP6VXzy3WJ73L+u1096mg==', CAST(N'2018-01-25 15:58:07.180' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (7, CAST(N'2018-01-25 16:50:27.067' AS DateTime), NULL, 1, NULL, 0, N'AJLX40TeIB3f0mDm6gpP6caP/oIcCS6VULutc0SV1Vt/fZ6hb7yJKQQGP2wfe3trFg==', CAST(N'2018-01-25 16:50:27.067' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (8, CAST(N'2018-01-25 16:58:53.913' AS DateTime), NULL, 1, NULL, 0, N'AMk6dKWWkHtPsAlSB0V0oeTcIfehgc4DHyzcvSERTycVaxWYoMRGZq/n1+oYeGAfOA==', CAST(N'2018-01-25 16:58:53.913' AS DateTime), N'', NULL, NULL)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F284564B7C30C8]    Script Date: 2/11/2018 11:43:13 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F28456678F97EA]    Script Date: 2/11/2018 11:43:13 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F28456A84A8D02]    Script Date: 2/11/2018 11:43:13 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B616016013798]    Script Date: 2/11/2018 11:43:13 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B61609612CA49]    Script Date: 2/11/2018 11:43:13 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B6160A7F8CA32]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsBlog_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsBlog_Insert]
	@TypeId int,
	@Image varchar(500),   
	@Title nvarchar(1500), 
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@NumberView int,
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsBlog (
		[TypeId]
		 ,[Image]	
		,[Title]
		,[Name]
		,[Summary]
		,[NumberView]
		 ,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
		@TypeId
		,@Image
		,@Title		
		,@Name
		,@Summary
		,@NumberView
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()




GO
/****** Object:  StoredProcedure [dbo].[CmsBlog_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsBlog_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,y.Name as TypeName,y.ShortUrl as ShortUrl
			FROM [CmsBlog] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			LEFT JOIN CmsType y ON y.Id = a.TypeId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [CmsBlog] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END




GO
/****** Object:  StoredProcedure [dbo].[CmsBlog_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsBlog_Update]
	@Id int,
	@TypeId int,
	@Image varchar(500),   
	@Title nvarchar(1500), 
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@NumberView int,
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsBlog SET
	   
		[TypeId]=@TypeId
	   ,[Image ] = @Image 
	   ,[Title] = @Title 
	   ,[Name ] = @Name 
	   ,[Summary ] = @Summary 
	  ,[NumberView]=@NumberView
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsBlog].[Id] = @Id
SELECT @@RowCount





GO
/****** Object:  StoredProcedure [dbo].[CmsCategory_Deletes]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Updates]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEmail_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsEmail_Insert]
	@Email varchar(50),   
	@Address nvarchar(500),  	
	@Phone varchar(50),  	
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsEmail (
		[Email]	
		,[Address]
		,[Phone]
		,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
		@Email
		,@Address
		,@Phone
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()




GO
/****** Object:  StoredProcedure [dbo].[CmsEmail_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEmail_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsEmail_Update]
	@Id int, 
	@Email varchar(50),  		 
	@Address nvarchar(500),  	
	@Phone varchar(50),  	
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsEmail SET
	   
	   [Email] = @Email
	  ,[Address]=@Address
	  ,[Phone]=@Phone
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
/****** Object:  StoredProcedure [dbo].[CmsEvent_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsEvent_Insert]
	@Image varchar(500),
	@TypeId int,   
	@Title nvarchar(250), 
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@NumberView int,
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsEvent (
		 [Image]
		 ,[TypeId]	
		,[Title]
		,[Name]
		,[Summary]
		,[NumberView]
		 ,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
		@Image
		,@TypeId
		,@Title		
		,@Name
		,@Summary
		,@NumberView
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()




GO
/****** Object:  StoredProcedure [dbo].[CmsEvent_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsEvent_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,y.Name as TypeName,y.ShortUrl as ShortUrl
			FROM [CmsEvent] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			LEFT JOIN CmsType y ON y.Id = a.TypeId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [CmsEvent] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END




GO
/****** Object:  StoredProcedure [dbo].[CmsEvent_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsEvent_Update]
	@Id int,
	@Image varchar(500),   
	@TypeId int,
	@Title nvarchar(250), 
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@NumberView int,
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsEvent SET
	   
	   [Image ] = @Image 
	   ,[TypeId]=@TypeId
	   ,[Title] = @Title 
	   ,[Name ] = @Name 
	   ,[Summary ] = @Summary 
	  ,[NumberView]=@NumberView
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsEvent].[Id] = @Id
SELECT @@RowCount





GO
/****** Object:  StoredProcedure [dbo].[CmsIntroduce_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsIntroduce_Insert]
	@HomeContent  nvarchar(Max),
	@PageIntroduce  nvarchar(Max),
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsIntroduce (
		 [HomeContent]	
		,[PageIntroduce]		
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
		@HomeContent
		,@PageIntroduce	
		
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()




GO
/****** Object:  StoredProcedure [dbo].[CmsIntroduce_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsIntroduce_Update]
	@Id int,	
	@HomeContent  nvarchar(Max),
	@PageIntroduce  nvarchar(Max),
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsIntroduce SET
	   
	   [HomeContent ] = @HomeContent 
	   ,[PageIntroduce] = @PageIntroduce	   
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsIntroduce].[Id] = @Id
SELECT @@RowCount





GO
/****** Object:  StoredProcedure [dbo].[CmsProducts_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsProducts_Insert]
	@TypeId int,
	@Image nvarchar(256), 
	@Name nvarchar(256), 
	@Link nvarchar(256), 
	@NumberView int, 	
	@Title nvarchar(max),  		 
	@Summary nvarchar(max),  		 
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsProducts (
		 [TypeId]
		 ,[Image]
		,[Name]
		,[Link]
		,[NumberView]
		,[Title]	
		,[Summary]
		,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (
		@TypeId
        ,@Image
		,@Name
		,@Link
		,@NumberView
		,@Title
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
/****** Object:  StoredProcedure [dbo].[CmsProducts_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsProducts_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,y.Name as TypeName,y.ShortUrl as ShortUrl
			FROM [CmsProducts] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			LEFT JOIN CmsType y ON y.Id = a.TypeId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [CmsProducts] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END




GO
/****** Object:  StoredProcedure [dbo].[CmsProducts_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsProducts_Update]
	@Id int, 
	@TypeId int,
	@Image nvarchar(256), 
	@Name nvarchar(256), 
	@Link nvarchar(256), 
	@NumberView int,
	@Title nvarchar(max),
	@Summary nvarchar(max),  		 
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsProducts SET
		[TypeId]=@TypeId
	    ,[Image] = @Image
	    ,[Name] = @Name
		,[Link] = @Link
		,[NumberView] = @NumberView
		,[Title]=@Title
		,[Summary] = @Summary
	  
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsProducts].[Id] = @Id
SELECT @@RowCount





GO
/****** Object:  StoredProcedure [dbo].[CmsService_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsService_Insert]
	@Image varchar(500),   
	@Title nvarchar(Max), 
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
/****** Object:  StoredProcedure [dbo].[CmsService_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsService_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSlide_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSlide_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSlide_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSociety_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSociety_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSociety_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSupport_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsSupport_Insert]
	@Name nvarchar(500),
	@Email varchar(500),   
	@Phone nvarchar(500),  			
	@IsRead bit,
	@ContentSent nvarchar(max),
	@IsConfirm bit, 
	@ContentConfirm nvarchar(max) ,
	@ConfirmBy int ,
	@CreatedDate datetime
AS

INSERT INTO CmsSupport (				
		[Name]
		,[Email]
		,[Phone]
		,[IsRead]
		,[ContentSent]		
		,[IsConfirm]
		,[ContentConfirm]
		,[ConfirmBy]
		,[CreatedDate]
	
	
) VALUES (
		@Name
		,@Email
		,@Phone
		,@IsRead
		,@ContentSent		
		,@IsConfirm
		,@ContentConfirm
		,@ConfirmBy
		,@CreatedDate
	
)
select SCOPE_IDENTITY()




GO
/****** Object:  StoredProcedure [dbo].[CmsSupport_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsSupport_List_Paging]
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
			FROM [CmsSupport] a
			LEFT JOIN SysUser u ON a.ConfirmBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [CmsSupport] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END




GO
/****** Object:  StoredProcedure [dbo].[CmsSupport_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[CmsSupport_Update]
	@Id int, 
	@Name varchar(500),
	@Email varchar(500),   
	@Phone nvarchar(500),  			
	@IsRead bit,
	@ContentSent nvarchar(max),
	@IsConfirm bit, 
	@ContentConfirm nvarchar(max) ,
	@ConfirmBy int ,
	@CreatedDate datetime

AS

UPDATE CmsSupport SET
	   
	   [Email] = @Email
	  ,[Name]=@Name
	  ,[Phone]=@Phone
	   ,[IsRead] = @IsRead
	   ,[ContentSent] = @ContentSent
	  
	   ,[IsConfirm] = @IsConfirm
	   ,[ContentConfirm] = @ContentConfirm
	   ,[ConfirmBy] = @ConfirmBy
	   ,[CreatedDate] = @CreatedDate
WHERE
    
	[CmsSupport].[Id] = @Id
SELECT @@RowCount





GO
/****** Object:  StoredProcedure [dbo].[CmsType_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsType_Insert]
	
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@Type int,
	@ShortUrl nvarchar(250),
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO CmsType (
		
		[Name]
		,[Summary]
		,[Type]
		,[ShortUrl]
		 ,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (		
		@Name
		,@Summary
		,@Type
		,@ShortUrl
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()




GO
/****** Object:  StoredProcedure [dbo].[CmsType_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CmsType_Update]
	@Id int,
	
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@Type int,
	@ShortUrl nvarchar(250),
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE CmsType SET
	   
	  
	   [Name] = @Name 
	   ,[Summary] = @Summary 
		,[Type]=@Type
		,[ShortUrl]=@ShortUrl
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[CmsType].[Id] = @Id
SELECT @@RowCount





GO
/****** Object:  StoredProcedure [dbo].[SysGroup_GetById]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SysGroup_GetById]
@Id int
as
select * from SysGroup where Id=@Id




GO
/****** Object:  StoredProcedure [dbo].[SysGroup_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_List]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_List_Reference]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_GetBy_GroupId]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_List]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_GetUserInGroup]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_GetUserNotInGroup]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_GetById]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SysMenu_GetById]
@Id int
as
select * from SysMenu where Id=@Id




GO
/****** Object:  StoredProcedure [dbo].[SysMenu_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_List]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_List_Recursive]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_Updates]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_Insert]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_List]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_ListByFK]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_Update]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_Deletes]    Script Date: 2/11/2018 11:43:13 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_GetById]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Table_GetById]
@Table nvarchar(120),
@Id varchar(100)
as
DECLARE @SQL NVARCHAR(4000)
Set @SQL='select * from '+@Table+' a where a.Id='+@Id+''
EXECUTE sp_executesql @SQL;

GO
/****** Object:  StoredProcedure [dbo].[Table_List]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Table_List]
	  
	@Table varchar(100),
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
		SET @SQL = 'SELECT a.* FROM ['+@Table+'] a '+ @sWhere+ @sOrder;
		EXECUTE sp_executesql @SQL;
	END
ELSE
	BEGIN
		IF (@sOrder IS NULL OR @sOrder='') SET @sOrder='ORDER BY a.Id'
		SET @SQL = 'WITH PagingTable AS
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName
			FROM ['+@Table+'] a 			
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			'+@sWhere+')
			SELECT * FROM PagingTable WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
	END
END


GO
/****** Object:  StoredProcedure [dbo].[Table_List_Paging]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Table_List_Paging]
	@Table varchar(50),
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
			FROM ['+@Table+'] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM ['+@Table+'] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END




GO
/****** Object:  StoredProcedure [dbo].[Table_Updates]    Script Date: 2/11/2018 11:43:13 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Table_Updates]
	@tableName varchar(100),
	@sSet nvarchar(4000),
	@sWhere nvarchar(4000)
AS
DECLARE @sSQL nvarchar(max)
BEGIN
SET @sSQL = 'UPDATE '+@tableName+'  SET ' + 	@sSet + ' WHERE ' + @sWhere
EXECUTE sp_executesql @sSQL;
SELECT @@RowCount
END



GO
