USE [AuditDB]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_FindReplaceString]    Script Date: 2020-07-07 10:25:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_FindReplaceString](@vInput nvarchar(max))
RETURNS nvarchar(max)

/***************************************************************
SELECT AuditDB.dbo.udf_FindReplaceString(null)  --- Test

SELECT AuditDB.dbo.udf_FindReplaceString('SLSL<dob>1973</dob>BLA<SIN>456</SIN>BELA')  --- Test

**********************protariu/dba******************************/

AS BEGIN
    DECLARE @vOut nVARCHAR(max);
	IF @vInput IS NULL 
	BEGIN
		SET @vOut=' Nothing to replace, empty input! '
	END
	ELSE
	BEGIN
		-- String 1
		DECLARE @vPos1 INT; SET @vPos1 = patindex('%<DOB>%',@vInput)+LEN('<DOB>')-1;
		DECLARE @vPos2 INT; SET @vPos2 = patindex('%</DOB>%',@vInput);
		DECLARE @vEnd INT;  SET @vEnd = LEN(@vInput);
		SET @vOut = SUBSTRING(@vInput,1,@vPos1) +'!*!'+SUBSTRING(@vInput,@vPos2,@vEnd);
		
		-- String 2
		IF PATINDEX ('%<SIN>%',@vOut) > 0
		BEGIN
			SET @vPos1 = patindex('%<SIN>%',@vOut)+LEN('<DOB>')-1;
			SET @vPos2 = patindex('%</SIN>%',@vOut);
			SET @vEnd = LEN(@vInput);
			SET @vOut = SUBSTRING(@vOut,1,@vPos1) +'!*!'+SUBSTRING(@vOut,@vPos2,@vEnd)
		END

	END
    RETURN @vOut;

END 
GO

