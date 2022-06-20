-- Write your own SQL object definition here, and it'll be included in your package.
IF EXISTS(SELECT *
          FROM sys.views v JOIN sys.schemas s ON v.schema_id = s.schema_id
          WHERE v.[name] = 'View1' and s.[name] = 'dbo')
BEGIN
    DROP VIEW dbo.View1    
END;