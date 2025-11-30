USE [FinancePortal]
GO

/****** Object:  Trigger [dbo].[Trg_Do_Not_Modify]    Script Date: 12/01/2016 4:57:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
CREATE TRIGGER [dbo].[Trg_Do_Not_Modify]
   ON  [dbo].[ClobData] 
   AFTER INSERT,DELETE,UPDATE
AS 

--- No not allpw to change old data

BEGIN
SET NOCOUNT ON;

--IF (SELECT YEAR FROM DELETED)<2000 
IF (SELECT [LastModifiedDateTime] FROM DELETED )<(Getdate()-30 )
BEGIN
	RAISERROR ('This data can not be changed! This is a bussiness rule!', 16, 1)
	ROLLBACK TRANSACTION
	RETURN; 
END
END



GO

