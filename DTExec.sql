-- THIS IS SQL2005

--The following example shows how to run the same package and capture the return code:

DECLARE @returncode int
EXEC @returncode = xp_cmdshell 'dtexec /f "C:\UpsertData.dtsx"'

--To execute an SSIS package saved to SQL Server using Windows authentication, use the following code:
dtexec /sq pkgOne /ser productionServer
 
--To execute an SSIS package saved to the File System folder in the SSIS Package Store, use the following code: 
dtexec /dts "\File System\MyPackage"

--To validate a package that uses Windows Authentication and is saved in SQL Server without executing the package, use the following code:
dtexec /sq pkgOne /ser productionServer /va
 
--To execute an SSIS package that is saved in the file system, use the following code:
dtexec /f "c:\pkgOne.dtsx" 
 
--To execute an SSIS package that is saved in the file system, and specify logging options, use the following code:
dtexec /f "c:\pkgOne.dtsx" /l "DTS.LogProviderTextFile;c:\log.txt"
 
--To execute a package that uses Windows Authentication and is saved to the default local instance of SQL Server, and verify the version before it is executed, use the following code:
dtexec /sq pkgOne /verifyv {c200e360-38c5-11c5-11ce-ae62-08002b2b79ef}
 
--To execute an SSIS package that is saved in the file system and configured externally, use the following code:
dtexec /f "c:\pkgOne.dtsx" /conf "c:\pkgOneConfig.cfg"
 
