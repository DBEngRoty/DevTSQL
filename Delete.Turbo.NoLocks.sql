-- Turbo delete - no locks
DECLARE @i INT; set @i=1;
WHILE @i<50000
BEGIN
DELETE TOP (1) FROM NapoleonLeads.dbo.Repository_Bucket WHERE BATCH_ID = (SELECT MIN(BATCH_ID) FROM NapoleonLeads.dbo.Repository_Bucket WITH (NOLOCK))
SET @i=@i+1;
END
(SELECT MIN(BATCH_ID) FROM NapoleonLeads.dbo.Repository_Bucket)
--2054786,2116735,2180048,2310469,2373089,2441610,3034763