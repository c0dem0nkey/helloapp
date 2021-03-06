SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Creating [dbo].[Users]'
GO
CREATE TABLE [dbo].[Users]
(
[Username] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ImageURL] [varchar] (150) COLLATE Latin1_General_CI_AS NOT NULL,
[Created] [datetime] NOT NULL,
[Updated] [datetime] NOT NULL,
[UserTypeID] [char] (3) COLLATE Latin1_General_CI_AS NULL,
[ShadowAccount] [bit] NOT NULL CONSTRAINT [DF_Users_ShadowAccount] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Users] on [dbo].[Users]'
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED  ([Username])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserTypes]'
GO
CREATE TABLE [dbo].[UserTypes]
(
[UserTypeID] [char] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[EventID] [int] NOT NULL,
[Name] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[Ordering] [int] NOT NULL CONSTRAINT [DF_UserTypes_Ordering] DEFAULT ((0)),
[DefaultColour] [char] (6) COLLATE Latin1_General_CI_AS NOT NULL,
[BurningColour] [char] (6) COLLATE Latin1_General_CI_AS NOT NULL,
[HotColour] [char] (6) COLLATE Latin1_General_CI_AS NOT NULL,
[WarmColour] [char] (6) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_UserTypes] on [dbo].[UserTypes]'
GO
ALTER TABLE [dbo].[UserTypes] ADD CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED  ([UserTypeID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Messages]'
GO
CREATE TABLE [dbo].[Messages]
(
[Username] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Text] [nvarchar] (140) COLLATE Latin1_General_CI_AS NOT NULL,
[Offensive] [bit] NOT NULL CONSTRAINT [DF_Messages_Offensive] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Messages] on [dbo].[Messages]'
GO
ALTER TABLE [dbo].[Messages] ADD CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED  ([Username])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[QueuedTweets]'
GO
CREATE TABLE [dbo].[QueuedTweets]
(
[QueuedTweetID] [int] NOT NULL IDENTITY(1, 1),
[Username] [varchar] (500) COLLATE Latin1_General_CI_AS NOT NULL,
[Message] [nvarchar] (500) COLLATE Latin1_General_CI_AS NOT NULL,
[Created] [datetime] NOT NULL,
[Processed] [bit] NOT NULL CONSTRAINT [DF_QueuedTweets_Processed] DEFAULT ((0)),
[ImageURL] [varchar] (500) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_QueuedTweets] on [dbo].[QueuedTweets]'
GO
ALTER TABLE [dbo].[QueuedTweets] ADD CONSTRAINT [PK_QueuedTweets] PRIMARY KEY CLUSTERED  ([QueuedTweetID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Friendships]'
GO
CREATE TABLE [dbo].[Friendships]
(
[Befriender] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Befriendee] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Friendships_1] on [dbo].[Friendships]'
GO
ALTER TABLE [dbo].[Friendships] ADD CONSTRAINT [PK_Friendships_1] PRIMARY KEY CLUSTERED  ([Befriender], [Befriendee])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Points]'
GO
CREATE TABLE [dbo].[Points]
(
[PointID] [int] NOT NULL,
[Username] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Issued] [datetime] NOT NULL,
[Amount] [int] NOT NULL,
[Details] [nchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Points] on [dbo].[Points]'
GO
ALTER TABLE [dbo].[Points] ADD CONSTRAINT [PK_Points] PRIMARY KEY CLUSTERED  ([PointID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Tokens]'
GO
CREATE TABLE [dbo].[Tokens]
(
[TokenID] [int] NOT NULL IDENTITY(1, 1),
[CampaignID] [int] NOT NULL,
[Token] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Tokens] on [dbo].[Tokens]'
GO
ALTER TABLE [dbo].[Tokens] ADD CONSTRAINT [PK_Tokens] PRIMARY KEY CLUSTERED  ([TokenID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Redemptions]'
GO
CREATE TABLE [dbo].[Redemptions]
(
[RedemptionID] [int] NOT NULL IDENTITY(1, 1),
[Username] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[TokenID] [int] NOT NULL,
[Created] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Redemptions] on [dbo].[Redemptions]'
GO
ALTER TABLE [dbo].[Redemptions] ADD CONSTRAINT [PK_Redemptions] PRIMARY KEY CLUSTERED  ([RedemptionID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Seats]'
GO
CREATE TABLE [dbo].[Seats]
(
[SeatID] [int] NOT NULL IDENTITY(1, 1),
[SeatNumber] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[Row] [char] (2) COLLATE Latin1_General_CI_AS NOT NULL,
[Section] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[EventID] [int] NOT NULL,
[Code] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Seats] on [dbo].[Seats]'
GO
ALTER TABLE [dbo].[Seats] ADD CONSTRAINT [PK_Seats] PRIMARY KEY CLUSTERED  ([SeatID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Sats]'
GO
CREATE TABLE [dbo].[Sats]
(
[Username] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[SessionID] [int] NOT NULL,
[SeatID] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Sits] on [dbo].[Sats]'
GO
ALTER TABLE [dbo].[Sats] ADD CONSTRAINT [PK_Sits] PRIMARY KEY CLUSTERED  ([Username], [SessionID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Sessions]'
GO
CREATE TABLE [dbo].[Sessions]
(
[SessionID] [int] NOT NULL IDENTITY(1, 1),
[EventID] [int] NOT NULL,
[Name] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Start] [datetime] NOT NULL,
[Finish] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Sessions] on [dbo].[Sessions]'
GO
ALTER TABLE [dbo].[Sessions] ADD CONSTRAINT [PK_Sessions] PRIMARY KEY CLUSTERED  ([SessionID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Events]'
GO
CREATE TABLE [dbo].[Events]
(
[EventID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[Slug] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Events] on [dbo].[Events]'
GO
ALTER TABLE [dbo].[Events] ADD CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED  ([EventID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Tags]'
GO
CREATE TABLE [dbo].[Tags]
(
[Name] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[Username] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Created] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Tags] on [dbo].[Tags]'
GO
ALTER TABLE [dbo].[Tags] ADD CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED  ([Name], [Username])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Campaigns]'
GO
CREATE TABLE [dbo].[Campaigns]
(
[CampaignID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Value] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Campaigns] on [dbo].[Campaigns]'
GO
ALTER TABLE [dbo].[Campaigns] ADD CONSTRAINT [PK_Campaigns] PRIMARY KEY CLUSTERED  ([CampaignID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Badges]'
GO
CREATE TABLE [dbo].[Badges]
(
[BadgeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ImageUrl] [varchar] (100) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Badges] on [dbo].[Badges]'
GO
ALTER TABLE [dbo].[Badges] ADD CONSTRAINT [PK_Badges] PRIMARY KEY CLUSTERED  ([BadgeID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserBadges]'
GO
CREATE TABLE [dbo].[UserBadges]
(
[BadgeID] [int] NOT NULL,
[Username] [varchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Awarded] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_UserBadges] on [dbo].[UserBadges]'
GO
ALTER TABLE [dbo].[UserBadges] ADD CONSTRAINT [PK_UserBadges] PRIMARY KEY CLUSTERED  ([BadgeID], [Username])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TagAggregates]'
GO
CREATE TABLE [dbo].[TagAggregates]
(
[TagAggregateID] [int] NOT NULL IDENTITY(1, 1),
[Tag] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[UserTypeID] [char] (3) COLLATE Latin1_General_CI_AS NULL,
[Count] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TideMarks]'
GO
CREATE TABLE [dbo].[TideMarks]
(
[TideMarkID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[LastID] [bigint] NOT NULL,
[TimeStamp] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TideMarks] on [dbo].[TideMarks]'
GO
ALTER TABLE [dbo].[TideMarks] ADD CONSTRAINT [PK_TideMarks] PRIMARY KEY CLUSTERED  ([TideMarkID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[UserBadges]'
GO
ALTER TABLE [dbo].[UserBadges] ADD
CONSTRAINT [FK_UserBadges_Badges] FOREIGN KEY ([BadgeID]) REFERENCES [dbo].[Badges] ([BadgeID]),
CONSTRAINT [FK_UserBadges_Users] FOREIGN KEY ([Username]) REFERENCES [dbo].[Users] ([Username])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Tokens]'
GO
ALTER TABLE [dbo].[Tokens] ADD
CONSTRAINT [FK_Tokens_Campaigns] FOREIGN KEY ([CampaignID]) REFERENCES [dbo].[Campaigns] ([CampaignID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Seats]'
GO
ALTER TABLE [dbo].[Seats] ADD
CONSTRAINT [FK_Seats_Events] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Sessions]'
GO
ALTER TABLE [dbo].[Sessions] ADD
CONSTRAINT [FK_Sessions_Events] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[UserTypes]'
GO
ALTER TABLE [dbo].[UserTypes] ADD
CONSTRAINT [FK_UserTypes_Events] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Friendships]'
GO
ALTER TABLE [dbo].[Friendships] ADD
CONSTRAINT [FK_Friendships_Users_Befriender] FOREIGN KEY ([Befriender]) REFERENCES [dbo].[Users] ([Username]),
CONSTRAINT [FK_Friendships_Users_Befriendee] FOREIGN KEY ([Befriendee]) REFERENCES [dbo].[Users] ([Username])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Messages]'
GO
ALTER TABLE [dbo].[Messages] ADD
CONSTRAINT [FK_Messages_Users] FOREIGN KEY ([Username]) REFERENCES [dbo].[Users] ([Username])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Points]'
GO
ALTER TABLE [dbo].[Points] ADD
CONSTRAINT [FK_Points_Users] FOREIGN KEY ([Username]) REFERENCES [dbo].[Users] ([Username])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Redemptions]'
GO
ALTER TABLE [dbo].[Redemptions] ADD
CONSTRAINT [FK_Redemptions_Users] FOREIGN KEY ([Username]) REFERENCES [dbo].[Users] ([Username]),
CONSTRAINT [FK_Redemptions_Tokens] FOREIGN KEY ([TokenID]) REFERENCES [dbo].[Tokens] ([TokenID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Sats]'
GO
ALTER TABLE [dbo].[Sats] ADD
CONSTRAINT [FK_Sits_Users] FOREIGN KEY ([Username]) REFERENCES [dbo].[Users] ([Username]),
CONSTRAINT [FK_Sats_Sessions] FOREIGN KEY ([SessionID]) REFERENCES [dbo].[Sessions] ([SessionID]),
CONSTRAINT [FK_Sats_Seats] FOREIGN KEY ([SeatID]) REFERENCES [dbo].[Seats] ([SeatID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Tags]'
GO
ALTER TABLE [dbo].[Tags] ADD
CONSTRAINT [FK_Tags_Users] FOREIGN KEY ([Username]) REFERENCES [dbo].[Users] ([Username])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Users]'
GO
ALTER TABLE [dbo].[Users] ADD
CONSTRAINT [FK_Users_Users] FOREIGN KEY ([UserTypeID]) REFERENCES [dbo].[UserTypes] ([UserTypeID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
