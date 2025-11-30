-- SQL 2K5
-- Simple Index on StageDB.dbo.PU_Current
If EXISTS(SELECT * FROM StageDB.sys.indexes where [Name] = 'PUC_Index_MPostal')
	DROP INDEX PUC_Index_MPostal ON StageDB.dbo.PU_Current
	
CREATE INDEX Idx_Index1 ON StageDB.dbo.PU_Current (M_Postal) WITH (FILLFACTOR = 80) 


-- Complex Index with include non key (see: Index with Included Columns)
If EXISTS(SELECT * FROM LeadManagement.sys.indexes where [Name] = 'IX_actd_dfo_Acode')
DROP INDEX IX_actd_dfo_Acode ON LeadManagement.dbo.actd_dfo
CREATE UNIQUE NONCLUSTERED INDEX [Idx_actd_dfo_Acode] ON [dbo].[actd_dfo] 
( [Activity_Code] ASC, [Row_IDName] ASC, [Activity_ID] ASC) INCLUDE ( [Data]) WITH (FILLFACTOR = 80) 
GO


/****** Object:  Index [IX_act_item_Activity_date]    Script Date: 09/13/2012 13:50:25 ******/
CREATE NONCLUSTERED INDEX [IX_act_item_Activity_date_2] ON [dbo].[act_item] 
(
	[Activity_Code_ID]ASC
)
INCLUDE ([Activity_date]  ) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FileGroup1]
GO



-- Index with Include
If EXISTS(SELECT * FROM Logging.sys.indexes where [Name] = 'Idx_LogId_Time')
DROP INDEX Idx_LogId_Time ON Logging.dbo.Log_Archive
CREATE NONCLUSTERED INDEX [Idx_LogId_Time] ON [dbo].[Log_Archive] 
( [LogID] ASC) INCLUDE (Timestamp) WITH (FILLFACTOR = 90) 
GO

/****** Object:  Index [IX_act_item_Activity_date]    Script Date: 09/12/2012 14:54:37 ******/
create INDEX [IX_act_item_Activity_date] ON [dbo].[act_item] 
([Activity_date] ASC)  INCLUDE (Activity_Code_ID)
GO


If EXISTS(SELECT * FROM StoreDB.sys.indexes where [Name] = 'Index1_DNC_CRTC')
	DROP INDEX Index1_DNC_CRTC ON StoreDB.dbo.DNC_CRTC
CREATE UNIQUE INDEX Index1_DNC_CRTC ON StoreDB.dbo.DNC_CRTC (Phone)



-- SQL2K
IF EXISTS (SELECT name FROM sysindexes WHERE name = 'Index1_PC_RWCoverage')
         DROP INDEX RWCoverage.Index1_PC_RWCoverage
GO



-- SQL2K
CREATE CLUSTERED INDEX [Index1_PC_RWCoverage] ON [dbo].[RWCoverage]([PostalCode]) ON [SECONDARY]

-- SQL2K
CREATE CLUSTERED INDEX [Idx1] ON [AuditDB].[dbo].[Server_User_Connections]([RowID]) 


GO
