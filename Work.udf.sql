SELECT (CHARINDEX(' ' + RTRIM(Keyword)+ ' ', ' ' + UPPER('KEBAB DELIKAT LTD ASTA') + ' '))  FROM StoreDB.dbo.Company_Keyword

SELECT 1 WHERE EXISTS (SELECT (CHARINDEX(' ' + RTRIM(Keyword)+ ' ', ' ' + UPPER('KEBAB DELIKAT LXTD ASTA') + ' '))  FROM StoreDB.dbo.Company_Keyword 
WHERE CHARINDEX(' ' + RTRIM(Keyword)+ ' ', ' ' + UPPER('keyword') + ' ')>0)

SELECT StageDB.DBO.udf_COBusinessName('KEBAB DELIKAT LTD ASTA')
SELECT StageDB.DBO.udf_COBusinessNameNew('KEBAB DELIKAT LTD ASTA')

UPDATE StageDB.dbo.InfoDirect_Stage SET BUSINESSNAMEFLAG=StageDB.DBO.udf_COBusinessName(FullNameActual)
UPDATE StageDB.dbo.InfoDirect_Stage SET BUSINESSNAMEFLAG=StageDB.DBO.udf_COBusinessNameNew(FullNameActual)

UPDATE StageDB.dbo.InfoDirect_Stage SET FullNameActual=SUBSTRING(FullNameActual,6,70)


UPDATE T1 SET T1.BUSINESSNAMEFLAG=1
FROM StageDB.dbo.InfoDirect_Stage T1, StoreDB.DBO.Company_Keyword T2 
WHERE CHARINDEX(' '+LTRIM(RTRIM(T2.Keyword))+' ',' '+(LTRIM(RTRIM(T1.FullNameActual)))+' ')<> 0

--SELECT TOP 100 BusinessNameFlag FROM InfoDirect_Stage
CHECKPOINT