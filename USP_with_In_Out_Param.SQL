CREATE PROCEDURE dbo.GetCountByLastName (
    @LastName NVARCHAR(50),
    @LastNameCount INT OUTPUT )
AS
SELECT @LastNameCount = COUNT(*)
FROM Person.Contact
WHERE LastName = @LastNameIf we want to return the value using T-SQL we'd use code like this:

DECLARE @TheCount INT


-- Execution!
EXEC dbo.GetCountByLastName 
    @LastName = 'Alexander',
    @LastNameCount = @TheCount OUTPUT

SELECT TheCount = @TheCount
GO
