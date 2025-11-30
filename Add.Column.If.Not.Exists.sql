--((SELECT COUNT(*) FROM StageDB.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='CMD_AdhocEmailCampaign_Raw' AND COLUMN_NAME='AdhocCampaign_ID') = 0)  
IF NOT EXISTS (SELECT * FROM StageDB.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='CMD_AdhocEmailCampaign_Raw' AND COLUMN_NAME='AdhocCampaign_ID')
ALTER TABLE StageDB.dbo.CMD_AdhocEmailCampaign_Raw ADD AdhocCampaign_ID INT NULL;
GO

-- GO command is mandatory !!!!!!! otherwise no alter is commited!!!


	--- Language standardization #3878
	Declare @strScript varchar(max); SET @strScript = '';
    SET @strScript= ' USE StageDB
                       IF NOT EXISTS(select * from sys.columns where object_id = OBJECT_ID(N''[dbo].['+@TableName+']'') and Name=''Language'')
                       ALTER TABLE [StageDB].[dbo].['+@TableName+'] ADD	[Language] VARCHAR(3) ; '     
    EXEC (@strScript)
	--PRINT @strScript

    SET @strScript= ' UPDATE [StageDB].[dbo].['+@TableName+'] SET [Language]= ' + 
					' (CASE WHEN Language = '''+'ENG'+''' THEN '''+'ENU'+''' WHEN Language = '''+'FR'+''' THEN '''+'FRC'+''' ELSE '''+'?'+''' END); '

    EXEC (@strScript); 
	--PRINT @strScript
	-- End Language Standardization !