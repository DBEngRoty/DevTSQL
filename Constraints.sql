USE [LeadDriver]
GO

ALTER TABLE [dbo].[Alerts_Email_Distribution_List]  WITH CHECK ADD CHECK  (([Active]='NO' OR [Active]='YES'))
GO


USE [LeadDriver]
GO

ALTER TABLE [dbo].[Alerts_Email_Distribution_List]  WITH CHECK ADD CHECK  (([Alert_Monitor_Leads_Health_Mazda]='NO' OR [Alert_Monitor_Leads_Health_Mazda]='YES'))
GO


USE [LeadDriver]
GO

ALTER TABLE [dbo].[Alerts_Email_Distribution_List]  WITH CHECK ADD CHECK  (([Alert_Monitor_OEM_Leads_Arrived]='NO' OR [Alert_Monitor_OEM_Leads_Arrived]='YES'))
GO


USE [LeadDriver]
GO

ALTER TABLE [dbo].[Alerts_Email_Distribution_List]  WITH CHECK ADD CHECK  (([Alert_Monitor_OEM_Rejected_Leads]='NO' OR [Alert_Monitor_OEM_Rejected_Leads]='YES'))
GO
