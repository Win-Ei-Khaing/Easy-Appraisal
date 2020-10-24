USE EasyAppraisalDb;
CREATE TABLE [tblUser] (
	UserID int IDENTITY(1,1) NOT NULL,
	UserCode nvarchar(50) NOT NULL,
	UserName nvarchar(100) NOT NULL,
	Position nvarchar(50) NOT NULL,
	Password nvarchar(50) NOT NULL,
  CONSTRAINT [PK_TBLUSER] PRIMARY KEY CLUSTERED
  (
  [UserID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [tblCategory] (
	CategoryID int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(200) NOT NULL,
  CONSTRAINT [PK_TBLCATEGORY] PRIMARY KEY CLUSTERED
  (
  [CategoryID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [tblUserMark] (
	UserMarkID int IDENTITY(1,1) NOT NULL,
	UserID int NOT NULL,
	CategoryID int NOT NULL,
	Mark decimal NOT NULL,
  CONSTRAINT [PK_TBLUSERMARK] PRIMARY KEY CLUSTERED
  (
  [UserMarkID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [tblMarkHistory] (
	MarkHistoryID int IDENTITY(1,1) NOT NULL,
	UserID int NOT NULL,
	CategoryID int NOT NULL,
	Mark int NOT NULL,
	GivenBy int NOT NULL,
	GivenOn datetime NOT NULL,
  CONSTRAINT [PK_TBLMARKHISTORY] PRIMARY KEY CLUSTERED
  (
  [MarkHistoryID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO


ALTER TABLE [tblUserMark] WITH CHECK ADD CONSTRAINT [tblUserMark_fk0] FOREIGN KEY ([UserID]) REFERENCES [tblUser]([UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [tblUserMark] CHECK CONSTRAINT [tblUserMark_fk0]
GO
ALTER TABLE [tblUserMark] WITH CHECK ADD CONSTRAINT [tblUserMark_fk1] FOREIGN KEY ([CategoryID]) REFERENCES [tblCategory]([CategoryID])
ON UPDATE CASCADE
GO
ALTER TABLE [tblUserMark] CHECK CONSTRAINT [tblUserMark_fk1]
GO

ALTER TABLE [tblMarkHistory] WITH CHECK ADD CONSTRAINT [tblMarkHistory_fk0] FOREIGN KEY ([UserID]) REFERENCES [tblUser]([UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [tblMarkHistory] CHECK CONSTRAINT [tblMarkHistory_fk0]
GO
ALTER TABLE [tblMarkHistory] WITH CHECK ADD CONSTRAINT [tblMarkHistory_fk1] FOREIGN KEY ([CategoryID]) REFERENCES [tblCategory]([CategoryID])
ON UPDATE CASCADE
GO
ALTER TABLE [tblMarkHistory] CHECK CONSTRAINT [tblMarkHistory_fk1]
GO
ALTER TABLE [tblMarkHistory] WITH CHECK ADD CONSTRAINT [tblMarkHistory_fk2] FOREIGN KEY ([GivenBy]) REFERENCES [tblUser]([UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [tblMarkHistory] CHECK CONSTRAINT [tblMarkHistory_fk2]
GO

