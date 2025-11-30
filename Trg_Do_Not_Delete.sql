USE [AuditDB]
GO

/****** Object:  Trigger [dbo].[Trg_Do_Not_Delete]    Script Date: 27/05/2016 11:16:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
CREATE TRIGGER [dbo].[Trg_Do_Not_Delete]
   ON  [dbo].[Server_Databases_Indexes_Missing]
   AFTER INSERT,DELETE,UPDATE
AS 

--- No not allpw to change old data

BEGIN
SET NOCOUNT ON;

BEGIN
	RAISERROR ('This data can not be deleted!', 16, 1)
	ROLLBACK TRANSACTION;
	RETURN; 
END
END



GO

