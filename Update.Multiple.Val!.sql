--A)
--Update on tables-values parameters
-- Transaction logs aren't recorded for table-valued parameters, fast update with no log
Create Procedure [dbo].[UpdateTransactionDates]
@vTable ChangeTransDate readonly
AS
UPDATE U SET U.TransDate = V.NewDate
FROM @vTable V
JOIN TransLog U ON U.TransID = V.TransID


DECLARE @NewTableParam = ChangeTransDate
EXEC dbo.UpdateTransactionDates @vTable = @NewTableParam


--B)
UPDATE D SET 
D.COL1=(CASE WHEN LEN(S.COL1)>0 THEN S.COL1 ELSE D.COL1 END), 
D.COL2=(CASE WHEN LEN(S.COL2)>0 THEN S.COL2 ELSE D.COL2 END), 
D.COL3=(CASE WHEN LEN(S.COL3)>0 THEN S.COL3 ELSE D.COL3 END) 
FROM TMPD D, TMPS S
WHERE D.PID=S.PID



--C)
UPDATE T1 SET T1.AREA=T2.AREA 
FROM TABLE1 T1, TABLE2 T2 
WHERE T1.PHONES=T2.PHONES