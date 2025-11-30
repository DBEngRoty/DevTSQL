------------
-- T SQL Search All Text & XML Columns in All Tables
------------
-- SQL nested cursors - sql server nested cursor - transact sql nested cursor

 

-- SQL Server create stored procedure with nested cursors
alter PROC usp_SearchKeywordInAllTables  @Keyword NVARCHAR(64) 
AS 
  BEGIN 
    SET NOCOUNT  ON 
    DECLARE  @OutputLength VARCHAR(4), 
             @NolockOption CHAR(8)
         SET @OutputLength = '256' 
         SET @NolockOption = '' 
         -- SET @NolockOption =  '(NOLOCK)'
    DECLARE  @DynamicSQL   NVARCHAR(MAX),
             @SchemaTableName   NVARCHAR(256), 
             @SchemaTableColumn NVARCHAR(128), 
             @SearchWildcard    NVARCHAR(128) 
         SET @SearchWildcard = QUOTENAME('%' + @Keyword + '%',CHAR(39)+CHAR(39)) 
         PRINT @SearchWildcard
    DECLARE  @SearchResults  TABLE( 
                                   SchemaTableColumn NVARCHAR(384), 
                                   TextWithKeyword   NVARCHAR(MAX) 
                                   ) 

  
    DECLARE curAllTables CURSOR  STATIC LOCAL FOR 
    SELECT   QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) AS ST
    FROM     INFORMATION_SCHEMA.TABLES 
    WHERE    TABLE_TYPE = 'BASE TABLE' 
             AND OBJECTPROPERTY(OBJECT_ID(QUOTENAME(TABLE_SCHEMA) + '.' 
             + QUOTENAME(TABLE_NAME)), 'IsMSShipped') != 1

    ORDER BY ST 
    OPEN curAllTables 
    FETCH NEXT FROM curAllTables 
    INTO @SchemaTableName 
    WHILE (@@FETCH_STATUS = 0) -- Outer cursor loop
      BEGIN 
        PRINT @SchemaTableName 
        SET @SchemaTableColumn = '' 
        DECLARE curAllColumns CURSOR  FOR -- Nested cursor
        SELECT   QUOTENAME(COLUMN_NAME) 
        FROM     INFORMATION_SCHEMA.COLUMNS 
        WHERE    TABLE_NAME = PARSENAME(@SchemaTableName,1)
                 AND TABLE_SCHEMA = PARSENAME(@SchemaTableName,2) 
                 AND DATA_TYPE IN ('varchar','nvarchar','char','nchar','xml') 
        ORDER BY ORDINAL_POSITION 
        OPEN curAllColumns 
        FETCH NEXT FROM curAllColumns 
        INTO @SchemaTableColumn 
        WHILE (@@FETCH_STATUS = 0) -- Inner cursor loop (nested cursor while)
          BEGIN 
            PRINT '  ' + @SchemaTableColumn 
            SET @DynamicSQL = 'SELECT ''' + @SchemaTableName + '.' + 
              @SchemaTableColumn + ''', LEFT(CONVERT(nvarchar(max),' + 
              @SchemaTableColumn + '),' + @OutputLength + ')  FROM ' + 
              @SchemaTableName + ' '+@NolockOption+ 
              ' WHERE CONVERT(nvarchar(max),' + @SchemaTableColumn + 
              ') LIKE ' + @SearchWildcard 
            INSERT INTO @SearchResults 
            EXEC sp_executeSQL  @DynamicSQL 
            FETCH NEXT FROM curAllColumns 
            INTO @SchemaTableColumn 
          END  -- Inner cursor loop
        CLOSE curAllColumns 
        DEALLOCATE curAllColumns 
        FETCH NEXT FROM curAllTables 
        INTO @SchemaTableName 
      END  -- Outer cursor loop
    CLOSE curAllTables 
    DEALLOCATE curAllTables 
   
    SELECT DISTINCT SchemaTableColumn, TextWithKeyWord FROM   @SearchResults 
  END 

GO 

 
/*
EXEC usp_SearchKeywordInAllTables  'TK1' 

*/
