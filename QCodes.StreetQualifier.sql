USE MASTER
declare @retStr as varchar(500)
declare @quality as smallint
declare @found_code as char(6)
declare @count as smallint

EXEC dbo.xp_qcodebase 'PO BOX 476 STN MAIN','WINIPEG','MB','R3C2J3', @retStr output, @found_code output, @count output, @quality
select @retStr AS QCAddressInfo, @found_code as PC_Found, @count AS PC_Counted, @quality AS QUALITY;

EXEC dbo.xp_qcodebase 'PO BOX 68001 RPO OSBORNE VILLAGE','WINIPEG','MB','R3C4E6', @retStr output, @found_code output, @count output, @quality
select @retStr AS QCAddressInfo, @found_code as PC_Found, @count AS PC_Counted, @quality AS QUALITY;

EXEC dbo.xp_qcodebase 'PO BOX 31478 RPO MAIN STREET','WITHEHORSE','YT','Y1A6K8', @retStr output, @found_code output, @count output, @quality
select @retStr AS QCAddressInfo, @found_code as PC_Found, @count AS PC_Counted, @quality AS QUALITY;