-- Delete on inner join.
DELETE EB FROM ResponseDriver.dbo.Export_Bucket EB INNER JOIN ResponseDriver.dbo.Export_Bucket_Archive EBA  ON EB.batch_id = EBA.batch_id AND EB.lead_id = EBA.lead_id;



-- FK ONE FIELD
WITH DropIDs (Clob_Repository_Id) AS (SELECT Top(500) C.Clob_Repository_Id  FROM LCS.dbo.Clob_Repository C WITH (NOLOCK) 
LEFT OUTER JOIN LCS.dbo.Lead L WITH (NOLOCK) ON C.clob_repository_id = L.clob_repository_id  
WHERE C.created_date_time < DATEADD(DAY,-185,GetDate()) 
AND L.clob_repository_id IS NULL)
DELETE C FROM LCS.dbo.Clob_Repository C
INNER JOIN DropIDs D ON D.Clob_Repository_Id = C.clob_repository_id; 




-- FK present COMBINATION OF FIELDS
WITH DropIDs (lead_id, batch_id) AS (SELECT Top(500) O.Lead_Id, O.Batch_Id  FROM LeadGateway_outbound.dbo.OutBound_Record O WITH (NOLOCK)
LEFT OUTER JOIN LeadGateway_outbound.dbo.Message_x_Record    M WITH (NOLOCK) ON O.Lead_id = M.Lead_id AND O.Batch_id = M.batch_id  
LEFT OUTER JOIN LeadGateway_outbound.dbo.Outbound_Record_Log L WITH (NOLOCK) ON O.Lead_id = L.Lead_id AND O.Batch_id = L.batch_id  
WHERE O.created_date_time < DATEADD(MONTH,-12,GetDate()) 
AND M.Lead_Id IS NULL AND M.Batch_Id IS NULL AND L.Lead_Id IS NULL AND L.Batch_Id IS NULL
)
DELETE OB FROM LeadGateway_outbound.dbo.OutBound_Record OB
INNER JOIN DropIDs D ON OB.lead_id = D.lead_id AND OB.batch_id = D.batch_id; 


-----
WITH DropIDs ([Batch_ID], [Lead_ID]) AS (SELECT Top(10) EBIL.Lead_Id, EBIL.Batch_Id  FROM ResponseDriver.dbo.Export_Bucket_Invalid_Leads EBIL WITH (NOLOCK)
INNER JOIN ResponseDriver.dbo.Export_Bucket EB WITH (NOLOCK) ON EBIL.Lead_id = EB.Lead_id AND EBIL.Batch_id = EB.batch_id)
DELETE EB FROM ResponseDriver.dbo.Export_Bucket EB
INNER JOIN DropIDs D ON EB.lead_id = D.lead_id AND EB.batch_id = D.batch_id; 



-- Purge FinancePortal.dbo.ContractDetails
-- !!!! Inner Join  !!!!
WITH  DropIDs (ContractID) AS (SELECT TOP(100) CD.ContractID FROM FinancePortal.dbo.ContractDetails CD WITH (NOLOCK) 
INNER JOIN FinancePortal.dbo.CreditApp CA WITH (NOLOCK) ON CA.CreditAppId = CD.CreditAppID  
WHERE CA.LastModifiedDateTime < DATEADD(DAY,-365,GetDate()))
DELETE FROM FinancePortal.dbo.ContractDetails WHERE ContractID IN (SELECT ContractID FROM DropIDs);




-- FK present COMBINATION OF FIELDS
-- !!!! Outer Join !!!!
WITH DropIDs (ID) AS (SELECT DISTINCT Top(1000) MPD.ID  FROM FinancePortal.dbo.MarketingProgramDetailS MPD WITH (NOLOCK)
LEFT OUTER JOIN FinancePortal.dbo.ContractDetails CD WITH (NOLOCK) ON MPD.ID = CD.MarketingProgramDetailID  
WHERE MPD.LastModifiedDT < DATEADD(DAY,-365,GetDate()) AND CD.MarketingProgramDetailID IS NULL)
DELETE MPD FROM FinancePortal.dbo.MarketingProgramDetailS MPD INNER JOIN DropIDs D ON MPD.ID = D.ID; 





















WITH  DropId (clob_id) AS (SELECT TOP(100000) M.clob_id FROM LPLS.dbo.Meta_Data_Clob M WITH (NOLOCK) 
INNER JOIN LPLS.dbo.Audit A WITH (NOLOCK) ON M.clob_id = A.meta_data_clob_id 
WHERE A.created_date_time < DATEADD(DAY,-7,GetDate()))
DELETE FROM LPLS.dbo.Meta_Data_Clob	WHERE clob_id IN (SELECT clob_id FROM DropId)


DELETE T FROM T
LEFT JOIN TT 
ON T.ID=TT.TID
WHERE TT.ID IS NULL

DELETE Agent FROM AgentResultLinks Agent LEFT JOIN Results R ON Agent.ResultID = R.ID WHERE R.ID IS NULL;


DELETE px FROM #prodextend px
INNER JOIN #product p ON p.din = px.din AND p.pkgSize = px.pkgSize
INNER JOIN #manu_clients mc ON mc.clientCode = p.clientCode


-- Delete on keys
delete c from dbo.clob_repository c with (readpast)
			left outer join dbo.lead l with (nolock) on c.clob_repository_id = l.clob_repository_id
			left outer join dbo.audit a1 with (nolock) on c.clob_repository_id = a1.lead_xml_clob_id
			left outer join dbo.audit a2 with (nolock) on c.clob_repository_id = a2.meta_data_clob_id
		where l.clob_repository_id is null
		and a1.lead_xml_clob_id is null
		and a2.meta_data_clob_id is null
		and c.clob_repository_id < @MaxClobid
		
		
		
		