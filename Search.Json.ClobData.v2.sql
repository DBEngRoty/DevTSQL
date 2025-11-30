SELECT  

              [ClobId]       ---, [ClobData]
         , JSON_VALUE (ClobData, '$.creditApplicationID') as CreditAppID
         , JSON_VALUE (ClobData, '$.creditApplicationLenderID') as creditApplicationLenderID
         , CASE 
         WHEN JSON_VALUE (ClobData, '$.creditApplicationLenderID') = 1 THEN 'SCI'+SPACE(20)
         WHEN JSON_VALUE (ClobData, '$.creditApplicationLenderID') = 2 THEN 'RBC'+SPACE(20)
         WHEN JSON_VALUE (ClobData, '$.creditApplicationLenderID') = 3 THEN 'iA'+SPACE(20)
         END AS LenderName
         --, JSON_VALUE (ClobData, '$.deal.leaseDetails.msrp') as MSRP
         , JSON_VALUE (ClobData, '$.deal.dealerInfo.dealerLegalName') as DealerLegalName
         , JSON_QUERY (ClobData, '$.deal.decision.decisionStipulations') as DecisionStipulations
         
INTO [FinancePortal].[dbo].[ClobData_Extract]

  FROM [FinancePortal].[dbo].[ClobData] WITH (NOLOCK)
 
  WHERE
  ISJSON(ClobData) = 1 
  AND JSON_VALUE (ClobData, '$.creditApplicationID') IS NOT NULL
  AND JSON_QUERY (ClobData, '$.deal.decision.decisionStipulations') IS NOT NULL;
 
