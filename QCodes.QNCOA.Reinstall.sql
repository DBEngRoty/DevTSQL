USE MASTER;


-- ADD QCODE
--EXEC sp_addextendedproc xp_qcodebase, 'xp_qcodeLWS.dll'
-- DROP
--EXEC sp_dropextendedproc xp_qcodebase


--QCODE
USE MASTER
declare @retStr as varchar(500); declare @quality as smallint; declare @found_code as char(6); declare @count as smallint;

EXEC dbo.xp_qcodebase '2200 YONGE ST','TORONTO','ON','M4S2C6', @retStr output, @found_code output, @count output, @quality
select @retStr AS QCAddressInfo, @found_code as PC_Found, @count AS PC_Counted, @quality AS QUALITY;
--PRINT @@ERROR



-- ADD QNCOA
--EXEC sp_addextendedproc xp_qncoabase, 'xp_qncoaLWS.dll'
-- REMOVE
--EXEC sp_dropextendedproc xp_qncoabase

declare @retStr as varchar(500); declare @status as integer;
EXEC MASTER.dbo.xp_qncoabase 'ASOLINE AU', '8 YUKON DR','RICHMOND HILL','ON','L4B4E9', @retStr output,@status output
select @retStr, @status