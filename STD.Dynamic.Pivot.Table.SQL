USE [Test]
GO

/* There should be a numeric column for agregates, if chars transform to numeric and convert back with a MAP table*/


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_STD_Pivot_Dynamic]
  @query    AS NVARCHAR(MAX),
  @on_rows  AS NVARCHAR(MAX),
  @on_cols  AS NVARCHAR(MAX),
  @agg_func AS NVARCHAR(MAX) = N'MAX',
  @agg_col  AS NVARCHAR(MAX)
AS

DECLARE 
  @sql     AS NVARCHAR(MAX),
  @cols    AS NVARCHAR(MAX),
  @newline AS NVARCHAR(2);

SET @newline = NCHAR(13) + NCHAR(10);

IF COALESCE(OBJECT_ID(@query, N'U'),
            OBJECT_ID(@query, N'V')) IS NOT NULL
  SET @query = N'SELECT * FROM ' + @query;

SET @query = N'( ' + @query + @newline + N'      ) AS Query';

IF @agg_col = N'*'
  SET @agg_col = N'1';

SET @sql =
  N'SET @result = '                                    + @newline +
  N'  STUFF('                                          + @newline +
  N'    (SELECT N'','' + '
           + N'QUOTENAME(pivot_col) AS [text()]'       + @newline +
  N'     FROM (SELECT DISTINCT('
           + @on_cols + N') AS pivot_col'              + @newline +
  N'           FROM' + @query + N') AS DistinctCols'   + @newline +
  N'     ORDER BY pivot_col'                           + @newline +
  N'     FOR XML PATH('''')),'                         + @newline +
  N'    1, 1, N'''');'

EXEC sp_executesql
  @stmt   = @sql,
  @params = N'@result AS NVARCHAR(MAX) OUTPUT',
  @result = @cols OUTPUT;

SET @sql = 
  N' DROP TABLE STD_Dynamic_Pivot; SELECT * INTO STD_Dynamic_Pivot  ' + @newline +
  N'FROM'                                              + @newline +
  N'  ( SELECT '                                       + @newline +
  N'      ' + @on_rows + N','                          + @newline +
  N'      ' + @on_cols + N' AS pivot_col,'             + @newline +
  N'      ' + @agg_col + N' AS agg_col'                + @newline +
  N'    FROM '                                         + @newline +
  N'      ' + @query                                   + @newline +
  N'  ) AS PivotInput'                                 + @newline +
  N'  PIVOT'                                           + @newline +
  N'    ( ' + @agg_func + N'(agg_col)'                 + @newline +
  N'      FOR pivot_col'                               + @newline +
  N'        IN(' + @cols + N')'                        + @newline +
  N'    ) AS PivotOutput;'

EXEC sp_executesql @sql;

/*

   EXECUTION
   !!!!!A_ID has to be numeric!!!!
   
EXEC dbo.usp_STD_Pivot_Dynamic
  @query	   = N' SELECT TOP 1000 * FROM SurveyAIDs  ORDER BY RESPONDER_ID',
  @on_rows	   = N'RESPONDER_ID , SURVEY_DATE',
  @on_cols     = N'QUESTION',   
  @agg_func    = N'MAX',
  @agg_col     = N'A_ID';

SELECT * FROM STD_Dynamic_Pivot;
*/