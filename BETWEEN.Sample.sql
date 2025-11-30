
-- BETWEEN OPERATOR
SELECT * FROM vEmployee e JOIN HumanResources.EmployeePayHistory ep 
	ON e.BusinessEntityID = ep.BusinessEntityID
	WHERE ep.Rate NOT BETWEEN 27 AND 30