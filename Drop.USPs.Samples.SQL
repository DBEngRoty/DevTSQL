
-- For SQL: 2008, 2012, 2014
IF OBJECT_ID('dbo.SciEmailApi_AddEmailMessage','P') IS NOT NULL
DROP PROCEDURE [dbo].[SciEmailApi_AddEmailMessage];
GO

-- For SQL: 2016, 2017, 2019
DROP PROCEDURE IF EXISTS dbo.SciEmailApi_AddEmailMessage;
GO