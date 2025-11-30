/*
Validation Report RWirelessActives & RWirelessDeactive
Created: protariu / 20051106
*/

CREATE PROCEDURE usp_Report_Validation_RWirelessAD

 AS

SELECT   'Active Subscribers  ' as  [File Name], 
      COUNT(*) AS QtyRecs,
      MIN(ActiveDate) AS [From],
      MAX(ActiveDate) AS [To],
      SUM(CASE WHEN LEN(BAN)=0 THEN 1 WHEN LEN(BAN)>0 THEN 0 WHEN BAN IS NULL THEN 1 ELSE 0 END) AS BAN,
      SUM(CASE WHEN LEN(ClientCellNo)=0 THEN 1 WHEN LEN(ClientCellNo)>0 THEN 0 WHEN ClientCellNo IS NULL THEN 1 ELSE 0 END) AS CTN,
      SUM(CASE WHEN LEN(BillCycle)=0 THEN 1 WHEN LEN(BillCycle)>0 THEN 0 WHEN BillCycle IS NULL THEN 1 ELSE 0 END) AS BillCycle,
      SUM(CASE WHEN LEN([Language])=0 THEN 1 WHEN LEN([Language])>0 THEN 0 WHEN [Language] IS NULL THEN 1 ELSE 0 END) AS BillLang,
      SUM(CASE WHEN LEN(PricePlan)=0 THEN 1 WHEN LEN(PricePlan)>0 THEN 0 WHEN PricePlan IS NULL THEN 1 ELSE 0 END) AS PricePlan,
      SUM(CASE WHEN LEN(FNameActual)=0 THEN 1 WHEN LEN(FNameActual)>0 THEN 0 WHEN FNameActual IS NULL THEN 1 ELSE 0 END) AS FirstName,
      SUM(CASE WHEN LEN(BusinessName)=0 THEN 1 WHEN LEN(BusinessName)>0 THEN 0 WHEN BusinessName IS NULL THEN 1 ELSE 0 END) AS BusinessName,
      SUM(CASE WHEN LEN(ActiveDate)=0 THEN 1 WHEN LEN(ActiveDate)>0 THEN 0 WHEN ActiveDate IS NULL THEN 1 ELSE 0 END) AS ActiveDate,
      SUM(CASE WHEN LEN(Address1)=0 THEN 1 WHEN LEN(Address1)>0 THEN 0 WHEN Address1 IS NULL THEN 1 ELSE 0 END) AS Address1,
      SUM(CASE WHEN LEN(City)=0 THEN 1 WHEN LEN(City)>0 THEN 0 WHEN City IS NULL THEN 1 ELSE 0 END) AS City,
      SUM(CASE WHEN LEN(Province)=0 THEN 1 WHEN LEN(Province)>0 THEN 0 WHEN Province IS NULL THEN 1 ELSE 0 END) AS Province,
      SUM(CASE WHEN LEN(PostalCode)=0 THEN 1 WHEN LEN(PostalCode)>0 THEN 0 WHEN PostalCode IS NULL THEN 1 ELSE 0 END) AS Postal,
      'AS' as TYPE

INTO AuditDB.dbo.RptValidRWActives
FROM StoreDB.dbo.RWActiveSubscribers


