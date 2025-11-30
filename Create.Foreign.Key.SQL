USE [CLMPValidation]
GO

ALTER TABLE [dbo].[Audit]  WITH CHECK ADD  CONSTRAINT [FK_Audit_process_result_id] FOREIGN KEY([process_result_id])
REFERENCES [dbo].[ProcessResult] ([process_result_id])
GO

ALTER TABLE [dbo].[Audit] CHECK CONSTRAINT [FK_Audit_process_result_id]
GO


