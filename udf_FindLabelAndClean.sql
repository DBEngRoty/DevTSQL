USE [AuditDB]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_FindLabelAndClean]    Script Date: 2020-07-27 3:13:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter FUNCTION [dbo].[udf_FindLabelAndClean](@vInput nvarchar(max), @vLabel VARCHAR(40))
RETURNS nvarchar(max)

/**********************************************************************************
SELECT AuditDB.dbo.udf_FindLabelAndClean('AB<DOB>1973-1</DOB>CDCD<DOB>1974-2</DOB>EFEFEF<DOB>1975-3</DOB>GHGHGHGH<DOB>1975-4</DOB>IJIJIJIJIJ<DOB>1975-5</DOB>KLKLKLKLKL','DOB')  --- Test
SELECT AuditDB.dbo.udf_FindLabelAndClean('XXXX<DOB>cc</DOB>XXXX','DOB')  --- Test
SELECT AuditDB.dbo.udf_FindLabelAndClean('XXXX1XXXX','DOB')  --- Test
SELECT AuditDB.dbo.udf_FindLabelAndClean('XXXX2XX2XSINXXX','SIN')  --- Test
SELECT AuditDB.dbo.udf_FindLabelAndClean('XXXXDATEOFBIXXXXXX','DateOfBirth')  --- Test
**********************protariu/dba*************************************************/

AS BEGIN
    DECLARE @vOut nVARCHAR(max);
	IF LEN(@vInput) < 1 OR LEN(@vLabel) < 1
	BEGIN
		SET @vOut = 'No action! See parameters!'; 
	END
	ELSE

	-- Build variables label markers !
	DECLARE @vLabel1 VARCHAR(40); SET @vLabel1 = '<'+@vLabel+'>';  --RETURN @vLabel1;
	DECLARE @vLabel2 VARCHAR(40); SET @vLabel2 = '</'+@vLabel+'>'; --RETURN @vLabel2;

	-- Check labels markers
	DECLARE @vOcur1 as Smallint; 	SET @vOcur1 = (LEN(@vInput)-LEN(REPLACE(@vInput,@vLabel1,SPACE(0))))/(LEN(@vLabel1));
	DECLARE @vOcur2 as Smallint; 	SET @vOcur2 = (LEN(@vInput)-LEN(REPLACE(@vInput,@vLabel2,SPACE(0))))/(LEN(@vLabel2));
	
	IF (@vOcur1 - @vOcur2 = 0) AND @vOcur1 > 0
	BEGIN
		-- We have proper marking of labels. We can trim.
	
	--BEGIN
		-- Trim 1
		IF CharIndex (@vLabel1,@vInput) > 0
		BEGIN
			DECLARE @vPos1 INT; SET @vPos1 = CharIndex(@vLabel1, @vInput)+LEN(@vLabel1)-1;
			DECLARE @vPos2 INT; SET @vPos2 = CharIndex(@vLabel2,@vInput);
			DECLARE @vEnd INT;  SET @vEnd = LEN(@vInput);
			IF (@vPos1 < @vPos2) AND (@vPos2 < @vEnd) 
			BEGIN
				SET @vOut = SUBSTRING(@vInput,1,@vPos1) +SPACE(0)+SUBSTRING(@vInput,@vPos2,@vEnd);
			END
		END;

		-- Trim 2
		IF CharIndex (@vLabel1,@vOut,@vPos2) > 0
		BEGIN
			SET @vPos1 = CHARIndex(@vLabel1 ,@vOut,@vPos2)+LEN(@vLabel1)-1;
			SET @vPos2 = CHARIndex(@vLabel2,@vOut,@vPos1);
			SET @vEnd = LEN(@vOut);
			IF (@vPos1 < @vPos2) AND (@vPos2 < @vEnd) 
			BEGIN
				SET @vOut = SUBSTRING(@vOut,1,@vPos1) +SPACE(0)+SUBSTRING(@vOut,@vPos2,@vEnd);
			END
		END;


		-- Trim 3
		IF CharIndex (@vLabel1,@vOut,@vPos2) > 0
		BEGIN
			SET @vPos1 = CHARIndex(@vLabel1 ,@vOut,@vPos2)+LEN(@vLabel1)-1;
			SET @vPos2 = CHARIndex(@vLabel2,@vOut,@vPos1);
			SET @vEnd = LEN(@vOut);
			IF (@vPos1 < @vPos2) AND (@vPos2 < @vEnd) 
			BEGIN
				SET @vOut = SUBSTRING(@vOut,1,@vPos1) +SPACE(0)+SUBSTRING(@vOut,@vPos2,@vEnd);
			END
		END;


		-- Trim 4
		IF CharIndex (@vLabel1,@vOut,@vPos2) > 0
		BEGIN
			SET @vPos1 = CHARIndex(@vLabel1 ,@vOut,@vPos2)+LEN(@vLabel1)-1;
			SET @vPos2 = CHARIndex(@vLabel2,@vOut,@vPos1);
			SET @vEnd = LEN(@vOut);
			IF (@vPos1 < @vPos2) AND (@vPos2 < @vEnd) 
			BEGIN
				SET @vOut = SUBSTRING(@vOut,1,@vPos1) +SPACE(0)+SUBSTRING(@vOut,@vPos2,@vEnd);
			END
		END;

		-- Trim 5
		IF CharIndex (@vLabel1,@vOut,@vPos2) > 0
		BEGIN
			SET @vPos1 = CHARIndex(@vLabel1 ,@vOut,@vPos2)+LEN(@vLabel1)-1;
			SET @vPos2 = CHARIndex(@vLabel2,@vOut,@vPos1);
			SET @vEnd = LEN(@vOut);
			IF (@vPos1 < @vPos2) AND (@vPos2 < @vEnd) 
			BEGIN
				SET @vOut = SUBSTRING(@vOut,1,@vPos1) +SPACE(0)+SUBSTRING(@vOut,@vPos2,@vEnd);
			END
		END;
		

	END
	
	
	
	--END
	ELSE
	BEGIN
		-- No proper labels, do nothing!
		SET @vOut = @vInput;
	END

	

	
	
    RETURN @vOut;

END 
GO

