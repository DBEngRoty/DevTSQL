USE [Mig]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_ConvertStringToTable]    Script Date: 28/11/2014 11:47:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE function [dbo].[udf_ConvertStringToTable]
(
@String varchar(max)
,@Delimiter NCHAR(1)
)
RETURNS @Result TABLE (val VARCHAR(4000), id BIGINT)
AS 
BEGIN

DECLARE @x XML 
SELECT
--@x = CAST('' + REPLACE(@String, @Delimiter, '') + '' AS XML)
@x = CAST('<A>' + REPLACE(@String, @Delimiter, '</A><A>') + '</A>' AS XML)

INSERT INTO @Result
SELECT
value = rtrim(ltrim(t.value('.', 'VARCHAR(4000)')))
, id = ROW_NUMBER() OVER (ORDER BY t.value('count(.)', 'bigint'))
FROM
@x.nodes('/A') AS x (t)

-- TEST
-- SELECT * FROM [dbo].[udf_ConvertStringToTable] ('XXX,XXXY',',')


RETURN
END




GO

