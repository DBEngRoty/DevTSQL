-- SQL 2k5 and above
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'AdventureWorks Administrator',
    @recipients = 'danw@Adventure-Works.com',
    @query = 'SELECT COUNT(*) FROM AdventureWorks.Production.WorkOrder
                  WHERE DueDate > ''2004-04-30''
                  AND  DATEDIFF(dd, ''2004-04-30'', DueDate) < 2' ,
    @subject = 'Work Order Count',
    @attach_query_result_as_file = 1 ;
	
	
-- SQL2K5 - WORKING SIMPLE SAMPLE
-- In SQL 2005 you have ot create a DB mail profile global in SQL server that will send the email.
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'WS443',
    @recipients = 'protariu@cstonecanada.com',
    @subject = 'Work Order Count',
	@body ='mesaj';
	

	
sp_send_dbmail [ [ @profile_name = ] 'profile_name' ]
    [ , [ @recipients = ] 'recipients [ ; ...n ]' ]
    [ , [ @copy_recipients = ] 'copy_recipient [ ; ...n ]' ]
    [ , [ @blind_copy_recipients = ] 'blind_copy_recipient [ ; ...n ]' ]
    [ , [ @subject = ] 'subject' ] 
    [ , [ @body = ] 'body' ] 
    [ , [ @body_format = ] 'body_format' ]
    [ , [ @importance = ] 'importance' ]
    [ , [ @sensitivity = ] 'sensitivity' ]
    [ , [ @file_attachments = ] 'attachment [ ; ...n ]' ]
    [ , [ @query = ] 'query' ]
    [ , [ @execute_query_database = ] 'execute_query_database' ]
    [ , [ @attach_query_result_as_file = ] attach_query_result_as_file ]
    [ , [ @query_attachment_filename = ] query_attachment_filename ]
    [ , [ @query_result_header = ] query_result_header ]
    [ , [ @query_result_width = ] query_result_width ]
    [ , [ @query_result_separator = ] 'query_result_separator' ]
    [ , [ @exclude_query_output = ] exclude_query_output ]
    [ , [ @append_query_error = ] append_query_error ]
    [ , [ @query_no_truncate = ] query_no_truncate ]
    [ , [ @query_result_no_padding = ] query_result_no_padding ]
    [ , [ @mailitem_id = ] mailitem_id ] [ OUTPUT ]
	
	
	
	

-- SQL 2K	
IF PATINDEX('%@%' , @vReciDV) > 0 EXEC master.dbo.xp_sendmail @recipients = @vReciDV,   @query = ' EXEC AuditDB.dbo.usp_JobInfoError 0 ',   @subject = @vSubject ,    @message = '  ?  ',    @attach_results = 'FALSE', @width = 250
IF PATINDEX('%@%' , @vReciDA) > 0 EXEC master.dbo.xp_sendmail @recipients = @vReciDA,   @query = ' EXEC AuditDB.dbo.usp_JobInfoError 0 ',   @subject = @vSubject ,    @message = '  ?  ',    @attach_results = 'FALSE', @width = 250



