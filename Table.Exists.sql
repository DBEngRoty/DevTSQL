
-- Temp table
IF OBJECT_ID('tempdb..#tempdbname') IS NOT NULL  
DROP TABLE #tempdbname   -- Remoeve "tempdb.dbo"

-- Permananet table
IF exists (select * from sys.objects where name = 'Scores' and type = 'u')
DROP TABLE Scores;
 

--Sample 3
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Customers')
BEGIN
  PRINT 'Table Exists'
END
