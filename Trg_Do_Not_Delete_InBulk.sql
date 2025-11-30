USE [AuditDB]
GO

/****** Object:  Trigger [dbo].[Trg_Do_Not_Delete_InBulk]    Script Date: 27/05/2016 11:23:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
CREATE TRIGGER [dbo].[Trg_Do_Not_Delete_InBulk]
   ON  [dbo].[Server_Databases_Indexes_Missing]
   FOR DELETE, UPDATE
AS 

--- No not allow to delete data.

BEGIN
DECLARE @Count int; SET @Count = @@ROWCOUNT;
IF @Count>1
BEGIN
	RAISERROR ('This data can not be deleted in bulk!', 16, 1)
	ROLLBACK TRANSACTION;
	RETURN; 
END
END



GO

