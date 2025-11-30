IF OBJECT_ID('tempdb..#Temp1') IS NOT NULL   DROP TABLE #Temp1;

DECLARE @ProductTotals TABLE
( 
 ProductID int, 
  Revenue money
  )



  Table Variables In T-SQL

Monday, March 21, 2005 



/*
Microsoft introduced table variables with SQL Server 2000 as an alternative to using temporary tables. In many cases a table variable can outperform a solution using a temporary table, although we will need to review the strengths and weaknesses of each in this article.
Table variables store a set of records, so naturally the declaration syntax looks very similar to a CREATE TABLE statement, as you can see in the following example:
*/



DECLARE @ProductTotals TABLE
(
  ProductID int, 
  Revenue money
)
 

 -- While connected to the Northwind data-base, we could write the following SELECT statement to populate the table variable.




INSERT INTO @ProductTotals (ProductID, Revenue)
  SELECT ProductID, SUM(UnitPrice * Quantity)
    FROM [Order Details]
    GROUP BY ProductID
 

You can use table variables in batches, stored procedures, and user-defined functions (UDFs). We can UPDATE records in our table variable as well as DELETE records.




UPDATE @ProductTotals
  SET Revenue = Revenue * 1.15
WHERE ProductID = 62
 
 
DELETE FROM @ProductTotals
WHERE ProductID = 60
 
 
SELECT TOP 5 * 
FROM @ProductTotals
ORDER BY Revenue DESC
 



You might think table variables work just like temporary tables (CREATE TABLE #ProductTotals), but there are some differences.

Scope

Unlike the majority of the other data types in SQL Server, you cannot use a table variable as an input or an output parameter. In fact, a table variable is scoped to the stored procedure, batch, or user-defined function just like any local variable you create with a DECLARE statement. The variable will no longer exist after the procedure exits - there will be no table to clean up with a DROP statement.

Although you cannot use a table variable as an input or output parameter, you can return a table variable from a user-defined function – we will see an example later in this article. However, because you can’t pass a table variable to another stored procedure as input – there still are scenarios where you’ll be required to use a temporary table when using calling stored procedures from inside other stored procedures and sharing table results.

The restricted scope of a table variable gives SQL Server some liberty to perform optimizations.

Performance

Because of the well-defined scope, a table variable will generally use fewer resources than a temporary table. Transactions touching table variables only last for the duration of the update on the table variable, so there is less locking and logging overhead.

Using a temporary table inside of a stored procedure may result in additional re-compilations of the stored procedure. Table variables can often avoid this recompilation hit. For more information on why stored procedures may recompile, look at Microsoft knowledge base article 243586 (INF: Troubleshooting Stored Procedure Recompilation).

Other Features

Constraints are an excellent way to ensure the data in a table meets specific requirements, and you can use constraints with table variables. The following example ensures ProductID values in the table will be unique, and all prices are less then 10.0.




DECLARE @MyTable TABLE
(
  ProductID int UNIQUE,
  Price money CHECK(Price < 10.0)
)
 



You can also declare primary keys. identity columns, and default values.




UPDATE @ProductTotals
DECLARE @MyTable TABLE
(
  ProductID int IDENTITY(1,1) PRIMARY KEY,
  Name varchar(10) NOT NULL DEFAULT('Unknown')
)
 



So far it seems that table variables can do anything temporary tables can do within the scope of a stored procedure, batch, or UDF), but there are some drawbacks.

Restrictions

You cannot create a non-clustered index on a table variable, unless the index is a side effect of a PRIMARY KEY or UNIQUE constraint on the table (SQL Server enforces any UNIQUE or PRIMARY KEY constraints using an index).

Also, SQL Server does not maintain statistics on a table variable, and statistics are used heavily by the query optimizer to determine the best method to execute a query. Neither of these restrictions should be a problem, however, as table variables generally exist for a specific purpose and aren’t used for a wide range of ad-hoc queries.

The table definition of a table variable cannot change after the DECLARE statement. Any ALTER TABLE query attempting to alter a table variable will fail with a syntax error. Along the same lines, you cannot use a table variable with SELECT INTO or INSERT EXEC queries. f you are using a table variable in a join, you will need to alias the table in order to execute the query.




