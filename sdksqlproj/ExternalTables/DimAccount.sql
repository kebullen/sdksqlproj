CREATE EXTERNAL TABLE [ext].DimAccount 
(
	[AccountKey] [int] NOT NULL,
	[ParentAccountKey] [int] NULL,
	[AccountLabel] [nvarchar](100) NULL,
	[AccountName] [nvarchar](50) NULL,
	[AccountDescription] [nvarchar](50) NULL,
	[AccountType] [nvarchar](50) NULL,
	[Operator] [nvarchar](50) NULL,
	[CustomMembers] [nvarchar](300) NULL,
	[ValueType] [nvarchar](50) NULL,
	[CustomMemberOptions] [nvarchar](200) NULL,
	[ETLLoadID] [int] NULL,
	[LoadDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL
)
WITH 
(
    LOCATION='/DimAccount/' 
,   DATA_SOURCE = contosoretaildw_public
,   FILE_FORMAT = VerticalBarTextFileFormat
,   REJECT_TYPE = VALUE
,   REJECT_VALUE = 0
);
