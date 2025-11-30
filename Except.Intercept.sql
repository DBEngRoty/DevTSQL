-- 


SELECT ProductID   
FROM Production.Product  
INTERSECT  
SELECT ProductID   
FROM Production.WorkOrder ;  
--Result: 238 Rows (products that have work orders)  


-- The following query returns any distinct values from the query to the left of the EXCEPT operator that are not also found on the right query.  


SELECT ProductID   
FROM Production.Product  
EXCEPT  
SELECT ProductID   
FROM Production.WorkOrder ;  
--Result: 266 Rows (products without work orders)  


-- The following query returns any distinct values from the query to the left of the EXCEPT operator that are not also found on the right query. The tables are reversed from the previous example.  


SELECT ProductID   
FROM Production.WorkOrder  
EXCEPT  
SELECT ProductID   
FROM Production.Product ;  
--Result: 0 Rows (work orders without products)  




IF EXISTS
(SELECT DRIVE FROM AuditDB.dbo.Server_Drives_Inventory EXCEPT  SELECT DRIVE FROM AuditDB.dbo.Server_Drives_Space_Free
UNION
SELECT DRIVE FROM AuditDB.dbo.Server_Drives_Space_Free EXCEPT SELECT DRIVE FROM AuditDB.dbo.Server_Drives_Inventory) 
PRINT 'Exists!'