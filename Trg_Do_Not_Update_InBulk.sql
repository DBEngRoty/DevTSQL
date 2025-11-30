USE [LeadGateway]
GO

/****** Object:  Trigger [dbo].[Trg_Do_Not_Delete_InBulk]    Script Date: 27/05/2016 11:23:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
CREATE or ALTER TRIGGER [dbo].[Trg_Do_Not_Update_InBulk]
   ON  [dbo].[gateway_record]
   FOR UPDATE
AS 

--- Limit update in bulk data.

BEGIN
DECLARE @Count int; SET @Count = @@ROWCOUNT;
IF @Count>50
BEGIN
	RAISERROR ('Update in bulk is forbiden. Check with Prod Support and DBA!', 16, 1)
	ROLLBACK TRANSACTION;
	RETURN; 
END
END



GO

