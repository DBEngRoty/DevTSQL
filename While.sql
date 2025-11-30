WHILE EXISTS (SELECT 1 FROM [AuditDB].[dbo].[Server_Stats_RW_IO] WHERE NumberReads IS NULL)
BEGIN
	SET @MinRowID =(SELECT MIN(RowID) FROM AuditDB.dbo.Server_Stats_RW_IO WHERE NumberReads IS NULL);
	SET @vFile = (SELECT [FILE_NAME]  FROM AuditDB.dbo.Server_Stats_RW_IO WHERE ROWID = @MinRowID);

	SET @CurrReads = (SELECT  Total_NumberReads FROM AuditDB.dbo.Server_Stats_RW_IO WHERE ROWID =  @MinRowID);
	SET @PrevReads = (SELECT  Total_NumberReads FROM AuditDB.dbo.Server_Stats_RW_IO WHERE ROWID =  (SELECT MAX(ROWID) FROM AuditDB.dbo.Server_Stats_RW_IO where [FILE_NAME] = @vFile AND ROWID < @MinRowID));
	 IF @PrevReads IS NULL SET @PrevReads = 0;


	SET @CurrWrites = (SELECT  Total_NumberWrites FROM AuditDB.dbo.Server_Stats_RW_IO WHERE ROWID =  @MinRowID);
	SET @PrevWrites  = (SELECT  Total_NumberWrites FROM AuditDB.dbo.Server_Stats_RW_IO WHERE ROWID =  (SELECT MAX(ROWID) FROM AuditDB.dbo.Server_Stats_RW_IO where [FILE_NAME] = @vFile AND ROWID < @MinRowID));
   	IF @PrevWrites IS NULL SET @PrevWrites = 0;
	
	UPDATE AuditDB.dbo.Server_Stats_RW_IO SET NumberReads = (@CurrReads-@PrevReads), NumberWrites = (@CurrWrites-@PrevWrites) WHERE ROWID=@MinRowID;

END