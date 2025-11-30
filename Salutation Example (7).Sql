-- Salutation Example (7).Sql
--
-- This example demonstrates how to generate salutations in a table. This example
--   was written for SQL Server 7, but will work with SQL Server 2000. 
--   SQL Server 2000 users may also have the option of using User-Defined
--   Functions as shown in the documentation (see the help file PersApi.Chm).
--
-- The table, PersDemo1, was imported from the Demo database provided with
--   the Personator API.

declare @PersLoc varchar(64), @Register varchar(32)
declare @hSalute int
declare @Error int
declare @Pre varchar(256), @Fn varchar(256), @Ln varchar(256),
	@Suf varchar(256)
declare @Salute varchar(256)

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

-- Initialize salutation session:
execute master.dbo.PersInitSalutation @hSalute out, 0, 1, 2, 3,
	'Dear', ':', 'Valued Customer'

if @hSalute = 0
begin
	execute master.dbo.PersLastError @Error out
	raiserror ('PersInitSalutation failed: %d', 16, 1, @Error)
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

-- Create a cursor to be used for fetching and updating:
use Demos
declare cPersDemo1 cursor for
	select Pre1, Fn1, Ln1, Suf1, Salutation from 
	PersDemo1 for update of Salutation

-- Open the cursor, get first record:
open cPersDemo1
fetch next from cPersDemo1 into @Pre, @Fn, @Ln, @Suf,
	@Salute

-- Loop through all records:
while @@fetch_status = 0
begin

	-- Generate salutation:
	execute master.dbo.PersSalutate @Error out, @hSalute,
		@Pre, @Fn, @Ln, @Suf, @Salute out

	update PersDemo1 set Salutation = @Salute where 
		current of cPersDemo1

	 -- Skip to next record:
	fetch next from cPersDemo1 into @Pre, @Fn, @Ln, @Suf,
		@Salute
end

-- Close and remove cursor:
close cPersDemo1
deallocate cPersDemo1
execute master.dbo.PersCloseSalutation @hSalute
