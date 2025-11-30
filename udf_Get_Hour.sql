USE [AuditDB]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_Get_Hour]    Script Date: 01/04/2016 4:15:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[udf_Get_Hour](@vDate datetime)
RETURNS SMALLINT

/***************************************************************
SELECT AuditDB.dbo.udf_Get_Hour(getdate())  --- Test
**********************protariu/dba******************************/

AS BEGIN
	IF @vDate IS NULL SET @vDate =GetDate();
    RETURN (SELECT CAST(CONVERT(CHAR(2),GETDATE(),108) AS SMALLINT));
END 



GO

