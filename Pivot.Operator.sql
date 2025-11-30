-- Sample 1
/* Data
VendorId   IncomeDay  IncomeAmount
---------- ---------- ------------
SPIKE      FRI        100
SPIKE      MON        300
FREDS      SUN        400
SPIKE      WED        500
SPIKE      TUE        200
JOHNS      WED        900
SPIKE      FRI        100
JOHNS      MON        300
SPIKE      SUN        400
SPIKE      WED        500
FREDS      THU        800
JOHNS      TUE        600
*/

SELECT * FROM DailyIncome
pivot (max (IncomeAmount) for IncomeDay in ([MON],[TUE],[WED],[THU],[FRI],[SAT],[SUN])) as MaxIncomePerDay
where VendorId in ('SPIKE')

--Outcome:
/*  
VendorId   MON         TUE         WED         THU         FRI         SAT         SUN 
---------- ----------- ----------- ----------- ----------- ----------- ----------- -----------
FREDS      500         350         500         800         900         500         400
JOHNS      300         600         900         800         300         800         600
SPIKE      600         150         500         300         200         100         400
*/

---*****************************************************
SELECT *
FROM (
    SELECT 
        year(invoiceDate) as [year],left(datename(month,invoicedate),3)as [month], 
        InvoiceAmount as Amount 
    FROM Invoice
) as s
PIVOT
(
    SUM(Amount)
    FOR [month] IN (jan, feb, mar, apr, 
    may, jun, jul, aug, sep, oct, nov, dec)
)AS pivot
-- *************************************************



-- Sample 1.1
SELECT OBJECT_NAME, instance_name, [Number of Deadlocks/sec],[Lock Waits/sec],[Lock Wait Time (ms)] FROM sys.dm_os_performance_counters 
PIVOT (MAX(CNTR_VALUE) FOR Counter_Name IN ([Lock Waits/sec],[Lock Wait Time (ms)],[Number of Deadlocks/sec])) AS XXXX
WHERE instance_name = '_Total' AND OBJECT_NAME LIKE '%LOCKS%' AND cntr_type = 272696576
------


-- Sample 2
CREATE TABLE #T
(
Team varchar (20), Member varchar (20)
)
 
INSERT INTO #T VALUES ('ERP','Jack')
INSERT INTO #T VALUES ('ERP','John')
INSERT INTO #T VALUES ('ERP','Mary')
INSERT INTO #T VALUES ('ERP','Robert')
INSERT INTO #T VALUES ('ERP','Diana')
INSERT INTO #T VALUES ('MHR','Pyt')
INSERT INTO #T VALUES ('MHR','George')
INSERT INTO #T VALUES ('MHR','Anna')
 
SELECT * FROM #T;

SELECT TEAM, 
[1] AS TEAMMEMBER1,
[2] AS TEAMMEMBER2,
[3] AS TEAMMEMBER3
FROM (SELECT TEAM, MEMBER, ROW_NUMBER() OVER (PARTITION BY TEAM ORDER BY MEMBER) AS ROWNUM FROM #T) A
PIVOT (MAX(MEMBER) FOR ROWNUM IN ([1],[2],[3])) AS PVT


-- sAMPLE 3
;WITH C as
(
  SELECT FormID,
         [Site 1],
         [Site 2],
         [Site 3],
         (SELECT SUM(S)
          FROM (VALUES([Site 1]),
                      ([Site 2]),
                      ([Site 3])) AS T(S)) as Total
   FROM (SELECT Site, COUNT(FormID) AS NumberOfForms,FormID
         FROM @CRFCount WHERE Present='Yes'
         GROUP BY Site, FormID) d
   PIVOT
   (SUM(NumberOfForms)
   FOR [Site] IN ([Site 1], [Site 2], [Site 3])
   )  AS p
)
SELECT *
FROM
  (
    SELECT FormID,
           [Site 1],
           [Site 2],
           [Site 3],
           Total
    FROM C
    UNION ALL
    SELECT 'Total',
           SUM([Site 1]),
           SUM([Site 2]),
           SUM([Site 3]),
           SUM(Total)
    FROM C
  ) AS T
ORDER BY CASE WHEN FormID = 'Total' THEN 1 END


-- sAMPLE 4 WITH CUBE
SELECT *
FROM
(
    SELECT
        Site = case when grouping(Site)=1 then 'All' else Site end,
        FormID = case when grouping(FormID)=1 then 'All' else cast(FormID as varchar(100)) end,
        measure = count(NumberOfForms)
    FROM @CRFCount 
       -- chose below
       GROUP BY Site, FormID with cube --(ms sql 2005)
       --group by grouping sets(Site, FormID, (Site, FormID), ()) --(ms sql 2008)
) AS BOM
PIVOT  (max(measure) FOR [Site] IN ([Site 1], [Site 2], [Site 3], [All]))
as pv

