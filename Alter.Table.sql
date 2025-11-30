USE [LeadDriver];
ALTER TABLE [LeadDriver].DBO.[gateway_sender_destination] ALTER COLUMN [sender_destination_name]          VARCHAR(50) NULL;
ALTER TABLE [LeadDriver].DBO.[gateway_sender_destination] ALTER COLUMN [sender_destination_username]      VARCHAR(50) NULL;
ALTER TABLE [LeadDriver].DBO.[gateway_sender_destination] ALTER COLUMN [sender_destination_password]      VARCHAR(250) NULL;
ALTER TABLE [LeadDriver].DBO.[gateway_sender_destination] ALTER COLUMN [sender_alert_email_address]       VARCHAR(100) NULL;
ALTER TABLE [LeadDriver].DBO.[gateway_sender_destination] ALTER COLUMN [destination_alert_email_address]  VARCHAR(100) NULL;


USE [ResponseDriver_I];

ALTER TABLE [ResponseDriver_I].dbo.[Email_Queue] ALTER COLUMN [Sender_Name]  VARCHAR(100) NULL;
ALTER TABLE [ResponseDriver_I].dbo.[Email_Queue] ALTER COLUMN [Sender_Email]  VARCHAR(100) NULL;


USE [ResponseDriver_I];
EXEC sp_rename 'Email_Queue', 'Email_Queue';
EXEC sp_rename 'ResponseDriver_I.dbo.Email_Queue.sender_name', 'Sender_Name', 'COLUMN';
EXEC sp_rename 'ResponseDriver_I.dbo.Email_Queue.sender_email', 'Sender_Email', 'COLUMN';
ALTER TABLE [ResponseDriver_I].dbo.[Email_Queue] ALTER COLUMN [Sender_Name]  VARCHAR(100) NULL;
ALTER TABLE [ResponseDriver_I].dbo.[Email_Queue] ALTER COLUMN [Sender_Email]  VARCHAR(100) NULL;


USE [LCS];

ALTER TABLE [LCS].dbo.[Notification_Dev] ADD [ProviderName] VARCHAR(255) NULL;

ALTER TABLE [LCS].[dbo].[Notification_CustomerCare] ALTER COLUMN [Email]      VARCHAR(50) NULL;
ALTER TABLE [LCS].[dbo].[Notification_CustomerCare] ALTER COLUMN [Last Name]  VARCHAR(40) NULL;
ALTER TABLE [LCS].[dbo].[Notification_CustomerCare] ALTER COLUMN [First Name] VARCHAR(40) NULL;

ALTER TABLE [AuditDB].[dbo].[Server_Stats_RW_IO] ALTER COLUMN [Database] VARCHAR(150) NULL;
ALTER TABLE [AuditDB].[dbo].[Server_Stats_RW_IO] ALTER COLUMN [File_Name] VARCHAR(150) NULL;


ALTER TABLE dbo.Server_Batch_ReqPerSec  DROP COLUMN InsertDate;
ALTER TABLE [LCS].dbo.[Notification_Dev] ADD [ProviderName] VARCHAR(255) NULL;


USE [ResponseDriver];
ALTER TABLE [ResponseDriver].dbo.[TELE_LOG] DROP COLUMN [Appointment_RowGUID];
ALTER TABLE [ResponseDriver].dbo.[TELE_LOG] REBUILD; --WITH (ONLINE = ON);
USE [ResponseDriver];




USE [LCS];
ALTER TABLE [LCS].[dbo].[Notification_Dev] ALTER COLUMN [Email]      VARCHAR(50) NULL;
ALTER TABLE [LCS].[dbo].[Notification_Dev] ALTER COLUMN [Last Name]  VARCHAR(40) NULL;
ALTER TABLE [LCS].[dbo].[Notification_Dev] ALTER COLUMN [First Name] VARCHAR(40) NULL;

ALTER TABLE dbo.EnhancedScan ADD RowID INT IDENTITY NOT NULL; 

-- Remane a column
sp_rename 'table_name.old_column', 'new_name', 'COLUMN';
sp_rename 'Server_Stats_Waits_Total.Waits_Total', 'Waits_Total_ms', 'COLUMN';
sp_rename 'Server_Audit_Info.Server_Name', 'Server_Name_xxx','COLUMN';
sp_rename 'Server_Audit_Info.Server_Name', 'Server_Name_xxx','COLUMN';

USE [LeaseCorpServicing];
-- Dev
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ALTER COLUMN [leaseBusinessLegalNameCorrection] nVARCHAR(100) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ALTER COLUMN [sciBusinessLegalNameColessee2Correction] nVARCHAR(100) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ALTER COLUMN [sciBusinessLegalNameColessee1Correction] nVARCHAR(100) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ALTER COLUMN [leaseDOBCorrection] nVARCHAR(20) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ALTER COLUMN [sciDOBColessee2Correction] nVARCHAR(20) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ALTER COLUMN [sciDOBColessee1Correction] nVARCHAR(20) NULL;

-- UAT
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ADD  [leaseBusinessLegalNameCorrection] nVARCHAR(100) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ADD  [sciBusinessLegalNameColessee2Correction] nVARCHAR(100) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ADD  [sciBusinessLegalNameColessee1Correction] nVARCHAR(100) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ADD  [leaseDOBCorrection] nVARCHAR(20) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ADD  [sciDOBColessee2Correction] nVARCHAR(20) NULL;
ALTER TABLE [LeaseCorpServicing].[dbo].[dataDown_changeLesseeInfo] ADD  [sciDOBColessee1Correction] nVARCHAR(20) NULL;







ALTER TABLE [ResponseDriver].[dbo].[NewsDetails] ALTER COLUMN [Description] nVARCHAR(MAX) NULL;

ALTER TABLE [AuditDB].[dbo].[Server_Audit_Tasks] ALTER COLUMN [Task] VARCHAR(100) NULL;
ALTER TABLE [AuditDB].[dbo].[Server_Audit_Tasks] ALTER COLUMN [Type] VARCHAR(20) NULL;

ALTER TABLE [AuditDB].[dbo].[Server_Audit_Thresholds] ALTER COLUMN [Max_Impact_of_No_Index] int not null;
ALTER TABLE [AuditDB].[dbo].[Server_Audit_Thresholds] ALTER COLUMN [Max_Rows_of_Bad_Index] int not null;

ALTER TABLE [AuditDB].[dbo].[Server_Audit_Thresholds] ADD [Server_Audit_Cls] SMALLDATETIME NULL;

ALTER TABLE [AuditDB].[dbo].[Server_Audit_Thresholds] ALTER COLUMN [Max_Con_Total] SMALLINT NOT NULL;
ALTER TABLE [AuditDB].[dbo].[Server_Audit_Thresholds] ALTER COLUMN [Max_Con_rUNNING] SMALLINT NOT NULL;




ALTER TABLE [ResponseDriver].[dbo].[Email_Templates] ALTER COLUMN [MessageBody] nVARCHAR(MAX) NULL;
ALTER TABLE [ResponseDriver].[dbo].[Email_Templates] ALTER COLUMN [MessagePlainTextBody] NVARCHAR(MAX) NULL;
ALTER TABLE [ResponseDriver].[dbo].[Email_Templates] DROP COLUMN [MessageAttachments];

ALTER TABLE [ResponseDriver].[dbo].[Email_Messages] ALTER COLUMN [MessageBody] nVARCHAR(MAX) NULL;
ALTER TABLE [ResponseDriver].[dbo].[Email_Messages] ALTER COLUMN [MessagePlainTextBody] NVARCHAR(MAX) NULL;

ALTER TABLE [AuditDB].[dbo].[Server_Stats_Processes] ALTER COLUMN [Process_Description] VARCHAR(500) NULL;
ALTER TABLE [AuditDB].[dbo].[Server_Stats_Processes] ADD [CounterValue] INT NULL;

USE [ResponseDriver_I]

ALTER TABLE ResponseDriver_I.dbo.email_queue ALTER COLUMN [subject] VARCHAR(512);

ALTER TABLE [ResponseDriver_I].[dbo].[email_queue_tmp] ALTER COLUMN [subject] VARCHAR(70) NULL;
ALTER TABLE [ResponseDriver_I].[dbo].[email_queue_tmp] ALTER COLUMN [subject] VARCHAR(50) NULL;

USE [CommonService];

ALTER TABLE [CommonService].[dbo].[vehicle_model_trim] ALTER COLUMN Trim VARCHAR(20) NULL;

ALTER TABLE [CommonService].[dbo].[Vehicle_Decoder_Options] ADD [Option_Type] VARCHAR(20) NULL;
ALTER TABLE [CommonService].[dbo].[Vehicle_Decoder_Options] ADD [Option_Category_Code] VARCHAR(20) NULL;


ALTER TABLE CommonService.dbo.Dealers ALTER COLUMN ZIP5 VARCHAR(10) NULL;

ALTER TABLE AuditDB.dbo.Server_DB_File ALTER COLUMN Database_Name VARCHAR(150)
ALTER TABLE AuditDb.dbo.Server_DB_File ALTER COLUMN DB_File_Name VARCHAR(250)NULL;

ALTER TABLE AuditDB.dbo.Server_DB_File_Archive ALTER COLUMN Database_Name VARCHAR(150)
ALTER TABLE AuditDb.dbo.Server_DB_File_Archive ALTER COLUMN DB_File_Name VARCHAR(250)NULL;

