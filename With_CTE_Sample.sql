;WITH DropIDs ([ID]) AS (SELECT Top(5000) PH.ID FROM [ResponseDriver].dbo.[PortfolioHistory]  PH WITH (NOLOCK) 
LEFT OUTER JOIN [ResponseDriver].dbo.[PortfolioHistoryAdditionalInfo_INT]       PHA  WITH (NOLOCK) ON PH.ID  = PHA.PortfolioHistoryID    
LEFT OUTER JOIN [ResponseDriver].dbo.[PortfolioHistoryAdditionalInfo_STR]       PHS  WITH (NOLOCK) ON PH.ID  = PHS.PortfolioHistoryID    
LEFT OUTER JOIN [ResponseDriver].dbo.[PortfolioHistoryAdditionalInfo_DATETIME]  PHDT WITH (NOLOCK) ON PH.ID  = PHDT.PortfolioHistoryID    
WHERE PH.create_dt < DATEADD(DAY,-3*365,GetDate()) AND PHA.PortfolioHistoryID IS NULL AND PHDT.PortfolioHistoryID IS NULL AND PHS.PortfolioHistoryID IS NULL)
DELETE PH FROM [ResponseDriver].dbo.[PortfolioHistory]  PH 
INNER JOIN DropIDs D ON D.ID  = PH.ID;





-- B) - BNS LEADS
;WITH DropIDs ([Batch_ID], [Lead_ID]) AS (SELECT Top(5000) RB.Batch_ID, RB.Lead_ID FROM [ResponseDriver].dbo.[Repository_Bucket] RB WITH (NOLOCK) 
LEFT OUTER JOIN [ResponseDriver].dbo.Leads L WITH (NOLOCK) ON L.ExternalLeadID  = RB.Lead_ID   
WHERE RB.created_date_time < DATEADD(DAY,-2,GetDate()) 
AND L.LeadID IS NULL)
DELETE RB FROM [ResponseDriver].dbo.[Repository_Bucket] RB 
INNER JOIN DropIDs D ON D.Batch_ID  = RB.Batch_ID AND D.Lead_ID = RB.Lead_ID;





WITH DirReps (Manager, DirectReports) AS 
(
    SELECT ManagerID, COUNT(*) AS DirectReports
    FROM HumanResources.Employee
    GROUP BY ManagerID
) 
SELECT AVG(DirectReports) AS [Average Number of Direct Reports]
FROM DirReps 
WHERE DirectReports>= 2 ;
GO


WITH DS1  ([Name], is_encrypted) as
(SELECT [Name], is_encrypted  from master.sys.databases where [Name] IN ('ResponseDriver','Portfolio','LPLS','LCS','LeadGateway','FinancePortal','EncStorage'))
SELECT COUNT(1) FROM DS1 WHERE is_encrypted = 0;



-- Delete with 
WITH RetD (Audit_ID) AS (SELECT TOP (@vPercent) PERCENT Audit_id FROM LPLS.dbo.Audit  WHERE created_date_time<@vDateRet2)
DELETE FROM LPLS.dbo.Audit WHERE Audit_id IN (SELECT Audit_id FROM RetD);


-- Update 1
WITH D AS (SELECT D.Dlr_StateID, D.DLR_PROVINCE FROM [ResponseDriver].[dbo].[Dealers] AS D  JOIN  [ResponseDriver].[dbo].[STATE] AS S ON S.State = D.DLR_PROVINCE WHERE D.DLR_STATEID IS NULL)
UPDATE D SET D.Dlr_StateID = S.StateID WHERE D.DLR_PROVINCE=S.STATE; 

-- Update 2
WITH Updates AS(SELECT P.product_desc,        P.price,        U.product_desc AS new_product_desc,        U.price AS new_price 
FROM Products AS P JOIN ProductUpdates AS U   ON P.sku = U.sku WHERE U.effective_date < CURRENT_TIMESTAMP)
UPDATE Updates SET product_desc = new_product_desc,    price = new_price; 

SELECT sku, product_desc, priceFROM Products;



-- Delete all
SET @vFlag=1;
WHILE @vFlag > 0 
BEGIN 
	SET @vFlag = 0; 
	WITH Drops ([Batch_ID]) as (SELECT [Batch_ID] FROM [dbo].[Batches] AS BT JOIN  Repository_Bucket AS RB ON BT.[Batch_Id] = RB.[Batch_Id] WHERE RB.Dealer_ID = @vDealerID)
	DELETE FROM [NapoleonLeads].[dbo].[Batches] WHERE Batch_ID IN (SELECT Batch_ID FROM Drops);
	SET @vFlag = @vFlag + @@ROWCOUNT;   WAITFOR DELAY '00:00:02'; PRINT 'BATCHES purge!'
END