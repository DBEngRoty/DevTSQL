IF OBJECT_ID ('Sales.reminder2','TR') IS NOT NULL
    DROP TRIGGER Sales.reminder2;
GO
CREATE TRIGGER reminder2
ON Sales.Customer
AFTER INSERT, UPDATE, DELETE 
AS
   EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'AdventureWorks2008R2 Administrator',
        @recipients = 'danw@Adventure-Works.com',
        @body = 'Don''t forget to print a report for the sales force.',
        @subject = 'Reminder';
GO

-- SELECT SUSER_SNAME() FROM deleted 
-- 
