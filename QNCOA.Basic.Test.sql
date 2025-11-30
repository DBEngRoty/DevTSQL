USE MASTER;

-- ADD
--EXEC sp_addextendedproc xp_qncoabase, 'xp_qncoa.dll'

-- REMOVE
--EXEC sp_dropextendedproc xp_qncoabase
 

declare @retStr as varchar(500); declare @status as integer;
exec MASTER.dbo.xp_qncoabase 'ASOLINE AU', '8 YUKON DR','RICHMOND HILL','ON','L4B4E9', @retStr output,@status output
select @retStr, @status

