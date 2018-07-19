USE [Elearn]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertToNoSigned]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Cms_Class]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Cms_ClassStudent]    Script Date: 2018-05-05 8:53:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cms_ClassStudent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NULL,
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
/****** Object:  Table [dbo].[Cms_ClassVideo]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Cms_GradeSubject]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Cms_HistoryTranfer]    Script Date: 2018-05-05 8:53:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cms_HistoryTranfer](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](500) NULL,
	[FromUser] [int] NULL,
	[ToUser] [int] NULL,
	[BCoin] [int] NULL,
	[Summary] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Cms_HistoryTranfer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cms_Student]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsBlog]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsCategory]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsEmail]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsEvent]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsIntroduce]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsProducts]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsService]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsSlide]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsSociety]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsSupport]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[CmsType]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Ex_Answer]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Ex_Category]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Ex_CategoryValue]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Ex_Exam]    Script Date: 2018-05-05 8:53:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ex_Exam](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdGuid] [varchar](500) NULL,
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ex_ExamConfig]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Ex_Question]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Ex_Subject]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[Ex_SubQuestion]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[SysGroup]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[SysGroupMenu]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[SysGroupUser]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[SysMenu]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[SysUser]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[UserProfile]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 2018-05-05 8:53:05 AM ******/
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

INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'9073d791-3cbb-4822-8dba-26f708a8a441', N'KHOI-2                        ', 6, N'Thầy Vũ Khắc Ngọc - Một số PP đặc biệt để giải các bài tập khó về peptit (Phần 3)', N'https://i.ytimg.com/vi/ihNXUxZ9Lzo/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=ihNXUxZ9Lzo                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-11 09:49:14.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'9073d791-3cbb-4822-8dba-26f708a8a442', N'KHOI-1                        ', 1, N'Thầy Vũ Khắc Ngọc - Một số PP đặc biệt để giải các bài tập khó về peptit (Phần 3)', N'https://i.ytimg.com/vi/ihNXUxZ9Lzo/hqdefault.jpg                                                                                                                                                                                                          ', 0, 250000, 10, 249976, NULL, N'<p>Thầy ch&agrave;o c&aacute;c em,</p>

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
', N'https://www.youtube.com/watch?v=ihNXUxZ9Lzo&t=3299s                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ', 1, 1, 10, CAST(N'2018-04-11 21:00:46.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'1412c06d-f40c-4f19-b992-6c332b952295', N'KHOI-2                        ', 6, N'Thầy Vũ Khắc Ngọc - Phương pháp giải các bài tập về Peptit (p2)', N'https://i.ytimg.com/vi/dxSx6RFU_nw/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=dxSx6RFU_nw                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-11 09:49:01.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'3ce82f27-798d-429a-b300-7d905226e41e', N'KHOI-1                        ', 1, N'NHỮNG BẢN MASHUP MỚI 2018 | MASHUP EM SẼ HẠNH PHÚC - TUYỂN TẬP MASHUP NHẠC TRẺ HAY NHẤT 2018', N'https://i.ytimg.com/vi/DXDGXOg7C9g/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=DXDGXOg7C9g                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 0, 0, 3, CAST(N'2018-05-04 23:06:23.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'6c410de8-1a66-4585-b3bf-8c4ffd77f401', N'KHOI-2                        ', 6, N'Thầy Vũ Khắc Ngọc - Một số PP đặc biệt để giải các bài tập khó về peptit (Phần 1)', N'https://i.ytimg.com/vi/16tz0xAWXNU/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=16tz0xAWXNU                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-11 09:48:38.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'5f79cea2-9f5f-4002-bbbf-9e8ef9d9eac1', N'KHOI-2                        ', 6, N'Giải chi tiết đề thi thử môn Hóa 2017 - Lần 1 - Chuyên ĐH Vinh - Trần Phương Duy (Phần 1)', N'https://i.ytimg.com/vi/s0rjKnwmkug/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=s0rjKnwmkug                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-11 09:47:40.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'24a3d3ea-134a-4f7c-a729-bc98e1e58810', N'KHOI-1                        ', 4, N'20 Bản Nhạc Remix Nhiều Lượt Nghe Nhất Youtube Của Masew 2018 - Nhạc Remix Tuyển Chọn Hay Nhất 2018', N'https://i.ytimg.com/vi/YGNvEuvfqts/hqdefault.jpg                                                                                                                                                                                                          ', 0, 2500000, 3, 180000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

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
', N'https://www.youtube.com/watch?v=YGNvEuvfqts                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-02 23:10:14.697' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c1', N'KHOI-1                        ', 1, N'Giải chi tiết đề thi thử môn Hóa 2017 - Lần 1 - Chuyên ĐH Vinh - Trần Phương Duy (Phần 2)', N'https://i.ytimg.com/vi/k2wc3RGMWHs/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=k2wc3RGMWHs                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-11 09:47:23.767' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c2', N'KHOI-1                        ', 1, N'[8VBIZ] - Hòa Minzy gây choáng vì giả giọng Lương Bích Hữu y như thật', N'https://i.ytimg.com/vi/tKJUv6tlPtA/hqdefault.jpg                                                                                                                                                                                                          ', 0, 500000, 3, 200000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

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
', N'https://www.youtube.com/watch?v=tKJUv6tlPtA                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-02 23:12:09.270' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c3', N'KHOI-2                        ', 1, N'Hết Hồn Khi Nghe Thu Minh Hát Được Nhiều Dòng Nhạc Cùng Trấn Thành | Chuyện Tối Nay Với Thành', N'https://i.ytimg.com/vi/BFsASZfitrU/hqdefault.jpg                                                                                                                                                                                                          ', 0, 500000, 3, 300000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

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
', N'https://www.youtube.com/watch?v=BFsASZfitrU                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-02 23:11:52.853' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c4', N'KHOI-3                        ', 1, N'Thu Minh huấn luyện Hương Tràm ngay tại sân khấu mi ni show', N'https://i.ytimg.com/vi/Xs4zL2oPIyI/hqdefault.jpg                                                                                                                                                                                                          ', 0, 500000, 3, 400000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

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
', N'https://www.youtube.com/watch?v=Xs4zL2oPIyI                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-02 23:11:33.643' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c5', N'KHOI-2                        ', 1, N'HLV Thu Minh hướng dẫn Hương Tràm (Trên Đỉnh PhùVân-Queen Of-Đường Cong)', N'https://i.ytimg.com/vi/tXLZBlDN2q8/hqdefault.jpg                                                                                                                                                                                                          ', 0, 15000, 3, 100000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

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
', N'https://www.youtube.com/watch?v=tXLZBlDN2q8                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-02 23:11:19.850' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c6', N'KHOI-1                        ', 1, N'DẠY THANH NHẠC- ĐÀO TẠO CA SĨ -LUYỆN THI NHẠC VIỆN', N'https://i.ytimg.com/vi/FbH7oILHxp4/hqdefault.jpg                                                                                                                                                                                                          ', 0, 1400000, 3, 900000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

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
', N'https://www.youtube.com/watch?v=FbH7oILHxp4                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-02 23:10:53.000' AS DateTime), 3, CAST(N'2018-04-03' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c7', N'KHOI-1                        ', 1, N'20 Bản Nhạc Remix Nhiều Lượt Nghe Nhất Youtube Của Masew 2018 - Nhạc Remix Tuyển Chọn Hay Nhất 2018', N'https://i.ytimg.com/vi/YGNvEuvfqts/hqdefault.jpg                                                                                                                                                                                                          ', 0, 500000, 3, 100000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

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
', N'https://www.youtube.com/watch?v=YGNvEuvfqts                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-02 23:10:30.733' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'24a3d3ea-134a-4f7c-a724-bc98e1e588c8', N'KHOI-1                        ', 1, N'Tuyển Tập Album Hoa Vinh 2018', N'https://i.ytimg.com/vi/3-D41MzOaKI/hqdefault.jpg                                                                                                                                                                                                          ', 0, 150000, 1, 100000, NULL, N'<p>cccccccccccc</p>
', N'https://www.youtube.com/watch?v=3-D41MzOaKI                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 9, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-04-02' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'24a3d3ea-134a-1f7c-a729-bc98e1e588c8', N'KHOI-1                        ', 1, N'HOA VINH : Trăm Năm Không Quên, Gọi Tên Em Trong Đêm, Ngắm Hoa Lệ Rơi', N'https://i.ytimg.com/vi/Hw9KOV3kB4c/hqdefault.jpg                                                                                                                                                                                                          ', 0, 2500000, 3, 150000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

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
', N'https://www.youtube.com/watch?v=Hw9KOV3kB4c&t=5915s                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ', 1, 1, 3, CAST(N'2018-04-02 23:09:05.000' AS DateTime), 3, CAST(N'2018-04-02' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c8', N'KHOI-2                        ', 6, N'Chữa đề thi thử nghiệm THPT QG môn Hóa năm 2017 ( đề minh họa lần 2)', N'https://i.ytimg.com/vi/TlNeByELueA/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=TlNeByELueA                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-11 09:47:59.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'24a3d3ea-134a-4f7c-a729-bc98e1e588c9', N'KHOI-2                        ', 6, N'Tham khảo Chữa đề thi minh họa THPT QG môn Hóa năm 2017 lần 3', N'https://i.ytimg.com/vi/taBVrH6INOc/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=taBVrH6INOc                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-11 09:48:21.877' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'24a3d3ea-134a-4f7c-a729-bc98e1e588d8', N'KHOI-2                        ', 6, N'Tổng hợp những bài hát hay nhất của Hoa Vinh  2018 đăng kí kênh ủng hộ mình nha', N'https://i.ytimg.com/vi/TJJSaJI0ZMs/hqdefault.jpg                                                                                                                                                                                                          ', 0, 150000, 3, 100000, N'Việc đưa khoá học ôn thi lên online giúp đem kiến thức phổ cập đến nhiều bạn học sinh hơn. Tại đây, các em có thể chủ động việc học trong cả mặt thời gian lẫn nơi học. Do đó khoá học sẽ cục kì hữu ích và tạo cơ hội cho những bạn không có điều kiện tham gia học tập trực tiếp với các thầy cô. 

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
', N'https://www.youtube.com/watch?v=TJJSaJI0ZMs                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-03-31 18:16:39.000' AS DateTime), 3, CAST(N'2018-03-31' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'24a3d3ea-134a-4f7c-a729-bc99e1e588c8', N'KHOI-1                        ', 4, N'Buồn Của Anh - Gọi Tên Em Trong Đêm - The Men | Tuyển Tập Những Bài Hát Hay Nhất Của The Men 2018', N'https://i.ytimg.com/vi/RZ3NBunTu7Y/hqdefault.jpg                                                                                                                                                                                                          ', 0, 500000, 3, 100000, NULL, N'<p>Trưa 2.4, Trung t&acirc;m nu&ocirc;i dưỡng bảo trợ trẻ em Tam B&igrave;nh (quận Thủ Đức, TP.HCM) đ&atilde; l&agrave;m c&aacute;c thủ tục b&agrave;n giao b&eacute; L&ecirc; Thị Phương Linh (8 tuổi, t&ecirc;n thường gọi l&agrave; Muội) cho gia đ&igrave;nh tiếp nhận hồi gia sau thời gian b&eacute; được nu&ocirc;i dưỡng, chăm s&oacute;c tại đ&acirc;y.</p>

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
', N'https://www.youtube.com/watch?v=RZ3NBunTu7Y                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-02 23:09:48.257' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'0fa5dde9-ffaa-4b4b-9609-d3bbff083bcc', N'KHOI-1                        ', 1, N'TEST', N'/Uploads/CKFinder/files/23926324_1501252383324393_5127268733155882781_o.jpg                                                                                                                                                                               ', 0, 0, 5, 0, NULL, NULL, NULL, 1, 0, 5, CAST(N'2018-04-12 09:41:07.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, N'829430cb-e997-45a1-a560-d7ab28edffe3', N'KHOI-2                        ', 6, N'Thầy Vũ Khắc Ngọc - Phương pháp giải các bài tập về Peptit (p1)', N'https://i.ytimg.com/vi/cLl7uwy6caY/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=cLl7uwy6caY                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 1, 3, CAST(N'2018-04-11 09:48:52.000' AS DateTime), 3, CAST(N'2018-05-04' AS Date))
INSERT [dbo].[Cms_Class] ([Id], [IdGuid], [Grade], [SubjectId], [Name], [Image], [Star], [Price], [TeacherId], [Sale], [Summary], [Content], [VideoDemo], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (23, N'b717d4c5-5e2a-4b32-b379-f7e42e9193ec', N'KHOI-1                        ', 6, N'NHỮNG BÀI HÁT ACOUSTIC NHẸ NHÀNG – LỜI CHƯA NÓI || NHỮNG BÀI HÁT HAY NHẤT VỀ TÌNH YÊU', N'https://i.ytimg.com/vi/fbLVHOw68Zc/hqdefault.jpg                                                                                                                                                                                                          ', 0, 0, 3, 0, NULL, NULL, N'https://www.youtube.com/watch?v=fbLVHOw68Zc                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 1, 0, 3, CAST(N'2018-05-04 23:16:44.267' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Cms_Class] OFF
SET IDENTITY_INSERT [dbo].[Cms_ClassVideo] ON 

INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, 5, N'Bài 1', N'https://www.youtube.com/watch?v=ihNXUxZ9Lzo&t=3299s', N'<p>io;i;</p>
', 1, 1, 5, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, 1, N'Bài 2', NULL, NULL, 2, 1, 5, CAST(N'2018-02-02 00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, 19, N'Bài 3', N'https://www.youtube.com/watch?v=PQof9THDnVY', N'<p>c&acirc;cscasc</p>
', 1, 1, 3, CAST(N'2018-04-11 20:26:06.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, 1, N'Bài 4', NULL, N'<p>ca</p>
', 1, 1, 3, CAST(N'2018-04-11 20:28:37.300' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, 20, N'Thầy Vũ Khắc Ngọc - Một số PP đặc biệt để giải các bài tập khó về peptit (Phần 3)', N'https://www.youtube.com/watch?v=ihNXUxZ9Lzo&t=3299s', NULL, 3, 1, 10, CAST(N'2018-04-11 21:01:28.000' AS DateTime), 10, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, 20, N'hầy Vũ Khắc Ngọc - Một số PP đặc biệt để giải các bài tập khó về peptit (Phần 2)', N'https://www.youtube.com/watch?v=PQof9THDnVY&t=135s', NULL, 2, 1, 10, CAST(N'2018-04-11 21:04:08.713' AS DateTime), NULL, NULL)
INSERT [dbo].[Cms_ClassVideo] ([Id], [ClassId], [Name], [Link], [Summary], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, 20, N'   40:32 Thầy Vũ Khắc Ngọc - Một số lý thuyết trọng tâm về este và chất béo (p1) KHỐI THPT HOCMAI 38 N lượt xem   24:53 [PEN-C N2 - Hóa Học - Thầy Vũ Khắc Ngọc] Trọng tâm về Peptit KHỐI THPT HOCMAI 11 N lượt xem   12:46 Phân Chia Thời Gian Học : Học ', N'https://www.youtube.com/watch?v=16tz0xAWXNU&t=13s', NULL, 1, 1, 10, CAST(N'2018-04-11 21:04:30.303' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Cms_ClassVideo] OFF
SET IDENTITY_INSERT [dbo].[Cms_GradeSubject] ON 

INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (1, N'KHOI-2                                            ', 1)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (2, N'KHOI-2                                            ', 4)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (3, N'KHOI-2                                            ', 5)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (4, N'KHOI-2                                            ', 6)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (5, N'KHOI-2                                            ', 1)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (6, N'KHOI-1                                            ', 1)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (7, N'KHOI-1                                            ', 4)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (9, N'KHOI-1                                            ', 6)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (10, N'KHOI-3                                            ', 1)
INSERT [dbo].[Cms_GradeSubject] ([Id], [Grade], [SubjectId]) VALUES (11, N'KHOI-3                                            ', 4)
SET IDENTITY_INSERT [dbo].[Cms_GradeSubject] OFF
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

INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'4e23a589-f649-4d48-a6fd-c4ebdad0e952', N'KHOI-1                        ', 9, N'DT-19                         ', N'Đề thi Tiếng Anh', 50, 19, NULL, 40, 1, 1, 1, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-05-05' AS Date))
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'2cb78204-1247-4ca6-b1be-ed2e4f22ab31', N'KHOI-1                        ', 4, N'DT-20                         ', N'Đề thi Vật lý', 50, 0, NULL, 40, 1, 1, 1, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-05-05' AS Date))
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'486b2ba0-2957-4727-bb12-9a5e744487f8', N'KHOI-1                        ', 1, N'DT-14                         ', N'Đề thi Hóa giữa kỳ', 16, 0, NULL, 13, 1, 1, 10, CAST(N'2018-04-11 21:07:47.000' AS DateTime), 3, CAST(N'2018-05-05' AS Date))
INSERT [dbo].[Ex_Exam] ([Id], [IdGuid], [Grade], [SubjectId], [Code], [Name], [Time], [Price], [TotalStudent], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'88403daa-3d2b-4192-a2b0-f1fc5c6c75a8', N'KHOI-1                        ', 9, N'DT-15                         ', N'Đề thi ddd', 29, 0, NULL, 28, 1, 1, 3, CAST(N'2018-04-12 10:00:38.000' AS DateTime), 3, CAST(N'2018-05-05' AS Date))
SET IDENTITY_INSERT [dbo].[Ex_Exam] OFF
SET IDENTITY_INSERT [dbo].[Ex_ExamConfig] ON 

INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'DT-19                         ', N'Chương 1', N'DK-1                          ', 4, 1, 1, 3, CAST(N'2018-04-03 10:07:14.000' AS DateTime), 3, CAST(N'2018-05-02' AS Date))
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'DT-19                         ', N'Chương 2', N'DK-1                          ', 6, 1, 1, 3, CAST(N'2018-04-03 10:07:19.517' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'DT-19                         ', N'Chương 3', N'DK-1                          ', 6, 1, 1, 3, CAST(N'2018-04-03 10:07:23.640' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'DT-20                         ', N'Chương 3', N'DK-1                          ', 4, 1, 1, 3, CAST(N'2018-04-03 10:07:41.713' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'DT-20                         ', N'Chương 4', N'DK-1                          ', 3, 1, 1, 3, CAST(N'2018-04-03 10:09:03.017' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'DT-20                         ', N'Chương 5', N'DK-1                          ', 2, 1, 1, 3, CAST(N'2018-04-03 10:09:09.827' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'DT-14                         ', N'Chương 1 ', N'DK-1                          ', 5, 1, 1, 3, CAST(N'2018-04-03 10:37:20.860' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'DT-14                         ', N'Chương 1 Lipit', N'DK-1                          ', 9, 1, 1, 10, CAST(N'2018-04-11 21:09:31.427' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (23, N'DT-14                         ', N'Chương 2 Hữu cơ', N'DK-1                          ', 9, 1, 1, 10, CAST(N'2018-04-11 21:09:50.000' AS DateTime), 10, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (24, N'DT-14                         ', N'Chương 3 Cân bằng', N'DK-2                          ', 9, 1, 1, 10, CAST(N'2018-04-11 21:10:08.510' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_ExamConfig] ([Id], [ExamCode], [Section], [LevelDifficult], [TotalNumber], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (25, N'DT-19                         ', N'Chương 4', N'DK-2                          ', 1, 1, 1, 3, CAST(N'2018-04-12 10:00:16.073' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Ex_ExamConfig] OFF
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
SET IDENTITY_INSERT [dbo].[Ex_Question] OFF
SET IDENTITY_INSERT [dbo].[Ex_Subject] ON 

INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Toán học', 1, 1, 1, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Vật lý', 1, 1, 1, CAST(N'2018-02-02 00:00:00.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Hóa học', 1, 1, 3, CAST(N'2018-03-25 15:51:55.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Sinh học', 1, 1, 3, CAST(N'2018-03-25 15:52:27.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Địa lý', 1, 1, 3, CAST(N'2018-03-25 16:31:09.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Tiếng Anh', 1, 1, 3, CAST(N'2018-03-25 16:32:40.000' AS DateTime), 3, CAST(N'2018-04-11' AS Date))
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'Văn học', 1, 1, 3, CAST(N'2018-04-11 20:52:57.837' AS DateTime), NULL, NULL)
INSERT [dbo].[Ex_Subject] ([Id], [Name], [Orders], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (24, N'x', 1, -1, 11, CAST(N'2018-04-11 23:03:19.000' AS DateTime), 11, CAST(N'2018-04-11' AS Date))
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
SET IDENTITY_INSERT [dbo].[SysGroupUser] OFF
SET IDENTITY_INSERT [dbo].[SysMenu] ON 

INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'/System/SysMenu', 4, N'Quản lý Menu', NULL, 1, 1, CAST(N'2017-02-02' AS Date), 1, CAST(N'2018-01-24 00:47:29.613' AS DateTime), NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'/System/SysGroupMenu', 4, N'Quản lý nhóm quyền Menu', NULL, 1, 1, CAST(N'2017-02-02' AS Date), 1, CAST(N'2018-01-25 23:05:25.387' AS DateTime), 5)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (4, N'#', NULL, N'SYSTEM', N'fa fa-cog fa-lg fa-spin', 1, 1, CAST(N'2018-01-21' AS Date), 1, CAST(N'2018-03-25 19:25:45.687' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, N'/System/SysGroup', 4, N'Quản lý nhóm', NULL, 1, 1, CAST(N'2018-01-21' AS Date), 1, CAST(N'2018-01-24 00:46:48.943' AS DateTime), NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, N'/System/SysUser', 4, N'Quản lý người dùng', NULL, 1, 1, CAST(N'2018-01-21' AS Date), 1, CAST(N'2018-01-24 00:47:10.283' AS DateTime), NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, N'/System/CmsCategory', 16, N'Quản lý danh mục', N'fa fa-minus-square-o ', 2, 1, CAST(N'2018-01-24' AS Date), 2, CAST(N'2018-01-26 22:42:34.327' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, N'/System/CmsService', 16, N'Quản lý dịch vụ', N'fa fa-minus-square-o ', 3, 1, CAST(N'2018-01-24' AS Date), 3, CAST(N'2018-01-26 22:42:24.463' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, N'/System/CmsEmail', 10, N'Quản lý Email', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-25' AS Date), 3, CAST(N'2018-01-26 22:38:07.983' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (12, N'/System/CmsSlide', 15, N'Quản lý Slide', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:37:51.950' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (13, N'/System/CmsSociety', 15, N'Quản lý mạng xã hội', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:37:58.913' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (15, N'#', NULL, N'Tiện ích', N'fa fa-cc-discover', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-01-26 22:46:15.663' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (16, N'#', NULL, N'CMS', N'fa fa-th-large', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-03-25 11:40:06.580' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (17, N'/System/CmsBlog', 16, N'Quản lý Tin tức', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-02-11 14:52:29.887' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (18, N'/System/CmsIntroduce', 15, N'Hướng dẫn người sử dụng', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-03-29 22:50:06.340' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (19, N'/System/CmsProducts', 16, N'Quản lý Video', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-02-11 14:52:46.177' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (20, N'/System/CmsEmail', 15, N'Quản lý email hệ thống', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-27' AS Date), 3, CAST(N'2018-02-02 16:59:59.437' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (21, N'/System/CmsEvent', 16, N'Quản lý sản phẩm', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-29' AS Date), 3, CAST(N'2018-02-11 14:56:56.217' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (22, N'/System/Cms_ClassVideo', 16, N'Quản lý bài giảng khóa học', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-01-29' AS Date), 3, CAST(N'2018-04-11 19:34:05.127' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (23, N'/System/CmsSupport', 15, N'Danh sách liên hệ', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-02-03' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (24, N'#', NULL, N'EXAMS', N'fa fa-dashboard', 1, 1, CAST(N'2018-03-25' AS Date), 3, CAST(N'2018-03-25 11:41:45.077' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (25, N'/System/Ex_ExamConfig', 24, N'Cấu trúc đề thi', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-03-25' AS Date), 3, CAST(N'2018-03-27 00:08:56.420' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (26, N'/System/Ex_Exam', 24, N'Đề thi', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-03-25' AS Date), 3, CAST(N'2018-03-26 22:26:55.277' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (27, N'/System/Ex_Question', 24, N'Thêm mới Câu hỏi', N'fa fa-minus-square-o ', 3, 1, CAST(N'2018-03-25' AS Date), 3, CAST(N'2018-04-11 11:24:54.250' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (28, N'/System/Ex_Subject', 16, N'Môn học', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-03-26' AS Date), 3, CAST(N'2018-03-26 22:30:42.993' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (30, N'/System/Ex_Category', 15, N'Cấu hình danh mục', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-03-29' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (31, N'/System/Cms_Class', 16, N'Lớp học', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-03-30' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (33, N'/System/ListQuestion', 24, N'Danh sách câu hỏi', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-04-11' AS Date), 3, CAST(N'2018-04-11 11:22:19.200' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (34, N'/System/AcceptClass', 16, N'Danh sách các lớp cần duyệt', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-04-12' AS Date), 3, NULL, NULL)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (35, N'/System/Cms_Student', 16, N'Danh sách học viên', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-05-04' AS Date), 3, CAST(N'2018-05-03 21:25:20.983' AS DateTime), 3)
INSERT [dbo].[SysMenu] ([Id], [Link], [ParentId], [Name], [Icon], [Orders], [UsedState], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (36, N'/System/Cms_Teacher', 16, N'Danh sách giáo viên', N'fa fa-minus-square-o ', 1, 1, CAST(N'2018-05-04' AS Date), 3, CAST(N'2018-05-03 21:25:28.377' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[SysMenu] OFF
SET IDENTITY_INSERT [dbo].[SysUser] ON 

INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (1, 1, N'trongnv1507', N'HOST FULLNAME', NULL, 1, NULL, N'0', 0, NULL, N'213123123', N'host@gmail.com', 1, 1, CAST(N'2018-01-22' AS Date), NULL, CAST(N'2018-01-22' AS Date), 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (3, 3, N'host', N'Quản trị cấp cao', NULL, 1, NULL, N'1', NULL, NULL, NULL, N'host@gmail.com', 1, 1, CAST(N'2018-01-24' AS Date), NULL, NULL, 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (4, 4, N'trongnv', N'Ngô Văn Trọng', NULL, 0, NULL, N'1', NULL, NULL, NULL, N'trongnv1507@gmail.com', 1, 3, CAST(N'2018-01-24' AS Date), NULL, NULL, 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (5, 5, N'admin', N'Quản trị hệ thống', NULL, 0, NULL, N'1', NULL, NULL, NULL, N'admin@gmail.com', 1, 3, CAST(N'2018-01-24' AS Date), NULL, NULL, 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (9, 9, N'GV04', N'GV-04', NULL, 0, NULL, N'1', NULL, NULL, NULL, N'GV04@gmail.com', 1, 3, CAST(N'2018-04-11' AS Date), NULL, NULL, 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (10, 10, N'GV01', N'GV-01', NULL, 0, NULL, N'1', NULL, NULL, NULL, N'GV01@gmail.com', 1, 3, CAST(N'2018-04-11' AS Date), NULL, NULL, 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (11, 11, N'KS01', N'Kiểm soát viên', NULL, 0, NULL, N'1', NULL, NULL, NULL, N'KS01@gmail.com', 1, 3, CAST(N'2018-04-11' AS Date), NULL, NULL, 250000, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (12, 12, N'HV01', N'HV01', NULL, 0, NULL, N'1', 0, NULL, NULL, N'HV01@gmail.com', 1, 3, CAST(N'2018-05-03' AS Date), 3, CAST(N'2018-05-03' AS Date), 1500000, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (23, 23, N'HV03', N'HV03', NULL, NULL, NULL, N'1', NULL, NULL, NULL, N'HV03@gmail.com', 1, 3, CAST(N'2018-05-03' AS Date), NULL, NULL, 1500000, NULL)
INSERT [dbo].[SysUser] ([Id], [UserId], [UserName], [FullName], [BankAccount], [Host], [Role], [Gender], [Orders], [ImageUrl], [Phone], [Email], [UsedState], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [BCoin], [Summary]) VALUES (24, 24, N'HV02', N'HV02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'HV02@gmail.com', 0, 3, CAST(N'2018-05-03' AS Date), NULL, NULL, 1500000, NULL)
SET IDENTITY_INSERT [dbo].[SysUser] OFF
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (5, N'admin')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (10, N'GV01')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (9, N'GV04')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (3, N'host')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (12, N'HV01')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (24, N'HV02')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (23, N'HV03')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (11, N'KS01')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (4, N'trongnv')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (1, N'trongnv1507')
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(N'2018-01-23 19:11:39.037' AS DateTime), NULL, 1, NULL, 0, N'APQX3rkCXd1JUuXGcTrFtgEb/+tRfzrDW7i2GaMbonFuyZ3KBhh2vd+I1nwnSWPvkw==', CAST(N'2018-01-23 19:11:39.037' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (2, CAST(N'2018-01-23 19:12:14.827' AS DateTime), NULL, 1, CAST(N'2018-01-25 16:45:04.037' AS DateTime), 0, N'AMDQdsJO1vAlrLG1w1ihaVnEriGuI5Y/kcsRa13MBpRivkPVdiEzeaSte2pPkJxFWg==', CAST(N'2018-01-23 19:12:14.827' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (3, CAST(N'2018-01-24 15:58:01.640' AS DateTime), NULL, 1, CAST(N'2018-05-01 17:00:14.260' AS DateTime), 0, N'AAcrxXqoLYKjwZs5M4khnh3l/Ssx+6l+gnTvQzdfe+KjVMCVusHTdIUqsIlZPDBZlg==', CAST(N'2018-01-24 15:58:01.640' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (4, CAST(N'2018-01-24 16:16:53.140' AS DateTime), NULL, 1, CAST(N'2018-05-01 16:59:47.317' AS DateTime), 1, N'AMPAFx0NuVPPTjdSxl5JZ4oZdJzUHdaz+ERgDqslaWEvUbUSxySyMAxZYRAPcmCcJA==', CAST(N'2018-01-24 16:16:53.140' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (5, CAST(N'2018-01-24 16:20:08.993' AS DateTime), NULL, 1, CAST(N'2018-02-10 05:38:22.323' AS DateTime), 0, N'APqUPUH5DKEK4/endHx709VBhQeqdBMip7u469b5gICNDctqkZ911TNbgpWWFGXqXQ==', CAST(N'2018-01-24 16:20:08.993' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (6, CAST(N'2018-01-25 15:58:07.180' AS DateTime), NULL, 1, NULL, 0, N'AP0p+aJMuND/MVMV/45OrBDpYiJ9ayecI8tRqR1tmBfSBOP6VXzy3WJ73L+u1096mg==', CAST(N'2018-01-25 15:58:07.180' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (7, CAST(N'2018-01-25 16:50:27.067' AS DateTime), NULL, 1, NULL, 0, N'AJLX40TeIB3f0mDm6gpP6caP/oIcCS6VULutc0SV1Vt/fZ6hb7yJKQQGP2wfe3trFg==', CAST(N'2018-01-25 16:50:27.067' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (8, CAST(N'2018-01-25 16:58:53.913' AS DateTime), NULL, 1, NULL, 0, N'AMk6dKWWkHtPsAlSB0V0oeTcIfehgc4DHyzcvSERTycVaxWYoMRGZq/n1+oYeGAfOA==', CAST(N'2018-01-25 16:58:53.913' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (9, CAST(N'2018-04-11 13:49:15.230' AS DateTime), NULL, 1, NULL, 0, N'AN/12yENMzAqLqlvdWiJfe8ZREfrl9ACVZ9QziuM/EARkzEB/jbFTyCxdHR9Z/9RSg==', CAST(N'2018-04-11 13:49:15.230' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (10, CAST(N'2018-04-11 13:50:30.317' AS DateTime), NULL, 1, NULL, 0, N'ANuzn1+zfsqE3LaqBoARyfbXlU8KMS73JysMhsvV1V3xx08ttuVAKcnMwLzhyNbg+Q==', CAST(N'2018-04-11 13:50:30.317' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (11, CAST(N'2018-04-11 15:20:23.290' AS DateTime), NULL, 1, CAST(N'2018-04-12 00:58:14.027' AS DateTime), 0, N'ANykQal4J9BCZxBGjj4EjgzFhWyNl/c4J7fTKz/IOfkldjoy3En0nxRh+QB2nc5JUg==', CAST(N'2018-04-11 15:20:23.290' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (12, CAST(N'2018-05-03 14:13:01.687' AS DateTime), NULL, 1, CAST(N'2018-05-03 16:02:03.757' AS DateTime), 0, N'AOqf6z6FxlYQR5PvxNsXyFFixMk2QliV8tj9fogiEp6XkbZV21rO04It+V+JmAyonQ==', CAST(N'2018-05-03 14:13:01.687' AS DateTime), N'', NULL, NULL)
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
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (24, CAST(N'2018-05-03 15:54:58.787' AS DateTime), NULL, 1, NULL, 0, N'AM0qTs/HRPPya1gXrIQwoRZRohxt1GXYp7XJZyPizSlZiE9MCvPSn0zy2uEibRRaFQ==', CAST(N'2018-05-03 15:54:58.787' AS DateTime), N'', NULL, NULL)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F284563B21BB5D]    Script Date: 2018-05-05 8:53:05 AM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F2845680EB69C7]    Script Date: 2018-05-05 8:53:05 AM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F28456D7629FA8]    Script Date: 2018-05-05 8:53:05 AM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F28456EF19A691]    Script Date: 2018-05-05 8:53:05 AM ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B61601933F3DA]    Script Date: 2018-05-05 8:53:05 AM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B6160213F15B6]    Script Date: 2018-05-05 8:53:05 AM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B61607F5B08C5]    Script Date: 2018-05-05 8:53:05 AM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B6160DDEF3A43]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cms_Class_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
	@UsedState,
	@CreatedBy,
	@CreatedDate,
	@ModifiedBy,
	@ModifiedDate
)

select  SCOPE_IDENTITY()

--endregion




GO
/****** Object:  StoredProcedure [dbo].[Cms_Class_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Cms_Class_List_Paging]
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,c.Name as GradeName,s.Name as SubjectName
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
/****** Object:  StoredProcedure [dbo].[Cms_Class_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
	[UsedState] = @UsedState,
	[CreatedBy] = @CreatedBy,
	[CreatedDate] = @CreatedDate,
	[ModifiedBy] = @ModifiedBy,
	[ModifiedDate] = @ModifiedDate
WHERE
	[Id] = @Id
select @@rowcount


GO
/****** Object:  StoredProcedure [dbo].[Cms_ClassStudent_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Cms_ClassStudent_Insert]
		
	@ClassId int,
	@StudentId int,	
	@UsedState int,  
	@CreatedBy int,
	@CreatedDate datetime,  
	@ModifiedDate datetime, 
	@ModifiedBy int 
AS

INSERT INTO Cms_ClassStudent(
				
		[ClassId]
		,[StudentId]		 
		,[UsedState]		
		,[CreatedDate]
		,[CreatedBy]
		,[ModifiedDate]
		,[ModifiedBy]
	
) VALUES (		
		
		@ClassId
		,@StudentId		
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()







GO
/****** Object:  StoredProcedure [dbo].[Cms_ClassVideo_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cms_ClassVideo_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cms_ClassVideo_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsBlog_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsBlog_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsBlog_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Deletes]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsCategory_Updates]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEmail_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEmail_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEmail_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEvent_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEvent_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsEvent_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsIntroduce_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsIntroduce_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsProducts_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsProducts_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsProducts_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsService_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsService_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsService_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSlide_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSlide_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSlide_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSociety_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSociety_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSociety_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSupport_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSupport_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CmsSupport_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Answer_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Answer_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Category_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Category_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_CategoryValue_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_CategoryValue_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Exam_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
		,@Orders
		,@UsedState		
		,@CreatedDate
		,@CreatedBy
		,@ModifiedDate
		,@ModifiedBy
	
)
select SCOPE_IDENTITY()







GO
/****** Object:  StoredProcedure [dbo].[Ex_Exam_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
			(SELECT a.*,ROW_NUMBER() OVER('+@sOrder+') AS RowNumber, u.UserName AS CreatedByName,b.Name as SubjectName,c.Name as GradeName
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
/****** Object:  StoredProcedure [dbo].[Ex_Exam_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_ExamConfig_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_ExamConfig_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_ExamConfig_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Question_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Question_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Question_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Subject_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Subject_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_Subject_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_SubQuestion_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Ex_SubQuestion_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_GetById]    Script Date: 2018-05-05 8:53:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SysGroup_GetById]
@Id int
as
select * from SysGroup where Id=@Id







GO
/****** Object:  StoredProcedure [dbo].[SysGroup_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_List]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_List_Reference]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroup_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_GetBy_GroupId]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_List]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupMenu_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_GetUserInGroup]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_GetUserNotInGroup]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysGroupUser_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_GetById]    Script Date: 2018-05-05 8:53:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SysMenu_GetById]
@Id int
as
select * from SysMenu where Id=@Id







GO
/****** Object:  StoredProcedure [dbo].[SysMenu_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_List]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_List_Recursive]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysMenu_Updates]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_GetMember_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_Insert]    Script Date: 2018-05-05 8:53:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SysUser_Insert]
	--@Id int,
	@UserId int,
	@FullName nvarchar(150),
	@UserName nvarchar(150),
	@Email nvarchar(150),	
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
	[UserName],
	[FullName],
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
	@UserName,
	@FullName,
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
/****** Object:  StoredProcedure [dbo].[SysUser_List]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_ListByFK]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SysUser_Update]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_Deletes]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_GetByGuidId]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_GetById]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_List]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_List_Paging]    Script Date: 2018-05-05 8:53:05 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Table_Updates]    Script Date: 2018-05-05 8:53:05 AM ******/
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
