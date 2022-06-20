-- Write your own SQL object definition here, and it'll be included in your package.
IF EXISTS(SELECT *
          FROM sys.views v JOIN sys.schemas s ON v.schema_id = s.schema_id
          WHERE v.[name] = 'View1' and s.[name] = 'dbo')
BEGIN
    DROP VIEW dbo.View1    
END;

if not exists(
select t.name, c.name
from sys.columns c join sys.tables t on c.object_id = t.object_id
    join sys.schemas s on t.schema_id = s.schema_id
where s.name = 'dbo' and t.name = 'Table1' and c.name = 'YetMoreData2')

begin
    alter table dbo.Table1 add YetMoreData2 varchar(50)

    update dbo.Table1 set YetMoreData2 = ''

    alter table dbo.Table1 alter column YetMoreData2 varchar(50) not null
end;
