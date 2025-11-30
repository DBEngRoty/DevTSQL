SELECT YEAR(Insert_Date_Time) as [Year], MONTH(Insert_Date_Time) as [Month], COUNT(*) AS QTY
FROM [NapoleonLeads].DBO.[Leads_Audit_Detail]
WITH (NOLOCK)
GROUP BY YEAR(Insert_Date_Time), MONTH(Insert_Date_Time)
ORDER BY YEAR(Insert_Date_Time), MONTH(Insert_Date_Time);



SELECT YEAR(Created_Date_Time) as [Year], MONTH(Created_Date_Time) as [Month], COUNT(*) AS QTY
FROM [NapoleonLeads].DBO.[Repository_Bucket]
WITH (NOLOCK)
GROUP BY YEAR(Created_Date_Time), MONTH(Created_Date_Time)
ORDER BY YEAR(Created_Date_Time), MONTH(Created_Date_Time);




SELECT YEAR(created_dt) as [Year], MONTH(created_dt) as [Month], DAY(created_dt) as [DATE], COUNT(*) AS QTY
FROM [EmailMessagingDB].DBO.[Message]
WITH (NOLOCK)
GROUP BY YEAR(created_dt), MONTH(created_dt), DAY(created_dt)
ORDER BY YEAR(created_dt), MONTH(created_dt), DAY(created_dt)


SELECT YEAR(created_dt) as [Year], MONTH(created_dt) as [Month], DAY(created_dt) as [DATE], COUNT(*) AS QTY
FROM [EmailMessagingDB].DBO.[Message]
WITH (NOLOCK)
GROUP BY YEAR(created_dt), MONTH(created_dt), DAY(created_dt)
ORDER BY YEAR(created_dt), MONTH(created_dt), DAY(created_dt)




SELECT YEAR(created_date_time) as [Year], MONTH(created_date_time) as [Month], COUNT(*) AS QTY
FROM dbo.clob_repository
WITH (NOLOCK)
GROUP BY YEAR(created_date_time), MONTH(created_date_time)
ORDER BY YEAR(created_date_time), MONTH(created_date_time)




--- Elmah
SELECT YEAR(TimeUtc) as [Year], MONTH(TimeUtc) as [Month], DAY(TimeUtc) as [DATE], COUNT(*) AS QTY
FROM [EmailDispatcher_Elmah].dbo.[ELMAH_Error]
WITH (NOLOCK)
GROUP BY YEAR(TimeUtc), MONTH(TimeUtc), DAY(TimeUtc)
ORDER BY YEAR(TimeUtc), MONTH(TimeUtc), DAY(TimeUtc)



  --- Audit connections
SELECT YEAR(InsertDate) as [Year], MONTH(InsertDate) as [Month], DAY(InsertDate) as [DATE], [LogiName], COUNT(*) AS QTY
FROM [AuditDB].[dbo].[Server_Stats_User_Connections]
WITH (NOLOCK)
where 
loginame not like 'pp.%' AND 
loginame not like 'sa' AND 
loginame not like 'SCIWORK%' AND 
loginame not like 'scica\%' AND
loginame not like 'NT %' AND
LEN(loginame)>3
GROUP BY YEAR(InsertDate), MONTH(InsertDate), DAY(InsertDate), [Loginame]
ORDER BY YEAR(InsertDate), MONTH(InsertDate), DAY(InsertDate)