USE [ResponseDriver_Stage] 
GO

/****** Object:  UserDefinedFunction [dbo].[udf_ConvertStringToTable]    Script Date: 28/11/2014 11:47:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



alter FUNCTION [dbo].[udf_RemoveSpaces] (@vString varchar(250))
RETURNS VARCHAR(250)
AS 


BEGIN

RETURN (SELECT REPLACE (@vString,space(1),space(0)));

-- TEST
-- SELECT ResponseDriver_Stage.dbo.udf_RemoveSpaces('xxx z x cv  xxxx')


END




GO