INSERT INTO AuditDB.dbo.RptValidRWActives ([File Name],QtyRecs,[From],[To], BAN, CTN, BillCycle, BillLang,PricePlan, FirstName, BusinessName, ActiveDate, Address1, City, Province, Postal, Type)
SELECT   'Active Bills' as  [File Name], 
      COUNT(*) AS QtyRecs,
      MIN(ActiveDate) AS [From],
      MAX(ActiveDate) AS [To],
      SUM(CASE WHEN LEN(BAN)=0 THEN 1 WHEN LEN(BAN)>0 THEN 0 WHEN BAN IS NULL THEN 1 ELSE 0 END) AS BAN,
      SUM(CASE WHEN LEN(ClientCellNo)=0 THEN 1 WHEN LEN(ClientCellNo)>0 THEN 0 WHEN ClientCellNo IS NULL THEN 1 ELSE 0 END) AS CTN,
      SUM(CASE WHEN LEN(BillCycle)=0 THEN 1 WHEN LEN(BillCycle)>0 THEN 0 WHEN BillCycle IS NULL THEN 1 ELSE 0 END) AS BillCycle,
      SUM(CASE WHEN LEN([Language])=0 THEN 1 WHEN LEN([Language])>0 THEN 0 WHEN [Language] IS NULL THEN 1 ELSE 0 END) AS BillLang,
      SUM(CASE WHEN LEN(PricePlan)=0 THEN 1 WHEN LEN(PricePlan)>0 THEN 0 WHEN PricePlan IS NULL THEN 1 ELSE 0 END) AS PricePlan,
      SUM(CASE WHEN LEN(FNameActual)=0 THEN 1 WHEN LEN(FNameActual)>0 THEN 0 WHEN FNameActual IS NULL THEN 1 ELSE 0 END) AS FirstName,
      SUM(CASE WHEN LEN(BusinessName)=0 THEN 1 WHEN LEN(BusinessName)>0 THEN 0 WHEN BusinessName IS NULL THEN 1 ELSE 0 END) AS BusinessName,
      SUM(CASE WHEN LEN(ActiveDate)=0 THEN 1 WHEN LEN(ActiveDate)>0 THEN 0 WHEN ActiveDate IS NULL THEN 1 ELSE 0 END) AS ActiveDate,
      SUM(CASE WHEN LEN(Address1)=0 THEN 1 WHEN LEN(Address1)>0 THEN 0 WHEN Address1 IS NULL THEN 1 ELSE 0 END) AS Address1,
      SUM(CASE WHEN LEN(City)=0 THEN 1 WHEN LEN(City)>0 THEN 0 WHEN City IS NULL THEN 1 ELSE 0 END) AS City,
      SUM(CASE WHEN LEN(Province)=0 THEN 1 WHEN LEN(Province)>0 THEN 0 WHEN Province IS NULL THEN 1 ELSE 0 END) AS Province,
      SUM(CASE WHEN LEN(PostalCode)=0 THEN 1 WHEN LEN(PostalCode)>0 THEN 0 WHEN PostalCode IS NULL THEN 1 ELSE 0 END) AS Postal,
      'AB' as Type
FROM StoreDB.dbo.RWActiveBills


INSERT INTO AuditDB.dbo.RptValidRWActives ([File Name],QtyRecs,[From],[To], BAN, CTN, BillCycle, BillLang,PricePlan, FirstName, BusinessName, ActiveDate, Address1, City, Province, Postal, Type)
SELECT   'Deactive Subscribers' as  [File Name], 
      COUNT(*) AS QtyRecs,
      MIN(DeactiveDate) AS [From],
      MAX(DeactiveDate) AS [To],
      SUM(CASE WHEN LEN(BAN)=0 THEN 1 WHEN LEN(BAN)>0 THEN 0 WHEN BAN IS NULL THEN 1 ELSE 0 END) AS BAN,
      SUM(CASE WHEN LEN(ClientCellNo)=0 THEN 1 WHEN LEN(ClientCellNo)>0 THEN 0 WHEN ClientCellNo IS NULL THEN 1 ELSE 0 END) AS CTN,
      SUM(CASE WHEN LEN(BillCycle)=0 THEN 1 WHEN LEN(BillCycle)>0 THEN 0 WHEN BillCycle IS NULL THEN 1 ELSE 0 END) AS BillCycle,
      SUM(CASE WHEN LEN([Language])=0 THEN 1 WHEN LEN([Language])>0 THEN 0 WHEN [Language] IS NULL THEN 1 ELSE 0 END) AS BillLang,
      SUM(CASE WHEN LEN(PricePlan)=0 THEN 1 WHEN LEN(PricePlan)>0 THEN 0 WHEN PricePlan IS NULL THEN 1 ELSE 0 END) AS PricePlan,
      SUM(CASE WHEN LEN(FNameActual)=0 THEN 1 WHEN LEN(FNameActual)>0 THEN 0 WHEN FNameActual IS NULL THEN 1 ELSE 0 END) AS FirstName,
      SUM(CASE WHEN LEN(BusinessName)=0 THEN 1 WHEN LEN(BusinessName)>0 THEN 0 WHEN BusinessName IS NULL THEN 1 ELSE 0 END) AS BusinessName,
      SUM(CASE WHEN LEN(ActiveDate)=0 THEN 1 WHEN LEN(ActiveDate)>0 THEN 0 WHEN ActiveDate IS NULL THEN 1 ELSE 0 END) AS ActiveDate,
      SUM(CASE WHEN LEN(Address1)=0 THEN 1 WHEN LEN(Address1)>0 THEN 0 WHEN Address1 IS NULL THEN 1 ELSE 0 END) AS Address1,
      SUM(CASE WHEN LEN(City)=0 THEN 1 WHEN LEN(City)>0 THEN 0 WHEN City IS NULL THEN 1 ELSE 0 END) AS City,
      SUM(CASE WHEN LEN(Province)=0 THEN 1 WHEN LEN(Province)>0 THEN 0 WHEN Province IS NULL THEN 1 ELSE 0 END) AS Province,
      SUM(CASE WHEN LEN(PostalCode)=0 THEN 1 WHEN LEN(PostalCode)>0 THEN 0 WHEN PostalCode IS NULL THEN 1 ELSE 0 END) AS Postal,
      'DS' as Type
