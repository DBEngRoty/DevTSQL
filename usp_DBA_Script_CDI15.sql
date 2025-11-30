EXEC s_ScriptAllObjectsInDatabase
@SourceDB	='AuditDB' ,
@SourceUID	=null ,	-- null for trusted connection
@SourcePWD	=null ,
@OutFilePath	='E:\Backups\Code\CDI15\AuditDB\' ,
@OutFileName	=null , -- null for separate file per object script
@WorkPath	='C:\' ,
@SourceSVR	='CDI15'

EXEC s_ScriptAllObjectsInDatabase
@SourceDB	='ProspectPool' ,
@SourceUID	=null ,	-- null for trusted connection
@SourcePWD	=null ,
@OutFilePath	='E:\Backups\Code\CDI15\ProspectPool\' ,
@OutFileName	=null , -- null for separate file per object script
@WorkPath	='C:\' ,
@SourceSVR	='CDI15'

EXEC s_ScriptAllObjectsInDatabase
@SourceDB	='StageDB' ,
@SourceUID	=null ,	-- null for trusted connection
@SourcePWD	=null ,
@OutFilePath	='E:\Backups\Code\CDI15\StageDB\' ,
@OutFileName	=null , -- null for separate file per object script
@WorkPath	='C:\' ,
@SourceSVR	='CDI15'

EXEC s_ScriptAllObjectsInDatabase
@SourceDB	='StoreDB' ,
@SourceUID	=null ,	-- null for trusted connection
@SourcePWD	=null ,
@OutFilePath	='E:\Backups\Code\CDI15\StoreDB\' ,
@OutFileName	=null , -- null for separate file per object script
@WorkPath	='C:\' ,
@SourceSVR	='CDI15'
