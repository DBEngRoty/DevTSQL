-- Clean/trim
IF (SELECT AuditDB.dbo.udf_RowsCount ('AuditDb.dbo.Server_DB_File_Archive'))>250*1000
BEGIN
	DELETE TOP (7000) FROM AuditDb.dbo.Server_DB_File_Archive WHERE
	ROWID < ((SELECT MIN(ROWID)+(7*1000) FROM AuditDb.dbo.Server_DB_File_Archive)); 
END