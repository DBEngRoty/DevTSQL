USE StageDB; 
--SELECT QCODEADDRESSINFO, ADDRPOSTSTQUALIFIER, ADDRESS1, ADDRESS2, ADDRESS, CITY, POSTAL  FROM InfoDirect_Stage;



SELECT  QCODEADDRESSINFO, DBO.udf_QCParseAddressStreetNO(QCODEADDRESSINFO) AS STEET, STATUS, ROWID, ADDRESS, POSTAL FROM InfoDirect_Stage WHERE SUBSTRING(QCODEADDRESSINFO,94,1) IN ('W','D')




--SELECT QCODEADDRESSINFO, ADDRPOSTSTTYPE, ADDRPOSTSTNAME, ADDRPOSTSTQUALIFIER, ADDRESS1, ADDRESS2, ADDRESS, CITY, POSTAL  FROM InfoDirect_Stage WHERE LEN(ADDRPOSTSTQUALIFIER)>0
--DROP TABLE InfoDirect_Stage_SS
--SELECT * INTO InfoDirect_Stage_SS FROM INFODIRECT_STAGE
--SELECT TOP 200 ADDRESS1, ADDRESS2, ADDRPOSTSTQUALIFIER FROM INFODIRECT_STAGE_SS WHERE LEN(ADDRPOSTSTQUALIFIER)>0
--SELECT COUNT(*) AS NO FROM InfoDirect_Stage WHERE STATUS IN ('N','O')
--SELECT COUNT(*) AS NO FROM InfoDirect_Stage_SS WHERE STATUS LIKE 'N%'
--UPDATE InfoDirect_Stage SET InvalidAddrFlag = '0' --dbo.udf_QCInvalidAddr(Status)
--SELECT (CASE Status WHEN 'N' THEN 1 WHEN 'O' THEN 1  ELSE 0 END) AS INVALID, INVALIDADDRFLAG, STATUS FROM InfoDirect_Stage 
--SELECT  QCODEADDRESSINFO, DBO.CreateMatchCodes_SuiteNumber(QCODEADDRESSINFO) AS M_SUITE, ADDRESS, POSTAL FROM InfoDirect_Stage
--SELECT  DBO.CreateMatchCodes_MainAddressLine(QCODEADDRESSINFO) AS M_GENERAL, QCODEADDRESSINFO, ADDRESS, POSTAL FROM InfoDirect_Stage
--SELECT  DBO.CreateMatchCodesQC_CivicNumber(QCODEADDRESSINFO) AS M_CIVIC, QCODEADDRESSINFO, ADDRESS, POSTAL FROM InfoDirect_Stage
--SELECT DBO.CreateMatchCodes_StreetName(QCODEADDRESSINFO), QCODEADDRESSINFO, ADDRESS, POSTAL FROM InfoDirect_Stage
--SELECT DBO.CreateMatchCodes_GeneralDelivery(QCODEADDRESSINFO), QCODEADDRESSINFO, ADDRESS, POSTAL FROM InfoDirect_Stage WHERE ADDRESS LIKE 'GD%' 
--SELECT SUBSTRING(QCODEADDRESSINFO,231,5) FROM InfoDirect_Stage WHERE SUBSTRING(QCODEADDRESSINFO,231,2)='RR'
--SELECT QCODEADDRESSINFO, ADDRESS1, ADDRESS2, ADDRESS, CITY, POSTAL  FROM InfoDirect_Stage WHERE ADDRESS LIKE 'RR%' OR SUBSTRING(QCODEADDRESSINFO,231,2)='RR'
--SELECT DBO.CreateMatchCodes_RuralRoute(QCODEADDRESSINFO), QCODEADDRESSINFO, ADDRESS, POSTAL FROM InfoDirect_Stage
--SELECT DBO.CreateMatchCodes_POBox_OLD(Address1,Address2,'',''),QCODEADDRESSINFO, ADDRESS, POSTAL FROM InfoDirect_Stage
--SELECT DBO.CreateMatchCodes_POBox(QCODEADDRESSINFO),           QCODEADDRESSINFO, ADDRESS, POSTAL FROM InfoDirect_Stage
--SELECT MAX(LEN(QCODEADDRESSINFO)) FROM InfoDirect_Stage
--SELECT ADDRESS1, ADDRESS2, DBO.udf_COParseAddressPostStType(ParsedAddress) FROM InfoDirect_Stage_SS 
--SELECT ADDRESS, DBO.udf_QCParseAddressSuiteNo(QCodeAddressInfo) AS QC_APT FROM InfoDirect_Stage WHERE LEN(ADDRESS2)>0
--SELECT ADDRESS, DBO.udf_QCParseAddressStreetNo(QCodeAddressInfo) AS QC_STREETNO FROM InfoDirect_Stage
--SELECT ADDRESS, DBO.udf_QCParseAddressStreetSuffix(QCodeAddressInfo)  FROM InfoDirect_Stage
--SELECT ADDRESS, DBO.udf_QCParseAddressStreetName(QCodeAddressInfo)  FROM InfoDirect_Stage
--SELECT ADDRESS, DBO.udf_QCParseAddressStreetType(QCodeAddressInfo)  FROM InfoDirect_Stage
--SELECT ADDRESS, QCodeAddressInfo, SUBSTRING(QCodeAddressInfo,94,1)  FROM InfoDirect_Stage WHERE SUBSTRING(QCodeAddressInfo,94,1)='C'
--SELECT ADDRESS, DBO.udf_QCParseAddressStreetDirection(QCodeAddressInfo)  FROM InfoDirect_Stage WHERE SUBSTRING(QCodeAddressInfo,94,1)='C'
--SELECT ADDRESS, DBO.udf_QCParseAddressPOBox(QCodeAddressInfo)  FROM InfoDirect_Stage 

/*
-- TEST QCODE
declare @retStr as varchar(500); declare @quality as smallint; declare @found_code as char(6);declare @count as smallint;
--exec dbo.xp_qcodebase '8 YUKON DR','RICHMOND HILL','ON','L4B4E9', @retStr output,@found_code output,@count output, @quality output
--select @retStr, @found_code, @count, @quality

exec dbo.xp_qcodebase '1132 CAMPBELL AVE RR 3 LCD ROYAL CITY MAIL','MARTINTOWN','ON','K0C1S0', @retStr output,@found_code output,@count output, @quality output
select @retStr, @found_code, @count, @quality

exec dbo.xp_qcodebase 'RR 1 SUCC BUREAU-CHEF','GATINEAU','QC','J8T4Y6', @retStr output,@found_code output,@count output, @quality output
select @retStr, @found_code, @count, @quality

SELECT TOP 100 CITY, POSTAL, PROVINCE, ADDRESS1, ADDRESS2, ADDRPOSTSTNAME, AddrPostStType, ADDRPOSTSTQUALIFIER FROM INFODIRECT_STAGE WHERE LEN(ADDRPOSTSTQUALIFIER)>0
--SELECT TOP 1 * FROM INFODIRECT_STAGE WHERE LEN(ADDRPOSTSTname)>0
*/

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




