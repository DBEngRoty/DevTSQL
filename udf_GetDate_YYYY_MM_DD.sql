USE [AuditDB]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_GetDate_YYYY_MM_DD]    Script Date: 04/02/2014 12:31:32 PM ******/
DROP FUNCTION [dbo].[udf_GetDate_YYYY_MM_DD]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_GetDate_YYYY_MM_DD]    Script Date: 04/02/2014 12:31:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_GetDate_YYYY_MM_DD](@vDays INT)
RETURNS VARCHAR(10)

/***************************************************************
SELECT AuditDB.dbo.udf_GetDate_YYYY_MM_DD(10)  --- Test
**********************protariu/dba******************************/

AS BEGIN
    IF @vDays IS NULL SET @vDays=0;
    DECLARE @vCDate VARCHAR(20);
	SET @vCDate = (SUBSTRING(CONVERT(CHAR(8),(GETDATE()-@vDays),112),1,4)+'-'+
	               SUBSTRING(CONVERT(CHAR(8),(GETDATE()-@vDays),112),5,2)+'-'+
				   SUBSTRING(CONVERT(CHAR(8),(GETDATE()-@vDays),112),7,2));
    RETURN @vCDate;
END 

GO

