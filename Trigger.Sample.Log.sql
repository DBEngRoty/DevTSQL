USE [Test]
GO
/****** Object:  Trigger [dbo].[Reminder]    Script Date: 03/13/2012 14:02:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[LogUser]
ON [dbo].[Table_1]
AFTER DELETE 
AS
--   EXEC msdb.dbo.sp_send_dbmail
--        @profile_name = 'AdventureWorks2008R2 Administrator',
--        @recipients = 'danw@Adventure-Works.com',
--        @body = 'Don''t forget to print a report for the sales force.',
--        @subject = 'Reminder';
 DECLARE @vTxt AS VARCHAR(50); set @vTxt = (select SUSER_SNAME() from  deleted);
 RAISERROR (@vTxt, 16, 10);
 
 
 
 
 USE MSSQLTips;
GO

CREATE TABLE dbo.SampleTable (
  SampleTableID INT NOT NULL IDENTITY(1,1),
  SampleTableInt INT NOT NULL,
  SampleTableChar CHAR(5) NOT NULL,
  SampleTableVarChar VARCHAR(30) NOT NULL,
  CONSTRAINT PK_SampleTable PRIMARY KEY CLUSTERED (SampleTableID)
);
GO

CREATE TABLE dbo.SampleTable_Audit (
  SampleTableID INT NOT NULL,
  SampleTableInt INT NOT NULL,
  SampleTableChar CHAR(5) NOT NULL,
  SampleTableVarChar VARCHAR(30) NOT NULL,
  Operation CHAR(1) NOT NULL,
  TriggerTable CHAR(1) NOT NULL,
  AuditDateTime smalldatetime NOT NULL DEFAULT GETDATE(),
);

CREATE INDEX IDX_SampleTable_Audit_AuditDateTime ON dbo.SampleTable_Audit (AuditDateTime DESC);
GO 

CREATE TRIGGER dbo.SampleTable_InsertTrigger
ON dbo.SampleTable
FOR INSERT
AS
BEGIN
   INSERT INTO dbo.SampleTable_Audit 
   (SampleTableID, SampleTableInt, SampleTableChar, SampleTableVarChar, Operation, TriggerTable)    
   SELECT SampleTableID, SampleTableInt, SampleTableChar, SampleTableVarChar, 'I', 'I'
   FROM inserted;
END;
GO

CREATE TRIGGER dbo.SampleTable_DeleteTrigger
ON dbo.SampleTable
FOR DELETE
AS
BEGIN
   INSERT INTO dbo.SampleTable_Audit 
   (SampleTableID, SampleTableInt, SampleTableChar, SampleTableVarChar, Operation, TriggerTable)    
   SELECT SampleTableID, SampleTableInt, SampleTableChar, SampleTableVarChar, 'D', 'D'
   FROM deleted;
END;
GO

CREATE TRIGGER dbo.SampleTable_UpdateTrigger
ON dbo.SampleTable
FOR UPDATE
AS
BEGIN
   INSERT INTO dbo.SampleTable_Audit 
   (SampleTableID, SampleTableInt, SampleTableChar, SampleTableVarChar, Operation, TriggerTable)    
   SELECT SampleTableID, SampleTableInt, SampleTableChar, SampleTableVarChar, 'U', 'D'
   FROM deleted;
   
   INSERT INTO dbo.SampleTable_Audit 
   (SampleTableID, SampleTableInt, SampleTableChar, SampleTableVarChar, Operation, TriggerTable)    
   SELECT SampleTableID, SampleTableInt, SampleTableChar, SampleTableVarChar, 'U', 'I'
   FROM inserted;
END;
GO 