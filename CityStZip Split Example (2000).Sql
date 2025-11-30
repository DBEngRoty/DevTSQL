-- CityStZip Split Example (2000).Sql
--
-- This example demonstrates how to split City/State/Zips in a table. This
--   example was written for SQL Server 2000, but will not work with 
--   SQL Server 2000. 
--
-- The table, PersDemo2, was imported from the Demo database provided with
--   the Personator API.

declare @PersLoc varchar(64), @Register varchar(32)
declare @hCSZ int
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

-- Initialize splitting session:
set @hCSZ=master.dbo.fPersInitCSZ()

if @hCSZ = 0
begin
	set @Error=master.dbo.fPersLastError()
	raiserror ('PersInitCSZ failed: %d', 16, 1, @Error)
	return
end

-- Demo2's structure:
--   ADDR1      nVarChar 40  <Input Address Line 1>
--   ADDR2      nVarChar 40  <Input Address Line 2>
--   CSZ        nVarChar 30  <Input City/State/Zip>
--   NUMBER     nVarChar 10  <Output Street Number>
--   PREDIR     nVarChar 10  <Output Street Pre Directional>
--   NAME       nVarChar 20  <Output Street Name>
--   SUFFIX     nVarChar 10  <Output Street Suffix>
--   POSTDIR    nVarChar 10  <Output Street Post Directional>
--   SECONDARY  nVarChar 30  <Output Secondary>
--   POBOX      nVarChar 20  <Output PO Box>
--   CITY       nVarChar 20  <Output City>
--   STATE      nVarChar  2  <Output State>
--   ZIP        nVarChar 10  <Output Zip>

use Demos
update PersDemo2 set City=master.dbo.fPersCity(@hCSZ,CSZ),
	State=master.dbo.fPersState(@hCSZ,CSZ),
	Zip=master.dbo.fPersZip5(@hCSZ,CSZ)

-- All done:
set @Error=master.dbo.fPersCloseCSZ(@hCSZ)