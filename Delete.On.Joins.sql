-- Purge FinancePortal.dbo.ContractDetails
WITH  DropIDs (ContractID) AS (SELECT TOP(100) CD.ContractID FROM FinancePortal.dbo.ContractDetails CD WITH (NOLOCK) 
INNER JOIN FinancePortal.dbo.CreditApp CA WITH (NOLOCK) ON CA.CreditAppId = CD.CreditAppID  
WHERE CA.LastModifiedDateTime < DATEADD(DAY,-365,GetDate()))
DELETE FROM FinancePortal.dbo.ContractDetails WHERE ContractID IN (SELECT ContractID FROM DropIDs);


-- Purge FinancePortal.dbo.MarketingProgramDetailS
WITH DropIDs (ID) AS (SELECT DISTINCT Top(1000) MPD.ID  FROM FinancePortal.dbo.MarketingProgramDetailS MPD WITH (NOLOCK)
LEFT OUTER JOIN FinancePortal.dbo.ContractDetails CD WITH (NOLOCK) ON MPD.ID = CD.MarketingProgramDetailID  
WHERE MPD.LastModifiedDT < DATEADD(DAY,-365,GetDate()) AND CD.MarketingProgramDetailID IS NULL)
DELETE MPD FROM FinancePortal.dbo.MarketingProgramDetailS MPD INNER JOIN DropIDs D ON MPD.ID = D.ID; 


-- Purge FinancePortal.dbo.MarketingProgram
WITH DropIDs (ID) AS (SELECT DISTINCT Top(1000) MP.ID  FROM FinancePortal.dbo.MarketingPrograms MP WITH (NOLOCK)
LEFT OUTER JOIN FinancePortal.dbo.MarketingProgramDetailS MPD WITH (NOLOCK) ON MP.ID = MPD.MarketingProgramID    
WHERE MP.LastModifiedDT < DATEADD(DAY,-365,GetDate()) AND MPD.MarketingProgramID IS NULL)
DELETE MP FROM FinancePortal.dbo.MarketingPrograms MP INNER JOIN DropIDs D ON MP.ID = D.ID; 