FROM StoreDB.dbo.RWDeactiveSubscribers


INSERT INTO AuditDB.dbo.RptValidRWActives ([File Name],QtyRecs,[From],[To], BAN, CTN, BillCycle, BillLang,PricePlan, FirstName, BusinessName, ActiveDate, Address1, City, Province, Postal, Type)
SELECT   'Deactive Bills' as  [File Name], 
      COUNT(*) AS QtyRecs,
      MIN(DeactiveDate) AS [From],
      MAX(DeactiveDate) AS [To],
      SUM(CASE WHEN LEN(BAN)=0 THEN 1 WHEN LEN(BAN)>0 THEN 0 WHEN BAN IS NULL THEN 1 ELSE 0 END) AS BAN,
      SUM(CASE WHEN LEN(ClientCellNo)=0 THEN 1 WHEN LEN(ClientCellNo)>0 THEN 0 WHEN ClientCellNo IS NULL THEN 1 ELSE 0 END) AS CTN,
      SUM(CASE WHEN LEN(BillCycle)=0 THEN 1 WHEN LEN(BillCycle)>0 THEN 0 WHEN BillCycle IS NULL THEN 1 ELSE 0 END) AS BillCycle,
      SUM(CASE WHEN LEN([Language])=0 THEN 1 WHEN LEN([Language])>0 THEN 0 WHEN [Language] IS NULL THEN 1 ELSE 0 END) AS BillLang,
      SUM(CASE WHEN LEN(PricePlan)=0 THEN 1 WHEN LEN(PricePlan)>0 THEN 0 WHEN PricePlan IS NULL THEN 1 ELSE 0 END) AS PricePlan,
      SUM(CASE WHEN LEN(FNameActual)=0 THEN 1 WHEN LEN(FNameActual)>0 THEN 0 WHEN FNameActual IS NULL THEN 1 ELSE 0 END) AS FirstName,
      SUM(CASE WHEN LEN(BusinessName)=0 THEN 1 WHEN LEN(BusinessName)>0 THEN 0 WHEN BusinessName IS NULL THEN 1 ELSE 0 END) AS BusinessName,
      SUM(CASE WHEN LEN(ActiveDate)=0 THEN 1 WHEN LEN(ActiveDate)>0 THEN 0 WHEN ActiveDate IS NULL THEN 1 ELSE 0 END) AS ActiveDate,
      SUM(CASE WHEN LEN(Address1)=0 THEN 1 WHEN LEN(Address1)>0 THEN 0 WHEN Address1 IS NULL THEN 1 ELSE 0 END) AS Address1,
      SUM(CASE WHEN LEN(City)=0 THEN 1 WHEN LEN(City)>0 THEN 0 WHEN City IS NULL THEN 1 ELSE 0 END) AS City,
      SUM(CASE WHEN LEN(Province)=0 THEN 1 WHEN LEN(Province)>0 THEN 0 WHEN Province IS NULL THEN 1 ELSE 0 END) AS Province,
      SUM(CASE WHEN LEN(PostalCode)=0 THEN 1 WHEN LEN(PostalCode)>0 THEN 0 WHEN PostalCode IS NULL THEN 1 ELSE 0 END) AS Postal,
      'DB' as Type
FROM StoreDB.dbo.RWDeactiveBills
GO
