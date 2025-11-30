USE [ResponseDriver]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_STD_PhoneCleansing]    Script Date: 02/12/2013 6:26:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[udf_STD_PhoneCleansing](@Phone varchar(20)) 
RETURNS char(10)
AS

BEGIN

DECLARE @VPhone VARCHAR(14); SELECT @VPhone='';
DECLARE @i INT; SELECT @i = 1;
DECLARE @INChar CHAR(1); SELECT @INChar ='';

WHILE (LEN(@VPhone)<14)  AND @i<=LEN(@Phone)
   BEGIN
  SELECT @INChar = SUBSTRING(@Phone,@i,1)
  
  IF (@INChar IN ('0','1','2','3','4','5','6','7','8','9')) 
   BEGIN
    SELECT @INChar=(@INChar);
    END
  ELSE
   BEGIN
    SELECT @INChar='';
   END  

  SELECT @VPhone = @VPhone + @INChar
  SELECT @i = @i +1
 END

SELECT @VPhone=REPLACE(@VPhone,SPACE(2),'')
SELECT @VPhone=REPLACE(@VPhone,SPACE(1),'')
SELECT @VPhone=LTRIM(@VPhone)
SELECT @VPhone=LEFT(@VPhone,10)


-- Area code validation
--IF (SELECT COUNT(*) FROM StoreDB.dbo.Lookup_AreaCodes WHERE LEFT(@VPhone,3)=Area)=0
--BEGIN
--    SELECT @VPhone=NULL;
-- END


RETURN(@VPhone)
END


GO

