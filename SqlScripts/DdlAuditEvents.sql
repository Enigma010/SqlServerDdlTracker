SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DdlAuditEvents](
	[Id] [uniqueidentifier] NOT NULL,
	[EventTime] [datetime] NULL,
	[LoginName] [varchar](150) NULL,
	[UserName] [varchar](150) NULL,
	[DatabaseName] [varchar](150) NULL,
	[SchemaName] [varchar](150) NULL,
	[ObjectName] [varchar](150) NULL,
	[ObjectType] [varchar](150) NULL,
	[Command] [varchar](max) NULL,
	[TriggerXml] [xml] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [dbo].[DdlAuditColumnEvents](
	[Id] [uniqueidentifier] NOT NULL,
	[DdlAuditEventsId] [uniqueidentifier] NOT NULL,
	[EventTime] [datetime] NULL,
	[LoginName] [varchar](150) NULL,
	[UserName] [varchar](150) NULL,
	[DatabaseName] [varchar](150) NULL,
	[SchemaName] [varchar](150) NULL,
	[ColumnName] [varchar](150) NULL,
	[ChangeType] [varchar](25) NULL,
	[Command] [varchar](max) NULL,
	[TriggerXml] [xml] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [dbo].[Person](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar(100)] NULL,
	[Email] [varchar(100)] NULL,
	[InActive] [boolean] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [dbo].[Context](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar(100)] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [dbo].[PersonContextIdentifier](
	[Id] [uniqueidentifier] NOT NULL,
	[PersonId] [uniqueidentifier] NOT NULL,
	[ContextId] [uniqueidentifier] NOT NULL,
	[ContextIdentifier] [varchar(100)] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO