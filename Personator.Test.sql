/*
DROP TABLE Template_Stage
SELECT * INTO Template_Stage FROM Template_Stage_Copy_80k WHERE ROWID<11
*/

USE STAGEDB;

declare @PersLoc varchar(64), @Register varchar(32) 
declare @hName int 
declare @Error int 

--   Personator API Location and registration string: 
set @PersLoc = 'C:\PersAPI' 
set @Register = 'b1cfcfd1cfcc014e' 

-- Register the API. Note that you MUST use a valid registration 
set @Error = master.dbo.fPersRegister(@Register) 
if @Error = 0 
begin 
    raiserror ('The Personator Register Key is Wrong', 16, 1) 
   return 
end 

-- Specify the location of the Personator lookup tables 
set @Error = master.dbo.fPersFileLoc(@PersLoc) 
if @Error = 0 
begin 
   raiserror ('The Personator Location is Wrong', 16, 1) 
   return 
end 

-- Initialize fielding session: 
set @hName = master.dbo.fPersInitName(0, 1, 1) 
if @hName = 0 
begin 
   set @Error = master.dbo.fPersLastError() 
   raiserror ('PersInitName failed: %d', 16, 1, @Error) 
   return 
end 

update StageDB.dbo.Template_Stage
set ParsedName= dbo.udf_COPersAPIParsedNameDual(@hName, FullName)


UPDATE  StageDB.dbo.Template_Stage
SET        Prefix=Substring(WorkingField,1,6),
           FName=Substring(WorkingField,16,30),
           MName=Substring(WorkingField,46,30),
           LName=Substring(WorkingField,76,30),
           Suffix=Substring(WorkingField,106,6)
      

set @Error = master.dbo.fPersCloseName(@hName)       

EXEC StageDB.dbo.usp_PersonatorAddDual 'Template_Stage'


-- LAST PIECE
declare @hGend int 
---declare @Error int 
declare @Gender varchar(256)
set @hGend = Master.dbo.fPersInitGenderizer(1, 1, 0) 
UPDATE StageDB.dbo.Template_Stage SET Pers_Gender=Master.dbo.fPersGenderize(@hGend,Pers_FName) 
set @Error = Master.dbo.fPersCloseGenderizer(@hGend)



--SQL Server Function Example: 
declare @hSalute int 
declare @Error int 
declare @Salutation varchar(256) 

set @hSalute = MASTER.DBO.fPersInitSalutation(0, 1, 2, 3, 'Dear', ':', 'Valued Customer') 
SELECT @Salutation = MASTER.DBO.fPersSalutate(@hSalute, 'Mr.', 'John','Smith', 'MD') 
set @Error = MASTER.DBO.fPersCloseSalutation(@hSalute) 
PRINT @Salutation