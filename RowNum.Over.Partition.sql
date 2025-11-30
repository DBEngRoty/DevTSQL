-- INSERT INTO [Global_Attribute]
WITH DataSet as
(
SELECT 	
ROW_NUMBER() OVER (PARTITION BY User_Id  ORDER BY User_Type DESC ) AS Row_ID,
	74 AS [MetadataField_ID], -- new attribute id for Notifications email addresses
	b.[User_ID],
	b.User_Type,
	a.Email_ID AS [Attribute_Value],
	a.ID Bilateral_ID,
	b.LeadSourceID, 
	'SCI Admin - data migration' AS [Entered_By],
	GETDATE() as [Entered_Datetime],
	null as [Modified_By],
	null as [Modified_Datetime],
	0 as Deleted,
	1 as Seq_No
FROM LeadManagement.DBO.Logins a (nolock) JOIN
LeadManagement.DBO.[Global_Attribute] b on a.ID = b.[User_ID]
WHERE b.Deleted <> 1
AND a.Email_ID IS Not NULL AND LEN(a.Email_ID)>0
AND b.MetadataField_ID in (21,47, 48, 56, 59) -- old flags for email notifications permission
AND b.Attribute_Value = 'Yes'
AND NOT EXISTS (select c.[ID] from [Global_Attribute] c where c.[User_ID] = b.[User_ID] and c.MetadataField_ID = 74 and c.Attribute_Value = a.Email_ID)
)
SELECT * FROM DataSet WHERE Row_ID=1;





CREATE TABLE #T
(
Team varchar (20), Member varchar (20)
)
 
INSERT INTO #T VALUES ('ERP','Jack')
INSERT INTO #T VALUES ('ERP','John')
INSERT INTO #T VALUES ('ERP','Mary')
INSERT INTO #T VALUES ('ERP','Robert')
INSERT INTO #T VALUES ('ERP','Diana')
INSERT INTO #T VALUES ('MHR','Pyt')
INSERT INTO #T VALUES ('MHR','George')
INSERT INTO #T VALUES ('MHR','Anna')
 
SELECT * FROM #T;

SELECT TEAM, 
[1] AS TEAMMEMBER1,
[2] AS TEAMMEMBER2,
[3] AS TEAMMEMBER3
FROM (SELECT TEAM, MEMBER, ROW_NUMBER() OVER (PARTITION BY TEAM ORDER BY MEMBER) AS ROWNUM FROM #T) A
PIVOT (MAX(MEMBER) FOR ROWNUM IN ([1],[2],[3])) AS PVT
