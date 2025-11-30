
-- Locate a field in a database
SELECT table_name,column_name from information_schema.columns
WHERE column_name like '%Activity_Code%' 


USE ResponseDriver;
GO

sp_rename 'Notification_Emails.Activity_Code',          'Activity_Code_DEL','COLUMN'; 
sp_rename 'Email_Messages.Activity_Code',               'Activity_Code_DEL','COLUMN'; 
sp_rename 'Leads.Activity_Code',                        'Activity_Code_DEL','COLUMN'; 
sp_rename 'external_email_reference_log.Activity_Code', 'Activity_Code_DEL','COLUMN'; 
sp_rename 'leads_bak.Activity_Code',                    'Activity_Code_DEL','COLUMN'; 
sp_rename 'Notification_Log.Activity_Code',             'Activity_Code_DEL','COLUMN'; 



sp_rename 'Notification_Emails.Activity_Code_DEL',          'Activity_Code','COLUMN';
sp_rename 'Email_Messages.Activity_Code_DEL',               'Activity_Code','COLUMN'; 
sp_rename 'Leads.Activity_Code_DEL',                        'Activity_Code','COLUMN'; 
sp_rename 'external_email_reference_log.Activity_Code_DEL', 'Activity_Code','COLUMN'; 
sp_rename 'leads_bak.Activity_Code_DEL',                    'Activity_Code','COLUMN'; 
sp_rename 'Notification_Log.Activity_Code_DEL',             'Activity_Code','COLUMN'; 

