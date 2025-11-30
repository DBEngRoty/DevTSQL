-- MS DBA
-- EXEC  sp_dba_KillProcessesDB  'ArielDC','KILL_PROCESSES'

CREATE PROCEDURE spu_dba_KillProcessesDB (@vcDatabase VARCHAR(30) = NULL, @vcKillProcesses VARCHAR(14) = NULL)
AS

DECLARE @siSPID SMALLINT, @vccmd varchar(255)

IF @vcKillProcesses <> 'KILL_PROCESSES' OR @vcDatabase IS NULL OR @vcKillProcesses IS NULL BEGIN
	PRINT 'syntax: sp_dba_KillProcessesDB @vcDatabase=<DatabaseName>, @vcKillProcesses=KILL_PROCESSES'
	RETURN
END

DECLARE cProcesses INSENSITIVE CURSOR
FOR 
SELECT 	spid 
FROM 	master..sysprocesses	p,
	master..sysdatabases	d
WHERE 	p.dbid = d.dbid
AND	d.name = @vcDatabase

OPEN cProcesses

FETCH NEXT FROM cProcesses INTO @siSPID

WHILE (@@FETCH_STATUS = 0) BEGIN

	SELECT @vccmd = 'KILL ' + CONVERT(VARCHAR, @siSPID)

	EXECUTE(@vccmd)

	FETCH NEXT FROM cProcesses INTO @siSPID

END

CLOSE cProcesses
DEALLOCATE cProcesses
GO