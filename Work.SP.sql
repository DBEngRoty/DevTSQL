--SELECT * FROM AuditDB.dbo.RptRWADHistory

drop TABLE tmp0
drop TABLE tmpD

SELECT [From],[To], DataType, GrossIn, DedupDrop, InvalidDrop, NetIn, InterDedup, InterDedup6, TotalStart, TotalFinal, 
        		      99999999*0 as GrossInD, 99999999*0 as DedupDropD, 99999999*0 as InvalidDropD, 99999999*0 as NetInD,
			      99999999*0 as InterDedupD, 99999999*0 as InterDedup6D, 99999999*0 as TotalStartD, 99999999*0 as TotalFinalD, ROWID
        Into TMP0
	FROM AuditDB.dbo.RptRWADHistory ORDER BY ROWID
       
SELECT [From],[To], DataType, GrossIn, DedupDrop, InvalidDrop, NetIn, InterDedup, InterDedup6, TotalStart, TotalFinal, ROWID
       INTO TMPD
       FROM AuditDB.dbo.RptRWADHistory
       WHERE DATATYPE LIKE 'D%'

DELETE FROM TMPD WHERE DATATYPE LIKE 'D%'
--UPDATE T1 SET T1.AREA=T2.AREA FROM TABLE1 T1, TABLE2 T2 WHERE
--T1.PHONES=T2.PHONES


Select * from TMP0
Select * from TMPD