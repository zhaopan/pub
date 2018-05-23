CREATE TABLE [dbo].[Sys_Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Thread] [varchar](255) NOT NULL,
	[Level] [varchar](50) NOT NULL,
	[Logger] [nvarchar](255) NOT NULL,
	[Message] [nvarchar](4000) NOT NULL,
	[Exception] [nvarchar](2000) NULL,
	[CreateDate] [datetime] NULL
) ON [PRIMARY]
GO
