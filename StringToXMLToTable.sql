 

DECLARE @str VARCHAR(100)  = '1,2,3';  
DECLARE @x XML;
SELECT @x = cast('<A>'+ replace(@str,',','</A><A>')+ '</A>' as xml);
SELECT t.value('.', 'int') as inVal  from @x.nodes('/A') as x(t); 
