USE [FinancePortal]
GO

/****** Object:  Trigger [dbo].[Trg_Do_Not_Modify_CDS]    Script Date: 20/01/2016 11:13:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
create TRIGGER [dbo].[Trg_Do_Not_Modify_CDS]
   ON  [dbo].[ContractDocumentSigned]
   AFTER DELETE, UPDATE
AS 

--- No not allow to change old data
--- Finance Portal should hodl the data for 7 years (read only)
--- do not purge before 7 years

BEGIN
SET NOCOUNT ON;

--IF (SELECT YEAR FROM DELETED)<2000 
IF (SELECT [LastModifiedDateTime] FROM DELETED )<(Getdate()-30 )
BEGIN
	RAISERROR ('This data can not be changed! The data should be stored for 7 years before purging. This is a bussiness rule!', 16, 1)
	ROLLBACK TRANSACTION
	RETURN; 
END
END



GO

