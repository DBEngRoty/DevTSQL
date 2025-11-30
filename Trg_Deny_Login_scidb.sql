USE [master]
GO
/****** Object:  DdlTrigger [Trg_Deny_Login_scidb]    Script Date: 24/02/2014 3:23:01 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE TRIGGER [Trg_Deny_Login_scidb]
ON ALL SERVER 
FOR LOGON
AS
BEGIN
IF ORIGINAL_LOGIN()= 'scidb' AND (SELECT COUNT(1) FROM sys.dm_exec_sessions WHERE is_user_process = 1 AND original_login_name = 'scidb' AND host_name LIKE 'MA%L') > 0
    ROLLBACK;
END;

GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ENABLE TRIGGER [Trg_Deny_Login_scidb] ON ALL SERVER
GO