ALTER TABLE AuditDb.dbo.Server_PLE DROP COLUMN [InsertDate];
ALTER TABLE AuditDb.dbo.Server_PLE ADD [InsertDate] DateTime default getdate()  NOT NULL;

ALTER TABLE AuditDb.dbo.Server_Locks ADD [InsertUTCDate] DateTime default getUTCdate()  NOT NULL;


ALTER TABLE AuditDb.dbo.Server_Stats_PLE ADD [InsertUTCDate] DateTime default getUTCdate()  NOT NULL;

ALTER TABLE AuditDb.dbo.Server_Stats_Waits ADD [InsertUTCDate] DateTime default getUTCdate()  NOT NULL;


ALTER TABLE dbo.Server_Batch_ReqPerSec  DROP COLUMN InsertDateUTC;
ALTER TABLE dbo.Server_Batch_ReqPerSec  DROP COLUMN InsertDate;
ALTER TABLE [LCS].dbo.[Notification_Dev] ADD [ProviderName] VARCHAR(255) NULL;
 


ALTER TABLE AuditDb.dbo.Servers_Outage_History ADD [InsertDate] DateTime default getdate()  NOT NULL;

ALTER TABLE AuditDb.dbo.Server_Batch_ReqPerSec  ADD [Batch_ReqPerSec] BIGINT DEFAULT 0 NOT NULL;
ALTER TABLE AuditDb.dbo.Server_Batch_ReqPerSec  ADD [Batch_ReqPerSec_Total] BIGINT DEFAULT 0 NOT NULL;


USE [LeadGateway];
ALTER TABLE LeadGateway.dbo.[PartnerNameTypeToProviderId] ALTER COLUMN [LeadClassName] VARCHAR(20) NULL;  --- 7 Jan 2015 (UAT & QA)



SELECT * FROM dbo.ao_Dealers WHERE Dlr_num IS NULL

ALTER TABLE dbo.ao_Dealers ALTER COLUMN Dlr_num VARCHAR(50) NOT NULL;

ALTER TABLE [dbo].[Server_TSQLs] ALTER COLUMN [TSQL_Type] VARCHAR(10) NOT NULL;


ALTER TABLE AuditDb.dbo.Server_DB_File ALTER COLUMN DB_File_Name VARCHAR(150)NULL;
ALTER TABLE AuditDb.dbo.Server_DB_File_Archive ALTER COLUMN DB_File_Name VARCHAR(150)NULL;


ALTER TABLE dbo.ao_Dealers ALTER COLUMN Dlr_Company VARCHAR(60) NOT NULL;

ALTER TABLE dbo.ao_Dealers ALTER COLUMN Rowguid uniqueidentifier NOT NULL;


ALTER TABLE dbo.ao_Dealers ALTER COLUMN Configuration_Status VARCHAR(50) NOT NULL;

DELETE FROM dbo.ao_Dealers WHERE Rowguid IS NULL
SELECT * FROM dbo.ao_Dealers WHERE Rowguid IS NULL



ALTER TABLE LeadManagement.dbo._migration_activity_Run_Wait ALTER COLUMN End_Time [datetime]

ALTER TABLE DM_Segmented ALTER COLUMN PID [BIGINT]

ALTER TABLE dbo.Server_Batch_ReqPerSec  DROP COLUMN Batch_Requests_PerSec;

ALTER TABLE dbo.[T_LG] DROP COLUMN RowID; 
ALTER TABLE dbo.EnhancedScan ADD RowID INT IDENTITY NOT NULL; 

ALTER TABLE MyCustomers ALTER COLUMN CompanyName SET DEFAULT 'A. Datum Corporation'

ALTER TABLE supplier ADD ( supplier_name varchar2(50), city varchar2(45) ); 

ALTER TABLE dbo.actd_dmo DROP COLUMN Activity_Code_ID

EXEC sp_rename 'Test.dbo.EnhancedScan_10.M_GENERAL','M_GENERAL_DF','COLUMN'

ALTER TABLE dbo.APC_CAMP_STAGE_QC_FIX ADD Address_Fix0 varchar(45)
ALTER TABLE dbo.APC_CAMP_STAGE_QC_FIX ADD RRNO varchar(5)

ALTER TABLE dbo.AccPac_Mth_Dlr_Bill ADD DIVISION_CD char(5)

ALTER TABLE dbo.AccPac_Mth_Dlr_Bill ADD SITE_CD char(10)




---- Add filed with constaint
ALTER TABLE [dbo].[Alerts_Email_Distribution_List]  WITH CHECK ADD CHECK  (([Active]='NO' OR [Active]='YES'))
ALTER TABLE [dbo].[Alerts_Email_Distribution_List]  WITH CHECK ADD CHECK  (([Alert_Monitor_Leads_Health_Mazda]='NO' OR [Alert_Monitor_Leads_Health_Mazda]='YES'))
GO