SELECT ProductName, Revenue
FROM Products P
  INNER JOIN @ProductTotals PT ON P.ProductID = PT.ProductID
 



You can use a table variable with dynamic SQL, but you must declare the table inside the dynamic SQL itself. The following query will fail with the error “Must declare the variable '@MyTable'.”




DECLARE @MyTable TABLE
(
  ProductID int ,
  Name varchar(10)
)
 
 
EXEC sp_executesql N'SELECT * FROM @MyTable'
 



It’s also important to note how table variables do not participate in transaction rollbacks. Although this can be a performance benefit, it can also catch you off guard if you are not aware of the behavior. To demonstrate, the following query batch will return a count of 77 records even though the INSERT took place inside a transaction with ROLLBACK.




DECLARE @ProductTotals TABLE
(
  ProductID int ,
  Revenue money
)
  
BEGIN TRANSACTION
  
  INSERT INTO @ProductTotals (ProductID, Revenue)
    SELECT ProductID, SUM(UnitPrice * Quantity)
    FROM  [Order Details]
    GROUP BY ProductID
  
ROLLBACK TRANSACTION
  
SELECT COUNT(*) FROM @ProductTotals
 



Choosing Between Temporary Tables and Table Variables

Now you’ve come to a stored procedure that needs temporary resultset storage. Knowing what we have learned so far, how do you decide on using a table variable or a temporary table?

First, we know there are situations that which demand the use of a temporary table. This in-cludes calling nested stored procedures which use the resultset, certain scenarios using dy-namic SQL, and cases where you need transaction rollback support.

Secondly, the size of the resultset will determine which solution to choose. If the table stores a resultset so large you require indexes to improve query performance, you’ll need to stick to a temporary table. In some borderline cases try some performance benchmark testing to see which approach offers the best performance. If the resultset is small, the table variable is always the optimum choice.

An Example: Split

Table variables are a superior alternative to using temporary tables in many situations. The ability to use a table variable as the return value of a UDF is one of the best uses of table vari-ables. In the following sample, we will address a common need: a function to parse a delimited string into pieces. In other words, given the string “1,5,9” – we will want to return a table with a record for each value: 1, 5, and 9.

The following user-defined function will walk through an incoming string and parse out the individual entries. The UDF insert the en-tries into a table variable and returns the table variable as a result. As an example, calling the UDF with the following SELECT statement:




SELECT * FROM fn_Split('foo,bar,widget', ',')
 



will return the following result set.




position value
1        foo
2        bar
3        widget
 

We could use the resultset in another stored procedure or batch as a table to select against or filter with. We will see why the split function can be useful in the next OdeToCode article. For now, here is the source code to fn_Split.




if exists (select * from dbo.sysobjects where id = ob-ject_id(N'[dbo].[fn_Split]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_Split]
GO
 
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO
 
CREATE  FUNCTION fn_Split(@text varchar(8000), @delimiter varchar(20) = ' ')
RETURNS @Strings TABLE
(    
  position int IDENTITY PRIMARY KEY,
  value varchar(8000)   
)
AS
BEGIN
 
DECLARE @index int
SET @index = -1 
 
WHILE (LEN(@text) > 0) 
 
  BEGIN 
    SET @index = CHARINDEX(@delimiter , @text)  
    IF (@index = 0) AND (LEN(@text) > 0)  
      BEGIN  
        INSERT INTO @Strings VALUES (@text)
          BREAK  
      END 
 
    IF (@index > 1)  
      BEGIN  
        INSERT INTO @Strings VALUES (LEFT(@text, @index - 1))   
        SET @text = RIGHT(@text, (LEN(@text) - @index))  
      END 
    ELSE
      SET @text = RIGHT(@text, (LEN(@text) - @index)) 
    END
  RETURN
 
END
GO
 
SET QUOTED_IDENTIFIER OFF
GO
 
SET ANSI_NULLS ON
GO
 



Summary

Next time you find yourself using a temporary table, think of table variables instead. Table variables can offer performance benefits and flexibility when compared to temporary tables, and you can let the server clean up afterwards.
