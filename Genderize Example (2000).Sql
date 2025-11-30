-- Genderize Example (2000).Sql
--
-- This example demonstrates how to genderize names in a table. This example
--   was written for SQL Server 2000, but will not work with SQL Server 2000. 
--
-- The table, PersDemo1, was imported from the Demo database provided with
--   the Personator API.

declare @PersLoc varchar(64), @Register varchar(32)
declare @hGend int
declare @Error int

-- Change the following line to reflect your installation location of the
--   Personator API and registration string:
set @PersLoc = 'c:\PersApi\'
set @Register = 'DEMO'

-- Register the API. Note that you MUST use a valid registration
--   key when testing the Right Fielder API with SQL Server. Contact
--   us at 781-545-7300 for more information:
set @Error=master.dbo.fPersRegister(@Register)

-- Specify the location of the Personator lookup tables (usually
--   a good idea, even if not necessary):
set @Error=master.dbo.fPersFileLoc(@PersLoc)

-- Initialize genderizing session:
set @hGend=master.dbo.fPersInitGenderizer(1, 1, 0)

if @hGend = 0
begin
	set @Error=master.dbo.fPersLastError()
	raiserror ('PersInitGenderize failed: %d', 16, 1, @Error)
	return
end

-- PersDemo1's structure:
--   FULLNAME   nVarChar 40  <Input Full Name>
--   PRE1       nVarChar 10  <Output Prefix 1>
--   FN1        nVarChar 20  <Output First Name 1>
--   MN1        nVarChar 10  <Output Middle Name 1>
--   LN1        nVarChar 20  <Output Last Name 1>
--   SUF1       nVarChar 10  <Output Suffix 1>
--   PRE2       nVarChar 10  <Output Prefix 2>
--   FN2        nVarChar 20  <Output First Name 2>
--   MN2        nVarChar 10  <Output Middle Name 2>
--   LN2        nVarChar 20  <Output Last Name 2>
--   SUF2       nVarChar 10  <Output Suffix 2>
--   SALUTATION nVarChar 30  <Output Salutation>

use Demos
update PersDemo1 set Pre1 = 'Mr.' where 
	master.dbo.fPersGenderize(@hGend,Fn1) = 'M'
update PersDemo1 set Pre1 = 'Ms.' where 
	master.dbo.fPersGenderize(@hGend,Fn1) = 'F'

update PersDemo1 set Pre2 = 'Mr.' where 
	master.dbo.fPersGenderize(@hGend,Fn2) = 'M'
update PersDemo1 set Pre2 = 'Ms.' where 
	master.dbo.fPersGenderize(@hGend,Fn2) = 'F'

-- All done:
set @Error=master.dbo.fPersCloseGenderizer(@hGend)