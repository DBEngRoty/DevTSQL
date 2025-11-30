USE [SystemRunDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_Generic_XML_Upload] 	@FILE AS VARCHAR(100), @XML as VARCHAR(100)
AS
DECLARE @VCMD  VARCHAR(500); SET @VCMD='';


--SAFE: SET @VCMD='BCP.EXE CustomerPool.dbo.FDR_CDCI_Transaction in "F:\Prototype System environment\txtInputFiles\ccd_cdci_txn.dat" -S CDI14 -T -f "F:\Prototype System environment\System Interface Descriptions\Import interfaces\GE Main\BCP_XML_format\ccd_kdw_txn.dat.xml" ';

SET @VCMD=@VCMD + 'BCP.EXE CustomerPool.dbo.FDR_CDCI_Transaction in "F:\Prototype System environment\txtInputFiles\'+LTRIM(RTRIM(@FILE))+'"'
SET @VCMD=@VCMD + ' -S CDI14 -T -f "F:\Prototype System environment\System Interface Descriptions\Import interfaces\GE Main\BCP_XML_format\'+LTRIM(RTRIM(@XML))+'"'

--SET @VCMD='BCP.EXE CustomerPool.dbo.FDR_CDCI_Transaction in "F:\Prototype System environment\txtInputFiles\ccd_cdci_txn.dat" -S CDI14 -T -f "F:\Prototype System environment\System Interface Descriptions\Import interfaces\GE Main\BCP_XML_format\ccd_kdw_txn.dat.xml" ';

BEGIN
--SET NOCOUNT ON;
--SELECT 1;
--PRINT @VCMD;
-- result: BCP.EXE CustomerPool.dbo.FDR_CDCI_Transaction in "F:\Prototype System environment\txtInputFiles\ccd_cdci_txn.dat" -S CDI14 -T -f "F:\Prototype System environment\System Interface Descriptions\Import interfaces\GE Main\BCP_XML_format\ccd_kdw_txn.dat.xml" 

EXEC xp_cmdshell @VCMD;

-- Test
-- EXEC usp_Generic_XML_Upload 'ccd_cdci_txn.dat','ccd_kdw_txn.dat.xml'


END





















USE [SystemRunDB]
GO
/****** Object:  StoredProcedure [dbo].[usp_Upload_ccd_kdw_txn_DAT]    Script Date: 05/03/2011 13:50:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_Upload_ccd_kdw_txn_DAT] 	@XML as VARCHAR(100), @FILE AS VARCHAR(100)
AS
DECLARE @VCMD VARCHAR(500); SET @VCMD='';
--SAFE: SET @VCMD='BCP.EXE CustomerPool.dbo.FDR_CDCI_Transaction in "F:\Prototype System environment\txtInputFiles\ccd_cdci_txn.dat" -S CDI14 -T -f "F:\Prototype System environment\System Interface Descriptions\Import interfaces\GE Main\BCP_XML_format\ccd_kdw_txn.dat.xml" ';
SET @VCMD='BCP.EXE CustomerPool.dbo.FDR_CDCI_Transaction in "F:\Prototype System environment\txtInputFiles\ccd_cdci_txn.dat" -S CDI14 -T -f "F:\Prototype System environment\System Interface Descriptions\Import interfaces\GE Main\BCP_XML_format\ccd_kdw_txn.dat.xml" ';

BEGIN
--SET NOCOUNT ON;
--SELECT 1;
PRINT @VCMD;
-- result: BCP.EXE CustomerPool.dbo.FDR_CDCI_Transaction in "F:\Prototype System environment\txtInputFiles\ccd_cdci_txn.dat" -S CDI14 -T -f "F:\Prototype System environment\System Interface Descriptions\Import interfaces\GE Main\BCP_XML_format\ccd_kdw_txn.dat.xml" 
--EXEC xp_cmdshell 'bcp '

EXEC xp_cmdshell @VCMD


-- Test
-- EXEC usp_Upload_ccd_kdw_txn_DAT


END
