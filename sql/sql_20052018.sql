USE [ELearn]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertToNoSigned]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[ConvertToNoSigned]
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
/****** Object:  Table [dbo].[Cms_Class]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cms_Class](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdGuid] [uniqueidentifier] NOT NULL,
	[Grade] [nchar](30) NULL,
	[SubjectId] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[Image] [nchar](250) NULL,
	[Star] [int] NULL,
	[Price] [float] NULL,
	[TeacherId] [int] NULL,
	[Sale] [float] NULL,
	[Summary] [nvarchar](max) NULL,
	[Content] [nvarchar](max) NULL,
	[VideoDemo] [nchar](500) NULL,
	[LinkFile] [nchar](500) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Cms_Class] PRIMARY KEY CLUSTERED 
(
	[IdGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cms_ClassStudent]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cms_ClassStudent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NULL,
	[ClassGuid] [nvarchar](250) NULL,
	[StudentId] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Cms_ClassStudent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cms_ClassVideo]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cms_ClassVideo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[Link] [nvarchar](500) NULL,
	[Summary] [nvarchar](max) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Cms_ClassVideo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cms_Comments]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cms_Comments](
	[IdGuid] [varchar](250) NOT NULL,
	[ClassId] [int] NULL,
	[ClassStudentId] [int] NULL,
	[UserId] [int] NULL,
	[UserName] [varchar](150) NULL,
	[Comments] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[IsShow] [bit] NULL,
 CONSTRAINT [PK_Cms_Comments] PRIMARY KEY CLUSTERED 
(
	[IdGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cms_GradeSubject]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cms_GradeSubject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Grade] [nchar](50) NULL,
	[SubjectId] [int] NULL,
 CONSTRAINT [PK_CmsGradeSubject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cms_HistoryPayment]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cms_HistoryPayment](
	[IdGuid] [uniqueidentifier] NOT NULL,
	[Code] [varchar](100) NULL,
	[FromUser] [int] NULL,
	[ToUser] [int] NULL,
	[BCoin] [float] NULL,
	[Summary] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NULL,
	[IsShow] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Cms_HistoryPayment] PRIMARY KEY CLUSTERED 
(
	[IdGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cms_Question]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cms_Question](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdGuid] [uniqueidentifier] NOT NULL,
	[Grade] [nchar](30) NULL,
	[SubjectId] [int] NULL,
	[TotalView] [int] NULL,
	[Summary] [nvarchar](max) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Cms_Question] PRIMARY KEY CLUSTERED 
(
	[IdGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cms_QuestionComments]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cms_QuestionComments](
	[IdGuid] [varchar](250) NOT NULL,
	[QuestionId] [varchar](500) NULL,
	[UserId] [int] NULL,
	[FullName] [nvarchar](150) NULL,
	[Comments] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[IsShow] [bit] NULL,
 CONSTRAINT [PK_Cms_QuestionComment] PRIMARY KEY CLUSTERED 
(
	[IdGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cms_Student]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cms_Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[UserName] [nvarchar](150) NULL,
	[FullName] [nvarchar](150) NULL,
	[Orders] [int] NULL,
	[ImageUrl] [nvarchar](200) NULL,
	[Phone] [varchar](50) NULL,
	[Email] [nvarchar](150) NULL,
	[UsedState] [int] NULL,
	[CreatedDate] [date] NULL,
	[Address] [nvarchar](500) NULL,
	[Summary] [nvarchar](max) NULL,
 CONSTRAINT [PK_Cms_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CmsBlog]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsCategory]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsEmail]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsEvent]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsIntroduce]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsProducts]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsService]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsSlide]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsSociety]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsSupport]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[CmsType]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[Ex_Answer]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_Answer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubQuestionId] [int] NULL,
	[Answer] [nvarchar](max) NULL,
	[CorrectAnswer] [bit] NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Ex_Answer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ex_Category]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nchar](20) NULL,
	[Name] [nvarchar](250) NULL,
	[Total] [int] NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Ex_Grade] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ex_CategoryValue]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_CategoryValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CatCode] [nchar](20) NULL,
	[TypeCode] [nchar](20) NULL,
	[Name] [nvarchar](250) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Ex_CategoryValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ex_Exam]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_Exam](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdGuid] [uniqueidentifier] NULL,
	[Grade] [nchar](30) NULL,
	[SubjectId] [int] NULL,
	[Code] [nchar](30) NULL,
	[Name] [nvarchar](250) NULL,
	[Time] [int] NULL,
	[Price] [int] NULL,
	[TotalStudent] [int] NULL,
	[TotalNumber] [int] NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Ex_Exam] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ex_ExamConfig]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_ExamConfig](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExamCode] [nchar](30) NULL,
	[Section] [nvarchar](max) NULL,
	[LevelDifficult] [nchar](30) NULL,
	[TotalNumber] [int] NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Ex_ExamConfig] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ex_ExamRegister]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_ExamRegister](
	[IdGuid] [uniqueidentifier] NOT NULL,
	[IdExam] [uniqueidentifier] NULL,
	[StudentId] [int] NULL,
	[IsSuccess] [bit] NULL,
	[ExamTime] [datetime] NULL,
	[TotalRight] [int] NULL,
	[TotalWrong] [int] NULL,
 CONSTRAINT [PK_Ex_ExamRegister] PRIMARY KEY CLUSTERED 
(
	[IdGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ex_ExamStudent]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_ExamStudent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExamId] [int] NULL,
	[StudentId] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Ex_ExamStudent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ex_Question]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_Question](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NULL,
	[Grade] [nchar](30) NULL,
	[SectionId] [int] NULL,
	[ExamId] [nchar](30) NULL,
	[QuestionContent] [nvarchar](max) NULL,
	[LevelDifficult] [nchar](30) NULL,
	[SubQuestion] [int] NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Ex_Question] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ex_Subject]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_Subject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Orders] [int] NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_CmsSubject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ex_SubQuestion]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_SubQuestion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NULL,
	[SubQuestionName] [nvarchar](250) NULL,
	[Orders] [int] NOT NULL,
	[UsedState] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Ex_SubQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysGroup]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[SysGroupMenu]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[SysGroupUser]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[SysMenu]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[SysUser]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SysUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Token] [varchar](500) NULL,
	[UserId] [int] NULL,
	[UserName] [nvarchar](150) NULL,
	[FullName] [nvarchar](150) NULL,
	[BankAccount] [varchar](150) NULL,
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
	[BCoin] [int] NULL,
	[Summary] [nvarchar](max) NULL,
 CONSTRAINT [PK_SysUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 2018-05-20 6:59:29 PM ******/
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
SET IDENTITY_INSERT [dbo].[Cms_Class] ON 

INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'9073d791-3cbb-4822-8dba-26f708a8a441', N'KHOI-2                        ', 6, N'Thầy Vũ Khắc Ngọc - Một số PP đặc biệt để giải các bài tập khó về peptit (Phần 3)', N'https://i.ytimg.com/vi/ihNXUxZ9Lzo/hqdefault.jpg                                                                                                                                                                                                          ', 0, 25000, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=ihNXUxZ9Lzo                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 10, CAST(N'2018-04-11 09:49:14.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'9073d791-3cbb-4822-8dba-26f708a8a442', N'KHOI-3                        ', 1, N'Mộ số phương pháp giải toán 12', N'https://i.ytimg.com/vi/ihNXUxZ9Lzo/hqdefault.jpg                                                                                                                                                                                                          ', 0, 25000, 10, 0, NULL, N'<p>Thầy ch&agrave;o c&aacute;c em,</p>

<p>Thầy xin tự giới thiệu thầy l&agrave; PGS.TS. Trần Thạch Văn hiện thầy đang c&ocirc;ng t&aacute;c tại trường Chuy&ecirc;n KHTN (Đại học Quốc gia H&agrave; Nội). Khi bắt đầu một kh&oacute;a học, c&acirc;u hỏi chung của c&aacute;c em l&agrave; &ldquo;Học kh&oacute;a n&agrave;y em sẽ nhận được g&igrave;?&rdquo;. V&agrave; để trả lời cho c&acirc;u hỏi đ&oacute;, thầy sẽ chia sẻ với c&aacute;c em những gi&aacute; trị m&agrave; kh&oacute;a học &ldquo;Luyện thi THPT Quốc Gia &ndash; M&ocirc;n H&oacute;a Học&rdquo; gồm 45 b&agrave;i giảng sẽ mang đến cho c&aacute;c em những điều sau sau:</p>

<ol>
	<li><strong>C&aacute;c b&agrave;i giảng chi tiết để c&aacute;c em c&oacute; thể tự học</strong>: Phần n&agrave;y c&aacute;c thầy đ&atilde; d&agrave;nh nhiều thời gian để bi&ecirc;n soạn c&ocirc;ng phu.</li>
	<li><strong>C&aacute;c b&agrave;i giảng chuy&ecirc;n s&acirc;u:</strong>&nbsp;Phần n&agrave;y c&aacute;c thầy rất c&acirc;n nhắc, chọn c&aacute;i g&igrave;, dậy c&aacute;i g&igrave; v&agrave; dậy như thế n&agrave;o để cho c&aacute;c em nắm được.</li>
	<li><strong>Nội dung v&agrave; c&aacute;ch truyền đạt dễ nhớ, dễ hiểu:</strong>&nbsp;C&aacute;c thầy biết rằng căng thẳng qu&aacute; c&aacute;c em cũng kh&oacute; tiếp thu m&agrave; tr&agrave;n lan qu&aacute; c&aacute;c em cũng kh&ocirc;ng tiếp nhận được.</li>
	<li><strong>C&aacute;c em c&oacute; cơ hội học từ những thầy c&ocirc; giỏi nhất:</strong>&nbsp;Học ở đ&acirc;y c&aacute;c em sẽ được học từ những thầy c&ocirc; c&oacute; tr&igrave;nh độ chuy&ecirc;n m&ocirc;n giỏi lu&ocirc;n c&oacute; kh&aacute;t vọng chinh phục đỉnh cao của tri thức, c&oacute; quan niệm gi&aacute;o dục hiện đại v&agrave; đ&atilde; được x&atilde; hội t&iacute;n nhiệm. Th&ocirc;ng qua những b&agrave;i giảng của m&igrave;nh c&aacute;c thầy c&ocirc; sẽ truyền cho c&aacute;c em động lực rất lớn học tập tốt hơn, vượt qua c&aacute;c k&igrave; thi với điểm số cao nhất.</li>
	<li><strong>B&agrave;i giảng sống động v&agrave; giống như b&agrave;i giảng h&agrave;ng ng&agrave;y:</strong>&nbsp;Sau bao nhi&ecirc;u năm kinh nghiệm đứng tr&ecirc;n bục giảng, giờ đ&acirc;y đứng trước m&aacute;y quay để giảng b&agrave;i quả kh&ocirc;ng dễ ch&uacute;t n&agrave;o. Nhưng c&aacute;c thầy lu&ocirc;n cố gắng để truyền tải hết cho c&aacute;c em kiến thức v&agrave; niềm vui th&iacute;ch khi tham gia mỗi buổi học online.</li>
</ol>

<p>Hi vọng với những chia sẻ tr&ecirc;n của thầy c&aacute;c em đ&atilde; c&oacute; những th&ocirc;ng tin nhất định về kh&oacute;a học v&agrave; tự đưa ra quyết định rồi. Hẹn gặp lại c&aacute;c em trong kh&oacute;a học, thầy tr&ograve; m&igrave;nh sẽ c&ugrave;ng nhau chinh phục tri thức H&oacute;a Học của thế giới v&agrave; vượt qua kỳ thi tốt nghiệp THPT 2016 với điểm số thật cao.</p>

<p>C&aacute;c em c&oacute; thể k&eacute;o xuống để xem th&ecirc;m th&ocirc;ng tin về kh&oacute;a học v&agrave; chương tr&igrave;nh học.&nbsp;<strong>Để tham khảo một số b&agrave;i giảng của thầy c&ocirc; gi&aacute;o trước khi đăng k&yacute; kh&oacute;a học, c&aacute;c em h&atilde;y bấm n&uacute;t &ldquo;học thử&rdquo;.</strong>&nbsp;Mọi thắc mắc về kh&oacute;a học c&aacute;c em c&oacute; thể nhắn tin v&agrave;o fanpage, comment ngay dưới kh&oacute;a học hoặc gọi điện thoại đến số hotline của Zuni l&agrave;&nbsp;<strong>0965 999 334</strong>&nbsp;để được giải đ&aacute;p.</p>

<p>Ch&uacute;c em học thật tốt v&agrave; đạt th&agrave;nh t&iacute;ch cao để kh&ocirc;ng phụ l&ograve;ng mong mỏi của gia đ&igrave;nh.</p>

<p>Thầy gi&aacute;o PGS.TS. Trần Thạch Văn v&agrave; c&aacute;c gi&aacute;o vi&ecirc;n tổ m&ocirc;n trường Chuy&ecirc;n KHTN (ĐH Quốc gia H&agrave; Nội)</p>
', N'https://www.youtube.com/watch?v=ihNXUxZ9Lzo&t=3299s                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ', NULL, 1, 1, 10, CAST(N'2018-04-11 21:00:46.000' AS DateTime), 3, CAST(N'2018-05-06' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (27, N'd71c476e-fecc-4a53-95cb-566479221d6b', N'KHOI-3                        ', 4, N'Chinh phục kỳ thi Vật lý - Sóng cơ học', N'https://i.ytimg.com/vi/_GO-P_090vw/hqdefault.jpg                                                                                                                                                                                                          ', 0, 200000, 28, 0, N'Tổng quan về sóng cơ học , các dạng bài tập sóng  cơ học.', N'<p>Tổng quan về s&oacute;ng cơ học , c&aacute;c dạng b&agrave;i tập s&oacute;ng &nbsp;cơ học.</p>
', N'https://www.youtube.com/watch?v=_GO-P_090vw&t=8s                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', N'/Uploads/28/2018/5/20/user.rar                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ', 1, 1, 28, CAST(N'2018-05-20 14:34:53.000' AS DateTime), 28, CAST(N'2018-05-20' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'1412c06d-f40c-4f19-b992-6c332b952295', N'KHOI-2                        ', 6, N'Thầy Vũ Khắc Ngọc - Phương pháp giải các bài tập về Peptit (p2)', N'https://i.ytimg.com/vi/dxSx6RFU_nw/hqdefault.jpg                                                                                                                                                                                                          ', 0, 25000, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=dxSx6RFU_nw                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 10, CAST(N'2018-04-11 09:49:01.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (26, N'108306c4-3423-42e3-a016-84a7cb76d45a', N'KHOI-3                        ', 4, N'Con lắc đơn và các dạng bài tập ', N'https://i.ytimg.com/vi/aptID9aDEvk/hqdefault.jpg                                                                                                                                                                                                          ', 0, 100000, 28, 0, N'Khóa học này sẽ giúp các em hiểu rõ hơn về cách hoạt động của Con lắc ', N'<p>Dạng 1: Chu kỳ con lắc đơn thay đổi theo chiều d&agrave;i l.</p>

<p>1.1/ Con lắc đơn c&oacute; chiều d&agrave;i cắt gh&eacute;p.</p>

<p>1.2/ Chu kỳ của con lắc vướng đinh .</p>

<p>1.3/ Chiều d&agrave;i con lắc đơn thay đổi theo nhiệt độ m&ocirc;i trường.</p>

<p>1.4/ Chiều d&agrave;i con lắc thay đổi do cắt (hoặc th&ecirc;m) một lượng rất nhỏ</p>

<p>Dạng 2: Chu kỳ con lắc đơn thay đổi theo gia tốc trọng trường g.</p>

<p>2.1/ Gia tốc g thay đổi theo độ cao.</p>

<p>2.2/ Gia tốc trong trường g thay đổi theo độ s&acirc;u.</p>

<p>2.3/ Thay đổi vị tr&iacute; địa l&iacute; đặt con lắc.</p>

<p>Dạng 3: Thay đổi đồng thời cả chiều d&agrave;i l v&agrave; gia tốc trọng trường g.</p>

<p>3.1/ Thay đổi nhiệt độ m&ocirc;i trường v&agrave; thay đổi gia tốc trọng trường g.</p>

<p>3.2/ Chiều d&agrave;i con lắc thay đổi do cắt (hoặc th&ecirc;m) một lượng v&agrave; thay đổi gia tốc g.</p>
', N'https://www.youtube.com/watch?v=aptID9aDEvk                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 28, CAST(N'2018-05-18 12:53:12.000' AS DateTime), 28, CAST(N'2018-05-20' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'6c410de8-1a66-4585-b3bf-8c4ffd77f401', N'KHOI-2                        ', 6, N'Thầy Vũ Khắc Ngọc - Một số PP đặc biệt để giải các bài tập khó về peptit (Phần 1)', N'https://i.ytimg.com/vi/16tz0xAWXNU/hqdefault.jpg                                                                                                                                                                                                          ', 0, 25000, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=16tz0xAWXNU                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 10, CAST(N'2018-04-11 09:48:38.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'5f79cea2-9f5f-4002-bbbf-9e8ef9d9eac1', N'KHOI-2                        ', 6, N'Giải chi tiết đề thi thử môn Hóa 2017 - Lần 1 - Chuyên ĐH Vinh - Trần Phương Duy (Phần 1)', N'https://i.ytimg.com/vi/s0rjKnwmkug/hqdefault.jpg                                                                                                                                                                                                          ', 0, 25000, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=s0rjKnwmkug                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 10, CAST(N'2018-04-11 09:47:40.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c1', N'KHOI-1                        ', 1, N'Giải chi tiết đề thi thử môn Hóa 2017 - Lần 1 - Chuyên ĐH Vinh - Trần Phương Duy (Phần 2)', N'https://i.ytimg.com/vi/k2wc3RGMWHs/hqdefault.jpg                                                                                                                                                                                                          ', 0, 25000, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=k2wc3RGMWHs                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 10, CAST(N'2018-04-11 09:47:23.767' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'24a3d3ea-134a-1f7c-a729-bc98e1e588c8', N'KHOI-1                        ', 1, N'HOA VINH : Trăm Năm Không Quên, Gọi Tên Em Trong Đêm, Ngắm Hoa Lệ Rơi', N'https://i.ytimg.com/vi/Hw9KOV3kB4c/hqdefault.jpg                                                                                                                                                                                                          ', 0, 2500000, 3, 150000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

<p>Ngồi một g&oacute;c ở trung t&acirc;m trong khi chờ nhận lại con g&aacute;i, chị L&ecirc; Thị Chi&ecirc;u (ngụ quận Thủ Đức) đ&ocirc;i mắt đỏ hoe,&nbsp;thỉnh thoảng chị &ocirc;m bụng bầu 8 th&aacute;ng đứng dậy, mắt nh&igrave;n v&agrave;o b&ecirc;n trong cửa xem con g&aacute;i xuất hiện chưa. Chỉ trong khoảng gần 1 giờ, &quot;điệp kh&uacute;c&quot; n&agrave;y diễn ra kh&ocirc;ng biết bao nhi&ecirc;u lần. &ldquo;T&ocirc;i&nbsp; sắp được gặp con g&aacute;i rồi. Sau bao th&aacute;ng ng&agrave;y xa c&aacute;ch, giờ hai mẹ con t&ocirc;i sắp được đo&agrave;n tụ&nbsp;rồi&rdquo;, chị Chi&ecirc;u n&oacute;i trong nước mắt.</p>

<p>Khi thấy c&aacute;n bộ trung t&acirc;m dẫn b&eacute; Muội ra, chị Chi&ecirc;u chạy &agrave;o đến. B&eacute; g&aacute;i 8 tuổi thấy mẹ cũng lao đến, s&agrave; v&agrave;o l&ograve;ng mẹ kh&oacute;c nức nở. Chị Chi&ecirc;u &ocirc;m chặt con v&agrave;o l&ograve;ng miệng lu&ocirc;n n&oacute;i: &ldquo;Mẹ t&igrave;m thấy con rồi. Mẹ t&igrave;m thấy con rồi. Con đừng sợ nữa, c&oacute; mẹ đ&acirc;y, c&oacute; mẹ đ&acirc;y&rdquo; rồi cũng &ograve;a kh&oacute;c. Họ kh&oacute;c trong hạnh ph&uacute;c. Đ&oacute; cũng l&agrave; khoảnh khắc 2 mẹ con tr&ugrave;ng ph&ugrave;ng sau chuỗi ng&agrave;y b&eacute; Muội mất t&iacute;ch.</p>

<p><img alt="Mẹ bầu rong ruổi khắp Sài Gòn tìm con gái mất tích và phép màu xuất hiện - 2" src="http://image.24h.com.vn/upload/2-2018/images/2018-04-02/1522675035-840-me-bau-rong-ruoi-khap-sai-gon-tim-con-gai-mat-tich-va-phep-mau-xuat-hien-mat-tich--5--1522674832-width660height440.jpg" /></p>

<p>B&eacute; Muội trong v&ograve;ng tay của b&agrave; ngoại</p>

<p>Trước đ&oacute;, v&agrave;o chiều 11.2, b&eacute; Muội n&oacute;i với cha l&agrave; nhớ mẹ qu&aacute;, muốn đến chỗ&nbsp;l&agrave;m việc của mẹ chơi.</p>

<p>Do mọi lần b&eacute; vẫn tự đi một m&igrave;nh đến chỗ mẹ n&ecirc;n được cha đồng &yacute;. Sau đ&oacute;, một m&igrave;nh b&eacute; Muội tự bắt xe bu&yacute;t số 19 đi từ l&agrave;ng Đại học Thủ Đức xuống chợ Bến Th&agrave;nh (quận 1) v&igrave; chị Chi&ecirc;u đang bu&ocirc;n b&aacute;n tại khu vực n&agrave;y.</p>

<p>Tuy nhi&ecirc;n, đến 19h c&ugrave;ng ng&agrave;y, chị Chi&ecirc;u đợi&nbsp;m&atilde;i kh&ocirc;ng thấy con đến n&ecirc;n bỏ b&aacute;n h&agrave;ng tới c&aacute;c trạm xe bu&yacute;t để t&igrave;m nhưng kh&ocirc;ng c&oacute; kết quả. Cả đ&ecirc;m v&agrave; đến s&aacute;ng h&ocirc;m sau, gia đ&igrave;nh chị Chi&ecirc;u đi t&igrave;m khắp c&aacute;c con đường, c&ocirc;ng vi&ecirc;n ở trung t&acirc;m nhưng tung t&iacute;ch b&eacute; Muội vẫn bặt tăm.</p>

<p><img alt="Mẹ bầu rong ruổi khắp Sài Gòn tìm con gái mất tích và phép màu xuất hiện - 3" src="http://image.24h.com.vn/upload/2-2018/images/2018-04-02/1522675035-524-me-bau-rong-ruoi-khap-sai-gon-tim-con-gai-mat-tich-va-phep-mau-xuat-hien-mat-tich--3--1522674832-width660height440.jpg" /></p>

<p>Sau gần 2 th&aacute;ng rong ruổi khắp S&agrave;i G&ograve;n t&igrave;m con g&aacute;i mất t&iacute;ch, chị Chi&ecirc;u đ&atilde; gặp lại con</p>

<p>&ldquo;Qu&atilde;ng thời gian đ&oacute; đối với t&ocirc;i như &aacute;c mộng. Lạc mất con t&ocirc;i như mất tất cả. Cũng chẳng thiết ăn uống g&igrave;. Nuốt cơm v&agrave;o thấy nghẹn đắng cổ họng, trong đầu suy nghĩ nhiều điều, từ việc tốt đến t&igrave;nh huống xấu nhất m&agrave; con sẽ gặp phải. Tự nhủ m&igrave;nh rằng con g&aacute;i c&oacute; thể gặp được người n&agrave;o đ&oacute; tốt bụng gi&uacute;p đỡ v&agrave; con an to&agrave;n nhưng những ng&agrave;y sau đ&oacute; trong l&ograve;ng lại ngổn ngang những điều xấu đến với con&rdquo;, chị Chi&ecirc;u n&oacute;i trong nấc nghẹn.</p>

<p>&ldquo;L&uacute;c đ&oacute;, cứ nghe ở đ&acirc;u c&oacute; trẻ lạc l&agrave; t&ocirc;i c&ugrave;ng cả gia đ&igrave;nh đổ x&ocirc; t&igrave;m đến với bao hy vọng rằng đ&oacute; l&agrave; con m&igrave;nh nhưng rồi lại thất vọng. C&aacute;c con đường ở trung t&acirc;m TP v&agrave; những khu vực l&acirc;n cận t&ocirc;i đều t&igrave;m kiếm nhưng vẫn kh&ocirc;ng thấy con. T&ocirc;i tr&igrave;nh b&aacute;o c&ocirc;ng an rồi t&igrave;m đến c&aacute;c trung t&acirc;m nu&ocirc;i trẻ nhỏ với hy vọng c&oacute; con m&igrave;nh ở đ&oacute; nhưng rồi lại thất vọng ra về&rdquo;, chị Chi&ecirc;u kể.</p>
', N'https://www.youtube.com/watch?v=Hw9KOV3kB4c&t=5915s                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ', NULL, 1, 1, 3, CAST(N'2018-04-02 23:09:05.000' AS DateTime), 3, CAST(N'2018-04-02' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c8', N'KHOI-2                        ', 6, N'Chữa đề thi thử nghiệm THPT QG môn Hóa năm 2017 ( đề minh họa lần 2)', N'https://i.ytimg.com/vi/TlNeByELueA/hqdefault.jpg                                                                                                                                                                                                          ', 0, 25000, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=TlNeByELueA                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 3, CAST(N'2018-04-11 09:47:59.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c9', N'KHOI-2                        ', 6, N'Tham khảo Chữa đề thi minh họa THPT QG môn Hóa năm 2017 lần 3', N'https://i.ytimg.com/vi/taBVrH6INOc/hqdefault.jpg                                                                                                                                                                                                          ', 0, 25000, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=taBVrH6INOc                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 3, CAST(N'2018-04-11 09:48:21.877' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'24a3d3ea-134a-4f7c-a729-bc98e1e588d8', N'KHOI-2                        ', 6, N'Tổng hợp những bài hát hay nhất của Hoa Vinh  2018 đăng kí kênh ủng hộ mình nha', N'https://i.ytimg.com/vi/TJJSaJI0ZMs/hqdefault.jpg                                                                                                                                                                                                          ', 0, 150000, 3, 100000, N'Việc đưa khoá học ôn thi lên online giúp đem kiến thức phổ cập đến nhiều bạn học sinh hơn. Tại đây, các em có thể chủ động việc học trong cả mặt thời gian lẫn nơi học. Do đó khoá học sẽ cục kì hữu ích và tạo cơ hội cho những bạn không có điều kiện tham gia học tập trực tiếp với các thầy cô. 

Hãy kéo xuống để tìm hiểu thêm thông tin cũng như học thử khoá học. Ngoài ra, nếu còn thắc mắc, các em có thể nhắn tin vào fanpage, comment ngay dưới khóa học hoặc gọi điện thoại đến số hotline của Zuni là 0965 999 334 để được các bạn tình nguyện viên giải đáp tận tình nhé.


Chúc các em một kì thi chuyển cấp thành công tốt đẹp !

Giáo viên giảng dạy:

PGS.TS. Trần Thạch Văn: 
 - Từ 1969 - 1975: Học Đại học tổng hợp Hóa tại trường ĐHTH Gdansk - Ba Lan. Tốt nghiệp loại giỏi

- Từ 12/1975 - 2010: Làm CBGD tại bộ môn Hữu cơ khoa Hóa học, ĐH KHTN, ĐHQG Hà Nội

- Từ 2010 - nay: Giáo viên trường THPT Chuyên KHTN

- Bảo vệ luận án tiến sĩ hệ nghiên cứu sinh ngắn hạn năm 1985

- Được phong tặng chức danh PGS năm 2001

- Đã công bố 50 công trình nghiên cứu trong lĩnh vực tổng hợp hữu cơ trong và ngoài nước

- Tham gia huấn luyện học sinh giỏi và bồi dưỡng giáo viên THPT

- Đã xuất bản nhiều đầu sách nổi tiếng:

+ 100 câu hỏi và bài tập hữu cơ

+ Phương pháp giải bài tập Hóa hữu cơ

+ Bồi dưỡng học sinh giỏi THCS

+ Luyện thi trắc nghiệm môn Hóa ', N'<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	Ch&agrave;o mừng c&aacute;c em đến với kho&aacute; luyện &ocirc;n thi v&agrave;o lớp 10 bộ m&ocirc;n Ho&aacute; Học !&nbsp;</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	Đ&acirc;y l&agrave; kho&aacute; học được bi&ecirc;n soạn bởi c&aacute;c thầy c&ocirc; của trường trực tuyến A0 &ndash; tập thể c&aacute;c thầy c&ocirc; gi&aacute;o giỏi c&oacute; tiếng v&agrave; nhiều năm kinh nghiệm của trường Chuy&ecirc;n KHTN. Kho&aacute; học kh&ocirc;ng nhằm g&igrave; hơn ngo&agrave;i việc gi&uacute;p c&aacute;c em &ocirc;n luyện kiến thức nhằm&nbsp;<span style="box-sizing: border-box; font-weight: 700;">thi đậu v&agrave;o c&aacute;c trường cấp 3&nbsp;</span>theo &yacute; nguyện của m&igrave;nh</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	To&agrave;n bộ hệ thống kiến thức Ho&aacute; Học cấp 2 sẽ được c&ocirc; đọng lạị một c&aacute;ch đầy đủ nhất trong c&aacute;c b&agrave;i giảng của kho&aacute; &ocirc;n thi n&agrave;y. Th&ocirc;ng qua 36 chủ đề, c&aacute;c em sẽ dần dần nắm vững b&iacute; quyết để chinh phục m&ocirc;n học tuy kh&oacute; m&agrave; dễ n&agrave;y. Hệ thống b&agrave;i tập được bi&ecirc;n soạn theo mức độ từ cơ bản đến n&acirc;ng cao do đ&oacute; sẽ ph&ugrave; hợp với đa số c&aacute;c bạn học sinh c&oacute; học lực từ trung b&igrave;nh kh&aacute; trở l&ecirc;n.</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	Do đ&oacute;, kho&aacute; học sẽ gi&uacute;p c&aacute;c em:</p>
<ul style="box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	<li style="box-sizing: border-box; list-style: none;">
		Tổng hợp kiến thức ho&aacute; học cấp 2 để chuẩn bị &ocirc;n thi v&agrave;o cấp 3</li>
	<li style="box-sizing: border-box; list-style: none;">
		Tiếp cận với hệ thống b&agrave;i tập đa dạng do ch&iacute;nh c&aacute;c thầy c&ocirc; chuy&ecirc;n KHTN bi&ecirc;n soạn</li>
	<li style="box-sizing: border-box; list-style: none;">
		Học c&aacute;ch tự tin để c&oacute; thể vận dụng kiến thức khi bước v&agrave;o k&igrave; thi tuyển đầu v&agrave;o cấp 3</li>
</ul>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	Việc đưa kho&aacute; học &ocirc;n thi l&ecirc;n online gi&uacute;p đem kiến thức phổ cập đến nhiều bạn học sinh hơn. Tại đ&acirc;y, c&aacute;c em c&oacute; thể chủ động việc học trong cả mặt thời gian lẫn nơi học. Do đ&oacute; kho&aacute; học sẽ cục k&igrave; hữu &iacute;ch v&agrave; tạo cơ hội cho những bạn kh&ocirc;ng c&oacute; điều kiện tham gia học tập trực tiếp với c&aacute;c thầy c&ocirc;.&nbsp;</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	H&atilde;y k&eacute;o xuống để t&igrave;m hiểu th&ecirc;m th&ocirc;ng tin cũng như học thử kho&aacute; học. Ngo&agrave;i ra, nếu c&ograve;n thắc mắc, c&aacute;c em c&oacute; thể nhắn tin v&agrave;o fanpage, comment ngay dưới kh&oacute;a học hoặc gọi điện thoại đến số hotline của Zuni l&agrave;&nbsp;<span style="box-sizing: border-box; font-weight: 700;">0965 999 334&nbsp;</span>để được c&aacute;c bạn t&igrave;nh nguyện vi&ecirc;n giải đ&aacute;p tận t&igrave;nh nh&eacute;.</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	<br style="box-sizing: border-box;" />
	Ch&uacute;c c&aacute;c em một k&igrave; thi chuyển cấp th&agrave;nh c&ocirc;ng tốt đẹp !</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	<span style="box-sizing: border-box; font-weight: 700;">Gi&aacute;o vi&ecirc;n giảng dạy:</span></p>
<ol style="box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	<li style="box-sizing: border-box;">
		<span style="box-sizing: border-box; font-weight: 700;">PGS.TS. Trần Thạch Văn:&nbsp;</span></li>
</ol>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	&nbsp;- Từ 1969 - 1975: Học&nbsp;Đại học tổng hợp H&oacute;a tại trường&nbsp;ĐHTH Gdansk - Ba Lan. Tốt nghiệp loại giỏi</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- Từ 12/1975 - 2010: L&agrave;m CBGD tại bộ m&ocirc;n Hữu cơ khoa H&oacute;a học, ĐH KHTN, ĐHQG H&agrave; Nội</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- Từ 2010 - nay: Gi&aacute;o vi&ecirc;n trường THPT Chuy&ecirc;n KHTN</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- Bảo vệ luận&nbsp;&aacute;n tiến sĩ hệ nghi&ecirc;n cứu sinh ngắn hạn năm&nbsp;1985</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	-&nbsp;Được phong tặng chức danh PGS năm 2001</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	-&nbsp;Đ&atilde; c&ocirc;ng bố 50 c&ocirc;ng tr&igrave;nh nghi&ecirc;n cứu trong lĩnh vực tổng hợp hữu cơ trong v&agrave; ngo&agrave;i nước</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- Tham gia huấn luyện học sinh giỏi v&agrave; bồi dưỡng gi&aacute;o vi&ecirc;n THPT</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- Đ&atilde; xuất bản nhiều đầu s&aacute;ch nổi tiếng:</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	+ 100 c&acirc;u hỏi v&agrave; b&agrave;i tập hữu cơ</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	+ Phương ph&aacute;p giải b&agrave;i tập H&oacute;a hữu cơ</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	+ Bồi dưỡng học sinh giỏi THCS</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	+ Luyện thi trắc nghiệm m&ocirc;n H&oacute;a&nbsp;</p>
<ol start="2" style="box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	<li style="box-sizing: border-box;">
		<span style="box-sizing: border-box; font-weight: 700;">TS. Vi Anh Tuấn:</span></li>
</ol>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- Từng Đạt 1 giải nh&igrave; v&agrave; 1 giải nhất HSG Quốc Gia m&ocirc;n H&oacute;a học, đoạt huy chương bạc H&oacute;a học Quốc tế lần thứ 30.</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- 1998-2002: SV lớp Cử nh&acirc;n t&agrave;i năng kh&oacute;a 2 của trường ĐHKHTN. Tốt nghiệp loại xuất sắc.&nbsp;</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- 2002-2006: NCS của trường ĐH KHTN.&nbsp;</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- 2006 &ndash; 2011 : Giảng vi&ecirc;n tại Khoa H&oacute;a học, Trường ĐHKHTN, ĐHQG HN</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	- 2011 &ndash; nay : Giảng vi&ecirc;n, chủ nhiệm bộ m&ocirc;n chuy&ecirc;n H&oacute;a tại Trường THPT Chuy&ecirc;n KHTN, Trường ĐHKHTN</p>
<p style="box-sizing: border-box; margin: 0px 0px 10px; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, helvetica, arial, &quot;lucida grande&quot;, sans-serif; font-size: 14px; background-color: rgb(240, 240, 240);">
	-&nbsp;Kinh nghiệm giảng dạy: 12 năm.&nbsp;Sở trường: Dạy luyện thi đại học v&agrave; thi HSG m&ocirc;n H&oacute;a học.


</p>
', N'https://www.youtube.com/watch?v=TJJSaJI0ZMs                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 3, CAST(N'2018-03-31 18:16:39.000' AS DateTime), 3, CAST(N'2018-03-31' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (24, N'1661412a-36ee-404d-8284-d04e49624765', N'KHOI-3                        ', 9, N'TIẾNG ANH LỚP 12', N'https://i.ytimg.com/vi/L6EDybuEGIk/hqdefault.jpg                                                                                                                                                                                                          ', 0, 250000, 10, 0, NULL, N'<p>UNIT 1: HOME LIFE</p>

<p>UNIT 2: CULTURAL DIVERSITY</p>

<p>UNIT 3: WAYS OF SOCIALIZING</p>

<p>UNIT 4: SCHOOL EDUCATION SYSTEM</p>

<p>UNIT 5: HIGHER EDUCATION</p>

<p>UNIT 6: FUTURE JOBS</p>

<p>UNIT 7: ECONOMIC REFORMS</p>

<p>UNIT 8: LIFE IN THE FUTURE</p>

<p>UNIT 9: DESERTS</p>

<p>UNIT 10: ENDANGERED SPECIES</p>

<p>UNIT 11: BOOKS UNIT 12: WATER SPORTS</p>
', N'https://www.youtube.com/watch?v=L6EDybuEGIk&list=PLR-moJy9pDIgU1HjaFRwgM15JNdqeGQUh                                                                                                                                                                                                                                                                                                                                                                                                                                 ', N'/Uploads/3/2018/5/10/jquery-timepicker-master.zip                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ', 1, 1, 10, CAST(N'2018-05-10 12:28:56.000' AS DateTime), 3, CAST(N'2018-05-10' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'0fa5dde9-ffaa-4b4b-9609-d3bbff083bcc', N'KHOI-1                        ', 1, N'TEST', N'/Uploads/CKFinder/files/23926324_1501252383324393_5127268733155882781_o.jpg                                                                                                                                                                               ', 0, 25000, 5, 0, NULL, NULL, NULL, NULL, 1, 0, 5, CAST(N'2018-04-12 09:41:07.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, N'829430cb-e997-45a1-a560-d7ab28edffe3', N'KHOI-2                        ', 6, N'Thầy Vũ Khắc Ngọc - Phương pháp giải các bài tập về Peptit (p1)', N'https://i.ytimg.com/vi/cLl7uwy6caY/hqdefault.jpg                                                                                                                                                                                                          ', 0, 25000, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=cLl7uwy6caY                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', NULL, 1, 1, 10, CAST(N'2018-04-11 09:48:52.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [LinkFile], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (28, N'a3c2a538-5429-4252-9d88-e02dd52c3e90', N'KHOI-3                        ', 4, N'[Vietsub + Kara] Đưa em đi du lịch - La Chi Hào | 带你去旅行 - 罗之豪', N'https://i.ytimg.com/vi/etc4jLhWAa0/hqdefault.jpg                                                                                                                                                                                                          ', 0, 20000, 28, 0, N'tesst', N'<p>test</p>
', N'https://youtube.com/watch?v=etc4jLhWAa0                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ', NULL, 1, 1, 28, CAST(N'2018-05-20 17:03:22.000' AS DateTime), 28, CAST(N'2018-05-20' AS Date))
SET IDENTITY_INSERT [dbo].[Cms_Class] OFF
SET IDENTITY_INSERT [dbo].[Cms_ClassStudent] ON 

INSERT [dbo].[Cms_ClassStudent] ([Id], [ClassId], [ClassGuid], [StudentId], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (23, 26, N'108306c4-3423-42e3-a016-84a7cb76d45a', 12, 1, 12, CAST(N'2018-05-20 16:36:21.733' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassStudent] ([Id], [ClassId], [ClassGuid], [StudentId], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (24, 27, N'd71c476e-fecc-4a53-95cb-566479221d6b', 12, 1, 12, CAST(N'2018-05-20 16:36:37.200' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassStudent] ([Id], [ClassId], [ClassGuid], [StudentId], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (25, 20, N'9073d791-3cbb-4822-8dba-26f708a8a442', 28, 1, 28, CAST(N'2018-05-20 18:01:09.457' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Cms_ClassStudent] OFF
SET IDENTITY_INSERT [dbo].[Cms_ClassVideo] ON 

INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, 5, N'Bài 1', N'https://www.youtube.com/watch?v=ihNXUxZ9Lzo&t=3299s', N'<p>io;i;</p>
', 1, 1, 5, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, 20, N'Các dạng toán về giao điểm của parabol và đường thẳng (Tiết 3) - Thầy Nguyễn Cao Cường', N'/Uploads/3/2018/5/6/Các dạng toán về giao điểm của parabol và đường thẳng (Tiết 3) - Thầy Nguyễn Cao Cường.mp4', NULL, 2, 1, 5, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-05-06' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, 19, N'Bài 3', N'https://www.youtube.com/watch?v=PQof9THDnVY', N'<p>c&acirc;cscasc</p>
', 1, 1, 3, CAST(N'2018-04-11 20:26:06.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, 1, N'Bài 4', NULL, N'<p>ca</p>
', 1, 1, 3, CAST(N'2018-04-11 20:28:37.300' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, 20, N'Đề thi thử lớp 10 môn toán 2017 có lời giải chi tiết', N'/Uploads/3/2018/5/6/Đề thi thử lớp 10 môn toán 2017 có lời giải chi tiết.mp4', NULL, 3, 1, 10, CAST(N'2018-04-11 21:01:28.000' AS DateTime), 3, CAST(N'2018-05-06' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, 20, N'Các dạng toán về giao điểm của parabol và đường thẳng (Tiết 2) - Thầy Nguyễn Cao Cường', N'/Uploads/3/2018/5/6/Các dạng toán về giao điểm của parabol và đường thẳng (Tiết 2) - Thầy Nguyễn Cao Cường.mp4', NULL, 2, 1, 10, CAST(N'2018-04-11 21:04:08.000' AS DateTime), 3, CAST(N'2018-05-06' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, 20, N'Giới thiệu các khóa Toán 9 và luyện thi vào 10 năm 2016 - Thầy Nguyễn Cao Cường', N'/Uploads/3/2018/5/6/Giới thiệu các khóa Toán 9 và luyện thi vào 10 năm 2016 - Thầy Nguyễn Cao Cường.mp4', NULL, 1, 1, 10, CAST(N'2018-04-11 21:04:30.000' AS DateTime), 3, CAST(N'2018-05-06' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, 20, N'Khai giảng các khóa học Toán 9 luyện thi vào 10 - Thầy Nguyễn Cao Cường', N'/Uploads/3/2018/5/6/Khai giảng các khóa học Toán 9 luyện thi vào 10 - Thầy Nguyễn Cao Cường.mp4', NULL, 1, 1, 3, CAST(N'2018-05-06 11:26:04.343' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, 24, N'TIẾNG ANH LỚP 12 - UNIT 1   HOME LIFE   ENGLISH 12', N'/Uploads/10/2018/5/10/TIẾNG ANH LỚP 12 - UNIT 1   HOME LIFE   ENGLISH 12.mp4', NULL, 1, 1, 10, CAST(N'2018-05-10 12:29:41.357' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, 24, N'TIẾNG ANH LỚP 12 - UNIT 1   HOME LIFE (LISTENING)   ENGLISH 12', N'/Uploads/10/2018/5/10/TIẾNG ANH LỚP 12 - UNIT 1   HOME LIFE (LISTENING)   ENGLISH 12.mp4', NULL, 1, 1, 10, CAST(N'2018-05-10 12:29:51.203' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, 24, N'TIẾNG ANH LỚP 12 - UNIT 2   CULTURAL DIVERSITY   ENGLISH 12', N'/Uploads/10/2018/5/10/TIẾNG ANH LỚP 12 - UNIT 2   CULTURAL DIVERSITY   ENGLISH 12.mp4', NULL, 1, 1, 10, CAST(N'2018-05-10 12:30:00.177' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, 24, N'TIẾNG ANH LỚP 12 - UNIT 2   CULTURAL DIVERSITY (LISTENING)   ENGLISH 12', N'/Uploads/10/2018/5/10/TIẾNG ANH LỚP 12 - UNIT 2   CULTURAL DIVERSITY (LISTENING)   ENGLISH 12.mp4', NULL, 1, 1, 10, CAST(N'2018-05-10 12:30:06.870' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, 24, N'TIẾNG ANH LỚP 12 - UNIT 3   WAYS OF SOCIALIZING   ENGLISH 12 - YouTube', N'/Uploads/10/2018/5/10/TIẾNG ANH LỚP 12 - UNIT 3   WAYS OF SOCIALIZING   ENGLISH 12 - YouTube.mp4', NULL, 1, 1, 10, CAST(N'2018-05-10 12:30:13.380' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, 24, N'TIẾNG ANH LỚP 12 - UNIT 4   SCHOOL EDUCATION SYSTEM (LISTENING)   ENGLISH 12', N'/Uploads/10/2018/5/10/TIẾNG ANH LỚP 12 - UNIT 4   SCHOOL EDUCATION SYSTEM (LISTENING)   ENGLISH 12.mp4', NULL, 1, 1, 10, CAST(N'2018-05-10 12:30:20.230' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, 24, N'TIẾNG ANH LỚP 12 - UNIT 5   HIGHER EDUCATION   ENGLISH 12', N'/Uploads/10/2018/5/10/TIẾNG ANH LỚP 12 - UNIT 5   HIGHER EDUCATION   ENGLISH 12.mp4', NULL, 1, 1, 10, CAST(N'2018-05-10 12:30:26.710' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, 25, N'KHẮC VIỆT - Đến Khi Nào [Official]', N'/Uploads/10/2018/5/15/KHẮC VIỆT - Đến Khi Nào [Official].mp4', N'<p>b&agrave;i một</p>
', 1, 1, 10, CAST(N'2018-05-15 16:26:40.340' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, 26, N'Tổng hợp lý thuyết và dạng bài tập con lắc đơn (P1)', N'/Uploads/28/2018/5/18/ke-hoach-bien-sao-hoa-thanh-can-cu-vu-tru-cua-con-nguoi-1523441885.mp4', N'<p>C&aacute;c phương ph&aacute;p của dao&nbsp;động&nbsp;điều hoa trong con lắc&nbsp;đơn.</p>
', 1, 1, 28, CAST(N'2018-05-18 13:08:40.000' AS DateTime), 28, CAST(N'2018-05-20' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, 26, N'Tổng hợp lý thuyết và dạng bài tập con lắc đơn (P2)', N'/Uploads/28/2018/5/20/Nature Beautiful short video 720p HD.mp4', N'<p>C&aacute;c dạng trong con lắc đơn bao gồm t&iacute;nh chu kỳ, tần số, bi&ecirc;n độ con lắc.</p>
', 1, 1, 28, CAST(N'2018-05-20 14:20:37.000' AS DateTime), 28, CAST(N'2018-05-20' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, 27, N'Tổng hợp lý thuyết và các dạng bài tập Sóng cơ (P1)', N'/Uploads/28/2018/5/20/Nature Beautiful short video 720p HD.mp4', N'<p>Tổng hợp l&yacute; thuyết v&agrave; c&aacute;c dạng b&agrave;i tập S&oacute;ng cơ</p>
', 1, 1, 28, CAST(N'2018-05-20 16:09:21.000' AS DateTime), 28, CAST(N'2018-05-20' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, 27, N'Nature Beautiful short video 720p HD', N'/Uploads/28/2018/5/20/Nature Beautiful short video 720p HD.mp4', N'<p>Tổng hợp l&yacute; thuyết v&agrave; c&aacute;c dạng b&agrave;i tập S&oacute;ng cơ P2</p>
', 1, 1, 28, CAST(N'2018-05-20 16:15:35.000' AS DateTime), 28, CAST(N'2018-05-20' AS Date))
SET IDENTITY_INSERT [dbo].[Cms_ClassVideo] OFF
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'0184dc51-3006-471d-a0cf-77c50a50fa5f', 24, 15, 12, N'HV01', N'Em đang không hiểu tại sao 1+1=2 ạ ', 12, CAST(N'2018-05-18 21:37:40.107' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'10e1bb93-7e01-403a-adb9-27900c35710a', 20, 25, 28, N'GV05', N'ccc', 28, CAST(N'2018-05-20 18:04:15.710' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'16e231ff-f4ae-41fa-929a-3d3bebd36d7f', 20, 25, 28, N'GV05', N'cc', 28, CAST(N'2018-05-20 18:06:08.270' AS DateTime), 1, NULL)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'1fba2a20-f17a-4051-b0b7-edaa483f9565', 24, 15, 10, N'GV01', N'Quỳnh nhận được điểm danh', 10, CAST(N'2018-05-18 21:44:42.890' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'23a33c00-1555-425f-a0db-4613e4cc10eb', 24, 15, 12, N'HV01', N'thầy chat lại đi em là hv01', 12, CAST(N'2018-05-18 21:44:24.007' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3022641d-9687-42aa-a7d4-ff101e525df6', 20, 25, 28, N'GV05', N'xxx', 28, CAST(N'2018-05-20 18:05:25.533' AS DateTime), 1, NULL)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'35ca78e6-daa6-49a8-a6d8-266909ab7f5d', 24, 15, 10, N'GV01', N'Đức ANh có nhận được k?', 10, CAST(N'2018-05-18 21:44:36.157' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3752f607-5f4a-4cc0-a223-dddd0d3e062d', 24, 15, 12, N'HV01', N'sao ko fix phím cứng là gửi
', 12, CAST(N'2018-05-18 21:43:43.600' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3cadf024-d875-44e7-b7f5-eb21da426b04', 20, 25, 10, N'GV01', N'sdc', 10, CAST(N'2018-05-20 18:02:13.803' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3cdb77f3-6584-44dc-960a-3aaf7fef1e97', 24, 15, 10, N'GV01', N'Chào các em', 10, CAST(N'2018-05-18 21:44:05.770' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'412de6da-203b-4b83-bc5c-9a345013474e', 24, 15, 10, N'GV01', N'chago em', 10, CAST(N'2018-05-19 17:18:34.973' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'4166c65e-ac27-4062-a82b-9d0836788a1d', 20, 25, 28, N'GV05', N'asc', 28, CAST(N'2018-05-20 18:05:47.763' AS DateTime), 1, NULL)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'47ae6f91-bdc7-46ac-bda3-57ebae42f48f', 17, 21, 12, N'HV01', N'/', 12, CAST(N'2018-05-20 10:49:34.417' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'4f9cd181-d20c-4f4a-84cf-dcafdbfe2e1e', 24, 15, 10, N'GV01', N'Thầy chào em', 10, CAST(N'2018-05-18 22:30:00.733' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'53220f83-1a29-4e3d-a090-94578536305c', 24, 15, 10, N'GV01', N'Thế em học lại toán lớp 1 đi nha. Chúc em may mắn', 10, CAST(N'2018-05-18 21:37:55.257' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'5558f824-e94f-4bb6-90ef-4b9dcc2e6a4a', 20, 25, 28, N'GV05', N'csdc', 28, CAST(N'2018-05-20 18:05:42.167' AS DateTime), 1, NULL)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'56c56d81-6b09-4973-a22b-c08da779a741', 24, 15, 10, N'GV01', N'Chào cưng. Thầy giúp gì cho cưng', 10, CAST(N'2018-05-18 21:41:16.477' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'57c93aa3-fa6c-4fb4-ace3-561c22fb9829', 24, 15, 12, N'HV01', N'bạn quỳnh đâu thầy?', 12, CAST(N'2018-05-18 21:44:47.243' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'5a8d6ff7-c1cc-4d1c-abdd-6b89b4f599bc', 20, 25, 10, N'GV01', N'xx', 10, CAST(N'2018-05-20 18:04:21.480' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'68443330-a0ec-43c2-ab8a-48c1f7043a6b', 20, 25, 10, N'GV01', N'á', 10, CAST(N'2018-05-20 18:04:23.263' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'6dc2074e-cff4-44ba-b73f-1bcede58c3a5', 20, 25, 28, N'GV05', N'asc', 28, CAST(N'2018-05-20 18:01:22.890' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'77308241-aa39-4285-a6da-2e000b795f5e', 24, 15, 12, N'HV01', N'2', 12, CAST(N'2018-05-19 17:19:27.550' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'774c35bf-cb37-4f43-a889-796a15fa7c52', 24, 15, 12, N'HV01', N'Vaang aj', 12, CAST(N'2018-05-19 17:18:51.897' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'7a39c950-d44e-4f29-bf12-2c4d809613ee', 24, 15, 12, N'HV01', N'Vang ạ', 12, CAST(N'2018-05-18 22:30:47.010' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'7aa789b4-0417-4d08-b12e-bdcd9cec70e0', 24, 15, 12, N'HV01', N'Chaof thaayf aj', 12, CAST(N'2018-05-19 17:18:19.560' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'7bccd694-f1c1-46e5-9668-5260a1debdd9', 17, 21, 12, N'HV01', N'/', 12, CAST(N'2018-05-20 10:49:16.753' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'7c759c73-8669-48a2-a759-27858cfc0aac', 24, 15, 12, N'HV01', N'Chào thầy . Thầy có online không ạ', 12, CAST(N'2018-05-18 21:37:06.060' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'7e1c4735-a1fc-45f2-83c7-88f412e92703', 24, 15, 10, N'GV01', N'1', 10, CAST(N'2018-05-19 17:18:55.810' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'834aefcb-0256-47f4-bf0b-318e72d0a116', 20, 25, 28, N'GV05', N'cdcdv', 28, CAST(N'2018-05-20 18:07:34.030' AS DateTime), 1, NULL)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'86bd0cee-61a1-4584-a68d-cccfa9e788b9', 17, 21, 10, N'GV01', N'f', 10, CAST(N'2018-05-20 10:52:11.870' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'8eabd3f0-43ed-465e-a3ec-c6f5b43c3d93', 20, 25, 28, N'GV05', N'zx', 28, CAST(N'2018-05-20 18:02:27.093' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'8f07c9d4-2049-406d-a2ae-237b23a2d84c', 20, 17, 12, N'HV01', N'Hi thầy dâm thủy', 12, CAST(N'2018-05-18 22:09:08.827' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'975f2e69-6ec4-4018-8727-684a5034b67b', 24, 15, 10, N'GV01', N'Chào em , Thầy đang online đây. Em có thắc mắc gì vậy???', 10, CAST(N'2018-05-18 21:37:25.010' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'9b108d73-92f2-4a48-8736-e7fa7ed89a61', 24, 15, 10, N'GV01', N'Em viết gì vậy', 10, CAST(N'2018-05-18 21:42:56.467' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'9ea7fd8b-e3e2-47f8-8a44-8c125750a275', 24, 15, 12, N'HV01', N'Chào thầy', 12, CAST(N'2018-05-18 22:26:26.657' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'9f26fdd8-d7f4-41f5-9e4c-e93dee4a2612', 20, 17, 10, N'GV01', N'Ái chà cu
', 10, CAST(N'2018-05-18 22:09:48.330' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'a5427a2b-a504-4fef-98cb-6234e0e726df', 24, 15, 12, N'HV01', N'vâng', 12, CAST(N'2018-05-18 22:32:12.890' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'a8faf0c1-3e7c-4fc8-8e2d-36bd69a1a696', 20, 17, 12, N'HV01', N'Hi thầy dâm thủy', 12, CAST(N'2018-05-18 22:09:16.567' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'b45a99de-2201-43a6-bc02-4a787d0663ae', 17, 21, 10, N'GV01', N'1', 10, CAST(N'2018-05-20 10:49:26.030' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'b83059c4-f4e5-4a13-8c8f-379e6663661e', 24, 15, 10, N'GV01', N'Chào Quỳnh', 10, CAST(N'2018-05-18 21:42:41.593' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'caa1f4b0-675c-4d6e-8cd5-67456a2fe4e2', 24, 15, 12, N'HV01', N'Em chào thầy ạ', 12, CAST(N'2018-05-18 21:41:03.233' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'cb616d6a-ff83-4bc6-9598-856c44ead7de', 24, 15, 10, N'GV01', N'12', 10, CAST(N'2018-05-19 17:19:31.513' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'd3133861-a6d3-4136-ad60-61616a6666b7', 17, 21, 10, N'GV01', N'2', 10, CAST(N'2018-05-20 10:49:38.933' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'dfbbcae7-b4c8-4869-9e0e-55171a78b3ac', 26, 18, 28, N'GV05', N'Chào các em học viên thân mến. Thầy là nhà Giáp Vật Lý . Hoàng Thái Phan nếu có thắc mắc gì về nội dung bài trong bài giảng chat với thầy ở đây nhé.', 28, CAST(N'2018-05-20 15:00:00.890' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'e35c055c-f981-4a0d-86d0-27d6fbf03819', 20, 25, 28, N'GV05', N'x', 28, CAST(N'2018-05-20 18:01:27.523' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'eba76cc7-10fa-4310-997c-f087f833f039', 17, 21, 12, N'HV01', N'123', 12, CAST(N'2018-05-20 10:52:07.060' AS DateTime), 1, 1)
INSERT [dbo].[Cms_Comments] ([IdGuid], [ClassId], [ClassStudentId], [UserId], [UserName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'ed5fb2a4-a201-42db-b4a9-a6799754603e', 20, 25, 28, N'GV05', N'f', 28, CAST(N'2018-05-20 18:02:08.413' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[Cms_GradeSubject] ON 

INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (1, N'KHOI-2                                            ', 1)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (2, N'KHOI-2                                            ', 4)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (3, N'KHOI-2                                            ', 7)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (4, N'KHOI-2                                            ', 6)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (6, N'KHOI-1                                            ', 1)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (7, N'KHOI-1                                            ', 4)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (9, N'KHOI-1                                            ', 6)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (10, N'KHOI-3                                            ', 1)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (11, N'KHOI-3                                            ', 4)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (12, N'KHOI-1                                            ', 9)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (13, N'KHOI-3                                            ', 9)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (14, N'KHOI-2                                            ', 22)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (15, N'KHOI-2                                            ', 8)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (16, N'KHOI-2                                            ', 9)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (17, N'KHOI-1                                            ', 7)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (18, N'KHOI-1                                            ', 8)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (19, N'KHOI-1                                            ', 9)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (20, N'KHOI-1                                            ', 22)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (21, N'KHOI-3                                            ', 6)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (22, N'KHOI-3                                            ', 8)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (23, N'KHOI-3                                            ', 9)
SET IDENTITY_INSERT [dbo].[Cms_GradeSubject] OFF
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'5c403efc-e97a-41ff-aa0a-0014bc201f5e', N'', 28, 28, 2000000, N'Rút tiền', CAST(N'2018-05-20 16:56:16.297' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'67dca5ac-06ee-4932-a212-01f6d844320d', N'9073d791-3cbb-4822-8dba-26f708a8a442', 28, 3, 7500, N'Thanh toán tiền học cho Admin', CAST(N'2018-05-20 18:01:09.423' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'ff12f4d6-c83b-4396-9c91-2fa278c86a41', N'd71c476e-fecc-4a53-95cb-566479221d6b', 12, 28, 140000, N'Thanh toán tiền học', CAST(N'2018-05-20 16:36:37.193' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'1b9ce6e1-a478-428a-b6aa-315bd4698e58', N'', 3, 12, 100000000, N'Nạp tiền', CAST(N'2018-05-20 16:37:56.180' AS DateTime), 1, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'39a98ce6-3f80-4e22-8098-527e1af5f3be', N'0cecfdab-2373-4386-a104-519291e656c5', 12, 3, 4.5, N'Thanh toán tiền đề thi cho Admin', CAST(N'2018-05-20 18:49:29.607' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'9f5eb547-0f48-4ec4-ac8e-54892ace9570', N'', 3, 24, 10000000, N'Nạp tiền', CAST(N'2018-05-20 16:38:12.363' AS DateTime), 1, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'6a217e5b-dc66-4596-9837-759798c841db', N'108306c4-3423-42e3-a016-84a7cb76d45a', 12, 28, 70000, N'Thanh toán tiền học', CAST(N'2018-05-20 16:36:21.723' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'c126aedd-729a-42f1-93d1-797a3b8c66fc', N'04935671-ac36-4cce-8984-d2544ccb16e5', 10, 3, 9000, N'Thanh toán tiền đề thi cho Admin', CAST(N'2018-05-20 18:46:19.607' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'7ea874f3-d758-45f0-afff-799426e83c21', N'9073d791-3cbb-4822-8dba-26f708a8a442', 28, 10, 17500, N'Thanh toán tiền học', CAST(N'2018-05-20 18:01:09.417' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'5cf24fbf-4e33-4fdf-87c4-8031462c9e9f', N'04935671-ac36-4cce-8984-d2544ccb16e5', 10, 3, 21000, N'Thanh toán tiền đề thi', CAST(N'2018-05-20 18:46:19.603' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'9ee152ba-6f08-43c8-ae38-80f2a584a4bf', N'', 28, 28, 279998, N'Rút tiền', CAST(N'2018-05-20 16:48:58.737' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'db555bba-28e7-4bf4-93a4-8c6e72a0ca66', N'0cecfdab-2373-4386-a104-519291e656c5', 12, 10, 10.5, N'Thanh toán tiền đề thi', CAST(N'2018-05-20 18:49:29.597' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'cc9cb91b-3a34-4d0f-9cde-8ec8612d956c', N'd71c476e-fecc-4a53-95cb-566479221d6b', 12, 3, 60000, N'Thanh toán tiền học cho Admin', CAST(N'2018-05-20 16:36:37.197' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'48438988-04ca-49f4-9b3a-9261021f7f03', N'', 28, 28, 2280000, N'Rút tiền', CAST(N'2018-05-20 16:49:43.240' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'6c55e7f4-0c01-4c10-ac61-9f0fd8a34c79', N'', 28, 28, 2280000, N'Rút tiền', CAST(N'2018-05-20 16:52:07.227' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'c2be7079-6195-444a-8c26-a5bf56213ee9', N'', 3, 25, 10000000, N'Nạp tiền', CAST(N'2018-05-20 16:38:18.780' AS DateTime), 1, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'7f126997-2278-4a69-a389-a93bb9b0ab79', N'', 28, 28, 280000, N'Đề xuất rút tiền', CAST(N'2018-05-20 16:45:35.417' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'dd38352f-0412-49dc-88a6-d7075760dd42', N'108306c4-3423-42e3-a016-84a7cb76d45a', 12, 3, 30000, N'Thanh toán tiền học cho Admin', CAST(N'2018-05-20 16:36:21.727' AS DateTime), NULL, 1)
INSERT [dbo].[Cms_HistoryPayment] ([IdGuid], [Code], [FromUser], [ToUser], [BCoin], [Summary], [CreatedDate], [IsShow], [IsActive]) VALUES (N'b823ab37-812c-42a6-bb56-e52e32803289', N'', 28, 28, 280000, N'Đề xuất rút tiền', CAST(N'2018-05-20 16:39:32.247' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Cms_Question] ON 

INSERT [dbo].[Cms_Question] ([Id], [IdGuid], [Grade], [SubjectId], [TotalView], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'cab154e9-b453-4d5c-b1e4-17c15f817485', NULL, 1, 60, N'Giải phương trình x+1=2? X =?', 1, 1, 24, CAST(N'2018-05-19 22:58:23.110' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Question] ([Id], [IdGuid], [Grade], [SubjectId], [TotalView], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'9073d791-3cbb-4822-8dba-26f708a8a441', N'KHOI-2                        ', 6, 24, N'Cho hình chóp S.ABCD có SA vuông góc với mp(ABCD), đáy ABC', 1, 1, 10, CAST(N'2018-02-02 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Question] ([Id], [IdGuid], [Grade], [SubjectId], [TotalView], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', NULL, 1, 14, N'1=+1 =???', 1, 1, 10, CAST(N'2018-05-19 22:54:47.423' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Cms_Question] OFF
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'020311b3-94a7-4de4-9077-9f0a2df402f7', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'de bo may di mua thuc an
', 28, CAST(N'2018-05-20 17:45:30.127' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'07a6346d-d6db-4d4e-b807-6f34cf56d9d0', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 12, N'HV. Nguyễn Đức Anh', N'a', 12, CAST(N'2018-05-20 17:26:51.117' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'07c4993c-e0da-4b2d-b0ab-1f2ae5529b32', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N's
df', 28, CAST(N'2018-05-20 17:43:45.640' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'081e96ac-ed60-472d-882e-4ea6b8b88e01', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'1', 3, CAST(N'2018-05-20 17:17:39.167' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'0a8aa44f-fd7f-49f6-ab43-8d09e8eabff4', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'x', 3, CAST(N'2018-05-20 17:32:24.307' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'0b095290-7fa9-437b-a331-e3353359f0d3', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'á ', 3, CAST(N'2018-05-20 17:27:59.223' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'0e3e1630-999e-4962-bb6b-8665832b6f45', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'ã', 3, CAST(N'2018-05-20 17:26:14.307' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'0f2ac7a0-458a-4597-b666-5433f8f2ed9c', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'czdsd', 28, CAST(N'2018-05-20 17:45:08.600' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'106d006b-7ac5-4ecc-b120-e6580ed87d9c', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'8', 3, CAST(N'2018-05-20 17:18:03.440' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'13193b1f-5d05-42d1-a30e-11d9f1a032bb', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'r
g', 28, CAST(N'2018-05-20 17:43:44.767' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'15028388-bf67-422f-bab9-d520bda5806c', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'âcsc
', 3, CAST(N'2018-05-20 17:34:50.897' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'18275b9c-64f4-4328-8a33-8071c28b8076', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'áklcnas
', 3, CAST(N'2018-05-20 17:45:42.960' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'1a4fa9c3-21cb-45a8-a10b-9f3a74afa456', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'dg
', 28, CAST(N'2018-05-20 17:43:45.417' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'1a98d06f-8a9b-4f40-9234-dfaeb5fa0b81', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'324', 3, CAST(N'2018-05-20 17:22:00.053' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'1ad57bb5-a59e-4ac7-a00c-78505e11f077', N'9073d791-3cbb-4822-8dba-26f708a8a441', 3, N'Quản trị cấp cao', N'ưef', 3, CAST(N'2018-05-20 17:38:03.490' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'1b2ea724-345c-46a4-907a-58e5d7ba9bae', N'9073d791-3cbb-4822-8dba-26f708a8a441', 3, N'Quản trị cấp cao', N'5', 3, CAST(N'2018-05-20 17:37:45.907' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'1c260654-d7f0-47fd-bb45-8be92ec9fc37', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 12, N'HV. Nguyễn Đức Anh', N'csa', 12, CAST(N'2018-05-20 17:44:17.903' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'1ed977b9-ab42-492e-bc2a-7d64fb781373', N'9073d791-3cbb-4822-8dba-26f708a8a441', 3, N'Quản trị cấp cao', N'4', 3, CAST(N'2018-05-20 17:35:35.227' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'270546cf-7805-446e-a3b3-cba532aa7fe3', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'áckasc
', 3, CAST(N'2018-05-20 17:45:38.617' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'288297c5-2048-4008-989c-5d7475d83ac6', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 12, N'HV. Nguyễn Đức Anh', N'sc', 12, CAST(N'2018-05-20 17:27:12.450' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'29ee984a-0f4a-4d47-906b-2c1d5e32a71e', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'thì chưa comment vào bài viết này nên chưa có
', 3, CAST(N'2018-05-20 17:39:22.907' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'2ea3a460-4b1d-4568-a793-b1776aeae851', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'sd', 3, CAST(N'2018-05-20 17:20:22.543' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'2f652d5e-dd71-4afd-9cfc-d55769a15e33', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 12, N'HV. Nguyễn Đức Anh', N'cs', 12, CAST(N'2018-05-20 17:27:37.553' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3061d062-b1ba-40f7-a2cd-993d822c10f8', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'
fd', 28, CAST(N'2018-05-20 17:43:44.420' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'349688a8-b7c7-4562-afcc-9dea3f000a4a', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'sacc', 28, CAST(N'2018-05-20 17:44:14.247' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3577931c-a7c2-471f-b55e-10b191d9871f', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'áclas
', 3, CAST(N'2018-05-20 17:45:44.030' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3612f87a-86d0-40af-aaed-3717a1c20923', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 28, N'GV05', N'zx', 28, CAST(N'2018-05-20 17:27:04.170' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3d22e27a-a630-4440-a994-8832c5825ca9', N'9073d791-3cbb-4822-8dba-26f708a8a441', 28, N'GV05', N'3', 28, CAST(N'2018-05-20 17:35:25.730' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3fac3d34-38a4-48c9-be0b-0d6ae6523cf7', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'cv', 3, CAST(N'2018-05-20 17:31:16.403' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'3fd9352d-9fc8-4119-8e11-d1bdef775b31', N'9073d791-3cbb-4822-8dba-26f708a8a441', 12, N'HV. Nguyễn Đức Anh', N'2', 12, CAST(N'2018-05-20 17:35:17.880' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'42ee4207-b27a-4853-9366-12110e8acdf3', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'ldfmbd
', 3, CAST(N'2018-05-20 17:45:37.853' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'466c9bc9-1e9a-4283-af41-7d6649cca34f', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'dong tien di
', 28, CAST(N'2018-05-20 17:45:22.627' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'47a35f6e-2685-4883-adbb-521de61b5615', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 28, N'GV05', N'c', 28, CAST(N'2018-05-20 17:26:55.410' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'484bb4d2-0ee2-4138-a62a-7c691c67f42d', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'dfgdf
', 3, CAST(N'2018-05-20 17:34:48.827' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'48ba7573-3440-4527-b3f0-68b32e6aa74c', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N's
', 28, CAST(N'2018-05-20 17:43:43.857' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'4cd7cdd4-9f90-478f-830f-9827d2f5f80f', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'a', 3, CAST(N'2018-05-20 17:20:35.237' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'53ad1767-f0c8-41d0-b4f3-85940f70d321', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 28, N'GV05', N'123', 28, CAST(N'2018-05-20 17:37:58.137' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'53ca2ec7-b99e-43aa-ac2c-0cf2c5b32e23', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'ácklasc
', 3, CAST(N'2018-05-20 17:45:43.510' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'54908e90-bcdb-4714-99b0-391d66287cdf', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'tiền gì vậy
', 3, CAST(N'2018-05-20 17:45:29.850' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'551bb12a-8689-4494-b1c2-33be8e321b53', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'các', 3, CAST(N'2018-05-20 17:42:17.087' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'56f88f85-6c99-4ec5-98b0-e0c52b3d4cdd', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'12', 3, CAST(N'2018-05-20 17:17:13.147' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'57907aeb-417f-40b9-9b08-132178875cfe', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'álcaklsc
', 3, CAST(N'2018-05-20 17:45:40.513' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'5ac7bc1c-ed0f-437e-8eed-76abcc0c7925', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 12, N'HV. Nguyễn Đức Anh', N'asc', 12, CAST(N'2018-05-20 17:44:36.223' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'5c5350f1-0b97-4a1a-9214-7733f25a54ed', N'9073d791-3cbb-4822-8dba-26f708a8a441', 28, N'GV05', N'2', 28, CAST(N'2018-05-20 17:37:21.300' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'5da7876d-b507-4c85-8bf6-5715744e97b6', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'sdsv', 3, CAST(N'2018-05-20 17:25:10.420' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'5e38b877-06f1-456d-8c45-accfb4917c8d', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'sao phair 5f', 28, CAST(N'2018-05-20 17:38:58.453' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'674ea90b-87b2-453e-9074-2965778845bb', N'CAB154E9-B453-4D5C-B1E4-17C15F817485', 24, N'HV. Nguyễn Xuân Quỳnh', N'xv', 24, CAST(N'2018-05-20 00:41:48.120' AS DateTime), 0, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'6f2eef66-266e-4031-8f91-77913f3ed807', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'123', 3, CAST(N'2018-05-20 17:17:02.080' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'7004c7c3-9c7c-4e0e-8201-e939885bbcc8', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'ákcnaskc
', 3, CAST(N'2018-05-20 17:45:39.913' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'70a9a46e-0616-4ee7-aee5-a5efe703f349', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'fsgfdsg', 28, CAST(N'2018-05-20 17:42:12.607' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'74f2c410-6742-4ebb-a053-7e94954d1157', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 28, N'GV05', N'ascasascascascascasc', 28, CAST(N'2018-05-20 17:27:47.003' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'79e1ba6c-d794-4561-b98d-05d3d19ab096', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'1234', 3, CAST(N'2018-05-20 17:43:36.820' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'80d7e3f8-3fda-4867-bd5d-47a140f26f9c', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'owf', 28, CAST(N'2018-05-20 17:43:01.423' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'8934e0c9-9f81-4038-ac56-3af07a43df5d', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N's
', 28, CAST(N'2018-05-20 17:43:44.170' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'8c65c637-b890-422f-919f-3cb401c27088', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'
r', 28, CAST(N'2018-05-20 17:43:45.217' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'8d1fb7e4-3902-4c29-b395-ccd0052c9784', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'
erh', 28, CAST(N'2018-05-20 17:43:46.000' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'8e4652d7-1b0b-4ecc-8457-50214ba293d0', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'= 2 chứ còn bằng mày', 3, CAST(N'2018-05-20 17:38:45.000' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'8e773018-eb29-470f-87b2-de63da5270a7', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'áckasc
', 3, CAST(N'2018-05-20 17:45:39.287' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'8f86e0aa-7be7-4eec-9d99-dc63e921834d', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'sac', 28, CAST(N'2018-05-20 17:44:26.533' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'960f8a76-eafe-4a9b-af17-d23d0314d4bd', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N's
', 28, CAST(N'2018-05-20 17:43:43.453' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'990375e9-0f35-465c-a5e8-703d524755a1', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'scas', 28, CAST(N'2018-05-20 17:44:05.897' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'996b3723-1118-4743-9426-2d333d8d9b22', N'9073d791-3cbb-4822-8dba-26f708a8a441', 12, N'HV. Nguyễn Đức Anh', N'3', 12, CAST(N'2018-05-20 17:37:34.907' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'9e174e1d-e795-4dca-bddd-d72cece687a7', N'CAB154E9-B453-4D5C-B1E4-17C15F817485', 24, N'HV. Nguyễn Xuân Quỳnh', N'123', 24, CAST(N'2018-05-20 00:40:05.170' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'9e2d4106-1fc3-4bf0-828d-16cf99139d91', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'nakscnasc
', 3, CAST(N'2018-05-20 17:45:42.360' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'9f2707e3-5939-4b3e-848b-9bcf816ca4b4', N'9073d791-3cbb-4822-8dba-26f708a8a441', 28, N'GV05', N'1', 28, CAST(N'2018-05-20 17:35:08.253' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'9fe22f4f-a83b-439a-9a08-ef6561868676', N'9073d791-3cbb-4822-8dba-26f708a8a441', 28, N'GV05', N'5', 28, CAST(N'2018-05-20 17:35:48.510' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'a295cc56-b868-4c01-909f-1c1222b991cf', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'g
', 28, CAST(N'2018-05-20 17:43:44.570' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'a69cf638-b83d-4c7f-9175-adf3e8a5244c', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 28, N'GV05', N'GV tham gia', 28, CAST(N'2018-05-20 17:21:32.913' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'a91a80ad-a078-48e9-be49-20b45d78c4b6', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'
f', 28, CAST(N'2018-05-20 17:43:44.317' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'aac476df-28dd-486a-9543-829b727d8c9f', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N's
', 28, CAST(N'2018-05-20 17:43:43.660' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'aecab598-549a-441c-8247-edd97dfc0c12', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'cnhj
', 3, CAST(N'2018-05-20 17:45:46.527' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'b362aad4-8c3f-47cf-82b3-5e32ccf9bd7a', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'cccc', 3, CAST(N'2018-05-20 17:42:52.860' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'b5624eed-67de-40b4-a787-6396d9823614', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N's
', 28, CAST(N'2018-05-20 17:43:43.227' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'be758d3c-f3f2-43c5-948b-2b878548715e', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 28, N'GV05', N'werwe', 28, CAST(N'2018-05-20 17:26:10.113' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'c587eda2-1895-4418-8b14-170cd2cc4164', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N's
', 28, CAST(N'2018-05-20 17:43:42.993' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'CAB154E9-B453-4D5C-B1E4-17C15F817481', N'CAB154E9-B453-4D5C-B1E4-17C15F817485', 10, N'Hoàng Nhật Minh', N'Chào admin', 24, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'ce29f787-a1f9-4da9-9476-782e19830a9a', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'álc
á', 3, CAST(N'2018-05-20 17:45:44.533' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'd13c1cca-b83f-44d4-9c61-6cc8de47cfbc', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'tuowngr cais gif =)) cui` vl', 28, CAST(N'2018-05-20 17:42:29.960' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'd6f4dac2-fd49-4de7-ab1a-d7dd94c8b306', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'âcsc', 3, CAST(N'2018-05-20 17:43:42.217' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'd9f823ef-6f7d-453b-b1ce-cf3fbf4c981b', N'CAB154E9-B453-4D5C-B1E4-17C15F817485', 24, N'HV. Nguyễn Xuân Quỳnh', N'ccc', 24, CAST(N'2018-05-20 00:39:25.770' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'dd30d4fd-fc41-48a0-acc3-561948201ed3', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N's
', 28, CAST(N'2018-05-20 17:43:44.020' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'dd47a8c1-4908-447e-b805-03ed195984ec', N'CAB154E9-B453-4D5C-B1E4-17C15F817485', 24, N'HV. Nguyễn Xuân Quỳnh', N'HV. Nguyễn Xuân Quỳnh', 24, CAST(N'2018-05-20 00:49:43.300' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'e054ad4b-2486-4ca7-90c1-14e7ae4859a3', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'dd
', 28, CAST(N'2018-05-20 17:43:42.677' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'e2b1d432-ebad-4420-8d27-b49621d933db', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'cau'' cl
', 28, CAST(N'2018-05-20 17:43:32.130' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'e887d346-51d1-4ac2-9c93-b02cd15bfcad', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'áckansc
', 3, CAST(N'2018-05-20 17:45:41.103' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'e92a55dd-139c-4d9f-ace4-ad1628c51c91', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'
', 28, CAST(N'2018-05-20 17:43:44.963' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'eb3024ff-8118-4197-8914-ba73c4550804', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 12, N'HV. Nguyễn Đức Anh', N'zx zx', 12, CAST(N'2018-05-20 17:27:52.710' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'edb6652e-81df-4f72-a255-c0d1c8d6c0d3', N'cab154e9-b453-4d5c-b1e4-17c15f817485', 3, N'Quản trị cấp cao', N'xa', 3, CAST(N'2018-05-20 17:33:59.723' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'ef508432-e809-47ef-a2ae-b8f9c9bd64eb', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'ascjka]scj
\á', 3, CAST(N'2018-05-20 17:45:45.470' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'f27d4408-408d-46b3-b480-3e0dfbdefc11', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 28, N'GV05', N'h
rb', 28, CAST(N'2018-05-20 17:43:45.827' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'f3868f85-2622-4919-8939-469ee940d8eb', N'9073d791-3cbb-4822-8dba-26f708a8a441', 28, N'GV05', N'1', 28, CAST(N'2018-05-20 17:37:15.843' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'f7d1fe45-10b6-47d9-8090-31871d487f43', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'ậclsc
a', 3, CAST(N'2018-05-20 17:45:44.990' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'f7faa8aa-a5c8-4fc3-9b9c-1f386abb5243', N'ca574ce1-1ff8-4e03-9c31-db7e31bd2205', 3, N'Quản trị cấp cao', N'ákcnkasc
', 3, CAST(N'2018-05-20 17:45:41.660' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'fc71df02-caf1-4e3c-af5d-7ed2de573d76', N'9073d791-3cbb-4822-8dba-26f708a8a441', 28, N'GV05', N'dfb', 28, CAST(N'2018-05-20 17:38:08.920' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'fcc4e2eb-b6f0-4ca2-b753-d99fae9f82d1', N'9073d791-3cbb-4822-8dba-26f708a8a441', 28, N'GV05', N'56', 28, CAST(N'2018-05-20 17:36:15.587' AS DateTime), 1, 1)
INSERT [dbo].[Cms_QuestionComments] ([IdGuid], [QuestionId], [UserId], [FullName], [Comments], [CreatedBy], [CreatedDate], [IsActive], [IsShow]) VALUES (N'fe8ee75c-5413-42ee-93cc-792bb29babe9', N'9073d791-3cbb-4822-8dba-26f708a8a441', 28, N'GV05', N'4', 28, CAST(N'2018-05-20 17:37:40.007' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[CmsBlog] ON 

INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, 0, N'Bộ trưởng Bộ GD&ĐT chỉ thị "Tăng cường công tác quản lý và nâng cao đạo đức nhà giáo"', N'/Uploads/CKFinder/images/Blog/Bo-truong-Bo-GD-DT-chi-thi-Tang-cuo-ng-cong-ta-c-qua-n-ly-va-nang-cao-da-o-du-c-nha-gia-o.png', N'Laika đang và sẽ tiếp tục là cái tên gây nhiều chú ý trong giới làm phim cũng như công đồng người yêu thích phim hoạt hình bởi những tác phẩm stop-motion cực kỳ xuất sắc.', 27, 1, N'<div>
<p>Vừa qua, Bộ trưởng Bộ GD&amp;ĐT Ph&ugrave;ng Xu&acirc;n Nhạ đ&atilde; k&yacute; chỉ thị 1737/CT-BGDĐT về việc tăng cường c&ocirc;ng t&aacute;c quản l&yacute; v&agrave; n&acirc;ng cao đạo đức nh&agrave; gi&aacute;o. Xin chia sẻ với c&aacute;c bạn to&agrave;n văn chỉ thị quan trọng của Bộ trưởng.</p>

<p><img alt="Bộ trưởng Bộ GD&amp;ĐT chỉ thị &quot;Tăng cường công tác quản lý và nâng cao đạo đức nhà giáo&quot;" src="https://i.bigschool.vn/w/33cfbc/700/News/images/2018/05/CT1737-CT-BGD_T1/Bo-truong-Bo-GD-DT-chi-thi-Tang-cuo-ng-cong-ta-c-qua-n-ly-va-nang-cao-da-o-du-c-nha-gia-o.png" style="width:700px" title="Bộ trưởng Bộ GD&amp;ĐT chỉ thị &quot;Tăng cường công tác quản lý và nâng cao đạo đức nhà giáo&quot;" /><br />
<img alt="Bộ trưởng Bộ GD&amp;ĐT chỉ thị &quot;Tăng cường công tác quản lý và nâng cao đạo đức nhà giáo&quot;" src="https://i.bigschool.vn/w/83f834/700/News/images/2018/05/CT1737-CT-BGD_T2/Bo-truong-Bo-GD-DT-chi-thi-Tang-cuo-ng-cong-ta-c-qua-n-ly-va-nang-cao-da-o-du-c-nha-gia-o.png" style="width:700px" title="Bộ trưởng Bộ GD&amp;ĐT chỉ thị &quot;Tăng cường công tác quản lý và nâng cao đạo đức nhà giáo&quot;" /><br />
<img alt="Bộ trưởng Bộ GD&amp;ĐT chỉ thị &quot;Tăng cường công tác quản lý và nâng cao đạo đức nhà giáo&quot;" src="https://i.bigschool.vn/w/de05f3/700/News/images/2018/05/CT1737-CT-BGD_T3/Bo-truong-Bo-GD-DT-chi-thi-Tang-cuo-ng-cong-ta-c-qua-n-ly-va-nang-cao-da-o-du-c-nha-gia-o.png" style="width:700px" title="Bộ trưởng Bộ GD&amp;ĐT chỉ thị &quot;Tăng cường công tác quản lý và nâng cao đạo đức nhà giáo&quot;" /></p>

<p><img alt="Chỉ thị 1737/CT-BGDĐT của Bộ trưởng Bộ GD&amp;ĐT" src="https://i.bigschool.vn/w/9c1954/700/News/images/2018/05/CT1737-CT-BGD_T4/Chi-thi-1737-CT-BGDDT-cua-Bo-truong-Bo-GD-DT.png" title="Chỉ thị 1737/CT-BGDĐT của Bộ trưởng Bộ GD&amp;ĐT" />Chỉ thị 1737/CT-BGDĐT của Bộ trưởng Bộ GD&amp;ĐT</p>
</div>

<p>&nbsp;</p>
', 1, 5, CAST(N'2018-01-30 00:00:00.000' AS DateTime), 3, CAST(N'2018-05-14' AS Date))
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, 0, N'Olympic Vật lí Châu Á lần thứ 19 (AphO 2018): Việt Nam giành 4 Huy chương Vàng', N'/Uploads/CKFinder/images/Dai-dien-Viet-Nam-trao-co-dang-cai-Olympic-Vat-li-Chau-A-lan-thu-20-AphO-2019-cho-dai-dien-den-tu-Australia.png', N'Không nhận được nhiều sự kỳ vọng từ khi công bố dự án, nhưng thành công nhất định trong mùa hè vừa qua của The angry birds Movie đã khiến những nhà sản xuất tự tin làm tiếp phần 2 cho ‘Những chú chim giận dữ‘.', 6, 1, N'<div style="text-align:center">
<p>Olympic Vật l&iacute; Ch&acirc;u &Aacute; lần thứ 19 (AphO 2018) được tổ chức tại Việt Nam từ ng&agrave;y 05 đến ng&agrave;y 13/5/2018 với sự tham gia của 185 học sinh, 48 l&atilde;nh đo&agrave;n v&agrave; 29 quan s&aacute;t vi&ecirc;n đến từ 25 quốc gia v&agrave; v&ugrave;ng l&atilde;nh thổ đ&atilde; kết th&uacute;c tốt đẹp.</p>

<ul>
	<li>&nbsp;<a href="https://bigschool.vn/khai-mac-ky-thi-olympic-vat-ly-chau-a-lan-thu-19-apho-2018">Khai mạc Kỳ thi Olympic Vật l&yacute; Ch&acirc;u &Aacute; lần thứ 19 (AphO 2018)</a></li>
</ul>

<p>&nbsp;</p>

<p><img alt="Thứ trưởng Nguyễn Hữu Độ, Chủ tịch APhO Leong Chuan Kwek, Hiệu trưởng ĐHBK HN Hoàng Minh Sơn với 33 học sinh đoạt Huy chương Vàng" src="https://i.bigschool.vn/w/148741/700/News/images/2018/05/Screen_Shot_2018-05-13_at_7.46.04_CH/Thu-truong-Nguyen-Huu-Do-Chu-tich-APhO-Leong-Chuan-Kwek-Hieu-truong-DHBK-HN-Hoang-Minh-Son-voi-33-hoc-sinh-doat-Huy-chuong-Vang.png" title="Thứ trưởng Nguyễn Hữu Độ, Chủ tịch APhO Leong Chuan Kwek, Hiệu trưởng ĐHBK HN Hoàng Minh Sơn với 33 học sinh đoạt Huy chương Vàng" />Thứ trưởng Nguyễn Hữu Độ, Chủ tịch APhO Leong Chuan Kwek, Hiệu trưởng ĐHBK HN Ho&agrave;ng Minh Sơn với 33 học sinh đoạt Huy chương V&agrave;ng</p>

<p><br />
Đội tuyển quốc gia Việt Nam gồm 08 th&iacute; sinh dự thi; kết quả 8/8 th&iacute; sinh đoạt giải, gồm: 04 Huy chương Vàng, 02 Huy chương Bạc, 02 Huy chương Đồng. Đ&acirc;y l&agrave; kết quả tốt nhất trong c&aacute;c lần tham dự AphO của học sinh Việt Nam.<br />
C&aacute;c học sinh đoạt Huy chương V&agrave;ng gồm:&nbsp;<br />
1. Em Trần Đức Huy, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n H&agrave; Nội - Amsterdam;<br />
2. Em Nguyễn Ngọc Long, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Lam Sơn, tỉnh Thanh H&oacute;a;<br />
3. Em Nguyễn Văn Th&agrave;nh Lợi, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Quang Trung, tỉnh B&igrave;nh Phước;<br />
4. Em Trịnh Duy Hiếu, học sinh lớp 11, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Bắc Giang, tỉnh Bắc Giang.</p>

<p><img alt="Thứ trưởng Nguyễn Hữu Độ và Chủ tịch APhO Leong Chuan Kwek trao tặng Huy chương Vàng cho em Trần Đức Huy" src="https://i.bigschool.vn/w/a77b6d/700/News/images/2018/05/Screen_Shot_2018-05-13_at_7.48.10_CH/Thu-truong-Nguyen-Huu-Do-va-Chu-tich-APhO-Leong-Chuan-Kwek-trao-tang-Huy-chuong-Vang-cho-em-Tran-Duc-Huy.png" title="Thứ trưởng Nguyễn Hữu Độ và Chủ tịch APhO Leong Chuan Kwek trao tặng Huy chương Vàng cho em Trần Đức Huy" />Thứ trưởng Nguyễn Hữu Độ v&agrave; Chủ tịch APhO Leong Chuan Kwek trao tặng Huy chương V&agrave;ng cho em Trần Đức Huy</p>

<p><br />
02 học sinh đoạt Huy chương bạc l&agrave;: Em Nguyễn Xu&acirc;n T&acirc;n, học sinh lớp 11, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Khoa học Tự&nbsp; nhi&ecirc;n, Đại học Quốc gia H&agrave; Nội v&agrave; em Nguyễn Văn Duy, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Đại học Sư phạm H&agrave; Nội. Em L&ecirc; Cao Anh, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Lam Sơn, tỉnh Thanh H&oacute;a v&agrave; em L&ecirc; Kỳ Nam, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Hạ Long, Tỉnh Quảng Ninh đoạt Huy chương Đồng.</p>

<p>&nbsp;</p>

<p>Năm nay, Ban tổ chức APhO đ&atilde; trao 33 Huy chương V&agrave;ng, 13 Huy chương Bạc, 24 Huy chương Đồng v&agrave; 9 giải Đặc biệt cho c&aacute;c c&aacute; nh&acirc;n c&oacute; th&agrave;nh t&iacute;ch xuất sắc trong k&igrave; thi. &nbsp;Em Trần Đức Huy, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n H&agrave; Nội - Amsterdam l&agrave; một trong 9 c&aacute; nh&acirc;n được giao giải Đặc biệt. C&oacute; 9 nước gi&agrave;nh được Huy chương V&agrave;ng gồm: Trung Quốc, Nga, Việt Nam, Đ&agrave;i Loan, Rumania, Ấn Độ, Singapor, Kazactan, Hồng K&ocirc;ng.</p>

<p><img alt="Em LAU Sze Chun, 13 tuổi (nhỏ tuổi nhất), đội tuyển Hồng Kông nhận Huy chương Đồng trong sự cổ vũ nồng nhiệt" src="https://i.bigschool.vn/w/c19f7b/700/News/images/2018/05/Screen_Shot_2018-05-13_at_7.51.06_CH/Em-LAU-Sze-Chun-13-tuoi-nho-tuoi-nhat-doi-tuyen-Hong-Kong-nhan-Huy-chuong-Dong-trong-su-co-vu-nong-nhiet.png" title="Em LAU Sze Chun, 13 tuổi (nhỏ tuổi nhất), đội tuyển Hồng Kông nhận Huy chương Đồng trong sự cổ vũ nồng nhiệt" />Em LAU Sze Chun, 13 tuổi (nhỏ tuổi nhất), đội tuyển Hồng K&ocirc;ng nhận Huy chương Đồng trong sự cổ vũ nồng nhiệt</p>

<p><br />
Chia sẻ về kết quả kỳ thi, PGS Ho&agrave;ng Minh Sơn - Hiệu trưởng Trường ĐH B&aacute;ch khoa H&agrave; Nội, Trưởng Ban Tổ chức APhO 2018 cho biết, kết quả kỳ thi năm nay cho thấy c&oacute; nhiều th&iacute; sinh đ&atilde; biết vận dụng một c&aacute;ch s&aacute;ng tạo c&aacute;c kiến thức vật l&iacute; v&agrave; c&aacute;c kĩ năng thực nghiệm để giải b&agrave;i thi v&agrave; do vậy đ&atilde; đạt được kết quả xuất sắc. T&ocirc;i đ&aacute;nh gi&aacute; cao sự nỗ lực, quyết t&acirc;m v&agrave; s&aacute;ng tạo của c&aacute;c t&agrave;i năng trẻ n&agrave;y. Ch&iacute;nh c&aacute;c em đ&atilde; g&oacute;p phần quan trọng trong việc tổ chức th&agrave;nh c&ocirc;ng của kỳ thi năm nay v&agrave; xứng đ&aacute;ng nhận được những lời ch&uacute;c mừng tốt đẹp nhất.<br />
Cũng tại buổi bế mạc, &ocirc;ng Leong Chuan Kwek - Chủ tịch APhO gửi lời cảm ơn tới Ch&iacute;nh phủ Việt Nam v&agrave; Trường ĐH B&aacute;ch khoa H&agrave; Nội - đơn vị chủ tr&igrave; đăng cai v&agrave; hỗ trợ nhiệt t&igrave;nh trong suốt thời gian k&igrave; thi diễn ra. &Ocirc;ng nhấn mạnh, việc đầu tư v&agrave;o sự kiện gi&aacute;o dục sẽ th&uacute;c đẩy Việt&nbsp; Nam tiến xa hơn trong việc ph&aacute;t triển kinh tế x&atilde; hội v&agrave; nền tảng khoa học trong tương lai. Đồng thời, gửi gắm tới to&agrave;n thể th&iacute; sinh tham dự kỳ thi th&ocirc;ng điệp &quot;d&ugrave; c&aacute;c bạn được bao nhi&ecirc;u điểm, kết quả của c&aacute;c bạn ra sao, c&aacute;c bạn l&agrave;m b&agrave;i như thế n&agrave;o, th&igrave; h&ocirc;m nay h&atilde;y gạt sang một b&ecirc;n. C&aacute;c bạn h&atilde;y giữ li&ecirc;n lạc với nhau v&agrave; tr&acirc;n trọng những kỉ niệm tuyệt vời trong 9 ng&agrave;y qua khi trở về qu&ecirc; hương&quot;.</p>

<p><img alt="Đại diện Việt Nam trao cờ đăng cai Olympic Vật lí Châu Á lần thứ 20 (AphO 2019) cho đại diện đến từ Australia" src="https://i.bigschool.vn/w/930a11/700/News/images/2018/05/Screen_Shot_2018-05-13_at_7.53.08_CH/Dai-dien-Viet-Nam-trao-co-dang-cai-Olympic-Vat-li-Chau-A-lan-thu-20-AphO-2019-cho-dai-dien-den-tu-Australia.png" title="Đại diện Việt Nam trao cờ đăng cai Olympic Vật lí Châu Á lần thứ 20 (AphO 2019) cho đại diện đến từ Australia" />Đại diện Việt Nam trao cờ đăng cai Olympic Vật l&iacute; Ch&acirc;u &Aacute; lần thứ 20 (AphO 2019) cho đại diện đến từ Australia</p>

<p><br />
Trải qua 9 ng&agrave;y tại Việt Nam, c&aacute;c đo&agrave;n dự thi v&agrave; những người tham gia đ&atilde; c&oacute; nhiều trải nghiệm với những hoạt động giao lưu văn h&oacute;a, văn nghệ, thể thao, tham quan, du lịch thuận lợi v&agrave; được bảo đảm an to&agrave;n. Với c&ocirc;ng t&aacute;c tổ chức nhiệt t&igrave;nh, chu đ&aacute;o, hiếu kh&aacute;ch của Ban tổ chức, c&aacute;c bạn b&egrave; quốc tế đ&atilde; c&oacute; những ấn tượng tốt đẹp về nước chủ nh&agrave;.</p>

<p>&nbsp;</p>

<p>Tại Lễ bế mạc, PGS Ho&agrave;ng Minh Sơn - Hiệu trưởng Trường ĐH B&aacute;ch khoa H&agrave; Nội, Trưởng Ban Tổ chức APhO 2018 đ&atilde; trao cờ đăng cai tổ chức Olympic Vật l&iacute; Ch&acirc;u &Aacute; lần thứ 20 (AphO 2019) cho đại diện đến từ Australia.</p>

<p><strong>Trung t&acirc;m Truyền th&ocirc;ng gi&aacute;o dục</strong></p>

<p><em>Nguồn: Bộ GD&amp;ĐT</em></p>
</div>

<p>&nbsp;</p>
', 1, 5, CAST(N'2017-01-30 00:00:00.000' AS DateTime), 3, CAST(N'2018-05-14' AS Date))
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, 0, N'Theo đề án thì tổng thu nhập của giáo viên tăng không đáng kể so với các ngành khác', N'/Uploads/CKFinder/images/Blog/Bo-truong-Phung-Xuan-Nha-phat-bieu-tai-Hoi-nghi-lan-thu-7-BCH-Trung-uong-Dang-khoa-XII.png', N'Laika đang và sẽ tiếp tục là cái tên gây nhiều chú ý trong giới làm phim cũng như công đồng người yêu thích phim hoạt hình bởi những tác phẩm stop-motion cực kỳ xuất sắc.', 97, 1, N'<div>
<p>Chiều 9/5, Hội nghị lần thứ 7 BCH TƯ Đảng (kh&oacute;a XII) thảo luận về &ldquo;Đề &aacute;n cải c&aacute;ch tiền lương đối với c&aacute;n bộ, c&ocirc;ng chức, vi&ecirc;n chức, lực lượng vũ trang v&agrave; người lao động trong doanh nghiệp&rdquo;. Bộ trưởng Ph&ugrave;ng Xu&acirc;n Nhạ đ&atilde; ph&aacute;t biểu đề xuất về lương gi&aacute;o vi&ecirc;n.</p>

<h2>Vấn đề về lương gi&aacute;o vi&ecirc;n đ&atilde; được khẳng định như thế n&agrave;o?</h2>

<p>Bộ trưởng Ph&ugrave;ng Xu&acirc;n Nhạ khẳng định: Đảng v&agrave; Nh&agrave; nước ta lu&ocirc;n coi ph&aacute;t triển GD&amp;ĐT l&agrave; &quot;Quốc s&aacute;ch h&agrave;ng đầu&quot;.&nbsp;<strong>Nghị quyết Trung ương 2, Kh&oacute;a VIII</strong>&nbsp;đ&atilde; x&aacute;c định lương gi&aacute;o vi&ecirc;n được xếp cao nhất trong hệ thống thang bậc lương h&agrave;nh ch&iacute;nh sự nghiệp v&agrave; c&oacute; th&ecirc;m chế độ phụ cấp t&ugrave;y theo t&iacute;nh chất c&ocirc;ng việc.&nbsp;<strong>Nghị quyết Trung ương 29, Kh&oacute;a XI</strong>&nbsp;về đổi mới căn bản, to&agrave;n diện GD&amp;ĐT tiếp tục khẳng định lại quan điểm n&agrave;y.</p>

<p>Thời gian vừa qua, được sự quan t&acirc;m của Đảng v&agrave; Nh&agrave; nước, tiền lương n&oacute;i ri&ecirc;ng, thu nhập n&oacute;i chung của nh&agrave; gi&aacute;o ng&agrave;y c&agrave;ng được cải thiện. Ch&iacute;nh phủ đ&atilde; quan t&acirc;m n&acirc;ng mức thu nhập cho gi&aacute;o vi&ecirc;n th&ocirc;ng qua việc bổ sung một số phụ cấp đặc th&ugrave; như phụ cấp ưu đ&atilde;i, phụ cấp th&acirc;m ni&ecirc;n nghề; mở rộng ti&ecirc;u chuẩn, ti&ecirc;u ch&iacute; n&acirc;ng lương trước thời hạn cho gi&aacute;o vi&ecirc;n, nh&acirc;n vi&ecirc;n ng&agrave;nh Gi&aacute;o dục...</p>

<p>Ch&iacute;nh s&aacute;ch tiền lương v&agrave; c&aacute;c loại phụ cấp theo lương hiện h&agrave;nh đ&atilde; g&oacute;p phần động vi&ecirc;n, khuyến kh&iacute;ch đội ngũ nh&agrave; gi&aacute;o v&agrave; c&aacute;n bộ quản l&yacute; gi&aacute;o dục chuy&ecirc;n t&acirc;m c&ocirc;ng t&aacute;c, đ&oacute;ng g&oacute;p nhiều hơn cho sự nghiệp ph&aacute;t triển GD&amp;ĐT nước nh&agrave;, nhất l&agrave; tại c&aacute;c v&ugrave;ng c&oacute; điều kiện kinh tế - x&atilde; hội đặc biệt kh&oacute; khăn, v&ugrave;ng s&acirc;u, v&ugrave;ng xa, bi&ecirc;n giới, hải đảo.</p>

<p><img alt="Bộ trưởng Phùng Xuân Nhạ phát biểu tại Hội nghị lần thứ 7 BCH Trung ương Đảng (khóa XII)." src="https://i.bigschool.vn/w/92a092/640/News/images/2018/05/Screen_Shot_2018-05-11_at_7.41.40_CH/Bo-truong-Phung-Xuan-Nha-phat-bieu-tai-Hoi-nghi-lan-thu-7-BCH-Trung-uong-Dang-khoa-XII.png" title="Bộ trưởng Phùng Xuân Nhạ phát biểu tại Hội nghị lần thứ 7 BCH Trung ương Đảng (khóa XII)." />Bộ trưởng Ph&ugrave;ng Xu&acirc;n Nhạ ph&aacute;t biểu tại Hội nghị lần thứ 7 BCH Trung ương Đảng (kh&oacute;a XII).</p>

<p><br />
Theo&nbsp;<strong>Đề &aacute;n&nbsp;&quot;Cải c&aacute;ch ch&iacute;nh s&aacute;ch tiền lương&nbsp;đối&nbsp;với c&aacute;n bộ, c&ocirc;ng chức, vi&ecirc;n chức, lực lượng vũ trang v&agrave; người lao động trong doanh nghiệp&quot;&nbsp;tr&igrave;nh Hội nghị Trung ương lần n&agrave;y</strong>, mức lương cơ bản của c&aacute;n bộ, c&ocirc;ng chức, vi&ecirc;n chức n&oacute;i chung, đội ngũ gi&aacute;o vi&ecirc;n n&oacute;i ri&ecirc;ng sẽ được điều chỉnh tăng l&ecirc;n.</p>

<p>&nbsp;</p>

<p>Tuy nhi&ecirc;n, x&eacute;t&nbsp;<strong>về tổng thể cơ cấu tiền lương theo bảng lương mới th&igrave; tổng lương v&agrave; phụ cấp của gi&aacute;o vi&ecirc;n tăng kh&ocirc;ng đ&aacute;ng kể so với mức hiện nay</strong>, nhất l&agrave; gi&aacute;o vi&ecirc;n c&ocirc;ng t&aacute;c tại c&aacute;c v&ugrave;ng c&oacute; điều kiện kinh tế - x&atilde; hội đặc biệt kh&oacute; khăn, v&ugrave;ng s&acirc;u, v&ugrave;ng xa, bi&ecirc;n giới, hải đảo.</p>

<h2>Đề xuất về lương gi&aacute;o vi&ecirc;n tại Hội nghị lần thứ 7 BCH TƯ Đảng Kho&aacute; XII</h2>

<p>Cho d&ugrave; lương cơ bản như dự kiến trong Đề &aacute;n tăng th&igrave;&nbsp;<strong>tổng thu nhập từ lương (lương + phụ cấp) của gi&aacute;o vi&ecirc;n sẽ tăng nhưng tăng kh&ocirc;ng đ&aacute;ng kể so với hiện nay, trong khi tổng thu nhập từ lương của c&aacute;c ng&agrave;nh kh&aacute;c tăng đ&aacute;ng kể</strong>&nbsp;khi thực hiện theo Đề &aacute;n n&agrave;y.</p>

<p>&quot;Điều n&agrave;y c&oacute; thể tạo ra sự lo lắng trong đội ngũ gi&aacute;o vi&ecirc;n, nhất l&agrave; trong bối cảnh đ&ocirc;ng đảo đội ngũ gi&aacute;o vi&ecirc;n v&agrave; dư luận x&atilde; hội đều mong muốn lương của nh&agrave; gi&aacute;o sẽ được tăng l&ecirc;n khi ch&uacute;ng t&ocirc;i xin &yacute; kiến về dự thảo Luật sửa đổi, bổ sung một số điều của Luật Gi&aacute;o dục&quot;, Bộ trưởng Bộ GD&amp;ĐT cho biết.</p>

<p>Khẳng định đội ngũ nh&agrave; gi&aacute;o c&oacute; vai tr&ograve; đặc biệt quan trọng trong qu&aacute; tr&igrave;nh đổi mới căn bản, to&agrave;n diện GD&amp;ĐT, theo Bộ trưởng Ph&ugrave;ng Xu&acirc;n Nhạ, ngo&agrave;i việc đ&aacute;p ứng c&aacute;c y&ecirc;u cầu chung của c&ocirc;ng việc,&nbsp;<strong>gi&aacute;o vi&ecirc;n cần được động vi&ecirc;n để gắn b&oacute;, t&acirc;m huyết với nghề, ph&aacute;t huy sự s&aacute;ng tạo, đổi mới trong qu&aacute; tr&igrave;nh dạy học.</strong></p>

<p>Đặc biệt,&nbsp;<strong>cần động vi&ecirc;n xứng đ&aacute;ng đội ngũ gi&aacute;o vi&ecirc;n mầm non, phổ th&ocirc;ng c&ocirc;ng t&aacute;c ở v&ugrave;ng c&oacute; điều kiện kinh tế - x&atilde; hội đặc biệt kh&oacute; khăn, c&aacute;c điểm trường lẻ ở th&ocirc;n/bản xa x&ocirc;i, hẻo l&aacute;nh</strong>. Gi&aacute;o vi&ecirc;n nơi đ&acirc;y kh&ocirc;ng chỉ thực hiện nhiệm vụ giảng dạy, m&agrave; nhiều trường hợp c&ograve;n như những người cha, người mẹ chăm s&oacute;c học sinh, đem con chữ đến với đồng b&agrave;o ở những v&ugrave;ng kh&oacute; khăn nhất.</p>

<p>B&ecirc;n cạnh đ&oacute;, hiện nay, c&oacute; rất &iacute;t học sinh giỏi muốn v&agrave;o ng&agrave;nh sư phạm, v&igrave; vậy&nbsp;<strong>cần c&oacute; ch&iacute;nh s&aacute;ch thu h&uacute;t, tạo động lực cho đội ngũ gi&aacute;o vi&ecirc;n, trước hết l&agrave; c&aacute;c ch&iacute;nh s&aacute;ch về lương, thưởng</strong>.</p>

<p>Ch&iacute;nh v&igrave; vậy,&nbsp;<strong>Bộ trưởng đề nghị Trung ương xem x&eacute;t c&oacute; ch&iacute;nh s&aacute;ch lương/phụ cấp đặc th&ugrave; đối với đội ngũ gi&aacute;o vi&ecirc;n</strong>, trong đ&oacute; quy định&nbsp;<strong>gi&aacute;o vi&ecirc;n thuộc trường hợp c&oacute; phụ cấp cao hơn 30% theo quy định của Đề &aacute;n&nbsp;v&agrave; nằm trong nh&oacute;m c&oacute; lương v&agrave; phụ cấp ở mức cao trong khối c&aacute;c đơn vị h&agrave;nh ch&iacute;nh sự nghiệp</strong>.</p>

<h2>Những &yacute; kiến thảo luận s&acirc;u sắc về&nbsp;Đề &aacute;n cải c&aacute;ch ch&iacute;nh s&aacute;ch tiền lương</h2>

<p>&nbsp;</p>

<p><img alt="Toàn cảnh phiên thảo luận Đề án cải cách chính sách tiền lương. Ảnh: TTXVN" src="https://i.bigschool.vn/w/a04723/640/News/images/2018/05/Screen_Shot_2018-05-11_at_8.06.04_CH/Toan-canh-phien-thao-luan-De-an-cai-cach-chinh-sach-tien-luong-Anh-TTXVN.png" title="Toàn cảnh phiên thảo luận Đề án cải cách chính sách tiền lương. Ảnh: TTXVN" />To&agrave;n cảnh phi&ecirc;n thảo luận Đề &aacute;n cải c&aacute;ch ch&iacute;nh s&aacute;ch tiền lương. Ảnh: TTXVN</p>

<p><br />
Đồng ch&iacute; Nguyễn Thị Kim Ng&acirc;n, Ủy vi&ecirc;n Bộ Ch&iacute;nh trị, Chủ tịch Quốc hội thay mặt Bộ Ch&iacute;nh trị điều h&agrave;nh phi&ecirc;n thảo luận.&nbsp;<br />
Ph&aacute;t biểu tại Hội nghị, c&aacute;c đồng ch&iacute; Ủy vi&ecirc;n Trung ương b&agrave;y tỏ nhất tr&iacute; cao với mục ti&ecirc;u, nhiệm vụ v&agrave; giải ph&aacute;p cải c&aacute;ch ch&iacute;nh s&aacute;ch tiền lương được x&aacute;c định trong Đề &aacute;n; nhất tr&iacute; cao việc ban h&agrave;nh Nghị quyết của Trung ương về vấn đề n&agrave;y.&nbsp;<br />
C&aacute;c &yacute; kiến ph&aacute;t biểu đ&aacute;nh gi&aacute; cao việc chuẩn bị Đề &aacute;n cải c&aacute;ch ch&iacute;nh s&aacute;ch tiền lương được chuẩn bị c&ocirc;ng phu, kỹ lưỡng, khoa học, to&agrave;n diện, kh&aacute;ch quan, c&aacute;c giải ph&aacute;p c&oacute; t&iacute;nh khả thi cao. Đề &aacute;n đ&atilde; x&aacute;c định mục ti&ecirc;u tổng qu&aacute;t v&agrave; c&aacute;c mục ti&ecirc;u cụ thể của việc cải c&aacute;ch ch&iacute;nh s&aacute;ch tiền lương trong từng giai đoạn: 2018 &ndash; 2020; 2021 - 2025 v&agrave; tầm nh&igrave;n đến năm 2030, đối với khu vực c&ocirc;ng v&agrave; khu vực doanh nghiệp. Đa số đại biểu nhấn mạnh ch&iacute;nh s&aacute;ch tiền lương l&agrave;m một bộ phận quan trọng, c&oacute; quan hệ chặt chẽ với c&aacute;c ch&iacute;nh s&aacute;ch kh&aacute;c trong hệ thống ch&iacute;nh s&aacute;ch.&nbsp;<br />
Trong Đề &aacute;n đ&atilde; đưa ra vấn đề huy động nguồn lực, tinh giản bi&ecirc;n chế, tiết kiệm&hellip; nhưng theo đại biểu hai vấn đề quan trọng nhất l&agrave; nguồn lực v&agrave; tinh giản bộ m&aacute;y, bi&ecirc;n chế.&nbsp;<br />
Bảng lương ưu ti&ecirc;n cho c&ocirc;ng chức, vi&ecirc;n chức, chuy&ecirc;n gia c&oacute; tr&igrave;nh độ cao; c&ocirc;ng chức vi&ecirc;n chức chuy&ecirc;n gia giỏi lương sẽ cao hơn l&atilde;nh đạo quản l&yacute;. Điều n&agrave;y cần phải l&agrave;m tốt c&ocirc;ng t&aacute;c tư tưởng v&agrave; x&aacute;c định thay đổi t&acirc;m l&yacute; l&atilde;nh đạo l&agrave; lương lu&ocirc;n lu&ocirc;n cao hơn mọi người.<br />
Tuy đ&atilde; t&iacute;nh to&aacute;n nguồn lực cải c&aacute;ch tiền lương với tinh thần t&iacute;ch cực nhất, nhưng so với nhu cầu để thực hiện cải c&aacute;ch ch&iacute;nh s&aacute;ch tiền lương theo dự thảo Đề &aacute;n vẫn c&ograve;n c&oacute; khoảng c&aacute;ch.&nbsp;<br />
Chủ tịch Tổng Li&ecirc;n đo&agrave;n Lao động Việt Nam đề nghị hướng thiết kế thang lương theo c&aacute;c bậc lương nửa đầu lũy tiến v&agrave; nửa sau lũy tho&aacute;i. Việc thiết kế nửa sau lũy tho&aacute;i vẫn đảm bảo được ch&iacute;nh s&aacute;ch tiền lương đối với c&aacute;n bộ, c&ocirc;ng chức c&oacute; th&acirc;m nhi&ecirc;n, năng lực th&ocirc;ng qua ch&iacute;nh s&aacute;ch lương linh hoạt đ&atilde; n&ecirc;u trong Đề &aacute;n.&nbsp;<br />
Chi tiết hơn về c&aacute;c &yacute; kiến, xin c&aacute;c bạn xem th&ecirc;m&nbsp;<strong><a href="https://baotintuc.vn/thoi-su/hoi-nghi-trung-uong-7-khoa-xii-thao-luan-sau-sac-de-an-cai-cach-chinh-sach-tien-luong-20180509204052844.htm" rel="noopener noreferrer" target="_blank">tại đ&acirc;y</a></strong>.<br />
<br />
<em>Nguồn Bộ GD&amp;ĐT v&agrave; TTXVN</em>.</p>
</div>
', 1, 5, CAST(N'2016-04-03 00:00:00.000' AS DateTime), 3, CAST(N'2018-05-14' AS Date))
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, 0, N'Vĩnh biệt Giáo sư Phan Đình Diệu! Người tiên phong xây dựng và phát triển Tin học Việt Nam!', N'/Uploads/CKFinder/images/Blog/Vien-truong-Tran-Dai-Nghia-cung-cac-Pho-Vien-truong-Vien-Khoa-hoc-Viet-Nam-Nguyen-Van-Dao-Nguyen-Van-Hieu-Phan-Dinh-Dieu-nhan-dip-ky-niem-80-nam-sinh-nhat-GS-Tran-Dai-Nghia-1993.png', N'Không nhận được nhiều sự kỳ vọng từ khi công bố dự án, nhưng thành công nhất định trong mùa hè vừa qua của The angry birds Movie đã khiến những nhà sản xuất tự tin làm tiếp phần 2 cho ‘Những chú chim giận dữ‘.', 10, 1, N'<div style="text-align:center">
<p>Nh&agrave; khoa học lớn Phan Đ&igrave;nh Diệu đ&atilde; vĩnh biệt ch&uacute;ng ta hồi 10h00 ng&agrave;y 13/5/2018. Từ trưa ng&agrave;y h&ocirc;m qua (13/5/2018) đ&atilde; c&oacute; tin về việc n&agrave;y. Nhưng đến tối, khi GS Phan Dương Hiệu con của GS Phan Đ&igrave;nh Diệu đưa th&ocirc;ng tin ch&iacute;nh thức, ch&uacute;ng t&ocirc;i mới tin l&agrave; sự thật!</p>

<h2>Th&ocirc;ng tin ch&iacute;nh thức từ gia đ&igrave;nh v&agrave; tiểu sử t&oacute;m tắt của GS Phan Đ&igrave;nh Diệu</h2>

<p>Tr&ecirc;n trang c&aacute; nh&acirc;n của m&igrave;nh, GS Phan Dương Hiệu chia sẻ bức ảnh với d&ograve;ng chữ &quot;Bố lu&ocirc;n ở b&ecirc;n mẹ v&agrave; ch&uacute;ng con.&quot;</p>

<p><img alt="Thông tin chính thức từ gia đình GS Phan Đình Diệu" src="https://i.bigschool.vn/w/deb629/450/News/images/2018/05/Screen_Shot_2018-05-14_at_7.43.14_SA/Thong-tin-chinh-thuc-tu-gia-dinh-GS-Phan-Dinh-Dieu.png" title="Thông tin chính thức từ gia đình GS Phan Đình Diệu" />Th&ocirc;ng tin ch&iacute;nh thức từ gia đ&igrave;nh GS Phan Đ&igrave;nh Diệu</p>

<p><br />
GS Phan Đ&igrave;nh Diệu&nbsp;sinh ng&agrave;y 12 th&aacute;ng 6 năm 1936, lớn l&ecirc;n tại huyện Can Lộc, tỉnh H&agrave; Tĩnh.&nbsp;Năm 1954, &ocirc;ng tốt nghiệp trung học tại trường kh&aacute;ng chiến Phan Đ&igrave;nh Ph&ugrave;ng - H&agrave; Tĩnh, ra H&agrave; Nội thi v&agrave;o trường Đại học Khoa học.&nbsp;Hết năm thứ nhất, &ocirc;ng chọn trường Đại học Sư phạm Khoa học. Cũng ch&iacute;nh tại đ&acirc;y, Phan Đ&igrave;nh Diệu đ&atilde; t&igrave;m thấy sự say m&ecirc; đối với ng&agrave;nh to&aacute;n học. Năm 1957, &ocirc;ng tốt nghiệp thủ khoa v&agrave; được giữ lại trường l&agrave;m c&aacute;n bộ giảng dạy.<br />
Năm 1962, &ocirc;ng được cử đi Li&ecirc;n X&ocirc; l&agrave;m nghi&ecirc;n cứu sinh tại Khoa To&aacute;n học t&iacute;nh to&aacute;n v&agrave; Điều khiển học, trường Đại học Tổng hợp quốc gia Moskva mang t&ecirc;n Lomonosov.<br />
M&ugrave;a h&egrave; năm 1965, sau khi ho&agrave;n th&agrave;nh luận &aacute;n tiến sĩ, &ocirc;ng được đề nghị ở lại l&agrave;m tiếp luận &aacute;n tiến sĩ khoa học v&agrave; đến năm 1967, &ocirc;ng về nước với học vị Tiến sĩ Khoa học.</p>

<p><img alt="Hai vợ chồng GS Phan Đình Diệu (vợ là bà Văn Thị Xuân Hương, em gái của thầy Văn Như Cương)" src="https://i.bigschool.vn/w/878b22/640/News/images/2018/05/Screen_Shot_2018-05-14_at_8.20.54_SA/Hai-vo-chong-GS-Phan-Dinh-Dieu-vo-la-ba-Van-Thi-Xuan-Huong-em-gai-cua-thay-Van-Nhu-Cuong.png" title="Hai vợ chồng GS Phan Đình Diệu (vợ là bà Văn Thị Xuân Hương, em gái của thầy Văn Như Cương)" />Hai vợ chồng GS Phan Đ&igrave;nh Diệu (vợ l&agrave; b&agrave; Văn Thị Xu&acirc;n Hương, em g&aacute;i của thầy Văn Như Cương)</p>

<p><br />
&Ocirc;ng được cử đến c&ocirc;ng t&aacute;c tại Uỷ ban Khoa học Nh&agrave; nước, bộ phận m&aacute;y t&iacute;nh, c&ugrave;ng c&aacute;c bạn đồng nghiệp kh&aacute;c x&acirc;y dựng ph&ograve;ng To&aacute;n học t&iacute;nh to&aacute;n vừa được th&agrave;nh lập.<br />
Năm 1975, trong một chuyến thực tập tại Ph&aacute;p, &ocirc;ng đ&atilde; được tiếp x&uacute;c với nhiều th&agrave;nh tựu hiện đại của ng&agrave;nh tin học tr&ecirc;n thế giới. Từ đ&oacute;, &ocirc;ng đ&atilde; say m&ecirc; t&igrave;m hiểu hai hướng ph&aacute;t triển m&agrave; &ocirc;ng cho l&agrave; c&oacute; triển vọng nhất v&agrave; c&oacute; thể ứng dụng v&agrave; ph&aacute;t triển ở Việt Nam l&agrave; vi tin học (tr&ecirc;n cơ sở kỹ thuật vi xử l&yacute; v&agrave; m&aacute;y vi t&iacute;nh) v&agrave; viễn tin học (tr&ecirc;n cơ sở c&ocirc;ng nghệ viễn th&ocirc;ng v&agrave; mạng m&aacute;y t&iacute;nh).<br />
Đầu năm 1977, Viện Khoa học t&iacute;nh to&aacute;n v&agrave; điều khiển được ch&iacute;nh thức th&agrave;nh lập, v&agrave; &ocirc;ng được ph&acirc;n c&ocirc;ng l&agrave;m viện trưởng. L&agrave; người dự thảo kế hoạch v&agrave; cũng l&agrave; người quản l&yacute;, từ năm 1977 đến 1985, &ocirc;ng đ&atilde; đưa viện vượt qua nhiều kh&oacute; khăn, trở ngại của buổi đầu hoạt động, x&acirc;y dựng được một số hướng nghi&ecirc;n cứu ch&iacute;nh về tin học.</p>

<p><img alt="GS Phan Đình Diệu với cố Thủ tướng Phạm Văn Đồng và một số nhà khoa học lớn" src="https://i.bigschool.vn/w/46216b/640/News/images/2018/05/Screen_Shot_2018-05-13_at_8.43.45_CH/GS-Phan-Dinh-Dieu-voi-co-Thu-tuong-Pham-Van-Dong-va-mot-so-nha-khoa-hoc-lon.png" title="GS Phan Đình Diệu với cố Thủ tướng Phạm Văn Đồng và một số nhà khoa học lớn" />GS Phan Đ&igrave;nh Diệu với cố Thủ tướng Phạm Văn Đồng v&agrave; một số nh&agrave; khoa học lớn</p>

<p><br />
Sau đ&oacute;, &ocirc;ng l&agrave;m Ph&oacute; Viện trưởng Viện Khoa học Việt Nam (nay l&agrave; Viện Khoa học v&agrave; C&ocirc;ng nghệ Việt Nam), Ph&oacute; trưởng thường trực Ban chỉ đạo Chương tr&igrave;nh quốc gia về c&ocirc;ng nghệ th&ocirc;ng tin (1993-1997), Th&agrave;nh vi&ecirc;n Hội đồng Ch&iacute;nh s&aacute;ch Khoa học v&agrave; C&ocirc;ng nghệ Quốc gia Việt Nam (từ năm 1992).<br />
&Ocirc;ng c&ograve;n l&agrave; người s&aacute;ng lập v&agrave; Chủ tịch đầu ti&ecirc;n Hội Tin học Việt Nam.</p>

<p><img alt="Viện trưởng Trần Đại Nghĩa cùng các Phó Viện trưởng Viện Khoa học Việt Nam: Nguyễn Văn Đạo, Nguyễn Văn Hiệu, Phan Đình Diệu (nhân dịp kỷ niệm 80 năm sinh nhật GS. Trần Đại Nghĩa-1993)" src="https://i.bigschool.vn/w/93ffcf/640/News/images/2018/05/Screen_Shot_2018-05-14_at_11.19.35_SA/Vien-truong-Tran-Dai-Nghia-cung-cac-Pho-Vien-truong-Vien-Khoa-hoc-Viet-Nam-Nguyen-Van-Dao-Nguyen-Van-Hieu-Phan-Dinh-Dieu-nhan-dip-ky-niem-80-nam-sinh-nhat-GS-Tran-Dai-Nghia-1993.png" title="Viện trưởng Trần Đại Nghĩa cùng các Phó Viện trưởng Viện Khoa học Việt Nam: Nguyễn Văn Đạo, Nguyễn Văn Hiệu, Phan Đình Diệu (nhân dịp kỷ niệm 80 năm sinh nhật GS. Trần Đại Nghĩa-1993)" />Viện trưởng Trần Đại Nghĩa c&ugrave;ng c&aacute;c Ph&oacute; Viện trưởng Viện Khoa học Việt Nam: Nguyễn Văn Đạo, Nguyễn Văn Hiệu, Phan Đ&igrave;nh Diệu (nh&acirc;n dịp kỷ niệm 80 năm sinh nhật GS. Trần Đại Nghĩa-1993)</p>

<p><br />
&Ocirc;ng cũng nguy&ecirc;n l&agrave; Ủy vi&ecirc;n Đo&agrave;n Chủ tịch Mặt trận Tổ quốc Việt Nam, Chủ nhiệm Hội đồng Tư vấn về khoa học gi&aacute;o dục, đại biểu Quốc hội kho&aacute; V, kho&aacute; VI khi hơn 40 tuổi.<br />
GS Phan Đ&igrave;nh Diệu l&agrave; một người thầy t&acirc;m huyết với gi&aacute;o dục, l&agrave; người c&oacute; c&ocirc;ng lao to lớn trong việc x&acirc;y dựng v&agrave; ph&aacute;t triển ng&agrave;nh Tin học Việt Nam.<br />
Gia đ&igrave;nh GS Phan Đ&igrave;nh Diệu v&agrave; b&agrave; Văn Thu Hương c&oacute; 3 người con l&agrave; Phan Dương Hiệu (Dương Hiệu l&agrave; c&aacute;ch n&oacute;i l&aacute;i của t&ecirc;n hai vợ chồng Diệu Hương), Phan Thị Quỳnh Dương v&agrave; Phan Thị H&agrave; Dương, trong đ&oacute; GS Phan Dương Hiệu, PGS Phan Thị H&agrave; Dương, l&agrave; những nh&agrave; to&aacute;n học sớm đạt được nhiều th&agrave;nh tựu từ khi c&ograve;n trẻ.</p>

<p><img alt="Gia đình Hạnh phúc và Thành đạt của GS Phan Đình Diệu" src="https://i.bigschool.vn/w/89271f/640/News/images/2018/05/Screen_Shot_2018-05-14_at_8.36.08_SA/Gia-dinh-Hanh-phuc-va-Thanh-dat-cua-GS-Phan-Dinh-Dieu.png" title="Gia đình Hạnh phúc và Thành đạt của GS Phan Đình Diệu" />Gia đ&igrave;nh Hạnh ph&uacute;c v&agrave; Th&agrave;nh đạt của GS Phan Đ&igrave;nh Diệu</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<h2>Tin buồn của ĐHQG H&agrave; Nội, Viện H&agrave;n l&acirc;m Khoa học &amp; C&ocirc;ng nghệ Việt Nam v&agrave; Gia đ&igrave;nh</h2>

<p><img alt="Vĩnh biệt Giáo sư Phan Đình Diệu! Người tiên phong xây dựng và phát triển Tin học Việt Nam!" src="https://i.bigschool.vn/w/c417ef/700/News/images/2018/05/32471962_10214458546154256_4950991290964639744_o/Gia-dinh-Hanh-phuc-va-Thanh-dat-cua-GS-Phan-Dinh-Dieu.jpg" style="width:700px" title="Vĩnh biệt Giáo sư Phan Đình Diệu! Người tiên phong xây dựng và phát triển Tin học Việt Nam!" /></p>

<h2>GS Phan Đ&igrave;nh Diệu trả lời phỏng vấn về dạy v&agrave; học năm 2009</h2>

<p>&nbsp;</p>

<p><img alt="Hai vợ chồng GS Phan Đình Diệu năm 2009. Ảnh: báo Tuổi trẻ" src="https://i.bigschool.vn/w/b8f344/400/News/images/2018/05/Screen_Shot_2018-05-13_at_8.23.04_CH/Hai-vo-chong-GS-Phan-Dinh-Dieu-nam-2009-Anh-bao-Tuoi-tre.png" title="Hai vợ chồng GS Phan Đình Diệu năm 2009. Ảnh: báo Tuổi trẻ" />Hai vợ chồng GS Phan Đ&igrave;nh Diệu năm 2009. Ảnh: b&aacute;o Tuổi trẻ</p>

<p><br />
Từ năm 2009, b&aacute;o Tuổi trẻ đ&atilde; đăng b&agrave;i trả lời phỏng vấn của GS Phan Đ&igrave;nh Diệu:<br />
<br />
* Thưa gi&aacute;o sư, hơn nửa thế kỷ dạy đại học, &ocirc;ng c&oacute; nhận x&eacute;t g&igrave; về c&aacute;c bạn trẻ sinh vi&ecirc;n?</p>

<p>&nbsp;</p>

<p><strong>GS Phan Đ&igrave;nh Diệu:</strong>&nbsp;C&oacute; nhiều em giỏi, tư chất th&ocirc;ng minh, l&agrave;m nghi&ecirc;n cứu được.</p>

<p>* C&ograve;n điểm yếu của họ?</p>

<p><strong>GS Phan Đ&igrave;nh Diệu:&nbsp;</strong>T&iacute;nh chủ động, độc lập yếu. Tự m&igrave;nh t&igrave;m t&ograve;i, tự suy nghĩ, t&igrave;m kiếm &yacute; tưởng c&ograve;n yếu. Chỉ mới l&agrave;m theo phận sự thầy gi&aacute;o giao, c&ograve;n tự suy nghĩ t&igrave;m vấn đề mới th&igrave; yếu. Rất dễ hiểu v&igrave; nếp dạy của m&igrave;nh thế.</p>

<p>* Thưa, b&acirc;y giờ ai cũng n&oacute;i nhiều về điều đ&oacute; nhưng kh&ocirc;ng biết sửa như thế n&agrave;o?</p>

<p><strong>GS Phan Đ&igrave;nh Diệu:&nbsp;</strong>Đ&uacute;ng l&agrave; ta n&oacute;i nhiều: phải dạy học tr&ograve; tư duy s&aacute;ng tạo. Nhưng thế n&agrave;o l&agrave; tư duy s&aacute;ng tạo th&igrave; chưa bao giờ c&oacute; sự trao đổi giữa thầy v&agrave; tr&ograve; để truyền thụ kinh nghiệm v&agrave; những tố chất ấy cho học tr&ograve; n&ecirc;n căn bản vẫn l&agrave; tiếp thu kiến thức một c&aacute;ch thụ động. Khả năng tiếp thu tốt nhưng từ tiếp thu tốt tới s&aacute;ng tạo l&agrave; một qu&aacute; tr&igrave;nh, đ&ograve;i hỏi phải được r&egrave;n luyện. Gi&aacute;o dục ta n&oacute;i nhiều về y&ecirc;u cầu s&aacute;ng tạo, độc lập tư duy nhưng chương tr&igrave;nh học gần như chưa lồng gh&eacute;p những năng lực đ&oacute; cho học sinh. Đ&oacute; l&agrave; ở những m&ocirc;n khoa học. C&ograve;n khoa học x&atilde; hội lại yếu hơn nữa. Điều n&agrave;y cần c&oacute; trong nội dung cải c&aacute;ch gi&aacute;o dục, đổi mới gi&aacute;o dục trong thời gian tới.</p>

<p>* Cụ thể như thế n&agrave;o, thưa gi&aacute;o sư?</p>

<p><strong>GS Phan Đ&igrave;nh Diệu:&nbsp;</strong>Năng lực s&aacute;ng tạo, tư duy s&aacute;ng tạo, tư duy ph&ecirc; ph&aacute;n... tất cả đều c&oacute; b&agrave;i bản, l&yacute; luận của n&oacute;. Trước hết &ocirc;ng thầy phải được học. Phải ch&uacute; &yacute; bồi dưỡng gi&aacute;o vi&ecirc;n năng lực ấy trước ti&ecirc;n. Nhiều nước tr&ecirc;n thế giới c&oacute; gi&aacute;o tr&igrave;nh dạy tư duy ph&ecirc; ph&aacute;n, đổi mới s&aacute;ng tạo cho con người, tư duy độc lập, tư duy s&aacute;ng tạo... Thầy m&igrave;nh kh&ocirc;ng được học thế bao giờ, m&agrave; cũng kh&ocirc;ng c&oacute; điều kiện tự học những thứ đ&oacute;. Muốn đại tr&agrave; phải học kinh nghiệm c&aacute;c nước ti&ecirc;n tiến đ&agrave;o tạo từ gi&aacute;o vi&ecirc;n. Gi&aacute;o vi&ecirc;n sẽ chủ động thực hiện được.</p>

<p>* Gi&aacute;o sư c&oacute; lời khuy&ecirc;n n&agrave;o với người trẻ tuổi c&oacute; kh&aacute;t vọng trở n&ecirc;n giỏi giang v&agrave; t&agrave;i năng?</p>

<p><strong>GS Phan Đ&igrave;nh Diệu:&nbsp;</strong>T&ocirc;i kh&ocirc;ng c&oacute; g&igrave; ở bản th&acirc;n để khuy&ecirc;n cả.</p>

<p>* Nhưng l&agrave; một người thầy, gi&aacute;o sư c&oacute; thể n&oacute;i với học tr&ograve; của m&igrave;nh chứ?</p>

<p><strong>GS Phan Đ&igrave;nh Diệu:&nbsp;</strong>Theo t&ocirc;i nghĩ, tự mỗi người qua kinh nghiệm của m&igrave;nh tạo ra c&aacute;ch l&agrave;m cho m&igrave;nh c&oacute; năng lực n&agrave;o đấy. Th&iacute; dụ, c&oacute; thể khuy&ecirc;n g&igrave; với người đang kh&aacute;t khao t&igrave;m t&ograve;i kiến thức?</p>

<p>Kh&ocirc;ng bao giờ xem c&aacute;i đ&atilde; học l&agrave; đủ rồi. Lu&ocirc;n nghĩ rằng b&ecirc;n cạnh c&aacute;i biết rồi c&ograve;n những điều chưa biết, chưa được học. Ngay trong học khoa học, t&ocirc;i đ&atilde; c&oacute; ch&uacute;t m&aacute;u &quot;nổi loạn&quot; rồi. Học to&aacute;n đại học nhưng khi học kiến thức t&ocirc;i kh&ocirc;ng nghĩ đ&oacute; l&agrave; ch&acirc;n l&yacute; duy nhất, chưa hẳn lu&ocirc;n lu&ocirc;n đ&uacute;ng. Chắc c&oacute; khoa học, l&yacute; thuyết kh&aacute;c điều m&igrave;nh đ&atilde; học, thậm ch&iacute; ngược lại. Do đ&oacute; phải t&igrave;m hiểu điều đ&oacute; c&oacute; kh&ocirc;ng, n&oacute; ở đ&acirc;u, t&igrave;m n&oacute; băng c&aacute;ch n&agrave;o.</p>

<p>* Xin gi&aacute;o sư cho một v&iacute; dụ?</p>

<p><strong>GS Phan Đ&igrave;nh Diệu:&nbsp;</strong>Th&iacute; dụ trong to&aacute;n học, một m&ocirc;n khoa học ai cũng nghĩ tất nhi&ecirc;n 1+1=2, l&agrave; ch&acirc;n l&yacute;. Nhưng c&oacute; phải vậy kh&ocirc;ng. Hồi mới tốt nghiệp đại học t&ocirc;i đ&atilde; ho&agrave;i nghi chuyện ấy. Cũng như c&oacute; nhất thiết kh&ocirc;ng phải kh&ocirc;ng l&agrave; c&oacute; hay kh&ocirc;ng. T&ocirc;i ho&agrave;i nghi. C&oacute; ch&acirc;n l&yacute; n&agrave;o kh&aacute;c kh&ocirc;ng. Hay l&agrave; c&oacute; những ch&acirc;n l&yacute; kh&aacute;c nhau. T&ocirc;i kh&ocirc;ng tin c&aacute;i g&igrave; tuyệt đối cả. Điều n&agrave;y n&oacute; lẳng nhẳng theo t&ocirc;i hết địa hạt n&agrave;y đến địa hạt kh&aacute;c, hết lĩnh vực n&agrave;y sang lĩnh vực kh&aacute;c.</p>

<p>* Hiện gi&aacute;o sư đang t&igrave;m t&ograve;i nghi&ecirc;n cứu vấn đề g&igrave;?</p>

<p><strong>GS Phan Đ&igrave;nh Diệu:&nbsp;</strong>T&ocirc;i đang nghi&ecirc;n cứu về c&aacute;i phức tạp, khoa học về c&aacute;i phức tạp. Nhiều c&aacute;i hay t&ocirc;i học được ở người ta th&ocirc;i. C&aacute;i phức tạp kh&ocirc;ng thể nhận diện được ho&agrave;n to&agrave;n, kh&ocirc;ng r&otilde; r&agrave;ng, kh&ocirc;ng chắc chắn, kh&ocirc;ng m&ocirc; tả được đầy đủ. Con người kh&ocirc;ng bao giờ bất lực trước kh&oacute; khăn g&igrave;, nhưng đừng ảo tưởng l&agrave; hiểu đầy đủ. C&aacute;i phức tạp cũng đang l&agrave; đối tượng nghi&ecirc;n cứu của khoa học thế giới hiện nay.</p>

<p>* Những &yacute; tưởng, suy nghĩ mới n&agrave;y c&oacute; thể lồng v&agrave;o để hiểu c&aacute;c vấn đề đơn giản hơn trong gi&aacute;o dục, học h&agrave;nh như thế n&agrave;o?</p>

<p><strong>GS Phan Đ&igrave;nh Diệu:&nbsp;</strong>T&ocirc;i kh&ocirc;ng thuộc những người qu&aacute; bi quan về gi&aacute;o dục, nhưng cũng kh&ocirc;ng thuộc loại xem mọi sự tốt cả rồi. Gi&aacute;o dục l&agrave; cuộc đời. M&agrave; cuộc đời vốn phức tạp lắm. Dạy người ta sống trong cuộc đời, nhiều y&ecirc;u cầu, nhiều mẫu h&igrave;nh. Kh&ocirc;ng theo mẫu. Đừng bắt. Họ phải theo những g&igrave; họ được thuyết phục. Tự m&igrave;nh đ&aacute;nh gi&aacute;, x&aacute;c định. Đ&oacute; l&agrave; một trong những c&aacute;ch để trưởng th&agrave;nh.<br />
<br />
* Xin cảm ơn gi&aacute;o sư!</p>
</div>
', 1, 5, CAST(N'2018-01-04 00:00:00.000' AS DateTime), 3, CAST(N'2018-05-14' AS Date))
INSERT [dbo].[CmsBlog] ([Id], [TypeId], [Name], [Image], [Title], [NumberView], [Orders], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, 0, N'Olympic Vật lí Châu Á lần thứ 19 (AphO 2018): Việt Nam giành 4 Huy chương Vàng', N'/Uploads/CKFinder/images/Blog/Thu-truong-Nguyen-Huu-Do-Chu-tich-APhO-Leong-Chuan-Kwek-Hieu-truong-DHBK-HN-Hoang-Minh-Son-voi-33-hoc-sinh-doat-Huy-chuong-Vang.png', N'Olympic Vật lí Châu Á lần thứ 19 (AphO 2018) được tổ chức tại Việt Nam từ ngày 05 đến ngày 13/5/2018 với sự tham gia của 185 học sinh, 48 lãnh đoàn và 29 quan sát viên đến từ 25 quốc gia và vùng lãnh thổ đã kết thúc tốt đẹp.', 0, 1, N'<p>Olympic Vật l&iacute; Ch&acirc;u &Aacute; lần thứ 19 (AphO 2018) được tổ chức tại Việt Nam từ ng&agrave;y 05 đến ng&agrave;y 13/5/2018 với sự tham gia của 185 học sinh, 48 l&atilde;nh đo&agrave;n v&agrave; 29 quan s&aacute;t vi&ecirc;n đến từ 25 quốc gia v&agrave; v&ugrave;ng l&atilde;nh thổ đ&atilde; kết th&uacute;c tốt đẹp.</p>

<ul>
	<li>&nbsp;<a href="https://bigschool.vn/khai-mac-ky-thi-olympic-vat-ly-chau-a-lan-thu-19-apho-2018">Khai mạc Kỳ thi Olympic Vật l&yacute; Ch&acirc;u &Aacute; lần thứ 19 (AphO 2018)</a></li>
</ul>

<p>&nbsp;</p>

<p><img alt="Thứ trưởng Nguyễn Hữu Độ, Chủ tịch APhO Leong Chuan Kwek, Hiệu trưởng ĐHBK HN Hoàng Minh Sơn với 33 học sinh đoạt Huy chương Vàng" src="https://i.bigschool.vn/w/148741/700/News/images/2018/05/Screen_Shot_2018-05-13_at_7.46.04_CH/Thu-truong-Nguyen-Huu-Do-Chu-tich-APhO-Leong-Chuan-Kwek-Hieu-truong-DHBK-HN-Hoang-Minh-Son-voi-33-hoc-sinh-doat-Huy-chuong-Vang.png" title="Thứ trưởng Nguyễn Hữu Độ, Chủ tịch APhO Leong Chuan Kwek, Hiệu trưởng ĐHBK HN Hoàng Minh Sơn với 33 học sinh đoạt Huy chương Vàng" />Thứ trưởng Nguyễn Hữu Độ, Chủ tịch APhO Leong Chuan Kwek, Hiệu trưởng ĐHBK HN Ho&agrave;ng Minh Sơn với 33 học sinh đoạt Huy chương V&agrave;ng</p>

<p><br />
Đội tuyển quốc gia Việt Nam gồm 08 th&iacute; sinh dự thi; kết quả 8/8 th&iacute; sinh đoạt giải, gồm: 04 Huy chương Vàng, 02 Huy chương Bạc, 02 Huy chương Đồng. Đ&acirc;y l&agrave; kết quả tốt nhất trong c&aacute;c lần tham dự AphO của học sinh Việt Nam.<br />
C&aacute;c học sinh đoạt Huy chương V&agrave;ng gồm:&nbsp;<br />
1. Em Trần Đức Huy, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n H&agrave; Nội - Amsterdam;<br />
2. Em Nguyễn Ngọc Long, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Lam Sơn, tỉnh Thanh H&oacute;a;<br />
3. Em Nguyễn Văn Th&agrave;nh Lợi, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Quang Trung, tỉnh B&igrave;nh Phước;<br />
4. Em Trịnh Duy Hiếu, học sinh lớp 11, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Bắc Giang, tỉnh Bắc Giang.</p>

<p><img alt="Thứ trưởng Nguyễn Hữu Độ và Chủ tịch APhO Leong Chuan Kwek trao tặng Huy chương Vàng cho em Trần Đức Huy" src="https://i.bigschool.vn/w/a77b6d/700/News/images/2018/05/Screen_Shot_2018-05-13_at_7.48.10_CH/Thu-truong-Nguyen-Huu-Do-va-Chu-tich-APhO-Leong-Chuan-Kwek-trao-tang-Huy-chuong-Vang-cho-em-Tran-Duc-Huy.png" title="Thứ trưởng Nguyễn Hữu Độ và Chủ tịch APhO Leong Chuan Kwek trao tặng Huy chương Vàng cho em Trần Đức Huy" />Thứ trưởng Nguyễn Hữu Độ v&agrave; Chủ tịch APhO Leong Chuan Kwek trao tặng Huy chương V&agrave;ng cho em Trần Đức Huy</p>

<p><br />
02 học sinh đoạt Huy chương bạc l&agrave;: Em Nguyễn Xu&acirc;n T&acirc;n, học sinh lớp 11, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Khoa học Tự&nbsp; nhi&ecirc;n, Đại học Quốc gia H&agrave; Nội v&agrave; em Nguyễn Văn Duy, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Đại học Sư phạm H&agrave; Nội. Em L&ecirc; Cao Anh, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Lam Sơn, tỉnh Thanh H&oacute;a v&agrave; em L&ecirc; Kỳ Nam, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n Hạ Long, Tỉnh Quảng Ninh đoạt Huy chương Đồng.</p>

<p>&nbsp;</p>

<p>Năm nay, Ban tổ chức APhO đ&atilde; trao 33 Huy chương V&agrave;ng, 13 Huy chương Bạc, 24 Huy chương Đồng v&agrave; 9 giải Đặc biệt cho c&aacute;c c&aacute; nh&acirc;n c&oacute; th&agrave;nh t&iacute;ch xuất sắc trong k&igrave; thi. &nbsp;Em Trần Đức Huy, học sinh lớp 12, Trường Trung học phổ th&ocirc;ng chuy&ecirc;n H&agrave; Nội - Amsterdam l&agrave; một trong 9 c&aacute; nh&acirc;n được giao giải Đặc biệt. C&oacute; 9 nước gi&agrave;nh được Huy chương V&agrave;ng gồm: Trung Quốc, Nga, Việt Nam, Đ&agrave;i Loan, Rumania, Ấn Độ, Singapor, Kazactan, Hồng K&ocirc;ng.</p>

<p><img alt="Em LAU Sze Chun, 13 tuổi (nhỏ tuổi nhất), đội tuyển Hồng Kông nhận Huy chương Đồng trong sự cổ vũ nồng nhiệt" src="https://i.bigschool.vn/w/c19f7b/700/News/images/2018/05/Screen_Shot_2018-05-13_at_7.51.06_CH/Em-LAU-Sze-Chun-13-tuoi-nho-tuoi-nhat-doi-tuyen-Hong-Kong-nhan-Huy-chuong-Dong-trong-su-co-vu-nong-nhiet.png" title="Em LAU Sze Chun, 13 tuổi (nhỏ tuổi nhất), đội tuyển Hồng Kông nhận Huy chương Đồng trong sự cổ vũ nồng nhiệt" />Em LAU Sze Chun, 13 tuổi (nhỏ tuổi nhất), đội tuyển Hồng K&ocirc;ng nhận Huy chương Đồng trong sự cổ vũ nồng nhiệt</p>

<p><br />
Chia sẻ về kết quả kỳ thi, PGS Ho&agrave;ng Minh Sơn - Hiệu trưởng Trường ĐH B&aacute;ch khoa H&agrave; Nội, Trưởng Ban Tổ chức APhO 2018 cho biết, kết quả kỳ thi năm nay cho thấy c&oacute; nhiều th&iacute; sinh đ&atilde; biết vận dụng một c&aacute;ch s&aacute;ng tạo c&aacute;c kiến thức vật l&iacute; v&agrave; c&aacute;c kĩ năng thực nghiệm để giải b&agrave;i thi v&agrave; do vậy đ&atilde; đạt được kết quả xuất sắc. T&ocirc;i đ&aacute;nh gi&aacute; cao sự nỗ lực, quyết t&acirc;m v&agrave; s&aacute;ng tạo của c&aacute;c t&agrave;i năng trẻ n&agrave;y. Ch&iacute;nh c&aacute;c em đ&atilde; g&oacute;p phần quan trọng trong việc tổ chức th&agrave;nh c&ocirc;ng của kỳ thi năm nay v&agrave; xứng đ&aacute;ng nhận được những lời ch&uacute;c mừng tốt đẹp nhất.<br />
Cũng tại buổi bế mạc, &ocirc;ng Leong Chuan Kwek - Chủ tịch APhO gửi lời cảm ơn tới Ch&iacute;nh phủ Việt Nam v&agrave; Trường ĐH B&aacute;ch khoa H&agrave; Nội - đơn vị chủ tr&igrave; đăng cai v&agrave; hỗ trợ nhiệt t&igrave;nh trong suốt thời gian k&igrave; thi diễn ra. &Ocirc;ng nhấn mạnh, việc đầu tư v&agrave;o sự kiện gi&aacute;o dục sẽ th&uacute;c đẩy Việt&nbsp; Nam tiến xa hơn trong việc ph&aacute;t triển kinh tế x&atilde; hội v&agrave; nền tảng khoa học trong tương lai. Đồng thời, gửi gắm tới to&agrave;n thể th&iacute; sinh tham dự kỳ thi th&ocirc;ng điệp &quot;d&ugrave; c&aacute;c bạn được bao nhi&ecirc;u điểm, kết quả của c&aacute;c bạn ra sao, c&aacute;c bạn l&agrave;m b&agrave;i như thế n&agrave;o, th&igrave; h&ocirc;m nay h&atilde;y gạt sang một b&ecirc;n. C&aacute;c bạn h&atilde;y giữ li&ecirc;n lạc với nhau v&agrave; tr&acirc;n trọng những kỉ niệm tuyệt vời trong 9 ng&agrave;y qua khi trở về qu&ecirc; hương&quot;.</p>

<p><img alt="Đại diện Việt Nam trao cờ đăng cai Olympic Vật lí Châu Á lần thứ 20 (AphO 2019) cho đại diện đến từ Australia" src="https://i.bigschool.vn/w/930a11/700/News/images/2018/05/Screen_Shot_2018-05-13_at_7.53.08_CH/Dai-dien-Viet-Nam-trao-co-dang-cai-Olympic-Vat-li-Chau-A-lan-thu-20-AphO-2019-cho-dai-dien-den-tu-Australia.png" title="Đại diện Việt Nam trao cờ đăng cai Olympic Vật lí Châu Á lần thứ 20 (AphO 2019) cho đại diện đến từ Australia" />Đại diện Việt Nam trao cờ đăng cai Olympic Vật l&iacute; Ch&acirc;u &Aacute; lần thứ 20 (AphO 2019) cho đại diện đến từ Australia</p>

<p><br />
Trải qua 9 ng&agrave;y tại Việt Nam, c&aacute;c đo&agrave;n dự thi v&agrave; những người tham gia đ&atilde; c&oacute; nhiều trải nghiệm với những hoạt động giao lưu văn h&oacute;a, văn nghệ, thể thao, tham quan, du lịch thuận lợi v&agrave; được bảo đảm an to&agrave;n. Với c&ocirc;ng t&aacute;c tổ chức nhiệt t&igrave;nh, chu đ&aacute;o, hiếu kh&aacute;ch của Ban tổ chức, c&aacute;c bạn b&egrave; quốc tế đ&atilde; c&oacute; những ấn tượng tốt đẹp về nước chủ nh&agrave;.</p>

<p>&nbsp;</p>

<p>Tại Lễ bế mạc, PGS Ho&agrave;ng Minh Sơn - Hiệu trưởng Trường ĐH B&aacute;ch khoa H&agrave; Nội, Trưởng Ban Tổ chức APhO 2018 đ&atilde; trao cờ đăng cai tổ chức Olympic Vật l&iacute; Ch&acirc;u &Aacute; lần thứ 20 (AphO 2019) cho đại diện đến từ Australia.</p>

<p><strong>Trung t&acirc;m Truyền th&ocirc;ng gi&aacute;o dục</strong></p>

<p><em>Nguồn: Bộ GD&amp;ĐT</em></p>
', 1, 3, CAST(N'2018-05-15 13:05:31.367' AS DateTime), NULL, NULL)
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
SET IDENTITY_INSERT [dbo].[Ex_Answer] ON 

INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (53, 14, N'Chuyển động của con lắc đồng hồ.', NULL, 1, 1, 3, CAST(N'2018-04-03 10:13:24.890' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (54, 14, N'Dao động của lá cây dưới tác dụng của gió', 1, 2, 1, 3, CAST(N'2018-04-03 10:13:24.890' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (55, 14, N'Chuyển động quay đều của cánh quạt ở quạt máy.', NULL, 3, 1, 3, CAST(N'2018-04-03 10:13:24.890' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (56, 14, N'Dao động của các phao nổi trên mặt biển.', NULL, 4, 1, 3, CAST(N'2018-04-03 10:13:24.890' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (57, 15, N'Số lần vật đi qua vị trí cân bằng trong một giây.', NULL, 1, 1, 3, CAST(N'2018-04-03 10:16:45.423' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (58, 15, N'Số dao động thực hiện được trong một khoảng thời gian xác định.', NULL, 2, 1, 3, CAST(N'2018-04-03 10:16:45.437' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (59, 15, N'Số chu kì thực hiện được trong một khoảng thời gian cho trước.', 1, 3, 1, 3, CAST(N'2018-04-03 10:16:45.437' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (60, 15, N'Nghịch đảo của chu kì.', NULL, 4, 1, 3, CAST(N'2018-04-03 10:16:45.437' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (77, 20, N' T = 60s; f = 120 Hz', NULL, 1, 1, 3, CAST(N'2018-04-03 10:23:55.640' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (78, 20, N'T = 0,5 s; f = 2 Hz', 1, 2, 1, 3, CAST(N'2018-04-03 10:23:55.640' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (79, 20, N' T = 2s; f = 0,5 Hz', NULL, 3, 1, 3, CAST(N'2018-04-03 10:23:55.640' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (80, 20, N'T = 0,5s; f = 4 Hz', NULL, 4, 1, 3, CAST(N'2018-04-03 10:23:55.640' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (81, 21, N'Biên độ A', 1, 1, 1, 3, CAST(N'2018-04-03 10:46:37.720' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (82, 21, N'Pha ban đầu', NULL, 2, 1, 3, CAST(N'2018-04-03 10:46:37.720' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (83, 21, N'Tần số góc', NULL, 3, 1, 3, CAST(N'2018-04-03 10:46:37.733' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (84, 21, N'Chu kì dao động T', NULL, 4, 1, 3, CAST(N'2018-04-03 10:46:37.733' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (89, 23, N' F luôn luôn ngược hướng với li độ.', 1, 1, 1, 3, CAST(N'2018-04-03 10:47:57.870' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (90, 23, N' F luôn luôn cùng chiều với vận tốc.', NULL, 2, 1, 3, CAST(N'2018-04-03 10:47:57.873' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (91, 23, N'F là một lực không đổi.', NULL, 3, 1, 3, CAST(N'2018-04-03 10:47:57.877' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (92, 23, N'F là lực có độ lớn thay đổi và chiều không đổi.', NULL, 4, 1, 3, CAST(N'2018-04-03 10:47:57.877' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (97, 25, N'Vật có chuyển động nhanh dần đều', 1, 1, 1, 3, CAST(N'2018-04-03 10:49:42.250' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (98, 25, N'Vật có chuyển động chậm dần đều.', NULL, 2, 1, 3, CAST(N'2018-04-03 10:49:42.250' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (99, 25, N'Gia tốc cùng hướng với chuyển động.', NULL, 3, 1, 3, CAST(N'2018-04-03 10:49:42.267' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (100, 25, N'Gia tốc a có độ lớn tăng dần.', NULL, 4, 1, 3, CAST(N'2018-04-03 10:49:42.267' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (109, 28, N'Độ lớn vận tốc cực đại và gia tốc bằng không.', 1, 1, 1, 3, CAST(N'2018-04-03 10:52:03.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (110, 28, N' Độ lớn gia tốc cực đại và vận tốc bằng không.', NULL, 2, 1, 3, CAST(N'2018-04-03 10:52:03.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (111, 28, N'Độ lớn gia tốc cực đại và vận tốc khác không', NULL, 3, 1, 3, CAST(N'2018-04-03 10:52:03.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (112, 28, N' Độ lớn gia tốc và vận tốc cực đại.', NULL, 4, 1, 3, CAST(N'2018-04-03 10:52:03.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (117, 30, N' Lực tác dụng đổi chiều', NULL, 1, 1, 3, CAST(N'2018-04-03 10:53:17.360' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (118, 30, N'Lực tác dụng bằng không', 1, 2, 1, 3, CAST(N'2018-04-03 10:53:17.360' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (119, 30, N'Lực tác dụng có độ lớn cực đại.', NULL, 3, 1, 3, CAST(N'2018-04-03 10:53:17.360' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (120, 30, N'Lực tác dụng có độ lớn cực tiểu.', NULL, 4, 1, 3, CAST(N'2018-04-03 10:53:17.360' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (121, 31, N'0.2', 1, 1, 1, 3, CAST(N'2018-04-03 10:53:45.313' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (122, 31, N'0.3', NULL, 2, 1, 3, CAST(N'2018-04-03 10:53:45.313' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (123, 31, N'0.4', NULL, 3, 1, 3, CAST(N'2018-04-03 10:53:45.313' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (124, 31, N'0.5', NULL, 4, 1, 3, CAST(N'2018-04-03 10:53:45.313' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (125, 32, N'0', 1, 1, 1, 3, CAST(N'2018-04-03 10:54:14.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (126, 32, N'1', NULL, 2, 1, 3, CAST(N'2018-04-03 10:54:14.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (127, 32, N'2', NULL, 3, 1, 3, CAST(N'2018-04-03 10:54:14.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (128, 32, N'4', NULL, 4, 1, 3, CAST(N'2018-04-03 10:54:14.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (129, 33, N'Đáp án 1', NULL, 1, 1, 3, CAST(N'2018-04-09 23:41:05.373' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (130, 33, N'Đáp án 2', 1, 2, 1, 3, CAST(N'2018-04-09 23:41:05.393' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (131, 33, N'Đáp án 3', NULL, 3, 1, 3, CAST(N'2018-04-09 23:41:05.393' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (132, 33, N'Đáp án 4', NULL, 4, 1, 3, CAST(N'2018-04-09 23:41:05.397' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (133, 34, N'Đáp án 1', NULL, 1, 1, 3, CAST(N'2018-04-09 23:41:05.397' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (134, 34, N'Đáp án 2', NULL, 2, 1, 3, CAST(N'2018-04-09 23:41:05.397' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (135, 34, N'Đáp án 3', 1, 3, 1, 3, CAST(N'2018-04-09 23:41:05.417' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (136, 34, N'Đáp án 4', NULL, 4, 1, 3, CAST(N'2018-04-09 23:41:05.433' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (145, 37, N'1', NULL, 1, 1, 10, CAST(N'2018-04-11 21:17:10.280' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (146, 37, N'2', 1, 2, 1, 10, CAST(N'2018-04-11 21:17:10.337' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (147, 37, N'3', NULL, 3, 1, 10, CAST(N'2018-04-11 21:17:10.403' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (148, 37, N'4', NULL, 4, 1, 10, CAST(N'2018-04-11 21:17:10.463' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (153, 39, N'Đáp án 1', NULL, 1, 1, 5, CAST(N'2018-04-12 09:42:45.210' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (154, 39, N'Đáp án 2', 1, 2, 1, 5, CAST(N'2018-04-12 09:42:45.213' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (155, 39, N'Đáp án 3', NULL, 3, 1, 5, CAST(N'2018-04-12 09:42:45.217' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (156, 39, N'Đáp án 4', NULL, 4, 1, 5, CAST(N'2018-04-12 09:42:45.217' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (157, 40, N'Chuyển động thẳng đều có giới hạn trong một đoạn thẳng.', 1, 1, 1, 3, CAST(N'2018-05-01 07:26:23.770' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (158, 40, N'Chuyển động qua lại một vị trí cố định và có giới hạn trong không gian.', NULL, 2, 1, 3, CAST(N'2018-05-01 07:26:23.773' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (159, 40, N'Chuyển động quanh một vị trí cố định và cách vị trí cố định một đoạn không đổi.', NULL, 3, 1, 3, CAST(N'2018-05-01 07:26:23.773' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (160, 40, N'Chuyển động thẳng biến đổi đều có giới hạn trong một đoạn thẳng.', NULL, 4, 1, 3, CAST(N'2018-05-01 07:26:23.777' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (161, 41, N'0.5', NULL, 1, 1, 3, CAST(N'2018-05-01 07:29:30.187' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (162, 41, N'1', NULL, 2, 1, 3, CAST(N'2018-05-01 07:29:30.190' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (163, 41, N'1.5', NULL, 3, 1, 3, CAST(N'2018-05-01 07:29:30.190' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (164, 41, N'2.5', 1, 4, 1, 3, CAST(N'2018-05-01 07:29:30.193' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (165, 42, N'1', NULL, 1, 1, 3, CAST(N'2018-05-01 07:30:12.030' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (166, 42, N'2', NULL, 2, 1, 3, CAST(N'2018-05-01 07:30:12.030' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (167, 42, N'3', 1, 3, 1, 3, CAST(N'2018-05-01 07:30:12.030' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (168, 42, N'4', NULL, 4, 1, 3, CAST(N'2018-05-01 07:30:12.037' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (169, 43, N'Đáp án 1', 1, 1, 1, 3, CAST(N'2018-05-01 07:30:27.280' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (170, 43, N'Đáp án 2', NULL, 2, 1, 3, CAST(N'2018-05-01 07:30:27.280' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (171, 43, N'Đáp án 3', NULL, 3, 1, 3, CAST(N'2018-05-01 07:30:27.280' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (172, 43, N'Đáp án 4', NULL, 4, 1, 3, CAST(N'2018-05-01 07:30:27.283' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (173, 44, N'Đáp án 1', 1, 1, 1, 3, CAST(N'2018-05-01 07:30:47.250' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (174, 44, N'Đáp án 2', NULL, 2, 1, 3, CAST(N'2018-05-01 07:30:47.253' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (175, 44, N'Đáp án 3', NULL, 3, 1, 3, CAST(N'2018-05-01 07:30:47.253' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (176, 44, N'Đáp án 4', NULL, 4, 1, 3, CAST(N'2018-05-01 07:30:47.257' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (177, 45, N'F có chiều luôn hướng về vị trí cân bằng.', 1, 1, 1, 3, CAST(N'2018-05-01 07:31:10.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (178, 45, N'F bằng không khi vận tốc của dao động bằng không.', NULL, 2, 1, 3, CAST(N'2018-05-01 07:31:10.003' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (179, 45, N'F biến thiên điều hòa cùng tần số với vận tốc của dao động.', NULL, 3, 1, 3, CAST(N'2018-05-01 07:31:10.007' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (180, 45, N'F biến thiên điều hòa cùng chu kì với li độ của dao động.', NULL, 4, 1, 3, CAST(N'2018-05-01 07:31:10.007' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (181, 46, N'Biên độ', NULL, 1, 1, 3, CAST(N'2018-05-01 07:31:20.140' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (182, 46, N'Tần số', 1, 2, 1, 3, CAST(N'2018-05-01 07:31:20.140' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (183, 46, N'Pha ban đầu', NULL, 3, 1, 3, CAST(N'2018-05-01 07:31:20.143' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (184, 46, N'Tấn số góc', NULL, 4, 1, 3, CAST(N'2018-05-01 07:31:20.143' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (185, 47, N'Dao động điều hòa là dao động tuần hoàn.', NULL, 1, 1, 3, CAST(N'2018-05-01 07:31:32.107' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (186, 47, N'Biên độ của dao động là giá trị cực đại của li độ.', NULL, 2, 1, 3, CAST(N'2018-05-01 07:31:32.107' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (187, 47, N'Vận tốc biến thiên cùng tần số với li độ', 1, 3, 1, 3, CAST(N'2018-05-01 07:31:32.110' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (188, 47, N' Dao động điều hòa có quỹ đạo là đường hình sin.', NULL, 4, 1, 3, CAST(N'2018-05-01 07:31:32.110' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (189, 48, N' Biến thiên cùng tần số với li độ x', NULL, 1, 1, 3, CAST(N'2018-05-01 07:31:53.900' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (190, 48, N'Luôn luôn cùng chiều với chuyển động.', NULL, 2, 1, 3, CAST(N'2018-05-01 07:31:53.903' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (191, 48, N'Bằng không khi hợp lực tác dụng bằng không', 1, 3, 1, 3, CAST(N'2018-05-01 07:31:53.907' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (192, 48, N'Là một hàm hình sin theo thời gian.', NULL, 4, 1, 3, CAST(N'2018-05-01 07:31:53.907' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (193, 49, N'continent', NULL, 1, 1, 3, CAST(N'2018-05-08 08:37:30.020' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (194, 49, N'permission', 1, 2, 1, 3, CAST(N'2018-05-08 08:37:30.037' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (195, 49, N'circumstance', NULL, 3, 1, 3, CAST(N'2018-05-08 08:37:30.037' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (196, 49, N'interest', NULL, 4, 1, 3, CAST(N'2018-05-08 08:37:30.047' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (197, 50, N'religious ', NULL, 1, 1, 3, CAST(N'2018-05-08 08:37:30.050' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (198, 50, N'miserable ', 1, 2, 1, 3, CAST(N'2018-05-08 08:37:30.050' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (199, 50, N'perform ', NULL, 3, 1, 3, CAST(N'2018-05-08 08:37:30.050' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (200, 50, N'include', NULL, 4, 1, 3, CAST(N'2018-05-08 08:37:30.053' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (269, 68, N'would be', NULL, 1, 1, 3, CAST(N'2018-05-08 11:57:11.893' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (270, 68, N'were', 1, 2, 1, 3, CAST(N'2018-05-08 11:57:11.897' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (271, 68, N'are', NULL, 3, 1, 3, CAST(N'2018-05-08 11:57:11.900' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (272, 68, N'will be', NULL, 4, 1, 3, CAST(N'2018-05-08 11:57:11.903' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (273, 69, N'different - than', 1, 1, 1, 3, CAST(N'2018-05-08 11:57:49.610' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (274, 69, N'same - as', NULL, 2, 1, 3, CAST(N'2018-05-08 11:57:49.610' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (275, 69, N'similar - like', NULL, 3, 1, 3, CAST(N'2018-05-08 11:57:49.613' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (276, 69, N'much more - than', NULL, 4, 1, 3, CAST(N'2018-05-08 11:57:49.613' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (277, 70, N'having built - to persevere', NULL, 1, 1, 3, CAST(N'2018-05-08 11:58:33.343' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (278, 70, N'building - persevering', 1, 2, 1, 3, CAST(N'2018-05-08 11:58:33.347' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (279, 70, N'to be building - persevered', NULL, 3, 1, 3, CAST(N'2018-05-08 11:58:33.347' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (280, 70, N'to build - having persevered', NULL, 4, 1, 3, CAST(N'2018-05-08 11:58:33.347' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (285, 72, N'would try', NULL, 1, 1, 3, CAST(N'2018-05-08 11:59:50.833' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (286, 72, N'must try', NULL, 2, 1, 3, CAST(N'2018-05-08 11:59:50.833' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (287, 72, N'has tried', 1, 3, 1, 3, CAST(N'2018-05-08 11:59:50.837' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (288, 72, N'will try', NULL, 4, 1, 3, CAST(N'2018-05-08 11:59:50.837' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (289, 73, N'and', NULL, 1, 1, 3, CAST(N'2018-05-08 12:00:17.433' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (290, 73, N'so as', NULL, 2, 1, 3, CAST(N'2018-05-08 12:00:17.437' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (291, 73, N'but also', NULL, 3, 1, 3, CAST(N'2018-05-08 12:00:17.440' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (292, 73, N'so that', 1, 4, 1, 3, CAST(N'2018-05-08 12:00:17.440' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (293, 74, N'or you will make', 1, 1, 1, 3, CAST(N'2018-05-08 12:00:43.607' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (294, 74, N'in case you would make', NULL, 2, 1, 3, CAST(N'2018-05-08 12:00:43.607' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (295, 74, N'if you would make', NULL, 3, 1, 3, CAST(N'2018-05-08 12:00:43.610' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (296, 74, N'unless you would have made', NULL, 4, 1, 3, CAST(N'2018-05-08 12:00:43.610' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (301, 76, N'buying', NULL, 1, 1, 3, CAST(N'2018-05-08 12:01:37.720' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (302, 76, N'buy', NULL, 2, 1, 3, CAST(N'2018-05-08 12:01:37.723' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (303, 76, N'to buy', 1, 3, 1, 3, CAST(N'2018-05-08 12:01:37.723' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (304, 76, N'of buying', NULL, 4, 1, 3, CAST(N'2018-05-08 12:01:37.727' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (365, 92, N'They have different ring settings.', NULL, 1, 1, 3, CAST(N'2018-05-09 17:15:17.220' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (366, 92, N'You can leave messages on them.', NULL, 2, 1, 3, CAST(N'2018-05-09 17:15:17.227' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (367, 92, N'They are widely used in business.', NULL, 3, 1, 3, CAST(N'2018-05-09 17:15:17.227' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (368, 92, N'They can be used in many different places and at any time.', 1, 4, 1, 3, CAST(N'2018-05-09 17:15:17.227' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (385, 97, N'cough ', 1, 1, 1, 3, CAST(N'2018-05-09 17:28:44.223' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (386, 97, N'tough ', NULL, 2, 1, 3, CAST(N'2018-05-09 17:28:44.227' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (387, 97, N'rough ', NULL, 3, 1, 3, CAST(N'2018-05-09 17:28:44.227' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (388, 97, N'enough', NULL, 4, 1, 3, CAST(N'2018-05-09 17:28:44.230' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (389, 98, N'prescription ', NULL, 1, 1, 3, CAST(N'2018-05-09 17:28:44.230' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (390, 98, N'preliminary', NULL, 2, 1, 3, CAST(N'2018-05-09 17:28:44.233' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (391, 98, N'presumption', NULL, 3, 1, 3, CAST(N'2018-05-09 17:28:44.233' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (392, 98, N'preparation', 1, 4, 1, 3, CAST(N'2018-05-09 17:28:44.233' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (433, 109, N'place', NULL, 1, 1, 3, CAST(N'2018-05-09 17:53:14.373' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (434, 109, N'crossroads', NULL, 2, 1, 3, CAST(N'2018-05-09 17:53:14.377' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (435, 109, N'junction', 1, 3, 1, 3, CAST(N'2018-05-09 17:53:14.380' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (436, 109, N'intersection', NULL, 4, 1, 3, CAST(N'2018-05-09 17:53:14.380' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (437, 110, N'across', 1, 1, 1, 3, CAST(N'2018-05-09 17:53:14.380' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (438, 110, N'up', NULL, 2, 1, 3, CAST(N'2018-05-09 17:53:14.403' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (439, 110, N'on', NULL, 3, 1, 3, CAST(N'2018-05-09 17:53:14.403' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (440, 110, N'along', NULL, 4, 1, 3, CAST(N'2018-05-09 17:53:14.407' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (441, 111, N'differ', 1, 1, 1, 3, CAST(N'2018-05-09 17:53:14.410' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (442, 111, N'notice', NULL, 2, 1, 3, CAST(N'2018-05-09 17:53:14.410' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (443, 111, N'separate', NULL, 3, 1, 3, CAST(N'2018-05-09 17:53:14.410' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (444, 111, N'distinguish', NULL, 4, 1, 3, CAST(N'2018-05-09 17:53:14.413' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (445, 112, N'occasion', NULL, 1, 1, 3, CAST(N'2018-05-09 17:53:14.413' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (446, 112, N'argument', NULL, 2, 1, 3, CAST(N'2018-05-09 17:53:14.413' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (447, 112, N'case', NULL, 3, 1, 3, CAST(N'2018-05-09 17:53:14.417' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (448, 112, N'problem', 1, 4, 1, 3, CAST(N'2018-05-09 17:53:14.417' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (449, 113, N'level', NULL, 1, 1, 3, CAST(N'2018-05-09 17:53:14.420' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (450, 113, N'ability', 1, 2, 1, 3, CAST(N'2018-05-09 17:53:14.420' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (451, 113, N'floor', NULL, 3, 1, 3, CAST(N'2018-05-09 17:53:14.423' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (452, 113, N'ladder', NULL, 4, 1, 3, CAST(N'2018-05-09 17:53:14.423' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (453, 114, N'3', 1, 1, 1, 10, CAST(N'2018-05-15 07:42:27.337' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (454, 114, N'4', NULL, 2, 1, 10, CAST(N'2018-05-15 07:42:27.363' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (455, 114, N'5', NULL, 3, 1, 10, CAST(N'2018-05-15 07:42:27.363' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (456, 114, N'2', NULL, 4, 1, 10, CAST(N'2018-05-15 07:42:27.363' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (457, 115, N'Đáp án 1', NULL, 1, 1, 10, CAST(N'2018-05-15 07:46:54.583' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (458, 115, N'23', 1, 2, 1, 10, CAST(N'2018-05-15 07:46:54.583' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (459, 115, N'45', NULL, 3, 1, 10, CAST(N'2018-05-15 07:46:54.583' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (460, 115, N'234', NULL, 4, 1, 10, CAST(N'2018-05-15 07:46:54.587' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (461, 116, N'1', NULL, 1, 1, 10, CAST(N'2018-05-15 07:47:14.267' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (462, 116, N'2', NULL, 2, 1, 10, CAST(N'2018-05-15 07:47:14.270' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (463, 116, N'3', 1, 3, 1, 10, CAST(N'2018-05-15 07:47:14.270' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (464, 116, N'4', NULL, 4, 1, 10, CAST(N'2018-05-15 07:47:14.270' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (465, 117, N'1', NULL, 1, 1, 10, CAST(N'2018-05-15 07:47:28.360' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (466, 117, N'2', NULL, 2, 1, 10, CAST(N'2018-05-15 07:47:28.363' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (467, 117, N'3', 1, 3, 1, 10, CAST(N'2018-05-15 07:47:28.367' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (468, 117, N'4', NULL, 4, 1, 10, CAST(N'2018-05-15 07:47:28.367' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (469, 118, N'Đáp án 1', 1, 1, 1, 10, CAST(N'2018-05-15 07:47:38.473' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (470, 118, N'Đáp án 2', NULL, 2, 1, 10, CAST(N'2018-05-15 07:47:38.473' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (471, 118, N'Đáp án 3', NULL, 3, 1, 10, CAST(N'2018-05-15 07:47:38.473' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (472, 118, N'Đáp án 4', NULL, 4, 1, 10, CAST(N'2018-05-15 07:47:38.477' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (473, 119, N'Đáp án 1', 1, 1, 1, 10, CAST(N'2018-05-15 07:47:49.303' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (474, 119, N'Đáp án 2', NULL, 2, 1, 10, CAST(N'2018-05-15 07:47:49.307' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (475, 119, N'Đáp án 3', NULL, 3, 1, 10, CAST(N'2018-05-15 07:47:49.307' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (476, 119, N'Đáp án 4', NULL, 4, 1, 10, CAST(N'2018-05-15 07:47:49.307' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (477, 120, N'Đáp án 1', NULL, 1, 1, 10, CAST(N'2018-05-15 16:54:39.493' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (478, 120, N'Đáp án 2', NULL, 2, 1, 10, CAST(N'2018-05-15 16:54:39.497' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (479, 120, N'Đáp án 3', 1, 3, 1, 10, CAST(N'2018-05-15 16:54:39.497' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (480, 120, N'Đáp án 4', NULL, 4, 1, 10, CAST(N'2018-05-15 16:54:39.507' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (481, 121, N'Đáp án 1', NULL, 1, 1, 10, CAST(N'2018-05-15 16:54:53.920' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (482, 121, N'test', 1, 2, 1, 10, CAST(N'2018-05-15 16:54:53.923' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (483, 121, N'Đáp án 3', NULL, 3, 1, 10, CAST(N'2018-05-15 16:54:53.923' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (484, 121, N'Đáp án 4', NULL, 4, 1, 10, CAST(N'2018-05-15 16:54:53.923' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (485, 122, N'Đáp án 1', NULL, 1, 1, 10, CAST(N'2018-05-15 16:56:15.843' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (486, 122, N'testttt', 1, 2, 1, 10, CAST(N'2018-05-15 16:56:15.847' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (487, 122, N'Đáp án 3', NULL, 3, 1, 10, CAST(N'2018-05-15 16:56:15.847' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (488, 122, N'Đáp án 4', NULL, 4, 1, 10, CAST(N'2018-05-15 16:56:15.850' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (493, 124, N'A. furnish', NULL, 1, 1, 3, CAST(N'2018-05-17 14:55:51.950' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (494, 124, N' B. reason', 1, 2, 1, 3, CAST(N'2018-05-17 14:55:51.953' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (495, 124, N'C. promise  ', NULL, 3, 1, 3, CAST(N'2018-05-17 14:55:51.953' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (496, 124, N'D. tonight', NULL, 4, 1, 3, CAST(N'2018-05-17 14:55:51.957' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (497, 125, N'A. habitable', 1, 1, 1, 3, CAST(N'2018-05-17 14:57:09.023' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (498, 125, N'B. infamously ', NULL, 2, 1, 3, CAST(N'2018-05-17 14:57:09.027' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (499, 125, N'C. geneticist  ', NULL, 3, 1, 3, CAST(N'2018-05-17 14:57:09.030' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (500, 125, N'Đáp án 4', NULL, 4, 1, 3, CAST(N'2018-05-17 14:57:09.030' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (501, 126, N'A. organisms', NULL, 1, 1, 3, CAST(N'2018-05-17 14:58:46.730' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (502, 126, N'B. bodies', NULL, 2, 1, 3, CAST(N'2018-05-17 14:58:46.733' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (503, 126, N'C. parts    ', 1, 3, 1, 3, CAST(N'2018-05-17 14:58:46.737' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (504, 126, N'D. muscles', NULL, 4, 1, 3, CAST(N'2018-05-17 14:58:46.740' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (505, 127, N'A. Really? ', NULL, 1, 1, 3, CAST(N'2018-05-17 15:01:12.340' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (506, 127, N'B. Thank you, it’s nice of you to say no ', NULL, 2, 1, 3, CAST(N'2018-05-17 15:01:12.343' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (507, 127, N'C. Can you say that again', NULL, 3, 1, 3, CAST(N'2018-05-17 15:01:12.347' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (508, 127, N'D. I love them, too', 1, 4, 1, 3, CAST(N'2018-05-17 15:01:12.350' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (509, 128, N'. A. date', NULL, 1, 1, 3, CAST(N'2018-05-17 15:05:06.843' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (510, 128, N'B. page', 1, 2, 1, 3, CAST(N'2018-05-17 15:05:06.850' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (511, 128, N'C. face', NULL, 3, 1, 3, CAST(N'2018-05-17 15:05:06.850' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (512, 128, N'D. map', NULL, 4, 1, 3, CAST(N'2018-05-17 15:05:06.853' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (513, 129, N'A. relation', NULL, 1, 1, 3, CAST(N'2018-05-17 15:06:30.833' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (514, 129, N'B. empployment', NULL, 2, 1, 3, CAST(N'2018-05-17 15:06:30.837' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (515, 129, N'C. importance ', 1, 3, 1, 3, CAST(N'2018-05-17 15:06:30.837' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (516, 129, N'D. happiness', NULL, 4, 1, 3, CAST(N'2018-05-17 15:06:30.837' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (517, 130, N'​​​​​​​A. worthy', NULL, 1, 1, 3, CAST(N'2018-05-17 15:08:09.323' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (518, 130, N'B. beneficial', 1, 2, 1, 3, CAST(N'2018-05-17 15:08:09.327' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (519, 130, N'C. costly ', NULL, 3, 1, 3, CAST(N'2018-05-17 15:08:09.327' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (520, 130, N'D. valuable', NULL, 4, 1, 3, CAST(N'2018-05-17 15:08:09.330' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (521, 131, N' A. decision ', NULL, 1, 1, 3, CAST(N'2018-05-17 15:08:54.017' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (522, 131, N'.B. decisive', NULL, 2, 1, 3, CAST(N'2018-05-17 15:08:54.020' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (523, 131, N'C. decide', NULL, 3, 1, 3, CAST(N'2018-05-17 15:08:54.023' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (524, 131, N'D. decisively', 1, 4, 1, 3, CAST(N'2018-05-17 15:08:54.027' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (525, 132, N'A. catch on', NULL, 1, 1, 3, CAST(N'2018-05-17 15:09:37.437' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (526, 132, N'B. take over', NULL, 2, 1, 3, CAST(N'2018-05-17 15:09:37.443' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (527, 132, N' C. stand for', 1, 3, 1, 3, CAST(N'2018-05-17 15:09:37.443' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (528, 132, N'D. hold on', NULL, 4, 1, 3, CAST(N'2018-05-17 15:09:37.443' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (529, 133, N'A. claim', NULL, 1, 1, 3, CAST(N'2018-05-17 15:10:31.927' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (530, 133, N' B. request', NULL, 2, 1, 3, CAST(N'2018-05-17 15:10:31.930' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (531, 133, N'C. demand', 1, 3, 1, 3, CAST(N'2018-05-17 15:10:31.933' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (532, 133, N' D. requisite', NULL, 4, 1, 3, CAST(N'2018-05-17 15:10:31.937' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (533, 134, N'A. which ', 1, 1, 1, 3, CAST(N'2018-05-17 15:11:11.417' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (534, 134, N' B. when', NULL, 2, 1, 3, CAST(N'2018-05-17 15:11:11.420' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (535, 134, N'C. who', NULL, 3, 1, 3, CAST(N'2018-05-17 15:11:11.420' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (536, 134, N' D. where', NULL, 4, 1, 3, CAST(N'2018-05-17 15:11:11.420' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (537, 135, N'A. commented', 1, 1, 1, 3, CAST(N'2018-05-17 15:13:51.503' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (538, 135, N'B. carried', NULL, 2, 1, 3, CAST(N'2018-05-17 15:13:51.503' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (539, 135, N' C. conducted', NULL, 3, 1, 3, CAST(N'2018-05-17 15:13:51.507' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (540, 135, N'D. filled ', NULL, 4, 1, 3, CAST(N'2018-05-17 15:13:51.507' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (541, 136, N'A. the more crowded the beaches get ', NULL, 1, 1, 3, CAST(N'2018-05-17 15:15:23.377' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (542, 136, N'B. the most crowded the beaches get', NULL, 2, 1, 3, CAST(N'2018-05-17 15:15:23.377' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (543, 136, N'C. the more the beaches get crowded', NULL, 3, 1, 3, CAST(N'2018-05-17 15:15:23.380' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (544, 136, N'D. the most the beaches get crowded', 1, 4, 1, 3, CAST(N'2018-05-17 15:15:23.380' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (565, 142, N'A. situations', 1, 1, 1, 3, CAST(N'2018-05-17 15:33:26.483' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (566, 142, N'B. positions', NULL, 2, 1, 3, CAST(N'2018-05-17 15:33:26.487' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (567, 142, N'  C. conditions', NULL, 3, 1, 3, CAST(N'2018-05-17 15:33:26.487' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (568, 142, N' D. locations ', NULL, 4, 1, 3, CAST(N'2018-05-17 15:33:26.493' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (569, 143, N'A. who', 1, 1, 1, 3, CAST(N'2018-05-17 15:33:26.493' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (570, 143, N'B. where', NULL, 2, 1, 3, CAST(N'2018-05-17 15:33:26.497' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (571, 143, N'C. whose', NULL, 3, 1, 3, CAST(N'2018-05-17 15:33:26.500' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (572, 143, N'D. which ', NULL, 4, 1, 3, CAST(N'2018-05-17 15:33:26.500' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (573, 144, N'A. differ', NULL, 1, 1, 3, CAST(N'2018-05-17 15:33:26.503' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (574, 144, N'B. differently', NULL, 2, 1, 3, CAST(N'2018-05-17 15:33:26.507' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (575, 144, N' C. different', 1, 3, 1, 3, CAST(N'2018-05-17 15:33:26.510' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (576, 144, N'D. differences', NULL, 4, 1, 3, CAST(N'2018-05-17 15:33:26.510' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (577, 145, N'A. Moreover', 1, 1, 1, 3, CAST(N'2018-05-17 15:33:26.513' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (578, 145, N'B. Otherwise', NULL, 2, 1, 3, CAST(N'2018-05-17 15:33:26.513' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (579, 145, N' C. Therefore', NULL, 3, 1, 3, CAST(N'2018-05-17 15:33:26.513' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (580, 145, N'D. However ', NULL, 4, 1, 3, CAST(N'2018-05-17 15:33:26.517' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (581, 146, N'A. get', NULL, 1, 1, 3, CAST(N'2018-05-17 15:33:26.517' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (582, 146, N'B. feel', NULL, 2, 1, 3, CAST(N'2018-05-17 15:33:26.520' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (583, 146, N'C. show ', 1, 3, 1, 3, CAST(N'2018-05-17 15:33:26.520' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Answer] ([Id], [SubQuestionId], [Answer], [CorrectAnswer], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (584, 146, N'D. take ', NULL, 4, 1, 3, CAST(N'2018-05-17 15:33:26.523' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Ex_Answer] OFF
SET IDENTITY_INSERT [dbo].[Ex_Category] ON 

INSERT [dbo].[Ex_Category] ([Id], [Code], [Name], [Total], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'KHOI                ', N'Khối', 3, 1, 1, 3, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 0, CAST(N'1900-01-01' AS Date))
INSERT [dbo].[Ex_Category] ([Id], [Code], [Name], [Total], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'DT                  ', N'Đề thi', 2, 1, 1, 3, CAST(N'2018-02-02 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Category] ([Id], [Code], [Name], [Total], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'DK                  ', N'Độ khó', 3, 1, 1, 3, CAST(N'2018-02-02 00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Ex_Category] OFF
SET IDENTITY_INSERT [dbo].[Ex_CategoryValue] ON 

INSERT [dbo].[Ex_CategoryValue] ([Id], [CatCode], [TypeCode], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'KHOI                ', N'KHOI-1              ', N'Khối 10', 1, 1, 3, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 0, CAST(N'1900-01-01' AS Date))
INSERT [dbo].[Ex_CategoryValue] ([Id], [CatCode], [TypeCode], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'KHOI                ', N'KHOI-2              ', N'Khối 11', 1, 1, 3, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 0, CAST(N'1900-01-01' AS Date))
INSERT [dbo].[Ex_CategoryValue] ([Id], [CatCode], [TypeCode], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'KHOI                ', N'KHOI-3              ', N'Khối 12', 1, 1, 3, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 0, CAST(N'1900-01-01' AS Date))
INSERT [dbo].[Ex_CategoryValue] ([Id], [CatCode], [TypeCode], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'DK                  ', N'DK-1                ', N'Dễ', 1, 1, 3, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 0, CAST(N'1900-01-01' AS Date))
INSERT [dbo].[Ex_CategoryValue] ([Id], [CatCode], [TypeCode], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'DK                  ', N'DK-2                ', N'Trung Bình', 1, 1, 3, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 0, CAST(N'1900-01-01' AS Date))
INSERT [dbo].[Ex_CategoryValue] ([Id], [CatCode], [TypeCode], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'DK                  ', N'DK-3                ', N'Khó', 1, 1, 3, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 0, CAST(N'1900-01-01' AS Date))
SET IDENTITY_INSERT [dbo].[Ex_CategoryValue] OFF
SET IDENTITY_INSERT [dbo].[Ex_Exam] ON 

INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'4e23a589-f649-4d48-a6fd-c4ebdad0e952', N'KHOI-1                        ', 9, N'DT-19                         ', N'Đề thi Tiếng Anh', 50, 19, 21, 13, 1, 1, 1, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-05-05' AS Date))
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'2cb78204-1247-4ca6-b1be-ed2e4f22ab31', N'KHOI-1                        ', 4, N'DT-20                         ', N'Đề thi Vật lý', 50, 0, 2, 40, 1, 1, 1, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-05-05' AS Date))
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'486b2ba0-2957-4727-bb12-9a5e744487f8', N'KHOI-1                        ', 1, N'DT-14                         ', N'Đề thi Hóa giữa kỳ', 16, 0, 2, 13, 1, 1, 10, CAST(N'2018-04-11 21:07:47.000' AS DateTime), 3, CAST(N'2018-05-05' AS Date))
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'88403daa-3d2b-4192-a2b0-f1fc5c6c75a8', N'KHOI-1                        ', 9, N'DT-15                         ', N'Đề thi ddd', 29, 0, 0, 28, 1, 1, 3, CAST(N'2018-04-12 10:00:38.000' AS DateTime), 3, CAST(N'2018-05-05' AS Date))
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'0cecfdab-2373-4386-a104-519291e656c5', N'KHOI-1                        ', 1, N'DT-16                         ', N'Đề thi Toán giữa kỳ', 1, 15, 1, 6, 1, 1, 10, CAST(N'2018-05-15 07:16:00.000' AS DateTime), 10, CAST(N'2018-05-15' AS Date))
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, N'b9543aed-ddc5-4189-838a-c56d3bb7e067', N'KHOI-1                        ', 1, N'DT-17                         ', N'Đề test', 10, 12, 0, 6, 1, 1, 10, CAST(N'2018-05-15 16:53:48.110' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'04935671-ac36-4cce-8984-d2544ccb16e5', N'KHOI-3                        ', 9, N'DT-18                         ', N'Tổng ôn tiếng Anh ', 15, 30000, 8, 15, 1, 1, 3, CAST(N'2018-05-17 14:43:15.543' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'6f6fbd65-df79-4c34-82b4-43ed7133b22f', N'KHOI-1                        ', 1, N'DT-19                         ', N'Đề thi 15phuts', 9, 12, 0, 9, 1, -1, 10, CAST(N'2018-05-18 11:17:11.000' AS DateTime), 10, CAST(N'2018-05-18' AS Date))
SET IDENTITY_INSERT [dbo].[Ex_Exam] OFF
SET IDENTITY_INSERT [dbo].[Ex_ExamConfig] ON 

INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'DT-19                         ', N'Section 1. Mark the letter A, B, C or D on your answer sheet to indicate the word that differs from the other three in the position of primary stress in each of the following questions', N'DK-1                          ', 2, 1, 1, 3, CAST(N'2018-04-03 10:07:14.000' AS DateTime), 3, CAST(N'2018-05-09' AS Date))
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'DT-19                         ', N'Section 2. Mark the letter A, B, C or D on your answer sheet to indicate the word whose underlined part differs from the other three in pronunciation in each of the following questions', N'DK-1                          ', 5, 1, 1, 3, CAST(N'2018-04-03 10:07:19.000' AS DateTime), 3, CAST(N'2018-05-09' AS Date))
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'DT-19                         ', N'Section 3. Read the following passage and mark the letter A, B, C or D on your answer sheet to indicate the correct word or phrase that best fits each of the blanks or correct answer to each of the questions.', N'DK-1                          ', 5, 1, 1, 3, CAST(N'2018-04-03 10:07:23.000' AS DateTime), 3, CAST(N'2018-05-09' AS Date))
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'DT-20                         ', N'Chương 3', N'DK-1                          ', 4, 1, 1, 3, CAST(N'2018-04-03 10:07:41.713' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'DT-20                         ', N'Chương 4', N'DK-1                          ', 3, 1, 1, 3, CAST(N'2018-04-03 10:09:03.017' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'DT-20                         ', N'Chương 5', N'DK-1                          ', 2, 1, 1, 3, CAST(N'2018-04-03 10:09:09.827' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'DT-14                         ', N'Chương 1 ', N'DK-1                          ', 5, 1, 1, 3, CAST(N'2018-04-03 10:37:20.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'DT-14                         ', N'Chương 1 Lipit', N'DK-1                          ', 9, 1, 1, 10, CAST(N'2018-04-11 21:09:31.427' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (23, N'DT-14                         ', N'Chương 2 Hữu cơ', N'DK-1                          ', 9, 1, 1, 10, CAST(N'2018-04-11 21:09:50.000' AS DateTime), 10, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (24, N'DT-14                         ', N'Chương 3 Cân bằng', N'DK-2                          ', 9, 1, 1, 10, CAST(N'2018-04-11 21:10:08.510' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (25, N'DT-19                         ', N'Section 4', N'DK-2                          ', 1, 1, 1, 3, CAST(N'2018-04-12 10:00:16.000' AS DateTime), 3, CAST(N'2018-05-09' AS Date))
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (26, N'DT-16                         ', N'Chương 1', N'DK-1                          ', 3, 1, 1, 10, CAST(N'2018-05-15 07:16:22.753' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (27, N'DT-16                         ', N'Chương 2', N'DK-1                          ', 3, 1, 1, 10, CAST(N'2018-05-15 07:16:29.547' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (28, N'DT-17                         ', N'chương một', N'DK-1                          ', 1, 1, 1, 10, CAST(N'2018-05-15 16:54:09.533' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (29, N'DT-17                         ', N'chương 2', N'DK-1                          ', 1, 1, 1, 10, CAST(N'2018-05-15 16:54:14.807' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (30, N'DT-18                         ', N'Chương 1 : Phát âm', N'DK-1                          ', 5, 1, 1, 3, CAST(N'2018-05-17 14:46:59.843' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (31, N'DT-18                         ', N'Chương 2 : Ngữ pháp', N'DK-1                          ', 5, 1, 1, 3, CAST(N'2018-05-17 14:47:21.063' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (32, N'DT-18                         ', N'Chương 3: Đoạn văn', N'DK-1                          ', 5, 1, 1, 3, CAST(N'2018-05-17 14:47:38.170' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Ex_ExamConfig] OFF
SET IDENTITY_INSERT [dbo].[Ex_ExamStudent] ON 

INSERT [dbo].[Ex_ExamStudent] ([Id], [ExamId], [StudentId], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, 18, 10, 0, 10, CAST(N'2018-05-20 18:46:19.623' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamStudent] ([Id], [ExamId], [StudentId], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, 14, 12, 0, 12, CAST(N'2018-05-20 18:48:24.737' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamStudent] ([Id], [ExamId], [StudentId], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, 13, 12, 0, 12, CAST(N'2018-05-20 18:48:53.757' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamStudent] ([Id], [ExamId], [StudentId], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, 16, 12, 1, 12, CAST(N'2018-05-20 18:49:29.640' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Ex_ExamStudent] OFF
SET IDENTITY_INSERT [dbo].[Ex_Question] ON 

INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (35, 4, N'KHOI-1                        ', 19, N'DT-20                         ', N'<p>Dao động l&agrave;:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:12:21.000' AS DateTime), 3, CAST(N'2018-05-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (36, 4, N'KHOI-1                        ', 14, N'DT-20                         ', N'Chuyển động nào sau đây là dao động tuần hoàn:', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:13:24.873' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (37, 4, N'KHOI-1                        ', 14, N'DT-20                         ', N'Tần số của một dao động tuần hoàn:', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:16:45.407' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (38, 4, N'KHOI-1                        ', 14, N'DT-20                         ', N'<p>Một dao động tuần ho&agrave;n thực hiện được 120 dao động trong 1 ph&uacute;t. Chu k&igrave; v&agrave; tần số của dao động l&agrave;:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:22:33.000' AS DateTime), 3, CAST(N'2018-04-03 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (39, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Trong phương tr&igrave;nh dao động điều h&ograve;a , rad l&agrave; đơn vị của đại lượng</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:46:37.687' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (40, 4, N'KHOI-1                        ', 20, N'DT-20                         ', N'<p>Ph&aacute;t biểu n&agrave;o sau đ&acirc;y sai khi n&oacute;i về dao động điều h&ograve;a:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:47:24.000' AS DateTime), 3, CAST(N'2018-05-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (41, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>F l&agrave; hợp lực t&aacute;c dụng v&agrave;o vật l&agrave;m vật dao động điều h&ograve;a. Chọn ph&aacute;t biểu đ&uacute;ng.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:47:57.813' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (42, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Một vật dao động điều h&ograve;a dưới t&aacute;c dụng của hợp lực F. Chọn ph&aacute;t biểu sai:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:48:33.000' AS DateTime), 3, CAST(N'2018-05-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (43, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Một vật dao động điều h&ograve;a, khi vật chuyển động từ vị tr&iacute; bi&ecirc;n về vị tr&iacute; c&acirc;n bằng th&igrave;</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:49:42.220' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (44, 4, N'KHOI-1                        ', 20, N'DT-20                         ', N'<p>Trong phương tr&igrave;nh của dao động điều h&ograve;a, rad/s l&agrave; đơn vị của đại lượng:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:50:12.000' AS DateTime), 3, CAST(N'2018-05-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (45, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Một vật đang dao động điều h&ograve;a, khi vật đi qua vị tr&iacute; c&acirc;n bằng th&igrave;:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:52:03.813' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (46, 4, N'KHOI-1                        ', 20, N'DT-20                         ', N'<p>Điều n&agrave;o sau đ&acirc;y sai về gia tốc của dao động điều h&ograve;a:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:52:37.000' AS DateTime), 3, CAST(N'2018-05-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (47, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Trong dao động điều h&ograve;a theo phương ngang của chất điểm, chất điểm đổi chiều chuyển động khi</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:53:17.330' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (48, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Một vật dao động điều h&ograve;a giữa hai điểm M v&agrave; N c&oacute; thời gian ngắn nhất để đi từ M đến N l&agrave; 0,4s. Chu<br />
k&igrave; dao động l&agrave;:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:53:45.297' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (49, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Một vật dao động điều h&ograve;a tr&ecirc;n trục ox với phương tr&igrave;nh . Pha dao động ở thời điểm t = 0,5s l&agrave;:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-03 10:54:14.827' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (50, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Test?</p>
', N'DK-1                          ', 2, 1, 0, 3, CAST(N'2018-04-09 23:41:04.417' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (51, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Giải phương tr&igrave;nh ??</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-04-11 16:21:16.000' AS DateTime), 3, CAST(N'2018-04-11 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (52, 1, N'KHOI-1                        ', 22, N'DT-14                         ', N'<table>
	<tbody>
		<tr>
			<td><a href="https://phuongtrinhhoahoc.com/chat-hoa-hoc/Ca(OH)2" rel="canonical">Ca(OH)<sub>2</sub></a></td>
			<td>+</td>
			<td>X<a href="https://phuongtrinhhoahoc.com/chat-hoa-hoc/CO2" rel="canonical">CO<sub>2</sub></a></td>
			<td>&rarr;</td>
			<td><a href="https://phuongtrinhhoahoc.com/chat-hoa-hoc/CaCO3" rel="canonical">CaCO<sub>3</sub></a></td>
			<td>+</td>
			<td><a href="https://phuongtrinhhoahoc.com/chat-hoa-hoc/H2O" rel="canonical">H<sub>2</sub>O</a></td>
		</tr>
	</tbody>
</table>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-04-11 21:12:55.000' AS DateTime), 10, CAST(N'2018-04-11 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (53, 4, N'KHOI-1                        ', 16, N'DT-20                         ', N'<p>Giải phương tr&igrave;nh&nbsp;<img alt="MathML (base64):PG1hdGg+CiAgICA8bXJvdz4KICAgICAgICA8bXN1Yj4KICAgICAgICAgICAgPG1pPng8L21pPgogICAgICAgICAgICA8bXRleHQ+MTI8L210ZXh0PgogICAgICAgIDwvbXN1Yj4KICAgICAgICA8bW8+PTwvbW8+CiAgICAgICAgPG1mcmFjPgogICAgICAgICAgICA8bXJvdz4KICAgICAgICAgICAgICAgIDxtbz4tPC9tbz4KICAgICAgICAgICAgICAgIDxtaT5iPC9taT4KICAgICAgICAgICAgICAgIDxtbz4mI3hCMTs8L21vPgogICAgICAgICAgICAgICAgPG1zcXJ0PgogICAgICAgICAgICAgICAgICAgIDxtc3VwPgogICAgICAgICAgICAgICAgICAgICAgICA8bWk+YjwvbWk+CiAgICAgICAgICAgICAgICAgICAgICAgIDxtbj4yPC9tbj4KICAgICAgICAgICAgICAgICAgICA8L21zdXA+CiAgICAgICAgICAgICAgICAgICAgPG1vPi08L21vPgogICAgICAgICAgICAgICAgICAgIDxtbj40PC9tbj4KICAgICAgICAgICAgICAgICAgICA8bWk+YTwvbWk+CiAgICAgICAgICAgICAgICAgICAgPG1pPmM8L21pPgogICAgICAgICAgICAgICAgPC9tc3FydD4KICAgICAgICAgICAgPC9tcm93PgogICAgICAgICAgICA8bXJvdz4KICAgICAgICAgICAgICAgIDxtbj4yPC9tbj4KICAgICAgICAgICAgICAgIDxtaT5hPC9taT4KICAgICAgICAgICAgPC9tcm93PgogICAgICAgIDwvbWZyYWM+CiAgICA8L21yb3c+CjwvbWF0aD4=" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAATsAAABRCAYAAACtxAFPAAAUnElEQVR4Xu2dCfB31RjHv9l3EyEiajQRiSIJUSk1RJayZ8+eLbIvZVeIrFEiS8iSLYpS1oYsb0iYsiREdtmZz9tzzHnve5dz7+8u5/5+zzPzjsb/Lud8z/l973OedQO5OAKOgCOwAghssAJz9Ck6AmUIXErS3yRd1uFZagS2k3QmM3SyW+p19snVIHBzSWskHSjpG47U0iLwdUl/drJb2vX1iSUg8ChJb5V0ZdPwEm7xS+aMgGt2c149H/siCBwpaXtJ2yzyEL93Pgg42c1nrXyk/SLwHUlflvTYfh+7ztPQGveTdD9Jd5L0E0knS3qDJN7/3wHf7Y8uIOBk51tiFRG4otlxHiHpmIEAuI6R2j4lz79I0hMkHeeENxD6JY91shsPa39TPgjcWdIpkraUdM4Aw7qMpGdJurqk10i6QNLlJO0g6bmSdpf0NUkPkHTuAO/3RzrZ+R5wBNYiABE9R9LVBsLjZpIeKunFkv5SeMdNJb3PbIX3N+1uoGH4Y2MEXLPz/bCKCHxEEtrXXgNNnqMrGhthD0VBw3uFpKdKerCk9ww0Bn+s2+x8DzgCulDSayW9bCAsri0Ju9y/Kp7/fEkHS7qnpBMGGoM/1snO98CKI3ADST+VtIvZ7caGI2h2vB8v7Q/GHsCqvs+Psau68qs77/uanWyqYOKNJL1b0mmSXiXp36u7FOPO3MluXLzHfBtriwF+M0lbSfqDpE+OOYBM33WopF0l3aphfEPhhyeW2L7HSfpVphgt5bCc7JZvWbED4W0kzCEWN4ZfgsbplhP7+IqlHxI/Yu9eKukwSd+fwdaDH9CESa17k6SPzWDMlUN0spvz6tWP/YZ2XLqjpB/apiVqf9kEAvmPtNbpkCIX24+3yQvaN354f59kFTi+kDLQDK65taQPSQKL2X8snewy2FEDDYEN+l5JO9qG5evMUXaZZENJZ9j8np0wMY6ulPu5saQfN1zfJ34QHRkT3zRbXcJQJ7/kWlYo4V42Eie7yZfEB1CFwO0lfVrSVSW9XBLhDstkDMeriYbEcf0sSVsnbAVsZYdI4ofcJH3hB9E90o6tOCXmIIz56RYPGMbrZDeHlVvRMT5G0lts7ssWz8WJ5HhJQetgmptI+kXDWr9TEtogeDRJH/hBGqSE/cyIuZj4f2lJkOpXJP2zaUAj/p2wmBdI4si/h2t2IyLvr2qNAInuBM3yg/32EsZzHS7pgAIq2MOOaEAKpwCJ/2Qw1Ekf+FEJeV9Jv5f0mZKEf4jw3kYoH2+9wsPdwEeDj8I7JG1hwc+8zTW74TD3Jy+AQGxvIqYLe9GfFnhe21vRnogh23QALx5pViTXFwVCCVpI2XgJw8FmSamlpuPkoviheaLRoVljRqgSyj1RAopCATkIJM+6/d0KFjzTyS6HZfEx1CGwm6TP2gVPMy1vTMSuaTmfdx1AI3iGpK9K+rkZ0JlrkKuUJN6Hv91F0kmSrmTa1JD4keD/tgai4/3YDykWkIMtNRD0wyU9TNL5ZuclrQ1xzW7MX5C/KwkBNi1lhPghoc3tKelLSXf2d9GQZBeP8rqSfmQExv/PsZAk/zLBQYOtjnCKOskBv/5WIv1JVGMhlu5FZl/kzpDDOyTZcZxH+8VmubZXxFDioSdDITvdc6mh9naLqztV0oPMcI8NiZg7vtzUc+Oohjfz/WbHwhjdl4xFdoz3aNNE+O+jzPNZNo9PWCUSbHt1kgN+fa1D6nM44lM9+XsW8BwKGPRBdqTlUV2GDxGZK3RzO9GKMFzBTiCQXRsnGsdt9jKmgttZXUKqQGPKwMRRmm/sZJe6HeZz3S0s7gzjMk4Ksikub5H7VT90vujYZ4q117rOekyyI5kewkZ+I4mKI2Xlzgk6frLFHtbNKwf8uuLe5T44AGcPtkwcWnFw9iJkx8cVr26oLMNxnY/vXyVR7+8gqwzDu1OdaOzj+5in+DxJOKoorY8t9vpmI6VrHLUE1wvcdrLrsj3yvgdN7lgbInaWj0p6pdmp3mh9ELBbPdC+4sGATtAxHrg+ZEyyQxP7XdQW9LYWaBzPY3MLIuZ/myoD54BfH2uQ+gxIDtJg/Yv197qSHZoXcXp8QNHicCphA4wlxjnFibaxOU8eYnbOVxc+zniRec7O5k1+YvHj7WSXuiXmcV1cGJIUMQzlGOZ/a0fVuL4aX0k8byGEA+2ODUrj6EVlTLJjrMSphVxgbJXEiMXCcef1CcHEueC3KP6p95NqRztJCkRg+ihqxF3IjmMr+b9o0eTSoi2WFTwgvvCLNtAmJxqnFMKKKKJQdQqJNXyOs5Ap+/7/4mSXui3mcd31zAuKTY6cRvos4KHEjlFWSDIOnGXD89VES1pUxia7F5phnXGTkrVtYQJoLtSxw25UJ7ngtyj+KfeHPhmEB6F5lZkw2pJdnHmBDY0iAmXVmhlfTE514UCBkLHpsZ/Zo0UtkefFebxolOz5dbzcTnYp22I+12wniQBVvJSQHUUqsZX8sWIKbY8S8fV9o1L6NU58CUdXwlGCFLMp+BsZFxx96mRo/BKnM8ploboLHdaqKrC0IbtibOFTTJuuahcZ4iWxuWFSgRyLAnmyf+kXQmQBRFdVeYX3Q4w4QCBDikOsI052o+yr0V4Sa2pNX1YGFV+fcozNlezYx2ik2O8QcmA5niFsfrQWjOXh2FS1IEPjN9pGaHgRx8J3ma0uOHfKbmlDdjwTmxkfnjoNjPfEGSqsE8RXFg3AsZWPNnZlQorIMe588nCym277xTaLulGkBnPGG4jnNQWsxvapIkFUjSdXsmO8dOzCRokQZhKa6WxvJIctqS7/dAz8uu62PvcKOGCrhVyIxyRbokpSyY4cX0wJXI80ObviDJUqex3jxE5HgHPKMxuxdbJrhGiwC/rcwAwy3kAcS+hw9d2a0cf2qZTr2wAxts2OsRFuQE4n8g/TBvhfwm04/kB6dZITfsVx9rVX+L3zweLoWmX7it+dSnaEknxQEoHJKf1wsZ1iVkCq7HWxSSE1NKV2gZ3s2vyE+722rw0cRhWniOF5xEhb99WON1zK9W1mPwXZUbbp19Eg0ezQ8CjSSewYNqQ6yQm/ociuqL22WdPitfGJI85XDrGdfGjKJAQwkxNcZ6+LTQocZReux+hkt8hy53NvnOLEqLB1kAdaJSTqYytB+8O2x9e+z5SyKciOuX7Lmk/z38wP2x3pZBzXjqvBIzf8htpZQ5Ad9jTiN9EUkaZMiNgOVxVfx3pwLOYf0kSgSXg52SXBlP1FcYpT3dcyTCROVOeoQsmjqh6nXSY/FdlRpJSMEYTadhyriK4nvIKaclWSG35dME+5Zwiyo+ozTg6OnU3l/9G+IUaq00CSeFlZs6IUx0ncJDbohcTJbiH4srk5TnGq824x4BtZhgXH6Lqgz0UmNxXZYf8hJSkIPyYM4E2ViXPDbxHs+7w3xWZHMDcVdiCvpjAS7KekdbEmSNUJxMmuz1VcsmfFXtK6aPTgiaOzFoZkigIM0eVqKrJjWYnHIpAaIUyBmnEU0ayT3PDLZXumkF1sewZrYuaKzY9CDB77j7QvykatsXU520JRgs00ZPDE707R7HgH/9aLrwtgumaXy7bqPg7c/qj4oeFMlc0kjm7nS0zuIMeOIWRKsiMXOC67TgpcWbHPMO8c8RtiTbo8M4XsYq247BgLx5CvencLeSHsBfteyNjh41TWde0eUQBxU+4se5v0NOyzle0eney6bIG87sHZwGa4mw3rDiXOBvJg2QzPs2upWZbaerDLbKckO5wSb44GTXc1cmerJEf8umA+xD0pZAd+FJAI/UCocsI/ArnR5PaXRAEGTArXiDrekYvL/8cpA5IkTjLOtqB6zZGSID0qOe9dUuCBOXN8xk7LCYVueq7ZDbETMnkm9g02Vwit4MfOJmHR+eJR74swFFJp2Fyfr9sQPc0JcqVtIfXKqDJSlgrU06vWeww2oeCMIIg4JZg4N/yGwqbtc1PIjmfi1acEPWSGXCTpHCM5KjbjAIP8YmcG16HVQXZVJIXTA4cGWRmcRji9kPsMKYa9zf30FSnr87HOfF2za7v8eV5P7bCtLLmaKid8bbFXQTqnS/qA2ej69LjmicQlo8IOtKXly0L2TeL4lSOUSnbwyE6SDrTjKh+3E0zjozF70Nj4MGOvI4aOenNUR8F2XJU/y6g4JVC1hqICOKAozMlxlXxv3vGpmtzvJLIjleiWlnLDj4cIaexCxLvEPxg2Cccn+gJwDY1diGeqG3zTxvO/OwKLIvA6O7azX4Pnb9Fn+v0zR6BMs8O7gpeOczTxR3hXSKUpphShRhI5DfuHApBNYQ8zh2vlh59zbmy8OMRx0SAcLyxpTC6OwFpXbZ0UE3xDigj3EZiKWko6zk2sqgSuZ1zKU0pqGlaXMfaSo9flxZncMxeyAy5q+lFLbdAmLpmsiw8jAYEmsuMRcc4g0c5ocgQSklhNk47c7EBOdgkL3/GSOZFdxyn6bcuKQArZxR4UEnIJXyAp99CKcstTY+VkN/UK+PsdgQwRSCG7OG8Qux1HA0rpEMLg4gg4Ao7ALBBIIbtiBYLDEor+lU0+xF6dtUJ2FOxGLo6AIzA9AqemkB3DjJtjxCWvU6aA15Z0EWx99Iwsdv1hDKSckDJCmEto3kwIC6Wj++plmjLWvq/xEJy+EfXnOQLdENggleziqqGptaV4NqlL2NCIgCbdo9hUhWsgUqKkQ/R1PBXCBiDBslZs3aY87l1OduPi7W9zBKoQSCY7umyT0rG1Nb0lkZfu63USVyEIToMi2VFvjABQjsbYAGl9RloTJbYpuEj8HoncEOwcicOPsf7jcwTyQCDpGEsZZTyvhJpsk1Cgr2xqZWRHDB+5mqdZ6kh8X+hpSdZG236m7o3NY3P5KByBrBBoOsbyd0oB0VmblnShoQkBxXVlrouTLCO7jazUCy38ynolhKMzuXXrdfeuQdHJLqstNvlg+HBiTuG0QJ4sObMkoJ9hyeVU2aW/rsuSI9BEdiTeUmKF2DoSzUMDZhrX8i/1aFlGdmRfUBWjqg8kmxJCJW2tTbMNJ7sl37QtpoezCxNIKD9UdisVOigOScmhugZFLV7rl+aIQB3ZYTujikEIHqa0NXY7PKbFbj8EHuNg4GuZeoxtwiNodmh+VEdIJdam5/rfVwMB7MFHm3MsZcbURMN2nFtGUMrY/ZoEBKrIDtWfahGUX6EUCxI3VY5zRKkXxrVHSTq/R7Lj6Eo1Fby1lHVxcQRSEQjt+qiOSy018rd/aXX8OFHwIaUOGqWDgnC0RQP8XOpL/Lp5IQDZ4SigysmupsrTNAObHLXgsWfEGlXcy5F4u2MlHWCNNgIp9qHZsVkPt3aAxQqm80LYRzsFAvTEpRQ7zaBPqTgVxGXqwxj77p87xdz9nRUIQHZxCe1wWZVKH3f+5lq+hpBeEyFVhZ6UDSs056DiLBvWjxW+fdsgwEnjCOshC3nVmT/ihs28g85knChow+iyZAhALHzhHi3pJUZeGHQppXxxyVzja3Ec0DyDBieVdd/tGW3IDlsLpaRCHfslg9ynMzACOLbYy5SprzKrxEOIK7msegmvgZdm2sc3eWP7Gl0q2bFRKRYKic45Tawv3Pw57REgegCHWWogeuy9H4LsUBAIjqcfhtfWa7+evd2RE9ltYc4INqkTXW9LvHIPglzY15BLisRkV8zwSbmfY/NekrATYvcmHvVEO5kQWhUaSFe1uEx5h1/TAwK5kB3xUGh02FqwAxaFLvZsoqH6nPYApT9ipgjEZBeK05K22CT0X9nFSI1riTvF5kexC2zbB1mXLRx4Q2iMTePzvxcQyIHsNpG0nyT6VxDgWRQcFXjVqIpcFYDsC+sIdEUgVPRpE3pC+Ao527SoRIujF0vRPhjbApuaPHcdu9/XAoGxyG5Pa3lW9HYRuAzJxR3cy4ZPBgWNeF0cgT4RIOyK/Gv6kaY2i+LYSpA7TcfpPk84VllVnlhjJA4V84zLhAgMTXZUS6HVInF8OB8QwlQI8sS9T427ulQeri92NZsQLn/1kiGwme1HQlCILSUPu07i2Dx6o9LLlMrdZRLXgCTtkoIXLhMiMDTZTTg1f7UjUIsAex97GppdSqxoiP+k8z3eVUJb6uL4ONoSJ0qQPvZoyNFlQgSc7CYE3189KQJUxyZD6JjEnFiiBbC9UYiWrAxqOlbF8WHT49jKETf1eDwpGKvwcie7VVhln2MRgWArPs+KxDaFOhX7JzfZkIkuoGjGjpY37va6DPagk10Gi+BDGBUBHAwErSN4U5uIjuviNEmKY1BA4NyaURNzd7z93e11oy5v9cuc7DJZCB/GKAgEB8OmLYiOgQX7G//d1IMlzrd1e90oy5r2Eie7NJz8qvkjANFBWgSoU+iiLHi9bJY4I2gIhY0OacqE2N3qPXKfx9dltG+c7DJaDB/KYAhAdHhcKTLRhugYEHm2ODKogUcGD+EmVSEqFLiFGPcwjy09VsjKcMkAASe7DBbBhzAoAoHo6IxH8HBZlk5xANtaqAi9V3aI8lvrjqW8h7afZPwQRIyg5Z006Oz84ckIONklQ+UXzhCBQHS3sRYDFybMAe2PkmcEvOO8iDMhTraYueJzQgwezo+NJR0saY2kfSWdLYlQlN2MNCmK6zIBAk52E4DurxwFAYiOjmKQDKldTY3WSexHoyMVjNi4D9soicej5wpxdmXHWH5DO0uiBDxeXv5h3wstQLENovGdWdIydBQg/CWXIOBk5zthGREIRIfnFEdBG0F7ozDFBXbThpaXHdIaKSobCsuiye0vaXPrgUzTqRBfR7cybHb0uoAkm6p5txmjX9sBASe7DqD5LVkjgIZGehZd6doSHROjmkmx8Oc+kkgTg8wQ7H7nGMlR1ZumPhx5Y2cG16HVQXYQYFM176xBXYbBOdktwyr6HGIEKDyBFtWF6NDm9i5pCcrvZCez+3FcJc/1BNP48MyGPhfY5rDXkSZGAyqOxAQhexvQDPaok10Gi+BDcAQcgeERcLIbHmN/gyPgCGSAgJNdBovgQ3AEHIHhEfgfZwu/jsQoorwAAAAASUVORK5CYII=" style="height:57px; width:222px" /></p>
', N'DK-1                          ', 1, 1, 0, 5, CAST(N'2018-04-12 09:41:55.000' AS DateTime), 5, CAST(N'2018-04-12 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (54, 4, N'KHOI-1                        ', 19, N'DT-20                         ', N'<p>Một vật dao động điều h&ograve;a tr&ecirc;n trục ox với phương tr&igrave;nh . Pha dao động ở thời điểm t = 0,5s l&agrave;:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-01 07:29:30.147' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (55, 4, N'KHOI-1                        ', 19, N'DT-20                         ', N'<p>Một vật dao động điều h&ograve;a giữa hai điểm M v&agrave; N c&oacute; thời gian ngắn nhất để đi từ M đến N l&agrave; 0,4s. Chu<br />
k&igrave; dao động l&agrave;:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-01 07:30:12.003' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (56, 4, N'KHOI-1                        ', 20, N'DT-20                         ', N'<p>Một vật dao động điều h&ograve;a giữa hai điểm M v&agrave; N c&oacute; thời gian ngắn nhất để đi từ M đến N l&agrave; 0,4s. Chu<br />
k&igrave; dao động l&agrave;:</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-01 07:30:27.260' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (57, 4, N'KHOI-1                        ', 20, N'DT-20                         ', N'<p>Trong dao động điều h&ograve;a theo phương ngang của chất điểm, chất điểm đổi chiều chuyển động khi</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-01 07:30:47.227' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (58, 9, N'KHOI-1                        ', 11, N'DT-19                         ', N'<p>Mark the letter A, B, C or D on your answer sheet to indicate the word that differs from the other three in the position of primary stress in each of the following questions</p>
', N'DK-1                          ', 2, 1, 0, 3, CAST(N'2018-05-08 08:37:29.483' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (59, 9, N'KHOI-1                        ', 11, N'DT-19                         ', NULL, N'DK-1                          ', 2, 1, 0, 3, CAST(N'2018-05-08 08:38:57.000' AS DateTime), 3, CAST(N'2018-05-09 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (60, 9, N'KHOI-1                        ', 13, N'DT-19                         ', N'<p>It&rsquo;s quite possible that James won&rsquo;t remember ___________ my medicine on his way back from work. Then I&rsquo;ll have to drive to the pharmacy myself in the evening.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-08 08:42:49.000' AS DateTime), 3, CAST(N'2018-05-08 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (61, 9, N'KHOI-1                        ', 12, N'DT-19                         ', N'<p>Young Betty talks to her imaginary pet rabbits as if they __________ real.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-08 11:57:11.493' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (62, 9, N'KHOI-1                        ', 12, N'DT-19                         ', N'<p>Although both civilizations built pyramids, those of the Aztecs were used in a ___________ way ___________ those of the Egyptians.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-08 11:57:49.587' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (63, 9, N'KHOI-1                        ', 12, N'DT-19                         ', N'<p>I watched the bird __________ its nest in the oak tree in our garden; it was inspiring to see that, although it was having great difficulty, it kept __________ until it succeeded.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-08 11:58:33.307' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (64, 9, N'KHOI-1                        ', 12, N'DT-19                         ', N'<p>I really can&rsquo;t stand Merve&rsquo;s boasting about herself all the time; I wish she ___________ to be a little more modest.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-08 11:59:03.000' AS DateTime), 3, CAST(N'2018-05-08 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (65, 9, N'KHOI-1                        ', 12, N'DT-19                         ', N'<p>He was wearing glasses _____ no one could see his face clearly.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-08 12:00:17.407' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (66, 9, N'KHOI-1                        ', 12, N'DT-19                         ', N'<p>You should not eat more _____ yourself ill.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-08 12:00:43.550' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (67, 9, N'KHOI-1                        ', 13, N'DT-19                         ', N'<p><strong>Motion Pictures: Forever Changed by the Computer</strong></p>

<p>We are truly at a(n) (1)__________ between imagination and reality, especially when it comes to film. No longer are we able to tell what is real and what isn&rsquo;t. In the past, it was easy to tell if a scene in a film was created artificially, as the special effects were never very good. To a person who grew up with the special effects that Hollywood can create today, the effects in films from 50 years ago are laughable. The scenes from these films come (2)__________ as so obviously fake that they are almost painful to watch.</p>

<p>Today, however, a line has been crossed. Computer-generated animation has made it nearly impossible to (3)_________ between what was actually filmed and what was created by lines of computer code by a programmer. Not only is scenery created by computers, but also many actors known as extras. In the past, a film director would have to hire dozens and possibly hundreds of extras in order to show a crowd scene. This is no longer the (4)____________, and the one film that proved thus was achievable was Titanic, directed by James Cameron. However, years later, computer animation was taken to yet another (5)__________ by the same director with the movie Avatar.</p>

<p>Giải th&iacute;ch:</p>

<p>&nbsp;</p>
', N'DK-1                          ', 5, 1, 0, 3, CAST(N'2018-05-08 12:01:11.000' AS DateTime), 3, CAST(N'2018-05-09 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (68, 9, N'KHOI-1                        ', 25, N'DT-19                         ', N'<p>According to the passage, what is the main advantage of cellphones?</p>
', N'DK-2                          ', 1, 1, 0, 3, CAST(N'2018-05-09 17:15:17.080' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (69, 1, N'KHOI-1                        ', 26, N'DT-16                         ', N'<p>T&igrave;m gi&aacute; trị của x qua biểu thức :</p>

<p>x+1=2 ... x=?</p>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-05-15 07:42:27.090' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (70, 1, N'KHOI-1                        ', 26, N'DT-16                         ', N'<p>T&iacute;nh&nbsp;&nbsp;<img alt="MathML (base64):PG1hdGg+CiAgICA8bWZyYWM+CiAgICAgICAgPG1yb3c+CiAgICAgICAgICAgIDxtbj40PC9tbj4KICAgICAgICA8L21yb3c+CiAgICAgICAgPG1yb3c+CiAgICAgICAgICAgIDxtcm93PgogICAgICAgICAgICAgICAgPG1uPjQ2PC9tbj4KICAgICAgICAgICAgPC9tcm93PgogICAgICAgIDwvbXJvdz4KICAgIDwvbWZyYWM+CiAgICA8bW8+KzwvbW8+CiAgICA8bWZyYWM+CiAgICAgICAgPG1yb3c+CiAgICAgICAgICAgIDxtbj4yMDwvbW4+CiAgICAgICAgPC9tcm93PgogICAgICAgIDxtcm93PgogICAgICAgICAgICA8bW4+MjM8L21uPgogICAgICAgIDwvbXJvdz4KICAgIDwvbWZyYWM+CjwvbWF0aD4=" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAH0AAABBCAYAAAD8OKvzAAAKgElEQVR4Xu2dZawsTRGGnw93glvQQICgwQkQ3N2Cu0Nwh+DubsHdPQR3d/mBhyDBgkNwzXOp/r6+fUZ6Zmf27J6dTk7uuWd7enrqnaqurqp+9wiWtnMSOGLmJ3b8GwC3B54PvHPm+y3DV0hgbtAvBLwFOCNwc+C1FXM6SF2OAVwSuBVwceDswJ+ALwAfAN4A/HjAAx8fuCZwXeCcwF+AUwMfAl4KfB74T994c4J+CuBFMUHnsWug+6I/I3v+Jix+CzwceAnw9w6wxMmX5pnAsYD7Ax8OgE8E3DHGeTPwUOAXXcDPBbpv+H2BJ2Y33yXQ1cKXAxft07r4/EHA04B/NfQXo6sAL4jPtBofL/rl8nYJvRPwy7Z7zwX65eLN+2tMeJc0Xc17DnCNeOld0tQ8ze5xgQsCdwVukoGiyddkq71l8wV6PXA+4DHAo4B/N/Q7DfAq4ArhPz0A+HMT8HOAfjrgFbHGnA14dNx4VzT9esDTgdsCHwX+2yD4Jkv4bECgcjPvS+ISoeb+HLhO+ANtWN47LIYv0S3aHOepQXeST46Ju7b4ELsEuo7Wc4GvAYLYBHgCLFmEW8YfPgbcDPhZhuhFgHcAarEOsbugP3QsGVqRd0f/twO3A35X9p8SdMfSZN0GuDXwU+BhOwa63vljgXvF8/ct6YL8muj0deBGwHfi/0cHHhEy9E9PiN+bTHu6j87z68LEq+1XBT49J+iuPe7FH5k5GrsG+rWAs4ZJ7tLyhMMlgE+1gH5y4NWZT6QD55rd1Y4HPCssgv2U/+NKizOVpidT9c3CC9010F2rlek/+1Q8Ps9Bf3+Y99/EZ+cNk65fZLsS8MGecb231sEfW+OSMAXojnEP4NLhcPwqm9iugV6J9ZHdctBL863VyCOYBnn2mOqGG+rM6UjaPgPcFPhR3m8K0AU7mZQvFZNYQO9+DVzDjco1bdl08F7ZYvq7Rs39BD1+I3hfnhL0U0XU7T0RVSrXsQX0dnh01Nx3PzhkqIYa10gtl13p5NWCbr89FmIVTXf9MpJ0BsAJNwUCFtDb4TlzBF30h24MfKPDSm4M6NcO0A1CfKvl2RbQmwWT/CA1/c4BfpeV3AjQ9SjdPriWuya1tQX0ZsnomSs31+y2mPtGmXejTkbdXH+MunVlhxbQ94Ke/KAfhvwa4+OxfWsL3NSu6ZM4cpolvUNNurFdo25dbQH9cOkkhfGvrQmRuOSKkXP3v3r37tM/1yNvPzZO/8Lop9euv/D9Vbz3PAFQcf/OLvuVgDHPrRNlGtO1UoGuo6Uki45vH+DOpwzOuDX+RMVEc0VzV6VyHhZ/H+q9HwTQ0z52iHNUIevOLgLuDudM4fzWvGhlGLZGSUp8GuP1C+hHJThWBbbtegHXQzc34Ra3BnDHKhMu5tH96Yrp5wkXx3CH9a5yYkNBHyqYTVzT16npCfDzRBDG8qi+doEImxqDH5pazZcE6+aM6unMHdYW0OfT9AT4hYH7AXlOog14rcEdIjumV18WUewJqRYD5U6cdXPW3u2xDAvo84Au4KZC9cDv2VWvFqAdDVDDTYNaTPq2DMy0p/eFeEhsl5ty6qcEXgyYqLGAwheg8UVbQJ8e9AS4ZU4n7LPlxedNJlmMTMw8L/yBvsJIy6AtZGmLkh7K/c7Zdm1NV2NNZVpMMhRwcbCC2JelNMnidOUogf5bUQLt3v8uUYjqS+Mu4bBU6rKm/z+4ZKRrji3b1SOOPgbwvsJHsTsZcP1IlxoK/zVw0jjkYJmU+/iuCOkh/OfW9DmtyNix5wR97JzWet0C+vRr+loBHHOzBPplxly85mssEW5rmj0PFbjuzdFqomFbI8MEek3l5hzCHDJml1XaBNC3RoYL6HWvXY2mbx3oW2Oa6jDq7DWXI7c1MlwcuR125CZQoK0ZYi5N3xoBrKLpXjsFtYjjWEJkRsmf88cJEWvIPKHRdXZrjKDXDfqUbBTHBi4blUuXj8CMZ98+CbxsHUwUq1KLmEHyDPfdgUsBHuux0NKoUlvd2BiQy2vWCfqUbBTSjFibaCVMWzP8a+i7M4U7VtNXoRYxPi1pweMB045fjOzRR2r4UiZAfV2gT8lGkYopLYroa1bXdhasjgF9FWoRkwOmB/2xpVOuNbnmvoet/XwdoE/JRpGKKTXnTwGse0vUIsbdTaU+MEiMlEFjBWwunDGgj6UWMQnxpMgIOQePNKdS6lrApui3DtCnZKOwmtV0qodEv9ciAIsmraF3ObF1xhWGgj6WWiS9rXKtJA2vqQidAuR1r+lTslGcJBTFdGtrfryosJkU9LHUIuVy4HFb30SL/fejza3pU7JRaFX1n95YIahUu9Cboq3VdPuNpRaxSN+tV8ox14Q0K55xdJe5696nZKPQapgfb6IaK5fpREbgcTN3RH9sk1At6GOpRTRP1nzdMCbQSn4zGsLNu3BKNorapztxFEGevq9UygFrQF+FWkSH5q3ZzK3/9iVY2lES6GKjqJWT1vRu4cV/u++iPtDTkdox1CLJoZFpypa2ElJmWUdmOa/j2r4anGuyLMpb08tv2vdgW/R5FxtFzWOcO8gNpDKTt65Xdn2gr0ItokOjAyLToU3+E0t7XW/S1qLpoZ4a9Fk1BwNqhLLJffrYKLrm7jJi0YjBGGVtc/m0xv4HXRd2gb4qtUhJlOM8pLuUL1YT9A/AiesvWM3pT2oGbfZrS7fOl6SPjaJpLi63hq9dKg1fl80SaD+TwLCxtYE+BbWIXCqGWmuAbIryyY4onfVBbWnp7GKjKJ/9LJHk8nCjFlSLmbQ87ysbtIcd9rBF2qkN9FWpRRw35zPr3TsCevqCLDGu7X2RXLDM9yC2GjaKvuc2j+FJWK2kIOel142HF9tAn4JapDwyaxG+zltfjD0/izXkIH6fcDbt81o2itp5q2Qqi/xxyV9qpRUtNX0qapES9JINse1hLhbsC5sSyKkV+pB+Q9gohoyrU6gflJZUt8YlTdmh8XLQ/X1KapH8SFMt6KXHv9/RuyFCr+k7lI2iZsy8T35UuQr0qVkmTpBxn9Sa9/JQfQ0J7lDB7Ff/MWwUQ+eay88dkGfjPPt2WMs1fWrQTai8N5yL2nNjZf36QdH0sWwUQ0HP5XefOAy5Z4w5QTc65KmTVBpcQ5Rz2uyag+LIrcpGMQT4JD/3/34LRONevS8i13XDvmPIJWdKTdz9HMCbAOk6Wukzhkhhn/tOwUYx5BGM42td/Q4Zt8yN2bk5QXeyefFkTYYt505rO6s9RAj72XcqNgqXXVtOFtz0XFbKymThlwzM9m1NfZruxHxwGZGsidNcWzLtl9C1TdryKcuCXBpqyAn3E9Sue0/FRmFSyi9BOmbUEyqfppxEIkNwr+5aPhspQQ3oCsZAhObGnHoXNUaq8/p9RJg+u6mI9sxrSjaKMpRt5bCVripFMt1+qY8ha+vntKazkhLUgq6MrNo0cGCNnMmWfOIKKVV6/iSoNXpzwhv8QkzJRuEWzG9culocAklBKw84eD7gK/Hvdyuqa44U2dxreo6N99JRMxzrF8adKzjOjxNfU6EDpyXoKw3aYLy3Y2qrgL4dT7jMsnOfvohnRyTwPz1mHW8itK1iAAAAAElFTkSuQmCC" style="height:26px; width:50px" />&nbsp;?</p>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-05-15 07:46:54.510' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (71, 1, N'KHOI-1                        ', 26, N'DT-16                         ', N'<p>&acirc;cscasc</p>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-05-15 07:47:14.230' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (72, 1, N'KHOI-1                        ', 27, N'DT-16                         ', N'<p>cccc</p>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-05-15 07:47:28.310' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (73, 1, N'KHOI-1                        ', 27, N'DT-16                         ', N'<p>c</p>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-05-15 07:47:38.447' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (74, 1, N'KHOI-1                        ', 27, N'DT-16                         ', N'<p>ac</p>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-05-15 07:47:49.273' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (75, 1, N'KHOI-1                        ', 28, N'DT-17                         ', N'<p>mnm?</p>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-05-15 16:54:39.433' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (76, 1, N'KHOI-1                        ', 29, N'DT-17                         ', N'<p>vdvdx??</p>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-05-15 16:54:53.887' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (77, 1, N'KHOI-1                        ', 28, N'DT-17                         ', N'<p>hhhhhh?</p>
', N'DK-1                          ', 1, 1, 0, 10, CAST(N'2018-05-15 16:56:15.793' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (78, 9, N'KHOI-3                        ', 30, N'DT-18                         ', N'<p><strong>Mark the letter A, B, C, or D on your&nbsp;</strong><strong>answer sheet to indicate the word that differs from the rest in the position of the main stress in each of the following question.</strong></p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 14:54:59.000' AS DateTime), 3, CAST(N'2018-05-17 00:00:00.000' AS DateTime))
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (79, 9, N'KHOI-3                        ', 30, N'DT-18                         ', N'<p><strong>Mark the letter A, B, C, or D on your&nbsp;</strong><strong>answer sheet to indicate the word that differs from the rest in the position of the main stress in each of the following question.</strong></p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 14:57:08.987' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (80, 9, N'KHOI-3                        ', 30, N'DT-18                         ', N'<p>The word &ldquo;Those&rdquo; in bold refers to</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 14:58:46.700' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (81, 9, N'KHOI-3                        ', 30, N'DT-18                         ', N'<p>&ldquo;How lovely your pets are!&rdquo;</p>

<p>&ldquo;_______________&rdquo;</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:01:12.307' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (82, 9, N'KHOI-3                        ', 30, N'DT-18                         ', N'<p>Jenny and her teacher are meeting at the bus stop. Jenny: &quot;Good afternoon, Miss. How are you?&quot; Teacher: &quot;______. And you?&quot;</p>
', N'DK-1                          ', 0, 1, 0, 3, CAST(N'2018-05-17 15:03:39.903' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (83, 9, N'KHOI-3                        ', 30, N'DT-18                         ', N'<p>Mark the letter A, B, C, or D on your answer sheet to indicate the word whose underlined part differs from the other three in pronunciation in each of the following questions.</p>

<p>&nbsp;</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:05:06.773' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (84, 9, N'KHOI-3                        ', 30, N'DT-18                         ', N'<p>Mark the letter A, B, C, or D on your answer sheet to indicate the word whose underlined part differs from the other three in pronunciation in each of the following questions</p>

<p>&nbsp;</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:06:30.797' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (85, 9, N'KHOI-3                        ', 31, N'DT-18                         ', N'<p>Mr Brown has kindly agreed to spare us some of his ______ time to answer our questions.<br />
&nbsp;</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:08:09.287' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (86, 9, N'KHOI-3                        ', 30, N'DT-18                         ', N'<p>It is not always easy to make a good ______ at the last minute</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:08:53.983' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (87, 9, N'KHOI-3                        ', 30, N'DT-18                         ', N'<p>When the manager of our company retires, the deputy manager will ______ that position.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:09:37.377' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (88, 9, N'KHOI-3                        ', 31, N'DT-18                         ', N'<p>. A university degree is considered to be a ______ for entry into most professions.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:10:31.900' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (89, 9, N'KHOI-3                        ', 31, N'DT-18                         ', N'<p>The book ______ you gave me is very interesting.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:11:11.353' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (90, 9, N'KHOI-3                        ', 31, N'DT-18                         ', N'<p>You ______ use your mobile phone during the test. It&#39;s against the rules.</p>
', N'DK-1                          ', 0, 1, 0, 3, CAST(N'2018-05-17 15:12:16.660' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (91, 9, N'KHOI-3                        ', 31, N'DT-18                         ', N'<p>A survey was ______ to study the effects of smoking on young adults.</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:13:51.440' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (92, 9, N'KHOI-3                        ', 31, N'DT-18                         ', N'<p>The better the weather is, ______.</p>

<p>&nbsp;</p>
', N'DK-1                          ', 1, 1, 0, 3, CAST(N'2018-05-17 15:15:23.307' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Question] ([Id], [SubjectId], [Grade], [SectionId], [ExamId], [QuestionContent], [LevelDifficult], [SubQuestion], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (93, 9, N'KHOI-3                        ', 32, N'DT-18                         ', N'<p>In the early twentieth century, an American woman named Emily Post wrote a book on etiquette. This book explained the proper behavior Americans should follow in many different social (1)______, from birthday parties to funerals. But in modern society, it is not simply to know the proper rules for behavior in your own country. It is necessary for people (2)______ work or travel abroad to understand the rules of etiquette in other cultures as well. Cultural (3)______ can be found in such simple processes as giving or receiving a gift. In Western cultures, a gift can be given to the receiver with relatively little ceremony. When a gift is offered, the receiver usually takes the gift and expresses his or her thanks. (4)______, in some Asian countries, the act of gift-giving may appear confusing to Westerners. In Chinese culture, both the giver and receiver understand that the receiver will typically refuse to take the gift several times before he or she finally accepts it. In addition, to (5)______ respect for the receiver, it is common in several Asian cultures to use both hands when offering a gift to another person. (Source: Reading Advantage by Casey Malarcher)</p>
', N'DK-1                          ', 5, -3, 0, 3, CAST(N'2018-05-17 15:31:09.000' AS DateTime), 3, CAST(N'2018-05-17 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Ex_Question] OFF
SET IDENTITY_INSERT [dbo].[Ex_Subject] ON 

INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Toán học', 1, 1, 1, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Vật lý', 1, 1, 1, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Hóa học', 1, 1, 3, CAST(N'2018-03-25 15:51:55.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Sinh học', 1, 1, 3, CAST(N'2018-03-25 15:52:27.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Địa lý', 1, 1, 3, CAST(N'2018-03-25 16:31:09.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Tiếng Anh', 1, 1, 3, CAST(N'2018-03-25 16:32:40.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'Văn học', 1, 1, 3, CAST(N'2018-04-11 20:52:57.837' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Ex_Subject] OFF
SET IDENTITY_INSERT [dbo].[Ex_SubQuestion] ON 

INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, 36, NULL, 1, 1, 3, CAST(N'2018-04-03 10:13:24.890' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, 37, NULL, 1, 1, 3, CAST(N'2018-04-03 10:16:45.423' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, 38, NULL, 1, 1, 3, CAST(N'2018-04-03 10:23:55.640' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, 39, NULL, 1, 1, 3, CAST(N'2018-04-03 10:46:37.720' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (23, 41, NULL, 1, 1, 3, CAST(N'2018-04-03 10:47:57.867' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (25, 43, NULL, 1, 1, 3, CAST(N'2018-04-03 10:49:42.250' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (28, 45, NULL, 1, 1, 3, CAST(N'2018-04-03 10:52:03.827' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (30, 47, NULL, 1, 1, 3, CAST(N'2018-04-03 10:53:17.360' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (31, 48, NULL, 1, 1, 3, CAST(N'2018-04-03 10:53:45.313' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (32, 49, NULL, 1, 1, 3, CAST(N'2018-04-03 10:54:14.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (33, 50, N'Câu 1', 1, 1, 3, CAST(N'2018-04-09 23:41:05.327' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (34, 50, N'Câu 2', 2, 1, 3, CAST(N'2018-04-09 23:41:05.397' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (37, 52, N'X=?', 1, 1, 10, CAST(N'2018-04-11 21:17:10.220' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (39, 53, N'c', 1, 1, 5, CAST(N'2018-04-12 09:42:45.203' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (40, 35, NULL, 1, 1, 3, CAST(N'2018-05-01 07:26:23.760' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (41, 54, NULL, 1, 1, 3, CAST(N'2018-05-01 07:29:30.187' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (42, 55, NULL, 1, 1, 3, CAST(N'2018-05-01 07:30:12.027' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (43, 56, NULL, 1, 1, 3, CAST(N'2018-05-01 07:30:27.277' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (44, 57, NULL, 1, 1, 3, CAST(N'2018-05-01 07:30:47.247' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (45, 42, NULL, 1, 1, 3, CAST(N'2018-05-01 07:31:10.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (46, 44, NULL, 1, 1, 3, CAST(N'2018-05-01 07:31:20.140' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (47, 40, NULL, 1, 1, 3, CAST(N'2018-05-01 07:31:32.107' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (48, 46, NULL, 1, 1, 3, CAST(N'2018-05-01 07:31:53.897' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (49, 58, N'A. continent B. permission C. circumstance D. interest', 1, 1, 3, CAST(N'2018-05-08 08:37:30.003' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (50, 58, N'A. religious B. miserable C. perform D. include', 2, 1, 3, CAST(N'2018-05-08 08:37:30.047' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (68, 61, NULL, 1, 1, 3, CAST(N'2018-05-08 11:57:11.887' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (69, 62, NULL, 1, 1, 3, CAST(N'2018-05-08 11:57:49.610' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (70, 63, NULL, 1, 1, 3, CAST(N'2018-05-08 11:58:33.340' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (72, 64, NULL, 1, 1, 3, CAST(N'2018-05-08 11:59:50.830' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (73, 65, NULL, 1, 1, 3, CAST(N'2018-05-08 12:00:17.430' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (74, 66, NULL, 1, 1, 3, CAST(N'2018-05-08 12:00:43.603' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (76, 60, N'It’s quite possible that James won’t remember ___________ my medicine on his way back from work. Then I’ll have to drive to the pharmacy myself in the evening.', 1, 1, 3, CAST(N'2018-05-08 12:01:37.717' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (92, 68, NULL, 1, 1, 3, CAST(N'2018-05-09 17:15:17.220' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (97, 59, N'A.cough B.tough C.rough D.enough', 1, 1, 3, CAST(N'2018-05-09 17:28:44.220' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (98, 59, N'A.prescription B.preliminary C.presumption D.preparation', 2, 1, 3, CAST(N'2018-05-09 17:28:44.230' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (109, 67, N'A.place B.crossroads C.junction D.intersection', 1, 1, 3, CAST(N'2018-05-09 17:53:14.367' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (110, 67, N'A.across B.up C.on D.along', 2, 1, 3, CAST(N'2018-05-09 17:53:14.380' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (111, 67, N'A.differ B.notice C.separate D.distinguish', 3, 1, 3, CAST(N'2018-05-09 17:53:14.407' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (112, 67, N'A.occasion B.argument C.case D.problem', 4, 1, 3, CAST(N'2018-05-09 17:53:14.413' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (113, 67, N' A.level B.ability C.floor D.ladder', 5, 1, 3, CAST(N'2018-05-09 17:53:14.417' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (114, 69, NULL, 1, 1, 10, CAST(N'2018-05-15 07:42:27.317' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (115, 70, NULL, 1, 1, 10, CAST(N'2018-05-15 07:46:54.577' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (116, 71, NULL, 1, 1, 10, CAST(N'2018-05-15 07:47:14.267' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (117, 72, NULL, 1, 1, 10, CAST(N'2018-05-15 07:47:28.353' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (118, 73, NULL, 1, 1, 10, CAST(N'2018-05-15 07:47:38.470' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (119, 74, NULL, 1, 1, 10, CAST(N'2018-05-15 07:47:49.303' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (120, 75, NULL, 1, 1, 10, CAST(N'2018-05-15 16:54:39.487' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (121, 76, NULL, 1, 1, 10, CAST(N'2018-05-15 16:54:53.917' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (122, 77, NULL, 1, 1, 10, CAST(N'2018-05-15 16:56:15.843' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (124, 78, NULL, 1, 1, 3, CAST(N'2018-05-17 14:55:51.947' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (125, 79, NULL, 1, 1, 3, CAST(N'2018-05-17 14:57:09.017' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (126, 80, NULL, 1, 1, 3, CAST(N'2018-05-17 14:58:46.727' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (127, 81, NULL, 1, 1, 3, CAST(N'2018-05-17 15:01:12.337' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (128, 83, NULL, 1, 1, 3, CAST(N'2018-05-17 15:05:06.843' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (129, 84, NULL, 1, 1, 3, CAST(N'2018-05-17 15:06:30.827' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (130, 85, NULL, 1, 1, 3, CAST(N'2018-05-17 15:08:09.320' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (131, 86, NULL, 1, 1, 3, CAST(N'2018-05-17 15:08:54.017' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (132, 87, NULL, 1, 1, 3, CAST(N'2018-05-17 15:09:37.437' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (133, 88, NULL, 1, 1, 3, CAST(N'2018-05-17 15:10:31.927' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (134, 89, NULL, 1, 1, 3, CAST(N'2018-05-17 15:11:11.410' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (135, 91, NULL, 1, 1, 3, CAST(N'2018-05-17 15:13:51.500' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (136, 92, NULL, 1, 1, 3, CAST(N'2018-05-17 15:15:23.373' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (142, 93, N'(1)', 1, 1, 3, CAST(N'2018-05-17 15:33:26.480' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (143, 93, N'(2)', 2, 1, 3, CAST(N'2018-05-17 15:33:26.493' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (144, 93, N'(3)', 3, 1, 3, CAST(N'2018-05-17 15:33:26.503' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (145, 93, N'(4)', 4, 1, 3, CAST(N'2018-05-17 15:33:26.510' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_SubQuestion] ([Id], [QuestionId], [SubQuestionName], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (146, 93, N'(5)', 5, 1, 3, CAST(N'2018-05-17 15:33:26.517' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Ex_SubQuestion] OFF
SET IDENTITY_INSERT [dbo].[SysGroup] ON 

INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'Nhom Test', N'<p>cascascascasc sa <b>asd asd asd&nbsp; &nbsp;</b></p><p><b><u>a</u></b></p><p><b><u>câcc</u></b></p><p><b><u>âccac</u></b></p>', 1, 3, CAST(N'2018-01-17' AS Date), 2, CAST(N'2018-01-24' AS Date))
INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'Nhóm admin', N'<p>cascascascasc sa <b>asd asd asd&nbsp; &nbsp;</b></p><p><b><u>a</u></b></p><p><b><u>câcccccccccc</u></b></p><p><b><u>âccac</u></b></p>', 1, 3, CAST(N'2018-01-17' AS Date), 3, CAST(N'2018-01-24' AS Date))
INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'Giáo viên', NULL, 1, 3, CAST(N'2018-04-12' AS Date), NULL, NULL)
INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'Học viên', NULL, 1, 3, CAST(N'2018-04-12' AS Date), NULL, NULL)
INSERT [dbo].[SysGroup] ([Id], [Name], [Summary], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'Kiểm soát viên', NULL, 1, 3, CAST(N'2018-04-12' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysGroup] OFF
SET IDENTITY_INSERT [dbo].[SysGroupMenu] ON 

INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (114, 19, 4, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (115, 19, 5, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (116, 19, 6, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (121, 19, 16, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (125, 19, 18, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (128, 19, 22, 4, N'View', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (129, 19, 4, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (130, 19, 5, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (131, 19, 6, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (138, 19, 18, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (141, 19, 22, 0, N'Admin', 1, 1, CAST(N'2018-01-30' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (144, 19, 7, 4, N'View', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (145, 19, 28, 4, N'View', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (146, 19, 24, 4, N'View', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (147, 19, 25, 4, N'View', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (148, 19, 26, 4, N'View', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (149, 19, 27, 4, N'View', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (150, 19, 26, 1, N'Add', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (151, 19, 26, 2, N'Edit', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (152, 19, 26, 3, N'Delete', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (154, 19, 25, 1, N'Add', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (155, 19, 25, 2, N'Edit', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (156, 19, 25, 3, N'Delete', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (157, 19, 25, 0, N'Admin', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (158, 19, 27, 1, N'Add', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (159, 19, 27, 2, N'Edit', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (160, 19, 27, 3, N'Delete', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (161, 19, 27, 0, N'Admin', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (162, 19, 28, 1, N'Add', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (163, 19, 28, 2, N'Edit', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (164, 19, 28, 3, N'Delete', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (165, 19, 28, 0, N'Admin', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (166, 19, 7, 1, N'Add', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (167, 19, 7, 2, N'Edit', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (168, 19, 7, 3, N'Delete', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (169, 19, 7, 0, N'Admin', 1, 1, CAST(N'2018-03-28' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (170, 19, 26, 0, N'Admin', 1, 1, CAST(N'2018-03-29' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (171, 19, 33, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (172, 19, 33, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (173, 19, 33, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (174, 19, 33, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (175, 19, 33, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (176, 19, 17, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (177, 19, 31, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (183, 19, 31, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (184, 19, 31, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (185, 19, 31, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (186, 19, 31, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (187, 19, 22, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (188, 19, 22, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (189, 19, 22, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (190, 19, 17, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (191, 19, 17, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (192, 19, 17, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (193, 19, 17, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (194, 19, 15, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (195, 19, 12, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (196, 19, 13, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (197, 19, 20, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (198, 19, 23, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (199, 19, 30, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (200, 19, 12, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (201, 19, 12, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (202, 19, 12, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (203, 19, 12, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (204, 19, 13, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (205, 19, 13, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (206, 19, 13, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (207, 19, 13, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (208, 19, 18, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (209, 19, 18, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (210, 19, 18, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (211, 19, 20, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (212, 19, 20, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (213, 19, 20, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (214, 19, 20, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (215, 19, 23, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (216, 19, 23, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (217, 19, 23, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (218, 19, 23, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (219, 19, 30, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (220, 19, 30, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (221, 19, 30, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (222, 19, 30, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (223, 20, 16, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (224, 20, 22, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (225, 20, 31, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (226, 20, 24, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (227, 20, 25, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (228, 20, 26, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (229, 20, 27, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (230, 20, 33, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (231, 20, 22, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (232, 20, 22, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (233, 20, 22, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (234, 20, 31, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (235, 20, 31, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (236, 20, 31, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (237, 20, 25, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
GO
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (238, 20, 25, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (239, 20, 25, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (240, 20, 26, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (241, 20, 26, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (242, 20, 26, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (243, 20, 33, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (244, 20, 33, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (245, 20, 33, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (246, 20, 27, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (247, 20, 27, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (248, 20, 27, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (249, 19, 34, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (250, 19, 34, 1, N'Add', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (251, 19, 34, 2, N'Edit', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (252, 19, 34, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (255, 19, 34, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (256, 22, 16, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (257, 22, 34, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (258, 22, 22, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (259, 22, 24, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (260, 22, 25, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (261, 22, 26, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (262, 22, 27, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (263, 22, 33, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (264, 22, 34, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (265, 22, 34, 5, N'Accept', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (266, 22, 22, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (267, 22, 22, 5, N'Accept', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (268, 22, 25, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (269, 22, 25, 5, N'Accept', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (270, 22, 26, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (271, 22, 26, 5, N'Accept', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (272, 22, 33, 3, N'Delete', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (273, 22, 33, 5, N'Accept', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (274, 22, 15, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (275, 22, 12, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (276, 22, 13, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (277, 22, 18, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (278, 22, 20, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (279, 22, 30, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (280, 22, 7, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (281, 22, 28, 4, N'View', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (282, 22, 7, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (283, 22, 28, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (284, 22, 12, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (285, 22, 13, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (286, 22, 18, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (287, 22, 20, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (288, 22, 30, 0, N'Admin', 1, 1, CAST(N'2018-04-11' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (289, 20, 37, 4, N'View', 1, 1, CAST(N'2018-05-18' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (290, 20, 39, 4, N'View', 1, 1, CAST(N'2018-05-18' AS Date), 1, NULL, NULL)
INSERT [dbo].[SysGroupMenu] ([Id], [GroupId], [MenuId], [RoleId], [RoleName], [UsedState], [Orders], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (291, 20, 40, 4, N'View', 1, 1, CAST(N'2018-05-18' AS Date), 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysGroupMenu] OFF
SET IDENTITY_INSERT [dbo].[SysGroupUser] ON 

INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, 18, 2, 2, 1, CAST(N'2018-01-24' AS Date), 2, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, 19, 5, 2, 1, CAST(N'2018-01-24' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (9, 19, 4, 2, 1, CAST(N'2018-03-25' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, 20, 9, 2, 1, CAST(N'2018-04-11' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (11, 20, 10, 2, 1, CAST(N'2018-04-11' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (12, 22, 11, 2, 1, CAST(N'2018-04-11' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (13, 21, 24, 2, 1, CAST(N'2018-05-03' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (14, 21, 12, 2, 1, CAST(N'2018-05-03' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (15, 21, 23, 2, 1, CAST(N'2018-05-03' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (16, 21, 25, 2, 1, CAST(N'2018-05-15' AS Date), -1, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (17, 21, 26, 2, 1, CAST(N'2018-05-16' AS Date), -1, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (18, 21, 27, 2, 1, CAST(N'2018-05-17' AS Date), -1, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (20, 20, 28, 2, 1, CAST(N'2018-05-18' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (21, 20, 29, 2, 1, CAST(N'2018-05-19' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysGroupUser] ([Id], [GroupId], [UserId], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (22, 20, 30, 2, 1, CAST(N'2018-05-19' AS Date), 3, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SysGroupUser] OFF
SET IDENTITY_INSERT [dbo].[SysMenu] ON 

INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'/System/SysMenu', 4, N'Quản lý Menu', NULL, 1, 1, CAST(N'2017-02-02' AS Date), 1, CAST(N'2018-01-24 00:47:29.613' AS DateTime), NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'/System/SysGroupMenu', 4, N'Quản lý nhóm quyền Menu', NULL, 1, 1, CAST(N'2017-02-02' AS Date), 1, CAST(N'2018-01-25 23:05:25.387' AS DateTime), 5)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (4, N'#', NULL, N'SYSTEM', N'fa fa-cog fa-lg fa-spin', 1, 1, CAST(N'2018-01-21' AS Date), 1, CAST(N'2018-03-25 19:25:45.687' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, N'/System/SysGroup', 4, N'Quản lý nhóm', NULL, 1, 1, CAST(N'2018-01-21' AS Date), 1, CAST(N'2018-01-24 00:46:48.943' AS DateTime), NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, N'/System/SysUser', 4, N'Quản lý người dùng', NULL, 1, 1, CAST(N'2018-01-21' AS Date), 1, CAST(N'2018-01-24 00:47:10.283' AS DateTime), NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, N'/System/CmsCategory', 16, N'Quản lý danh mục', N'fa fa-minus-square-o ', 2, 0, CAST(N'2018-01-24' AS Date), 2, CAST(N'2018-05-08 14:21:32.543' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, N'/System/CmsService', 16, N'Quản lý dịch vụ', N'fa fa-minus-square-o ', 3, 0, CAST(N'2018-01-24' AS Date), 3, CAST(N'2018-05-08 14:21:45.237' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, N'/System/CmsEmail', 10, N'Quản lý Email', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-25' AS Date), 3, CAST(N'2018-01-26 22:38:07.983' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (12, N'/System/CmsSlide', 15, N'Quản lý Slide', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:37:51.950' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (13, N'/System/CmsSociety', 15, N'Quản lý mạng xã hội', N'fa fa-minus-square-o ', 1, 0, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-05-08 14:20:52.840' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (15, N'#', NULL, N'Tiện ích', N'fa fa-cc-discover', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:46:15.663' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (16, N'#', NULL, N'CMS', N'fa fa-th-large', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-03-25 11:40:06.580' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (17, N'/System/CmsBlog', 16, N'Quản lý Tin tức', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-02-11 14:52:29.887' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (18, N'/System/CmsIntroduce', 15, N'Hướng dẫn người sử dụng', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-03-29 22:50:06.340' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (19, N'/System/CmsProducts', 16, N'Quản lý Video', N'fa fa-minus-square-o ', 1, 0, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-05-08 14:22:02.013' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (20, N'/System/CmsEmail', 15, N'Quản lý email hệ thống', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-02-02 16:59:59.437' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (21, N'/System/CmsEvent', 16, N'Quản lý sản phẩm', N'fa fa-minus-square-o ', 1, 0, CAST(N'2018-01-29' AS Date), 3, CAST(N'2018-05-08 14:22:14.383' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (22, N'/System/Cms_ClassVideo', 16, N'Quản lý bài giảng khóa học', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-29' AS Date), 3, CAST(N'2018-04-11 19:34:05.127' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (23, N'/System/CmsSupport', 15, N'Danh sách liên hệ', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-02-03' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (24, N'#', NULL, N'EXAMS', N'fa fa-dashboard', 1, 1, CAST(N'2018-03-25' AS Date), 3, CAST(N'2018-03-25 11:41:45.077' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (25, N'/System/Ex_ExamConfig', 24, N'Cấu trúc đề thi', N'fa fa-minus-square-o ', 1, 0, CAST(N'2018-03-25' AS Date), 3, CAST(N'2018-05-15 13:10:34.290' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (26, N'/System/Ex_Exam', 24, N'Đề thi', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-03-25' AS Date), 3, CAST(N'2018-03-26 22:26:55.277' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (27, N'/System/Ex_Question', 24, N'Thêm mới Câu hỏi', N'fa fa-minus-square-o ', 3, 1, CAST(N'2018-03-25' AS Date), 3, CAST(N'2018-04-11 11:24:54.250' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (28, N'/System/Ex_Subject', 16, N'Môn học', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-03-26' AS Date), 3, CAST(N'2018-03-26 22:30:42.993' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (30, N'/System/Ex_Category', 15, N'Cấu hình danh mục', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-03-29' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (31, N'/System/Cms_Class', 16, N'Lớp học', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-03-30' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (33, N'/System/ListQuestion', 24, N'Danh sách câu hỏi', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-04-11' AS Date), 3, CAST(N'2018-04-11 11:22:19.200' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (34, N'/System/AcceptClass', 16, N'Danh sách các lớp cần duyệt', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-04-12' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (35, N'/System/Cms_Student', 16, N'Danh sách học viên', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-05-04' AS Date), 3, CAST(N'2018-05-03 21:25:20.983' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (36, N'/System/Cms_Teacher', 16, N'Danh sách giáo viên', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-05-04' AS Date), 3, CAST(N'2018-05-03 21:25:28.377' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (37, N'#', NULL, N'BÁO CÁO', N'fa fa-file-pdf-o', 1, 1, CAST(N'2018-05-09' AS Date), 3, CAST(N'2018-05-08 14:23:52.120' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (39, N'/System/ReportClass', 37, N'Thống kê lớp học', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-05-09' AS Date), 3, CAST(N'2018-05-08 17:13:08.737' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (40, N'/System/HistoryPayment', 37, N'Lịch sử giao dịch', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-05-09' AS Date), 3, CAST(N'2018-05-08 14:25:18.937' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[SysMenu] OFF
SET IDENTITY_INSERT [dbo].[SysUser] ON 

INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (1, NULL, 1, N'trongnv1507', N'HOST FULLNAME', NULL, 1, NULL, N'0', 0, N'/Uploads/CKFinder/files/images.jpg', N'213123123', N'host@gmail.com', 1, 1, CAST(N'2018-01-22' AS Date), NULL, CAST(N'2018-01-22' AS Date), 250039, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (3, NULL, 3, N'host', N'Quản trị cấp cao', NULL, 1, NULL, N'1', NULL, N'/Uploads/CKFinder/files/31069037_1239203196215468_6536668495363103921_n.jpg', NULL, N'host@gmail.com', 1, 1, CAST(N'2018-01-24' AS Date), NULL, NULL, 1066522, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (4, NULL, 4, N'trongnv', N'Ngô Văn Trọng', NULL, 0, NULL, N'1', NULL, N'/Uploads/CKFinder/files/images.jpg', NULL, N'trongnv1507@gmail.com', 1, 3, CAST(N'2018-01-24' AS Date), NULL, NULL, 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (5, NULL, 5, N'admin', N'Quản trị hệ thống', NULL, 0, NULL, N'1', NULL, N'/Uploads/CKFinder/files/images.jpg', NULL, N'admin@gmail.com', 1, 3, CAST(N'2018-01-24' AS Date), NULL, NULL, 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (9, NULL, 9, N'GV04', N'GV-04', NULL, 0, NULL, N'1', NULL, N'/Uploads/img_default.png', NULL, N'GV04@gmail.com', 1, 3, CAST(N'2018-04-11' AS Date), NULL, NULL, 700000, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (10, NULL, 10, N'GV01', N'Hoàng Nhật Minh', NULL, 0, NULL, N'1', 0, N'/Uploads/img_default.png', NULL, N'trongnv1507@gmail.com', 1, 3, CAST(N'2018-05-20' AS Date), 3, CAST(N'2018-05-20' AS Date), 49987510, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (11, NULL, 11, N'KS01', N'Kiểm soát viên', NULL, 0, NULL, N'1', NULL, N'/Uploads/CKFinder/files/images.jpg', NULL, N'KS01@gmail.com', 1, 3, CAST(N'2018-04-11' AS Date), NULL, NULL, 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (12, NULL, 12, N'HV01', N'HV. Nguyễn Đức Anh', NULL, 0, NULL, N'1', 0, N'/Uploads/CKFinder/files/images.jpg', NULL, N'HV01@gmail.com', 1, 3, CAST(N'2018-05-03' AS Date), 3, CAST(N'2018-05-03' AS Date), 109906935, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (23, NULL, 23, N'HV03', N'HV03', NULL, NULL, NULL, N'1', NULL, N'/Uploads/CKFinder/files/images.jpg', NULL, N'HV03@gmail.com', 1, 3, CAST(N'2018-05-03' AS Date), NULL, NULL, 1500000, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (24, NULL, 24, N'HV02', N'HV. Nguyễn Xuân Quỳnh', NULL, NULL, NULL, NULL, NULL, N'/Uploads/CKFinder/files/images.jpg', NULL, N'HV02@gmail.com', 1, 3, CAST(N'2018-05-03' AS Date), NULL, NULL, 11929981, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (25, NULL, 25, N'HV04', N'HV04', NULL, 0, NULL, NULL, 0, N'/Uploads/CKFinder/files/images.jpg', NULL, N'HV04@gmail.com', 0, NULL, CAST(N'2018-05-17' AS Date), 3, CAST(N'2018-05-17' AS Date), 11330000, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (26, N'A10D3E79-20AA-4E92-838A-01A61A8D6A75', 26, N'HV05', N'HV05', NULL, 0, NULL, N'0', 0, N'/Uploads/CKFinder/files/images.jpg', NULL, N'trongnv@gmail.com', 1, NULL, CAST(N'2018-05-17' AS Date), 3, CAST(N'2018-05-17' AS Date), 100000000, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (28, N'0431d425-be73-48ac-bbb6-b9a7e3a005fb', 28, N'GV05', N'GV05', NULL, 0, NULL, N'1', 0, N'/Uploads/img_default.png', NULL, N'hatokazu95@gmail.com', 1, NULL, CAST(N'2018-05-19' AS Date), 3, CAST(N'2018-05-19' AS Date), 43415002, NULL)
INSERT [dbo].[SysUser] ([Id], [Token], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (30, NULL, 30, N'GV11', N'GV11', NULL, 0, NULL, N'1', 0, N'/Uploads/CKFinder/files/31069037_1239203196215468_6536668495363103921_n.jpg', N'342', N'GV11@gmail.com', 1, 3, CAST(N'2018-05-19' AS Date), 3, CAST(N'2018-05-19' AS Date), 0, N'<p>cccax</p>
')
SET IDENTITY_INSERT [dbo].[SysUser] OFF
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (5, N'admin')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (10, N'GV01')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (9, N'GV04')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (28, N'GV05')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (30, N'GV11')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (3, N'host')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (12, N'HV01')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (24, N'HV02')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (23, N'HV03')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (25, N'HV04')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (26, N'HV05')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (11, N'KS01')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (4, N'trongnv')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (1, N'trongnv1507')
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(N'2018-01-23 19:11:39.037' AS DateTime), NULL, 1, NULL, 0, N'APQX3rkCXd1JUuXGcTrFtgEb/+tRfzrDW7i2GaMbonFuyZ3KBhh2vd+I1nwnSWPvkw==', CAST(N'2018-01-23 19:11:39.037' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (2, CAST(N'2018-01-23 19:12:14.827' AS DateTime), NULL, 1, CAST(N'2018-01-25 16:45:04.037' AS DateTime), 0, N'AMDQdsJO1vAlrLG1w1ihaVnEriGuI5Y/kcsRa13MBpRivkPVdiEzeaSte2pPkJxFWg==', CAST(N'2018-01-23 19:12:14.827' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (3, CAST(N'2018-01-24 15:58:01.640' AS DateTime), NULL, 1, CAST(N'2018-05-18 07:13:50.993' AS DateTime), 0, N'AAcrxXqoLYKjwZs5M4khnh3l/Ssx+6l+gnTvQzdfe+KjVMCVusHTdIUqsIlZPDBZlg==', CAST(N'2018-01-24 15:58:01.640' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (4, CAST(N'2018-01-24 16:16:53.140' AS DateTime), NULL, 1, CAST(N'2018-05-01 16:59:47.317' AS DateTime), 1, N'AMPAFx0NuVPPTjdSxl5JZ4oZdJzUHdaz+ERgDqslaWEvUbUSxySyMAxZYRAPcmCcJA==', CAST(N'2018-01-24 16:16:53.140' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (5, CAST(N'2018-01-24 16:20:08.993' AS DateTime), NULL, 1, CAST(N'2018-02-10 05:38:22.323' AS DateTime), 0, N'APqUPUH5DKEK4/endHx709VBhQeqdBMip7u469b5gICNDctqkZ911TNbgpWWFGXqXQ==', CAST(N'2018-01-24 16:20:08.993' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (6, CAST(N'2018-01-25 15:58:07.180' AS DateTime), NULL, 1, NULL, 0, N'AP0p+aJMuND/MVMV/45OrBDpYiJ9ayecI8tRqR1tmBfSBOP6VXzy3WJ73L+u1096mg==', CAST(N'2018-01-25 15:58:07.180' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (7, CAST(N'2018-01-25 16:50:27.067' AS DateTime), NULL, 1, NULL, 0, N'AJLX40TeIB3f0mDm6gpP6caP/oIcCS6VULutc0SV1Vt/fZ6hb7yJKQQGP2wfe3trFg==', CAST(N'2018-01-25 16:50:27.067' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (8, CAST(N'2018-01-25 16:58:53.913' AS DateTime), NULL, 1, NULL, 0, N'AMk6dKWWkHtPsAlSB0V0oeTcIfehgc4DHyzcvSERTycVaxWYoMRGZq/n1+oYeGAfOA==', CAST(N'2018-01-25 16:58:53.913' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (9, CAST(N'2018-04-11 13:49:15.230' AS DateTime), NULL, 1, CAST(N'2018-05-18 04:24:11.103' AS DateTime), 0, N'AN/12yENMzAqLqlvdWiJfe8ZREfrl9ACVZ9QziuM/EARkzEB/jbFTyCxdHR9Z/9RSg==', CAST(N'2018-04-11 13:49:15.230' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (10, CAST(N'2018-04-11 13:50:30.317' AS DateTime), NULL, 1, CAST(N'2018-05-19 08:32:59.290' AS DateTime), 0, N'ANuzn1+zfsqE3LaqBoARyfbXlU8KMS73JysMhsvV1V3xx08ttuVAKcnMwLzhyNbg+Q==', CAST(N'2018-04-11 13:50:30.317' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (11, CAST(N'2018-04-11 15:20:23.290' AS DateTime), NULL, 1, CAST(N'2018-05-10 06:03:46.703' AS DateTime), 0, N'ANykQal4J9BCZxBGjj4EjgzFhWyNl/c4J7fTKz/IOfkldjoy3En0nxRh+QB2nc5JUg==', CAST(N'2018-04-11 15:20:23.290' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (12, CAST(N'2018-05-03 14:13:01.687' AS DateTime), NULL, 1, CAST(N'2018-05-20 11:47:12.937' AS DateTime), 0, N'AAcrxXqoLYKjwZs5M4khnh3l/Ssx+6l+gnTvQzdfe+KjVMCVusHTdIUqsIlZPDBZlg==', CAST(N'2018-05-03 14:13:01.687' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (13, CAST(N'2018-05-03 15:24:33.830' AS DateTime), NULL, 1, NULL, 0, N'AFvO7j5GiaveaE8ilJXkbkXd4Crnu1xBqlNScROCF/V+mp2UPT29yi7ho09zMONWMQ==', CAST(N'2018-05-03 15:24:33.830' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (14, CAST(N'2018-05-03 15:26:43.893' AS DateTime), NULL, 1, NULL, 0, N'ABODLfis2EHXM+y5xvCY1G2R8o5xfBXvLkGljPKgaDf9HC8nJ9KT/aG6AFNSX4M1YQ==', CAST(N'2018-05-03 15:26:43.893' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (15, CAST(N'2018-05-03 15:28:19.800' AS DateTime), NULL, 1, NULL, 0, N'AJfeXCYDiWV/VRkn5qEiB20Vbht1gQ+l/oxRG/ZWVI8natYSaTdNjXXydj8oqawOAQ==', CAST(N'2018-05-03 15:28:19.800' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (16, CAST(N'2018-05-03 15:32:05.410' AS DateTime), NULL, 1, NULL, 0, N'AGaEbVupRD7Crd1JxT+H09euH7gDK0/40sNV5jnQzPjUY7yTyvXMLhjcdRlpZbQpSg==', CAST(N'2018-05-03 15:32:05.410' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (17, CAST(N'2018-05-03 15:33:21.593' AS DateTime), NULL, 1, NULL, 0, N'APbLixjn+5D2xL3ku5VqSv6vPolACnDDy0w1MAPgeeVve3bD5mVV5Au04oABQqextg==', CAST(N'2018-05-03 15:33:21.593' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (18, CAST(N'2018-05-03 15:37:03.897' AS DateTime), NULL, 1, NULL, 0, N'ADQB3eOEhXdVPjjlA4xlqvYKGxB/KO3oWL4UvS6DRUcFaxaXCG5f9U1ieiCMwZAmng==', CAST(N'2018-05-03 15:37:03.897' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (19, CAST(N'2018-05-03 15:38:50.123' AS DateTime), NULL, 1, NULL, 0, N'AN0kCHTijeTN5RtfNGYha8Gf7Wecy0X7dxCKkUE5H6bibI3jAopoaLyEtLTQHGnSBA==', CAST(N'2018-05-03 15:38:50.123' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (20, CAST(N'2018-05-03 15:43:07.117' AS DateTime), NULL, 1, NULL, 0, N'ADdzEYK4ojI3TshkMiVL5+Y4NXeFTrmhXA24qb8h3mtX0Eo3fZ3qWjChjA56af1BtA==', CAST(N'2018-05-03 15:43:07.117' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (21, CAST(N'2018-05-03 15:46:32.943' AS DateTime), NULL, 1, NULL, 0, N'AHvqfvUeNH8m+AaMycOnQsq/GJogdyDMylUR6zhtFq62G8a9Ft7xQdP4wwYiteBSzA==', CAST(N'2018-05-03 15:46:32.943' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (22, CAST(N'2018-05-03 15:48:14.857' AS DateTime), NULL, 1, NULL, 0, N'AA5WoJXXxStd8wT51ajd/Ko8rjb1eUAJKBf0klmkUW9QDtqKfkaTN3CGXuCM5+0GAg==', CAST(N'2018-05-03 15:48:14.857' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (23, CAST(N'2018-05-03 15:51:48.480' AS DateTime), NULL, 1, NULL, 0, N'APcnb5u6nKzSVs+P6aVpdtANQiP2wTBYYUTfgS22Hgm9GmyHWq15sVAcO9gh9L6hsw==', CAST(N'2018-05-03 15:51:48.480' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (24, CAST(N'2018-05-03 15:54:58.787' AS DateTime), NULL, 1, CAST(N'2018-05-20 11:47:08.830' AS DateTime), 1, N'AAcrxXqoLYKjwZs5M4khnh3l/Ssx+6l+gnTvQzdfe+KjVMCVusHTdIUqsIlZPDBZlg==', CAST(N'2018-05-03 15:54:58.787' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (25, CAST(N'2018-05-15 09:35:30.200' AS DateTime), NULL, 1, CAST(N'2018-05-15 09:35:41.283' AS DateTime), 0, N'AIzqf1vB7Gy9o2T9pb2sqZ91BsxUvW58KJnEOiJmiOTbT2wIcxULh6M4ujE7sCVo8A==', CAST(N'2018-05-15 09:35:30.200' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (26, CAST(N'2018-05-16 16:32:33.863' AS DateTime), NULL, 1, CAST(N'2018-05-16 16:48:27.997' AS DateTime), 1, N'AF+MrHz2vL2bYe80s9m+EEziPA4LAiOaK0+Jaj8wRws4LtP/xfkewSM7nsncpobvFQ==', CAST(N'2018-05-16 16:32:33.863' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (27, CAST(N'2018-05-16 17:00:58.160' AS DateTime), NULL, 1, NULL, 0, N'AP8AJcW7OPMo2ZT88jAEnK2TIFwo8y6u9NICoVW0NFHcmBH2Y38PolMrgGsFnYiC+g==', CAST(N'2018-05-16 17:00:58.160' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (28, CAST(N'2018-05-18 05:35:11.747' AS DateTime), NULL, 1, NULL, 0, N'ANggWkkTgZzUBDW5sF8fpaFrgtRkgQYlk/mzK8lKUv1IzxxB9mH+MK5W04Dj2zbaOQ==', CAST(N'2018-05-18 05:35:11.747' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (29, CAST(N'2018-05-18 18:20:20.957' AS DateTime), NULL, 1, NULL, 0, N'AIYdhY9XqPQPmZhY42OGlO1w4fQaVQst9QXN5kqglGAFssmZQHciT7NcIvI4jw5LKQ==', CAST(N'2018-05-18 18:20:20.957' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (30, CAST(N'2018-05-18 18:25:03.267' AS DateTime), NULL, 1, NULL, 0, N'AEGazm3vd96rddSAv2lQnC9rRGyH9JmidMziVBdNCQbtflZzdMb8UgXuoUrkDhAyng==', CAST(N'2018-05-18 18:25:03.267' AS DateTime), N'', NULL, NULL)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F2845650470207]    Script Date: 2018-05-20 6:59:29 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F2845695354060]    Script Date: 2018-05-20 6:59:29 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F28456CEC710FF]    Script Date: 2018-05-20 6:59:29 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F28456F0BC2FBF]    Script Date: 2018-05-20 6:59:29 PM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B616036496102]    Script Date: 2018-05-20 6:59:29 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B6160870777F6]    Script Date: 2018-05-20 6:59:29 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B6160AA157CDA]    Script Date: 2018-05-20 6:59:29 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B6160E3C42A83]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Cms_Class_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Cms_Class_Insert]
	@IdGuid varchar(500),
	@Grade nchar(30),
	@SubjectId int,
	@Name nvarchar(250),
	@Image nchar(250),
	@Star int,
	@Price float,
	@TeacherId int,
	@Sale float,
	@Summary nvarchar(max),
	@Content nvarchar(max),
	@VideoDemo nchar(500),
	@LinkFile varchar(500),
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate date
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Cms_Class] (
	[IdGuid],
	[Grade],
	[SubjectId],
	[Name],
	[Image],
	[Star],
	[Price],
	[TeacherId],
	[Sale],
	[Summary],
	[Content],
	[VideoDemo],
	[Orders],
	[LinkFile],
	[UsedState],
	[CreatedBy],
	[CreatedDate],
	[ModifiedBy],
	[ModifiedDate]
) VALUES (
	@IdGuid,
	@Grade,
	@SubjectId,
	@Name,
	@Image,
	@Star,
	@Price,
	@TeacherId,
	@Sale,
	@Summary,
	@Content,
	@VideoDemo,
	@Orders,
	@LinkFile,
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate
)

select  SCOPE_IDENTITY()

--endregion





GO
/****** Object:  StoredProcedure [dbo].[Cms_Class_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Cms_Class_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,c.Name as GradeName,s.Name as SubjectName,u.FullName as FullName
			FROM [Cms_Class] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			LEFT JOIN Ex_CategoryValue c on c.TypeCode=a.Grade
			LEFT JOIN Ex_Subject s on s.Id=a.SubjectId
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [Cms_Class] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END








GO
/****** Object:  StoredProcedure [dbo].[Cms_Class_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[usp_UpdateCmsClass]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   ngotrog using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateCmsClass]
-- Date Generated: Saturday, March 31, 2018
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Cms_Class_Update]
	@Id int,
	@IdGuid varchar(500),
	@Grade nchar(30),
	@SubjectId int,
	@Name nvarchar(250),
	@Image nchar(250),
	@Star int,
	@Price float,
	@TeacherId int,
	@Sale float,
	@Summary nvarchar(max),
	@Content nvarchar(max),
	@VideoDemo nchar(500),
	@LinkFile varchar(500),
	@Orders int,	
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate date
AS

SET NOCOUNT ON

UPDATE [dbo].[Cms_Class] SET
	[IdGuid]=@IdGuid,
	[Grade] = @Grade,
	[SubjectId] = @SubjectId,
	[Name] = @Name,
	[Image] = @Image,
	[Star] = @Star,
	[Price] = @Price,
	[TeacherId] = @TeacherId,
	[Sale] = @Sale,
	[Summary] = @Summary,
	[Content] = @Content,
	[VideoDemo] = @VideoDemo,
	[Orders] = @Orders,
	[LinkFile]=@LinkFile,
	[UsedState] = @UsedState,
	[CreatedBy] = @CreatedBy,
	[CreatedDate] = @CreatedDate,
	[ModifiedBy] = @ModifiedBy,
	[ModifiedDate] = @ModifiedDate
WHERE
	[Id] = @Id
select @@rowcount



GO
/****** Object:  StoredProcedure [dbo].[Cms_ClassStudent_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Cms_ClassStudent_Insert]
		
	@ClassId int,
	@ClassGuid nvarchar(250),	
	@StudentId int,	
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO Cms_ClassStudent(
				
		[ClassId]		
		,[ClassGuid]
		,[StudentId]		 
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (		
		
		@ClassId		
		,@ClassGuid
		,@StudentId		
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()








GO
/****** Object:  StoredProcedure [dbo].[Cms_ClassVideo_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Cms_ClassVideo_Insert]
	
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@ClassId int,
	@Link nvarchar(250),
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO Cms_ClassVideo (
		
		[Name]
		,[Summary]
		,[ClassId]
		,[Link]
		 ,[Orders]
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (		
		@Name
		,@Summary
		,@ClassId
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
/****** Object:  StoredProcedure [dbo].[Cms_ClassVideo_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Cms_ClassVideo_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,cl.Name as ClassName
			FROM [Cms_ClassVideo] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			LEFT JOIN Cms_Class cl on cl.Id=a.ClassId			
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [Cms_ClassVideo] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END








GO
/****** Object:  StoredProcedure [dbo].[Cms_ClassVideo_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Cms_ClassVideo_Update]
	@Id int,
	
	@Name nvarchar(250),
	@Summary  nvarchar(Max),
	@ClassId int,
	@Link nvarchar(250),
	@Orders int,
	@UsedState int,  
	@CreatedBy int, 
	@CreatedDate datetime, 
	
	@ModifiedDate datetime, 
	@ModifiedBy int 

AS

UPDATE Cms_ClassVideo SET
	   
	  
	   [Name] = @Name 
	   ,[Summary] = @Summary 
		,[ClassId]=@ClassId
		,[Link]=@Link
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[Cms_ClassVideo].[Id] = @Id
SELECT @@RowCount









GO
/****** Object:  StoredProcedure [dbo].[Cms_Comments_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Cms_Comments_Insert]
	@IdGuid varchar(250)
	,@ClassId int
	,@ClassStudentId int
	,@UserId int
	,@UserName varchar(250)
	,@Comments nvarchar(MAX)
	,@CreatedBy int
	,@CreatedDate datetime
	,@IsActive bit
	,@IsShow bit
as

INSERT INTO [dbo].[Cms_Comments]
           ([IdGuid]
		   ,[ClassId]
		   ,[ClassStudentId]
           ,[UserId]
           ,[UserName]
           ,[Comments]		   
           ,[CreatedDate]
           ,[IsActive]
		   ,[CreatedBy]
           ,[IsShow])
     VALUES
           (@IdGuid
		   ,@ClassId 
		   ,@ClassStudentId
           ,@UserId
           ,@UserName 
           ,@Comments 		 
           ,@CreatedDate
           ,@IsActive 
		   ,@CreatedBy
           ,@IsShow )


GO
/****** Object:  StoredProcedure [dbo].[Cms_HistoryPayment_GetAll]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[Cms_HistoryPayment_GetAll]
	@fromDate datetime,
	@toDate datetime,
	@userId int
AS
 
BEGIN
  IF (@userId = 0)
  BEGIN
    SELECT
      a.*,b.UserName as FromUserStr,c.UserName as ToUserStr
    FROM Cms_HistoryPayment a
	LEFT JOIN SysUser b on a.FromUser=b.Id
	LEFT JOIN SysUser c on a.ToUser=c.Id
	where a.CreatedDate between @fromDate and @toDate
	order by a.CreatedDate desc
  END
  ELSE
  BEGIN
     SELECT
      a.*,b.UserName as FromUserStr,c.UserName as ToUserStr
    FROM Cms_HistoryPayment a
	LEFT JOIN SysUser b on a.FromUser=b.Id
	LEFT JOIN SysUser c on a.ToUser=c.Id
	where a.CreatedDate between @fromDate and @toDate
	and a.ToUser=@userId
	order by a.CreatedDate desc
  END

END

GO
/****** Object:  StoredProcedure [dbo].[Cms_HistoryPayment_GetNotShow]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Cms_HistoryPayment_GetNotShow]
	@top int,
	@userId int
AS
 
BEGIN
  IF (@userId = 0)
  BEGIN
    SELECT TOP (@top)
      a.*,b.FullName as FromUserStr,c.FullName as ToUserStr
    FROM Cms_HistoryPayment a
	LEFT JOIN SysUser b on a.FromUser=b.Id
	LEFT JOIN SysUser c on a.ToUser=c.Id
	where a.IsShow=0 or a.IsShow is null
	order by CreatedDate desc
  END
  ELSE
  BEGIN
     SELECT TOP (@top)
      a.*,b.FullName as FromUserStr,c.FullName as ToUserStr
    FROM Cms_HistoryPayment a
	LEFT JOIN SysUser b on a.FromUser=b.Id
	LEFT JOIN SysUser c on a.ToUser=c.Id
	where 
	 a.ToUser=@userId and (a.IsShow=0 or a.IsShow is null)
	 order by CreatedDate desc
  END

END

GO
/****** Object:  StoredProcedure [dbo].[Cms_HistoryPayment_GetStudent]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Cms_HistoryPayment_GetStudent]
	@fromDate datetime,
	@toDate datetime,
	@userId int
AS
 
BEGIN
  
     SELECT
      a.*,b.UserName as FromUserStr,c.UserName as ToUserStr
    FROM Cms_HistoryPayment a
	LEFT JOIN SysUser b on a.FromUser=b.Id
	LEFT JOIN SysUser c on a.ToUser=c.Id
	where a.CreatedDate between @fromDate and @toDate
	and a.FromUser=@userId
	order by a.CreatedDate desc
  

END

GO
/****** Object:  StoredProcedure [dbo].[Cms_HistoryPayment_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Cms_HistoryPayment_Insert]
	@IdGuid varchar(500),
	@Code varchar(500),
	@FromUser int,
	@ToUser int,
	@BCoin float,
	@Summary nvarchar(500),	
	@CreatedDate datetime,
	@IsShow bit	,
	@IsActive bit	
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Cms_HistoryPayment] (
	[IdGuid]
	,[Code]
	,[FromUser]
	,[ToUser]
	,[BCoin]
	,[Summary]
	,[CreatedDate]
	,[IsShow]
	,[IsActive]

) VALUES (
	 @IdGuid
	,@Code
	,@FromUser
	,@ToUser
	,@BCoin
	,@Summary
	,@CreatedDate
	,@IsShow
	,@IsActive)	


--endregion





GO
/****** Object:  StoredProcedure [dbo].[Cms_Question_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Cms_Question_Insert]
	@IdGuid varchar(500)
	,@Grade varchar(50)
	,@SubjectId int
	,@TotalView int
	,@Summary nvarchar(max)
	,@Orders int
	,@UsedState int
	,@CreatedBy int
	,@CreatedDate datetime
	,@ModifiedBy int
	,@ModifiedDate  datetime
as
INSERT INTO [dbo].[Cms_Question]
           ([IdGuid]
           ,[Grade]
           ,[SubjectId]
           ,[TotalView]
           ,[Summary]
           ,[Orders]
           ,[UsedState]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[ModifiedBy]
           ,[ModifiedDate])
     VALUES
           (@IdGuid
           ,@Grade
           ,@SubjectId
           ,@TotalView
           ,@Summary
           ,@Orders
           ,@UsedState
           ,@CreatedBy
           ,@CreatedDate
           ,@ModifiedBy
           ,@ModifiedDate)

Select SCOPE_IDENTITY()		   

GO
/****** Object:  StoredProcedure [dbo].[Cms_Question_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Cms_Question_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,s.Name as SubjectName,u.FullName as FullName
			FROM [Cms_Question] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 			
			LEFT JOIN Ex_Subject s on s.Id=a.SubjectId
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [Cms_Question] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END








GO
/****** Object:  StoredProcedure [dbo].[Cms_QuestionComments_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Cms_QuestionComments_Insert]
	@IdGuid varchar(250)
	,@QuestionId varchar(250)
	,@UserId int
	,@FullName nvarchar(250)
	,@Comments nvarchar(MAX)
	,@CreatedBy int
	,@CreatedDate datetime
	,@IsActive bit
	,@IsShow bit
as
INSERT INTO [dbo].[Cms_QuestionComments]
           ([IdGuid]
           ,[QuestionId]
           ,[UserId]
           ,[FullName]
           ,[Comments]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive]
           ,[IsShow])
     VALUES
           (@IdGuid
           ,@QuestionId
           ,@UserId
           ,@FullName
           ,@Comments
           ,@CreatedBy
           ,@CreatedDate
           ,@IsActive
           ,@IsShow)

Select SCOPE_IDENTITY()

GO
/****** Object:  StoredProcedure [dbo].[CmsBlog_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsBlog_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsBlog_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Deletes]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Updates]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEmail_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEmail_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEmail_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEvent_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEvent_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEvent_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsIntroduce_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsIntroduce_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsProducts_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsProducts_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsProducts_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsService_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsService_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsService_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSlide_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSlide_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSlide_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSociety_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSociety_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSociety_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSupport_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSupport_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSupport_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Answer_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Ex_Answer_Insert]
	@SubQuestionId int,
	@Answer nvarchar(max),
	@CorrectAnswer bit,
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate date	
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Ex_Answer] (
	[SubQuestionId],
	[Answer],
	[CorrectAnswer],
	[Orders],
	[UsedState],
	[CreatedBy],
	[CreatedDate],
	[ModifiedBy],
	[ModifiedDate]
) VALUES (
	@SubQuestionId,
	@Answer,
	@CorrectAnswer,
	@Orders,
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate
)

select  SCOPE_IDENTITY()

--endregion





GO
/****** Object:  StoredProcedure [dbo].[Ex_Answer_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[usp_UpdateExAnswer]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   ngotrog using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateExAnswer]
-- Date Generated: Tuesday, March 27, 2018
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Ex_Answer_Update]
	@Id int,
	@SubQuestionId int,
	@Answer nvarchar(max),
	@CorrectAnswer bit,
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate datetime
AS

SET NOCOUNT ON

UPDATE [dbo].[Ex_Answer] SET
	[SubQuestionId] = @SubQuestionId,
	[Answer] = @Answer,
	[CorrectAnswer] = @CorrectAnswer,
	[Orders] = @Orders,
	[UsedState] = @UsedState,
	[CreatedBy] = @CreatedBy,
	[CreatedDate] = @CreatedDate,
	[ModifiedBy] = @ModifiedBy,
	[ModifiedDate] = @ModifiedDate
WHERE
	[Id] = @Id

--endregion

SELECT @@RowCount
--endregion




GO
/****** Object:  StoredProcedure [dbo].[Ex_Category_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_Category_Insert]
	@Code nchar(20),
	@Name nvarchar(250),
	@Total int,
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate date,
	@Id int OUTPUT
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Ex_Category] (
	[Code],
	[Name],
	[Total],
	[Orders],
	[UsedState],
	[CreatedBy],
	[CreatedDate],
	[ModifiedBy],
	[ModifiedDate]
) VALUES (
	@Code,
	@Name,
	@Total,
	@Orders,
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate
)

SET @Id = SCOPE_IDENTITY()

--endregion





GO
/****** Object:  StoredProcedure [dbo].[Ex_Category_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[usp_UpdateExCategory]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   ngotrog using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateExCategory]
-- Date Generated: Wednesday, March 28, 2018
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Ex_Category_Update]
	@Id int,
	@Code nchar(20),
	@Name nvarchar(250),
	@Total int,
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate date
AS

SET NOCOUNT ON

UPDATE [dbo].[Ex_Category] SET
	[Code] = @Code,
	[Name] = @Name,
	[Total] = @Total,
	[Orders] = @Orders,
	[UsedState] = @UsedState,
	[CreatedBy] = @CreatedBy,
	[CreatedDate] = @CreatedDate,
	[ModifiedBy] = @ModifiedBy,
	[ModifiedDate] = @ModifiedDate
WHERE
	[Id] = @Id

	select @@Rowcount
--endregion



GO
/****** Object:  StoredProcedure [dbo].[Ex_CategoryValue_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_CategoryValue_Insert]
	@CatCode nchar(20),
	@TypeCode nchar(20),
	@Name nvarchar(250),
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate date,
	@Id int OUTPUT
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Ex_CategoryValue] (
	[CatCode],
	[TypeCode],
	[Name],
	[Orders],
	[UsedState],
	[CreatedBy],
	[CreatedDate],
	[ModifiedBy],
	[ModifiedDate]
) VALUES (
	@CatCode,
	@TypeCode,
	@Name,
	@Orders,
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate
)

SET @Id = SCOPE_IDENTITY()

--endregion





GO
/****** Object:  StoredProcedure [dbo].[Ex_CategoryValue_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[usp_UpdateExCategoryValue]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   ngotrog using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateExCategoryValue]
-- Date Generated: Wednesday, March 28, 2018
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Ex_CategoryValue_Update]
	@Id int,
	@CatCode nchar(20),
	@TypeCode nchar(20),
	@Name nvarchar(250),
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate date
AS

SET NOCOUNT ON

UPDATE [dbo].[Ex_CategoryValue] SET
	[CatCode] = @CatCode,
	[TypeCode] = @TypeCode,
	[Name] = @Name,
	[Orders] = @Orders,
	[UsedState] = @UsedState,
	[CreatedBy] = @CreatedBy,
	[CreatedDate] = @CreatedDate,
	[ModifiedBy] = @ModifiedBy,
	[ModifiedDate] = @ModifiedDate
WHERE
	[Id] = @Id

--endregion
select @@RowCount



GO
/****** Object:  StoredProcedure [dbo].[Ex_Exam_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Ex_Exam_Insert]
	@IdGuid varchar(500),
	@Grade nchar(30),
	@SubjectId int,	
	@Code nchar(50),   	
	@Name nvarchar(250),
	@Time int,
	@Price int,
	@TotalNumber int,
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO Ex_Exam (
		IdGuid
		,Grade		
		,SubjectId
		,Code
		,Name		
		,Time
		,Price
		,TotalNumber
		,TotalStudent	
		,Orders
		,UsedState		
		,CreatedDate
		,CreatedBy
		,ModifiedDate
		,ModifiedBy
)VALUES (
		@IdGuid
		,@Grade
		, @SubjectId
		,'DT-'+CONVERT(varchar(10), IDENT_CURRENT('Ex_Exam'))
		,@Name		
		,@Time
		,@Price
		,@TotalNumber
		,0		
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()








GO
/****** Object:  StoredProcedure [dbo].[Ex_Exam_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Ex_Exam_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,b.Name as SubjectName,c.Name as GradeName,u.FullName as FullName
			FROM [Ex_Exam] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			LEFT JOIN Ex_Subject b on a.SubjectId=b.Id
			LEFT JOIN Ex_CategoryValue c ON a.Grade = c.TypeCode
			
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [Ex_Exam] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END








GO
/****** Object:  StoredProcedure [dbo].[Ex_Exam_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_Exam_Update]
	@Id int,
	@IdGuid varchar(500),
	@Grade nchar(30),
	@SubjectId int,	
	@Name nvarchar(250), 
	@Time int,
	@Price int,
	@TotalNumber int,
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime,  
	@ModifiedBy int 
	

AS

UPDATE Ex_Exam SET
		[IdGuid]=@IdGuid
	   ,[Grade]=@Grade
		,[SubjectId]=@SubjectId	   
	   ,[Name] = @Name 
	   ,[Time] = @Time 	
	   ,[Price]    =@Price
	  ,[TotalNumber]=@TotalNumber
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[Ex_Exam].[Id] = @Id
SELECT @@RowCount









GO
/****** Object:  StoredProcedure [dbo].[Ex_ExamConfig_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_ExamConfig_Insert]
	@ExamCode nchar(30),
	@Section nvarchar(MAX),
	@LevelDifficult nchar(30),
	@TotalNumber int,
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate date	
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Ex_ExamConfig] (
	[ExamCode],
	[Section],
	[LevelDifficult],
	[TotalNumber],
	[Orders],
	[UsedState],
	[CreatedBy],
	[CreatedDate],
	[ModifiedBy],
	[ModifiedDate]
) VALUES (
	@ExamCode,
	@Section,
	@LevelDifficult,
	@TotalNumber,
	@Orders,
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate
)

select SCOPE_IDENTITY()

--endregion





GO
/****** Object:  StoredProcedure [dbo].[Ex_ExamConfig_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Ex_ExamConfig_List_Paging '','',0,10,0
CREATE  PROCEDURE [dbo].[Ex_ExamConfig_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,e.Name as ExamName,c.Name as DiffName
			FROM [Ex_ExamConfig] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 			
			LEFT JOIN Ex_Exam e on e.Code=a.ExamCode
			LEFT JOIN Ex_CategoryValue c on c.TypeCode=a.LevelDifficult
		
			
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [Ex_ExamConfig] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END








GO
/****** Object:  StoredProcedure [dbo].[Ex_ExamConfig_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[usp_UpdateExExamConfig]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   ngotrog using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateExExamConfig]
-- Date Generated: Monday, March 26, 2018
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Ex_ExamConfig_Update]
	@Id int,
	@ExamCode nchar(30),
	@Section nvarchar(MAX),
	@LevelDifficult nchar(30),
	@TotalNumber int,
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,	
	@ModifiedDate date,
	@ModifiedBy int
AS

SET NOCOUNT ON

UPDATE [dbo].[Ex_ExamConfig] SET
	[ExamCode] = @ExamCode,
	[Section] = @Section,
	[LevelDifficult] = @LevelDifficult,
	[TotalNumber] = @TotalNumber,
	[Orders] = @Orders,
	[UsedState] = @UsedState,
	[CreatedBy] = @CreatedBy,
	[CreatedDate] = @CreatedDate,
	[ModifiedBy] = @ModifiedBy,
	[ModifiedDate] = @ModifiedDate
WHERE
	[Id] = @Id
SELECT @@RowCount
--endregion



GO
/****** Object:  StoredProcedure [dbo].[Ex_ExamStudent_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_ExamStudent_Insert]			
	@ExamId int,
	@StudentId int,	
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO Ex_ExamStudent(
				
		[ExamId]		
		,[StudentId]		 
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (		
		
		@ExamId		
		,@StudentId		
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()








GO
/****** Object:  StoredProcedure [dbo].[Ex_Question_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_Question_Insert]
	@SubjectId int,
	@Grade nchar(30),	
	@ExamId nchar(30),
	@SectionId int,
	@QuestionContent nvarchar(max),
	@LevelDifficult nchar(30),
	@SubQuestion int,
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedDate datetime	,
	@ModifiedBy int

AS

SET NOCOUNT ON

INSERT INTO [dbo].[Ex_Question] (
	[SubjectId],
	[Grade],
	[SectionId],
	[ExamId],
	[QuestionContent],
	[LevelDifficult],
	[SubQuestion],
	[Orders],
	[UsedState],
	[CreatedBy],
	[CreatedDate],
	[ModifiedBy],
	[ModifiedDate]
) VALUES (
	@SubjectId,
	@Grade,
	@SectionId,
	@ExamId,
	@QuestionContent,
	@LevelDifficult,
	@SubQuestion,
	@Orders,
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate
)

select  SCOPE_IDENTITY()

--endregion




GO
/****** Object:  StoredProcedure [dbo].[Ex_Question_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_Question_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,s.Name as SubjectName,e.Name as ExamName,g.Section as Section,v.Name as GradeName
			FROM [Ex_Question] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 
			LEFT JOIN Ex_Subject s ON s.Id = a.SubjectId  
			LEFT JOIN Ex_Exam e ON e.Code = a.ExamId						
			LEFT JOIN Ex_ExamConfig g ON g.Id = a.SectionId							
			LEFT JOIN Ex_CategoryValue v ON v.TypeCode = a.Grade
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [Ex_Question] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END








GO
/****** Object:  StoredProcedure [dbo].[Ex_Question_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[usp_UpdateExQuestion]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   ngotrog using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateExQuestion]
-- Date Generated: Sunday, April 1, 2018
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Ex_Question_Update]
	@Id int,
	@SubjectId int,
	@Grade nchar(30),	
	@ExamId nchar(30),
	@SectionId int,
	@QuestionContent nvarchar(max),
	@LevelDifficult nchar(30),
	@SubQuestion int,
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedDate date,
	@ModifiedBy int
	
AS

SET NOCOUNT ON

UPDATE [dbo].[Ex_Question] SET
	[SubjectId] = @SubjectId,
	[Grade] = @Grade,
	[SectionId] = @SectionId,
	[ExamId] = @ExamId,
	[QuestionContent] = @QuestionContent,
	[LevelDifficult] = @LevelDifficult,
	[SubQuestion] = @SubQuestion,
	[Orders] = @Orders,
	[UsedState] = @UsedState,
	[CreatedBy] = @CreatedBy,
	[CreatedDate] = @CreatedDate,
	[ModifiedBy] = @ModifiedBy,
	[ModifiedDate] = @ModifiedDate
WHERE
	[Id] = @Id
select @Id


GO
/****** Object:  StoredProcedure [dbo].[Ex_Subject_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_Subject_Insert]
	  	
	@Name nvarchar(250),	
	
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO Ex_Subject (
	
Name		
,Orders
,UsedState		
,CreatedDate
,CreatedBy
,ModifiedDate
,ModifiedBy
)  VALUES (
					
		@Name		
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()








GO
/****** Object:  StoredProcedure [dbo].[Ex_Subject_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_Subject_List_Paging]
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
			FROM [Ex_Subject] a
			LEFT JOIN SysUser u ON a.CreatedBy = u.UserId 								
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [Ex_Subject] a '+ @sWhere;
	
	print @SQL
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
END








GO
/****** Object:  StoredProcedure [dbo].[Ex_Subject_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_Subject_Update]
	@Id int,
	
	@Name nvarchar(250),	
	
	@Orders int,
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 	

AS

UPDATE Ex_Subject SET
	    	   
	   [Name] = @Name 
	   
	   ,[Orders] = @Orders
	   ,[UsedState] = @UsedState
	  
	   ,[CreatedDate] = @CreatedDate
	   ,[CreatedBy] = @CreatedBy
	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
WHERE
    
	[Ex_Subject].[Id] = @Id
SELECT @@RowCount









GO
/****** Object:  StoredProcedure [dbo].[Ex_SubQuestion_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Ex_SubQuestion_Insert]
	@QuestionId int,
	@SubQuestionName nvarchar(250),
	
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,
	@ModifiedBy int,
	@ModifiedDate date
AS

SET NOCOUNT ON

INSERT INTO [dbo].[Ex_SubQuestion] (
	[QuestionId],
	[SubQuestionName],
	
	[Orders],
	[UsedState],
	[CreatedBy],
	[CreatedDate],
	[ModifiedBy],
	[ModifiedDate]
) VALUES (
	@QuestionId,
	@SubQuestionName,
	
	@Orders,
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate
)

select SCOPE_IDENTITY()

--endregion




GO
/****** Object:  StoredProcedure [dbo].[Ex_SubQuestion_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[usp_UpdateExSubQuestion]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   ngotrog using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_UpdateExSubQuestion]
-- Date Generated: Sunday, April 1, 2018
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[Ex_SubQuestion_Update]
	@Id int,
	@QuestionId int,
	@SubQuestionName nvarchar(250),	
	@Orders int,
	@UsedState int,
	@CreatedBy int,
	@CreatedDate datetime,	
	@ModifiedDate datetime,
	@ModifiedBy int
AS

SET NOCOUNT ON

UPDATE [dbo].[Ex_SubQuestion] SET
	[QuestionId] = @QuestionId,
	[SubQuestionName] = @SubQuestionName,		
	[Orders] = @Orders,
	[UsedState] = @UsedState,
	[CreatedBy] = @CreatedBy,
	[CreatedDate] = @CreatedDate,
	[ModifiedBy] = @ModifiedBy,
	[ModifiedDate] = @ModifiedDate
WHERE
	[Id] = @Id
	select @@ROWCOUNT


GO
/****** Object:  StoredProcedure [dbo].[SysGroup_GetById]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SysGroup_GetById]
@Id int
as
select * from SysGroup where Id=@Id








GO
/****** Object:  StoredProcedure [dbo].[SysGroup_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_List]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_List_Reference]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_GetBy_GroupId]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_List]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_GetUserInGroup]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_GetUserNotInGroup]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_GetById]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SysMenu_GetById]
@Id int
as
select * from SysMenu where Id=@Id








GO
/****** Object:  StoredProcedure [dbo].[SysMenu_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_List]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_List_Recursive]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_Updates]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_GetMember_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysUser_GetMember_Paging]
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
			LEFT JOIN SysGroupUser b on a.UserId=b.UserId
			 '+@sWhere+')
			SELECT *,ROW_NUMBER() OVER(ORDER BY RowNumber) AS IndexNumber FROM PagingTable '
		IF @toRow > 0 
			SET @SQL +=' WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
		print @SQL;
	END
	
	SET @SQL = 'SELECT @TotalRow = COUNT(a.Id) FROM [SysUser] a LEFT JOIN  SysGroupUser b on a.UserId=b.UserId '+ @sWhere;
	
	EXECUTE sp_executesql @SQL,N'@TotalRow INT OUTPUT',@TotalRow output ;
	print @SQL;
END

--SysUser_GetMember_Paging '','',0,10,0






GO
/****** Object:  StoredProcedure [dbo].[SysUser_Insert]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysUser_Insert]
	--@Id int,
	@UserId int,
	@Token varchar(500),
	@FullName nvarchar(150),
	@UserName nvarchar(150),
	@Email nvarchar(150),	
	@ImageUrl nvarchar(152),
	@Phone varchar(50),
	@Host bit,
	@Gender nvarchar(3),
	@BCoin int,	
	@UsedState int,
	@CreatedBy int,
	@CreatedDate date,
	@ModifiedBy int,
	@ModifiedDate date,
	@BankAccount varchar(150),
	@Summary nvarchar(max)
AS


INSERT INTO [dbo].[SysUser] (
	--[Id],
	[UserId],
	[Token],
	[UserName],
	[FullName],
	[ImageUrl],
	[Host],
	[Gender],
	[BCoin],
	[Phone],
	[Email],
	
	[UsedState],
	[CreatedBy],
	[CreatedDate],
	[ModifiedBy],
	[ModifiedDate],
	[BankAccount],
	[Summary]
) VALUES (
	--@Id,
	@UserId,
	@Token,
	@UserName,
	@FullName,
	@ImageUrl,
	@Host,
	@Gender,
	@BCoin,
	@Phone,
	@Email,
	
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate,
	@BankAccount,
	@Summary
)

SELECT SCOPE_IDENTITY()

--endregion








GO
/****** Object:  StoredProcedure [dbo].[SysUser_List]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_ListByFK]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_Update]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysUser_Update]
	@UserId int,
	@Token varchar(256),
	@UserName nvarchar(256)
	,@FullName nvarchar(256)	
	,@Host bit
	,@Gender nvarchar(3)
	,@BCoin int
	,@Orders int
	
	,@ImageUrl nvarchar(152)	
	,@Phone nvarchar(256)
	,@Email nvarchar(256)

	,@UsedState int
	,@CreatedBy int
	,@CreatedDate datetime
	,@ModifiedDate datetime
	,@ModifiedBy int,
	@BankAccount varchar(150),
	@Summary nvarchar(max)

AS

UPDATE SysUser SET
	   [UserName] = @UserName
	   ,[FullName] = @FullName
	   ,[Token]	 =@Token
	   ,[Host] = @Host
	  ,[Gender] = @Gender
	   ,[Orders] = @Orders
	   ,[BCoin]=@BCoin
	   ,[ImageUrl] = @ImageUrl	   
	   ,[Phone] = @Phone
	   ,[Email] = @Email
	    ,[UsedState] = @UsedState
	   	   ,[CreatedBy] = @CreatedBy
	   ,[CreatedDate] = @CreatedDate

	   ,[ModifiedDate] = @ModifiedDate
	   ,[ModifiedBy] = @ModifiedBy
	   ,[BankAccount]=@BankAccount
	   ,[Summary]=@Summary
	   
	 
WHERE
    
	[SysUser].[UserId ] = @UserId 
SELECT @@RowCount






GO
/****** Object:  StoredProcedure [dbo].[Table_Deletes]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_GetByGuidId]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Table_GetByGuidId]
@Table nvarchar(120),
@Id varchar(100)
as
DECLARE @SQL NVARCHAR(4000)
Set @SQL='select * from '+@Table+' a where a.IdGuid='''+@Id+''''
EXECUTE sp_executesql @SQL;


GO
/****** Object:  StoredProcedure [dbo].[Table_GetById]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_List]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_List_Paging]    Script Date: 2018-05-20 6:59:29 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_Select]    Script Date: 2018-05-20 6:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Table_Select]
	  
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber
			FROM ['+@Table+'] a 						
			'+@sWhere+')
			SELECT * FROM PagingTable WHERE RowNumber BETWEEN '+CONVERT(Nvarchar,@fromRow)+' AND '+CONVERT(Nvarchar,@toRow)+';'
		EXECUTE sp_executesql @SQL;
	END
END






GO
/****** Object:  StoredProcedure [dbo].[Table_Updates]    Script Date: 2018-05-20 6:59:29 PM ******/
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
