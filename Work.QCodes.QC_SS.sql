
-- TEST QCODE
declare @retStr as varchar(500); declare @quality as smallint; declare @found_code as char(6);declare @count as smallint;
exec MASTER.dbo.xp_qcodebase 'THOMAS SPARTA LINE','ST THOMAS','ON','N5P3S8', @retStr output,@found_code output,@count output, @quality output
select @retStr, @found_code, @count, @quality

exec MASTER.dbo.xp_qcodebase 'HWY 17','','ON','P7C4V1', @retStr output,@found_code output,@count output, @quality output
select @retStr, @found_code, @count, @quality

exec MASTER.dbo.xp_qcodebase '97 UPPER BROOKFIELD RD','','','B0N1C0', @retStr output,@found_code output,@count output, @quality output
select @retStr, @found_code, @count, @quality

exec MASTER.dbo.xp_qcodebase '502 RIDGE RD N','','','L0S1N0', @retStr output,@found_code output,@count output, @quality output
select @retStr, @found_code, @count, @quality


--SELECT TOP 100 CITY, POSTAL, PROVINCE, ADDRESS1, ADDRESS2, ADDRPOSTSTNAME, AddrPostStType, ADDRPOSTSTQUALIFIER FROM INFODIRECT_STAGE WHERE LEN(ADDRPOSTSTQUALIFIER)>0
--SELECT TOP 1 * FROM INFODIRECT_STAGE WHERE LEN(ADDRPOSTSTname)>0


--SELECT COUNT(*) AS NO FROM VIEW_TMP
--SELECT COUNT(*) AS NO FROM VIEW_RR
/*
declare @retStr as varchar(500); declare @quality as smallint; declare @found_code as char(6);declare @count as smallint;
exec MASTER.dbo.xp_qcodebase '44 KING ST W RR 2','MILLBROOK','ON','L0A1G0', @retStr output,@found_code output,@count output, @quality output
select @retStr, @found_code, @count, @quality

exec MASTER.dbo.xp_qcodebase '5 GREENAN RD','STOUFFVILLE','ON','', @retStr output,@found_code output,@count output, @quality output
select @retStr, @found_code, @count, @quality


SELECT * FROM VIEW_RR
SELECT COUNT(*) AS NO FROM VIEW_RR

SELECT COUNT(*) AS NO FROM VIEW_INVALID_ADDR WHERE STATUSSS LIKE 'N%'
SELECT COUNT(*) AS NO FROM VIEW_INVALID_ADDR WHERE STATUS IN ('N','O')
*/

--SELECT CITY, status, INVALIDADDRFLAG, MASTER.dbo.QCode_Getcity(ADDRESS,CITY,PROVINCE,POSTAL) AS CITYY FROM STAGEDB.DBO.INFODIRECT_STAGE




