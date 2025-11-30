-- DEDUPLICATION UNIQUE ID FIELD PRESENT 
-- Group by = criteriu de deduplicare 
DELETE FROM TMP WHERE ROWID  IN (SELECT Rowid FROM TMP  WHERE ROWID NOT IN (SELECT MIN (RowId) FROM TMP GROUP BY City, Postal))

-- Flag dups!
;WITH Dups AS (SELECT Dlr_Email, COUNT(*) as QTY FROM [ResponseDriver].DBO.[Dealers] WHERE LEN(Dlr_Email)>0 GROUP BY Dlr_Email HAVING COUNT(*)>1)
UPDATE [ResponseDriver].DBO.[Dealers] SET [Flag_Dups_Email]='Y' WHERE Dlr_Email IN (SELECT DISTINCT Dlr_Email FROM Dups); 

-- Add RowID
ALTER TABLE [QVIEWArchive].[dbo].[FileCabinetVersions]  ADD [RowID] INT Identity(1, 1);
-- Dedup
DELETE FROM [QVIEWArchive].[dbo].[FileCabinetVersions]  WHERE ROWID  IN (SELECT Rowid FROM [QVIEWArchive].[dbo].[FileCabinetVersions]  WHERE ROWID NOT IN (SELECT MIN (RowId) FROM [QVIEWArchive].[dbo].[FileCabinetVersions] GROUP BY [ResourceID], [ParentResourceID], [VersionNo]))


ALTER TABLE [QVIEWArchive].[dbo].[FileCabinetVersions]  ADD [RowID] INT Identity(1, 1);
DELETE FROM [QVIEWArchive].[dbo].[FileCabinetVersions]  WHERE ROWID  IN (SELECT Rowid FROM [QVIEWArchive].[dbo].[FileCabinetVersions]  WHERE ROWID NOT IN (SELECT MIN (RowId) FROM [QVIEWArchive].[dbo].[FileCabinetVersions] GROUP BY [ResourceID], [ParentResourceID], [VersionNo]))



;WITH Dups AS (SELECT Address, COUNT(*) as qty FROM StageDB.[dbo].[Dealers] WHERE LEN(Address)>0 GROUP BY Address HAVING COUNT(*)>1)
UPDATE StageDB.[dbo].[Dealers] SET [Flag_Dup_Address]='Y' WHERE Address IN (SELECT DISTINCT Address FROM Dups); 


-- Locate duplicates
SELECT [path], COUNT(*) as qty from dbo.Messaging_Files group by [path] having COUNT(*)>1


-- !!! Locate DUPLICATES !!!;
SELECT DEALERID, OEMID, COUNT(*) as qty from ResponseDriver.[dbo].[DealerAuthOEM] group by DEALERID, OEMID having COUNT(*)>1
-- UAT(87)
-- Remove duplicates (the incoming file can bring duplicates in all OEMs!!!)
DELETE FROM ResponseDriver.[dbo].[DealerAuthOEM]
WHERE ID  IN (SELECT ID FROM ResponseDriver.[dbo].[DealerAuthOEM] WHERE ID NOT IN (SELECT MIN (Id) FROM ResponseDriver.[dbo].[DealerAuthOEM] GROUP BY DEALERID, OEMID))
