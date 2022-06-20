CREATE TABLE [dbo].[Table1]
(
  [Id] INT NOT NULL,
  [Moredata] VARCHAR(50) NULL,
  [YetMoredata] VARCHAR(50) NOT NULL,
  --added after table was created, if not null, need a default (or jump through hoops)
  [YetMoreData2] VARCHAR(50) NOT NULL DEFAULT ''
)
