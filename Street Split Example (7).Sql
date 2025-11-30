-- Street Split Example (7).Sql
--
-- This example demonstrates how to split street addresses in a table. This 
--   example was written for SQL Server 7, but will work with SQL Server 2000. 
--   SQL Server 2000 users may also have the option of using User-Defined
--   Functions as shown in the documentation (see the help file PersApi.Chm).
--
-- The table, PersDemo2, was imported from the Demo database provided with
--   the Personator API.

declare @PersLoc varchar(64), @Register varchar(32)
declare @hStreet int
declare @Error int
declare @Addr1 varchar(256), @Addr2 varchar(256)
declare @Number varchar(256), @PreDir varchar(256), @Name varchar(256),
	@Suffix varchar(256), @PostDir varchar(256), @Secondary varchar(256),
	@POBox varchar(256), @Out1 varchar(256), @Out2 varchar(256),
	@Out3 varchar(256)

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
execute master.dbo.PersInitStreet @hStreet out, 0, 0

if @hStreet = 0
begin
	execute master.dbo.PersLastError @Error out
	raiserror ('PersInitStreet failed: %d', 16, 1, @Error)
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
	select Addr1, Addr2, Number, PreDir, [Name], Suffix,
	PostDir, Secondary, POBox from PersDemo2 for update of 
	Number, PreDir, [Name], Suffix, PostDir, Secondary,
	POBox

-- Open the cursor, get first record:
open cPersDemo2
fetch next from cPersDemo2 into @Addr1, @Addr2, @Number, @PreDir,
	@Name, @Suffix, @PostDir, @Secondary, @POBox

-- Loop through all records:
while @@fetch_status = 0
begin

	-- Split Street:
	execute master.dbo.PersSplitStreet @Error out,
		@hStreet, @Addr1, @Addr2, '', @Number out, 
		@PreDir out, @Name out, @Suffix out, 
		@PostDir out, @Secondary out, @POBox out,
		@Out1 out, @Out2 out, @Out3 out

	update PersDemo2 set Number = @Number, PreDir = @PreDir,
		[Name] = @Name, Suffix = @Suffix, PostDir= @PostDir,
		Secondary = @Secondary, POBox = @POBox where 
		current of cPersDemo2

	 -- Skip to next record:
	fetch next from cPersDemo2 into @Addr1, @Addr2, 
		@Number, @PreDir,@Name, @Suffix, @PostDir, 
		@Secondary, @POBox
end

-- Close and remove cursor:
close cPersDemo2
deallocate cPersDemo2
execute master.dbo.PersCloseStreet @hStreet