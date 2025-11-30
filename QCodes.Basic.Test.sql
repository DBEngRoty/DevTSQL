USE MASTER;

-- ADD
--EXEC sp_addextendedproc xp_qcodebase, 'xp_qcodeLT300606WS.dll'

-- DROP
--EXEC sp_dropextendedproc xp_qcodebase


USE MASTER
declare @retStr as varchar(500)
declare @quality as smallint
declare @found_code as char(6)
declare @count as smallint

EXEC dbo.xp_qcodebase '2200 YONGE ST','TORONTO','ON','M4S2C6', @retStr output, @found_code output, @count output, @quality
select @retStr AS QCAddressInfo, @found_code as PC_Found, @count AS PC_Counted, @quality AS QUALITY;
--PRINT @@ERROR


