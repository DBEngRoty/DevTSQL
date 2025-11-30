-- CityStZip Split Example (7).Sql
--
-- This example demonstrates how to split city/state/zips in a table. This 
--   example was written for SQL Server 7, but will work with SQL Server 2000. 
--   SQL Server 2000 users may also have the option of using User-Defined
--   Functions as shown in the documentation (see the help file PersApi.Chm).
--
-- The table, PersDemo2, was imported from the Demo database provided with
--   the Personator API.

declare @PersLoc varchar(64), @Register varchar(32)
declare @hCSZ int
declare @Error int
declare @CSZ varchar(256)
declare @City varchar(256), @State varchar(256), @Zip5 varchar(256),
	@Zip4 varchar(256)

-- Change the following line to reflect your installation location of the
--   Personator API and registration string:
set @PersLoc = 'c:\PersApi\'
set @Register = 'DEMO'

-- Register the API. Note that you MUST use a valid registration
--   key when testing the Right Fielder API with SQL Server. Contact
--   us at 781-545-7300 for more information:
execute master.dbo.PersRegister @Error out, @Register

-- Specify the location of the Personator lookup tables (usually
--   a good idea, even if not necessary):
execute master.dbo.PersFileLoc @Error out, @PersLoc

-- Initialize splitting session:
execute master.dbo.PersInitCSZ @hCSZ out

if @hCSZ = 0
begin
	execute master.dbo.PersLastError @Error out
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

-- Create a cursor to be used for fetching and updating:
use Demos
declare cPersDemo2 cursor for
	select CSZ, City, State, Zip from 
	PersDemo2 for update of City, State, Zip

-- Open the cursor, get first record:
open cPersDemo2
fetch next from cPersDemo2 into @CSZ, @City, @State,
	@Zip5

-- Loop through all records:
while @@fetch_status = 0
begin

	-- Split City/State/Zip:
	execute master.dbo.PersSplitCSZ @Error out, @hCSZ,
		@CSZ, @City out, @State out, @Zip5 out, 
		@Zip4 out

	update PersDemo2 set City = @City, State = @State,
		Zip = @Zip5 where current of cPersDemo2

	 -- Skip to next record:
	fetch next from cPersDemo2 into @CSZ, @City, @State,
		@Zip5
end

-- Close and remove cursor:
close cPersDemo2
deallocate cPersDemo2
execute master.dbo.PersCloseCSZ @hCSZ