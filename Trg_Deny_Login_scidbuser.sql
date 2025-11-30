USE [master]
GO
/****** Object:  DdlTrigger [Trg_Deny_Login_scidbuser]    Script Date: 24/02/2014 3:09:54 PM ******/
--DROP TRIGGER [Trg_Deny_Login_scidbuser] ON ALL SERVER
GO
/****** Object:  DdlTrigger [Trg_Deny_Login_scidbuser]    Script Date: 24/02/2014 3:09:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Trg_Deny_Login_scidbuser]
ON ALL SERVER 
FOR LOGON
AS
BEGIN
IF ORIGINAL_LOGIN()= 'scidbuser' AND (SELECT COUNT(1) FROM sys.dm_exec_sessions WHERE is_user_process = 1 AND original_login_name = 'scidbuser' AND host_name LIKE 'MA%L') > 0
    ROLLBACK;
END;

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
gO
ENABLE TRIGGER [Trg_Deny_Login_scidbuser] ON ALL SERVER
GO

