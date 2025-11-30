Declare @sqlQuery varchar(max); SET @sqlQuery = SPACE(1);
Declare @Header varchar(5000), @Headerc varchar(5000)


-- Generate column names
SELECT @Header = IsNull(@Header + ',', '') + Column_Name FROM StageDB.INFORMATION_SCHEMA.COLUMNS WHERE table_name='RptSourceSuppression' ORDER BY ORDINAL_POSITION ASC;
--PRINT @Header;
SELECT @Headerc = IsNull(@Headerc + ',', '') + (char(39)+Column_Name+char(39))  FROM StageDB.INFORMATION_SCHEMA.COLUMNS WHERE table_name='RptSourceSuppression' ORDER BY ORDINAL_POSITION ASC;
--PRINT @Headerc;

SET @sqlQuery = 'INSERT INTO StageDB.dbo.RptSourceSuppression ('+@Header+') SELECT '+@Headerc
--PRINT @sqlQuery;
EXEC (@sqlQuery);