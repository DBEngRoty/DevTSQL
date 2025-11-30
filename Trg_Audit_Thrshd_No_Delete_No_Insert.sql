USE [AuditDB]
GO

/****** Object:  Trigger [dbo].[Trg_Audit_Thrshd_No_Delete_No_Insert]    Script Date: 06/02/2018 2:22:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
CREATE TRIGGER [dbo].[Trg_Audit_Thrshd_No_Delete_No_Insert]
   ON  [dbo].[Server_Audit_Thresholds] 
   after DELETE, INSERT
AS 

--- Only one record in this table

BEGIN
SET NOCOUNT ON;


IF (SELECT COUNT(1) FROM DELETED )>0
BEGIN
	RAISERROR ('Only one record in this table! Just update! No delete!', 16, 1)
	ROLLBACK TRANSACTION
	RETURN; 
END

IF (SELECT COUNT(1) FROM inserted)>0
BEGIN
	RAISERROR ('Only one record in this table! Just update! No insert!', 16, 1)
	ROLLBACK TRANSACTION
	RETURN; 
END



END



GO

ALTER TABLE [dbo].[Server_Audit_Thresholds] ENABLE TRIGGER [Trg_Audit_Thrshd_No_Delete_No_Insert]
GO

