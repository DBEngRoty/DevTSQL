--pentrun updaturi complicate


----- Sample 1 -----------------
UPDATE S SET  Flag_WrongAnswer = 1
--SELECT DISTINCT S.*   --pentru verificare numai - nu pentru update !!
FROM StageDB.dbo.CRM_Survey_Stage S
LEFT JOIN CustomerPool.dbo.Lookup_SurveyQuestion Q ON
S.Question_ID = Q.Q_ID AND Q.Status = 'Active'
LEFT JOIN CustomerPool.dbo.Lookup_SurveyAnswerSet A ON
Q.Answer_Set = A.Code_Set_Value
WHERE Code_Set_Value IS NULL



--------- Sample 2 ---------
select top 10 DealerID as RDDealerId, DealerOEMID from dealeroem
SELECT top 10 * FROM AuditDB.dbo.UAT_Dealers_LL
SELECT top 10 * FROM ResponseDriver.dbo.Dealers;


begin tran one1

UPDATE rd set RD.Latitude = AU.Latitude, RD.Longitude = AU.Longitude 
FROM       ResponseDriver.dbo.Dealers RD
inner join ResponseDriver.dbo.dealeroem do on rd.DealerID = do.DealerID 
inner join AuditDB.dbo.UAT_Dealers_LL au on do.DealerOEMID collate Latin1_General_CI_AS = au.dealer_oem_id 
where rd.Latitude is null and rd.Longitude is null;

commit  tran one1
rollback tran one1




----- Sample  -----------------
UPDATE DU SET  DU.Latitude = LL.[LAT], DU.Longitude = LL.[LONG]
--SELECT DISTINCT S.*   --pentru verificare numai - nu pentru update !!
FROM       [ResponseDriver_Stage].[dbo].[Dealers_Upload] DU
INNER JOIN [ResponseDriver_Stage].[dbo].[LatLong_120] LL ON
DU.Input_Provider_Dealer_ID = LL.DEALERID;


UPDATE P 
set P.dealerid=O.dealerid, p.last_upd_dt=O.last_upd_dt
FROM 
[ResponseDriver].[dbo].[Portfolio] P
INNER JOIN [RD].[dbo].[Portfolio] O ON  P.ID = O.ID;

--Verify !!!
SELECT TOP 1000 P.ID, O.ID, P.dealerid, O.dealerid, p.last_upd_dt, O.last_upd_dt
FROM [ResponseDriver].[dbo].[Portfolio] P
INNER JOIN [RD].[dbo].[Portfolio] O ON  P.ID = O.ID;