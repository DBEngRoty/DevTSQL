--SQL2K5
-- SQL2k5
IF object_id('Prospectpool.dbo.ProspectClassificationUniverse','U') IS NOT NULL
DROP TABLE Prospectpool.dbo.ProspectClassificationUniverse;


--Here's an easy way to check if a temp table exists, before trying to create it (ie. for reusable scripts) from Simon Sabin's post :
 
IF object_id('tempdb..#MyTempTable') IS NOT NULL
BEGIN
   DROP TABLE #MyTempTable
END

CREATE TABLE #MyTempTable
( ID int IDENTITY(1,1), SomeValue varchar(100))
GO




--cleanup
if object_id('StageDB.dbo.'+@InterfaceName+'_Raw','U') is not null
begin
  set @cmd='drop table StageDB.dbo.'+@InterfaceName+'_Raw';
  execute sp_executesql @cmd;
end

 

if object_id('StageDB.dbo.'+@InterfaceName+'_Stage','U') is not null
begin
  set @cmd='drop table StageDB.dbo.'+@InterfaceName+'_Stage';
  execute sp_executesql @cmd;
end;

 
-- dYNAMIC CODE HERE FOR DROPS
DECLARE @VTabOt VARCHAR(50); SET @VTabOt=@VTable+'_OrigTemp';

-- Drop previous
SET @VCMD =	'
IF object_id('''+@VTabOt+''',''U'') IS NOT NULL DROP TABLE '+@VTabOt+';'
--PRINT @VCMD;
EXEC (@VCMD);


















if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Suppression_FIDO_Stage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Suppression_FIDO_Stage]
GO

CREATE TABLE [dbo].[Suppression_FIDO_Stage] (
	[RowId]   INT IDENTITY (1,1) PRIMARY KEY,
	[FileID] [smallint] NULL ,
	[NameStatus] [int] NULL ,
	[FIDOAcct1] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [SECONDARY]
GO


