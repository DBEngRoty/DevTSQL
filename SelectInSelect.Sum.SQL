 SELECT database_id,  CONVERT(VARCHAR(25), DB.name) AS dbName,
 (SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') AS DataFiles,
 (SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') AS LogFiles
 FROM sys.databases DB ORDER BY database_id