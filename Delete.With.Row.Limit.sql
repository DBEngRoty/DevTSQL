-- Delete by order with rows limit

IF (SELECT COUNT(1) FROM [ResponseDriver].DBO.[Exceptions]) > 500*1000
BEGIN
	WITH DelRS AS (SELECT TOP (4700) [Exception_ID]  FROM [ResponseDriver].DBO.[Exceptions] ORDER BY [Exception_Datetime] ASC)
	DELETE FROM [ResponseDriver].DBO.[Exceptions] where [Exception_ID] in (SELECT [Exception_ID] FROM DelRS);
END;