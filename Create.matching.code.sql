CREATE   FUNCTION CreateMatchCodes_BusinessNameIMP(@BusName VARCHAR(60)) 
RETURNS VARCHAR(15)
AS

BEGIN
DECLARE @M_BusName VARCHAR(60); SELECT @M_BusName = '';
DECLARE @Word1 VARCHAR(60); SELECT @Word1='';
DECLARE @Word2 VARCHAR(50); SELECT @Word2='';
DECLARE @Word3 VARCHAR(40); SELECT @Word3='';

----Rule 1 - Remove strange chars 
	SELECT @BusName=REPLACE(@Busname,CHAR(39),'');  -- The apostrofy
	SELECT @BusName=REPLACE(@BusName,'.','');
	SELECT @BusName=REPLACE(@BusName,',','');
	SELECT @BusName=REPLACE(@BusName,'-','');
	SELECT @BusName=REPLACE(@BusName,'_','');
	SELECT @BusName=REPLACE(@BusName,'&','');
	SELECT @BusName=REPLACE(@BusName,'É',''); 
	SELECT @BusName=REPLACE(@BusName,SPACE(5),' ')
	SELECT @BusName=REPLACE(@BusName,SPACE(4),' ')
	SELECT @BusName=REPLACE(@BusName,SPACE(3),' ')
	SELECT @BusName=REPLACE(@BusName,SPACE(2),' ');  SELECT @BusName=LTRIM(RTRIM(@BusName));  SELECT @M_BusName=@BusName; --Save the intermediate value


-- Remove non significant words IF there are more than 3 words only
IF LEN(@BusName)>1 AND CHARINDEX(' ',@BusName)<>0 AND CHARINDEX(' ',@BusName,(CHARINDEX(' ',@BusName)+1))<>0 
BEGIN
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'LTD'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'AND'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'ET'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'INC'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'INCORPORATED'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'CO'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'CORP'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'CORPORATE'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'CORPORATION'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'ENTREPRISE'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'ENTREPRISES'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(SPACE(1)+@BusName+SPACE(1),SPACE(1)+'CANADA'+SPACE(1),SPACE(1))
	SELECT @BusName=REPLACE(@BusName,SPACE(5),SPACE(1))
	SELECT @BusName=REPLACE(@BusName,SPACE(4),SPACE(1))
	SELECT @BusName=REPLACE(@BusName,SPACE(3),SPACE(1))
	SELECT @BusName=REPLACE(@BusName,SPACE(2),SPACE(1))
              SELECT @Busname=LTRIM(RTRIM(@BusName));
END



-- Recover the old value if Lenght less than chosen limit
IF LEN(@BusName)<10  
BEGIN
	SELECT @BusName=@M_BusName;
END


----Rule 2 - Get first chars from words
IF LEN(@BusName)=1 SELECT @M_BusName=@BusName
-- 1 Word
IF LEN(@BusName)>1 AND CHARINDEX(' ',@BusName)=0
BEGIN
	SELECT @Word1=@BusName
	SELECT @Word1 = REPLACE(@Word1,'A',''); SELECT @Word1 = REPLACE(@Word1,'E',''); SELECT @Word1 = REPLACE(@Word1,'I',''); SELECT @Word1 = REPLACE(@Word1,'O',''); SELECT @Word1 = REPLACE(@Word1,'U',''); 
	SELECT @M_BusName = LEFT(@Word1,15);
END


-- 2 Words
IF LEN(@BusName)>1 AND CHARINDEX(' ',@BusName)<>0 AND CHARINDEX(' ',@BusName,(CHARINDEX(' ',@BusName)+1))=0 
BEGIN
       SELECT @Word1=SUBSTRING(@BusName,1,(CHARINDEX(' ',@BusName)));
       SELECT @Word2=SUBSTRING(@BusName,CHARINDEX(' ',@BusName),LEN(@BusName));
       SELECT @Word1 = REPLACE(@Word1,'A',''); SELECT @Word1 = REPLACE(@Word1,'E',''); SELECT @Word1 = REPLACE(@Word1,'I',''); SELECT @Word1 = REPLACE(@Word1,'O',''); SELECT @Word1 = REPLACE(@Word1,'U',''); 
       SELECT @Word2 = REPLACE(@Word2,'A',''); SELECT @Word2 = REPLACE(@Word2,'E',''); SELECT @Word2 = REPLACE(@Word2,'I',''); SELECT @Word2 = REPLACE(@Word2,'O',''); SELECT @Word2 = REPLACE(@Word2,'U',''); 
       SELECT @M_BusName = LEFT(@Word1,9)+LEFT(@Word2,6);
END



-- 3 Words
IF LEN(@BusName)>1 AND CHARINDEX(' ',@BusName)<>0 AND CHARINDEX(' ',@BusName,(CHARINDEX(' ',@BusName)+1))<>0 
BEGIN
       SELECT @Word1=SUBSTRING(@BusName,1,(CHARINDEX(' ',@BusName)));
       SELECT @Word2=SUBSTRING(@BusName,CHARINDEX(' ',@BusName)+1,(CHARINDEX(' ',@BusName)+1));
       SELECT @Word3=SUBSTRING(@BusName,CHARINDEX(' ',@BusName,(CHARINDEX(' ',@BusName)+1)),LEN(@BusName));
       SELECT @Word1 = REPLACE(@Word1,'A',''); SELECT @Word1 = REPLACE(@Word1,'E',''); SELECT @Word1 = REPLACE(@Word1,'I',''); SELECT @Word1 = REPLACE(@Word1,'O',''); SELECT @Word1 = REPLACE(@Word1,'U',''); 
       SELECT @Word2 = REPLACE(@Word2,'A',''); SELECT @Word2 = REPLACE(@Word2,'E',''); SELECT @Word2 = REPLACE(@Word2,'I',''); SELECT @Word2 = REPLACE(@Word2,'O',''); SELECT @Word2 = REPLACE(@Word2,'U',''); 
       SELECT @Word3 = REPLACE(@Word3,'A',''); SELECT @Word3 = REPLACE(@Word3,'E',''); SELECT @Word3 = REPLACE(@Word3,'I',''); SELECT @Word3 = REPLACE(@Word3,'O',''); SELECT @Word3 = REPLACE(@Word3,'U',''); 
       SELECT @M_BusName = LEFT(@Word1,7)+LEFT(@Word2,5)+LEFT(@Word3,3);
END

--Remove any spaces
SELECT @M_BusName = REPLACE(@M_BusName,SPACE(1),'')

--RETURN @WORD1
--RETURN @Busname
RETURN @M_BusName


END

