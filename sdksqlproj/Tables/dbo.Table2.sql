-- Write your own SQL object definition here, and it'll be included in your package.
CREATE TABLE [dbo].[Table2]
(
  [Id] INT NOT NULL,
  [Moredata] VARCHAR(50) NULL,
  [YetMoredata] VARCHAR(50) NOT NULL,
  --added after table was created, if not null, need a default (or jump through hoops)
  [YetMoreData2] VARCHAR(50) NOT NULL DEFAULT ''
)
