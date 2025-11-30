USE [AuditDB]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_Get_Current_Hour]    Script Date: 04/02/2014 2:08:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_Get_Current_Hour]()
RETURNS SMALLINT

/***************************************************************
SELECT AuditDB.dbo.udf_Get_Current_Hour()  --- Test
**********************protariu/dba******************************/

AS BEGIN
    RETURN (SELECT CAST(CONVERT(CHAR(2),GETDATE(),108) AS SMALLINT));
END 

GO

