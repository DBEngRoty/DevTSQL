SELECT TOP (100) clob_repository_id
	FROM LCS.dbo.clob_repository WHERE created_date_time < GETDATE()-1000 AND clob_repository_id NOT IN (SELECT clob_repository_id FROM dbo.lead);