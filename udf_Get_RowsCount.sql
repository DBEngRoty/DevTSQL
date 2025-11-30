create FUNCTION dbo.udf_RowsCount(@sTableName sysname)
RETURNS INT -- Row count of the table, NULL if not found.

/***************************************************************
* Returns the row count for a table by examining sysindexes.
* This function must be run in the same database as the table.
* Common Usage:   SELECT dbo.udf_RowsCount ('Table_name)  
**********************protariu/dba******************************/

AS BEGIN
    DECLARE @nRowCount INT; DECLARE @nObjectID INT; SET @nObjectID = OBJECT_ID(@sTableName)
    IF @nObjectID IS NULL RETURN NULL -- Object might not be found
    SELECT TOP 1 @nRowCount = Rows FROM sysindexes WHERE id = @nObjectID AND indid < 2
    RETURN @nRowCount
END 
GO

/*
-- Get rowcounT for all tables
SELECT [name],dbo.udf_RowsCount([name]) as [Row_Count] FROM sysobjects WHERE type='U' and name != 'dtproperties'  ORDER BY 2 DESC
GO
*/