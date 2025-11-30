
-- Define the CTE expression name and column list.
;WITH DEL (ID) AS
(SELECT TOP(1000) ID FROM WSO2MetricsDb.DBO.METRIC_GAUGE  WHERE ID IS NOT NULL AND (DATEDIFF(SECOND, '1970-01-01 00:00:00', Dateadd(day, -180, GETUTCDATE())))<TIMESTAMP)
DELETE FROM WSO2MetricsDb.DBO.METRIC_GAUGE WHERE ID IN (SELECT ID FROM DEL);
GO

-- Define the CTE expression name and column list.
;WITH DEL (ID) AS
(SELECT TOP(1000) ID FROM WSO2MetricsDb.DBO.METRIC_TIMER  WHERE ID IS NOT NULL AND (DATEDIFF(SECOND, '1970-01-01 00:00:00', Dateadd(day, -180, GETUTCDATE())))<TIMESTAMP)
DELETE FROM WSO2MetricsDb.DBO.METRIC_TIMER WHERE ID IN (SELECT ID FROM DEL);
GO



GO
-- Define the CTE expression name and column list.
WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
-- Define the CTE query.
(
    SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
-- Define the outer query referencing the CTE name.
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;
GO

