-- Add Pers API Functions.Sql
--
--   Adds the Personator API functions to SQL Server.
--
-- This program only works in SQL Server 2000. Prior versions did not support user-defined
--   functions.

create function fPersRegister(@Str varchar(64))
	returns int as
	begin
		declare @Result int
		execute master.dbo.PersRegister @Result out, @Str
		return @Result
	end
go

create function fPersVersion ()
	returns int as
	begin
		declare @Version int
		execute master.dbo.PersVersion @Version out
		return @Version
	end
go

create function fPersFileLoc(@Dir varchar(256))
	returns int as
	begin
		declare @Result int
		execute master.dbo.PersFileLoc @Result out, @Dir
		return @Result
	end
go

create function fPersLastError ()
	returns int as
	begin
		declare @Error int
		execute master.dbo.PersLastError @Error out
		return @Error
	end
go

create function fPersInitName (@Mainly int, @Also int,
	@Dual int)
	returns int as
	begin
		declare @hName int
		execute master.dbo.PersInitName @hName out, @Mainly,
			@Also, @Dual
		return @hName
	end
go

create function fPersAddNameConnector (@hName int, 
	@Connector varchar(64))
	returns int as
	begin
		declare @Error int
		execute master.dbo.PersAddNameConnector @hName,
			@Connector
		return NULL
	end
go

create function fPersPre1 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Pre1
	end
go

create function fPersFn1 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Fn1
	end
go

create function fPersMn1 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Mn1
	end
go

create function fPersLn1 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Ln1
	end
go

create function fPersSuf1 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Suf1
	end
go

create function fPersPre2 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Pre2
	end
go

create function fPersFn2 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Fn2
	end
go

create function fPersMn2 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Mn2
	end
go

create function fPersLn2 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Ln2
	end
go

create function fPersSuf2 (@hName int, @FullName varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Pre1 varchar(256), @Fn1 varchar(256),
			@Mn1 varchar(256), @Ln1 varchar(256), @Suf1 varchar(256),
			@Pre2 varchar(256), @Fn2 varchar(256), @Mn2 varchar(256),
			@Ln2 varchar(256), @Suf2 varchar(256)
		execute master.dbo.PersSplitName @Error out, @hName, @FullName,
			@Pre1 out, @Fn1 out, @Mn1 out, @Ln1 out, @Suf1 out, @Pre2 out,
			@Fn2 out, @Mn2 out, @Ln2 out, @Suf2 out
		return @Suf2
	end
go

create function fPersCloseName (@hName int)
	returns int as
	begin
		execute master.dbo.PersCloseName @hName
		return NULL
	end
go

create function fPersInitGenderizer (@Precision int, @Population int,
	@Genderbase int)
	returns int as
	begin
		declare @hGender int
		execute master.dbo.PersInitGenderizer @hGender out, @Precision,
			@Population, @Genderbase
		return @hGender
	end
go

create function fPersGenderize (@hGender int, @First varchar(256))
	returns varchar(8) as
	begin
		declare @Error int
		declare @Gender varchar(8)
		execute master.dbo.PersGenderize @Error out, @hGender, 
			@First, @Gender out
		return @Gender
	end
go

create function fPersFixedFn (@hGender int, @First varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Gender varchar(8), @Fixed varchar(256)
		execute master.dbo.PersGenderize @Error out, @hGender, 
			@First, @Gender out, @Fixed out
		return @Fixed
	end
go

create function fPersCloseGenderizer (@hGender int)
	returns int as
	begin
		execute master.dbo.PersCloseGenderizer @hGender
		return NULL
	end
go

create function fPersInitSalutation (@Opt1 int, @Opt2 int,
	@Opt3 int, @Opt4 int, @SalPre varchar(256), @Salsuf varchar(256),
	@Slug varchar(256))
	returns int as
	begin
		declare @hSalute int
		execute master.dbo.PersInitSalutation @hSalute out, @Opt1,
			@Opt2, @Opt3, @Opt4, @SalPre, @SalSuf, @Slug
		return @hSalute
	end
go

create function fPersSalutate (@hSalute int, @Pre varchar(256),
	@First varchar(256), @Last varchar(256), @Suf varchar(256))
	returns varchar(256) as
	begin
		declare @Error as int
		declare @Salute as varchar(256)
		execute master.dbo.PersSalutate @Error out, @hSalute, 
			@Pre, @First,	@Last, @Suf, @Salute out
		return @Salute
	end
go

create function fPersCloseSalutation (@hSalute int)
	returns int as
	begin
		execute master.dbo.PersCloseSalutation @hSalute
		return NULL
	end
go

create function fPersInitStreet (@USCan int, @Option int,
	@Custom int)
	returns int as
	begin
		declare @hStreet int
		execute master.dbo.PersInitStreet @hStreet out, @USCan,
			@Option, @Custom
		return @hStreet
	end
go

create function fPersStNumber (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @Number
	end
go

create function fPersStPreDir (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet  @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @PreDir
	end
go

create function fPersStName (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet  @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @Name
	end
go

create function fPersStSuffix (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet  @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @Suffix
	end
go

create function fPersStPostDir (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet  @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @PostDir
	end
go

create function fPersStSecondary (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet  @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @Secondary
	end
go

create function fPersStPOBox (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet  @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @POBox
	end
go

create function fPersStOut1 (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet  @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @Out1
	end
go

create function fPersStOut2 (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet  @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @Out2
	end
go

create function fPersStOut3 (@hStreet int, @Addr1 varchar(256),
	@Addr2 varchar(256), @Addr3 varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @Number varchar(256),@PreDir varchar(256),@Name varchar(256),
			@Suffix varchar(256),@PostDir varchar(256),@Secondary varchar(256),
			@POBox varchar(256),@Out1 varchar(256),@Out2 varchar(256),
			@Out3 varchar(256)
		execute master.dbo.PersSplitStreet  @Error out, @hStreet, @Addr1, @Addr2,
			@Addr3, @Number out, @PreDir out, @Name out, @Suffix out,
			@PostDir out, @Secondary out, @POBox out, @Out1 out, @Out2 out,
			@Out3 out
		return @Out3
	end
go

create function fPersCloseStreet (@hStreet int)
	returns int as
	begin
		execute master.dbo.PersCloseStreet @hStreet
		return NULL
	end
go

create function fPersInitCSZ ()
	returns int as
	begin
		declare @hCSZ int
		execute master.dbo.PersInitCSZ @hCSZ out
		return @hCSZ
	end
go

create function fPersCity (@hCSZ int, @CSZ varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @City varchar(256),@State varchar(256),
			@Zip5 varchar(256),@Zip4 varchar(256)
		execute master.dbo.PersSplitCSZ @Error out, @hCSZ, @CSZ, 
			@City out, @State out, @Zip5 out, @Zip4 out
		return @City
	end
go

create function fPersState (@hCSZ int, @CSZ varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @City varchar(256),@State varchar(256),
			@Zip5 varchar(256),@Zip4 varchar(256)
		execute master.dbo.PersSplitCSZ @Error out, @hCSZ, @CSZ, 
			@City out, @State out, @Zip5 out, @Zip4 out
		return @State
	end
go
	
create function fPersZip5 (@hCSZ int, @CSZ varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @City varchar(256),@State varchar(256),
			@Zip5 varchar(256),@Zip4 varchar(256)
		execute master.dbo.PersSplitCSZ @Error out, @hCSZ, @CSZ, 
			@City out, @State out, @Zip5 out, @Zip4 out
		return @Zip5
	end
go

create function fPersZip4 (@hCSZ int, @CSZ varchar(256))
	returns varchar(256) as
	begin
		declare @Error int
		declare @City varchar(256),@State varchar(256),
			@Zip5 varchar(256),@Zip4 varchar(256)
		execute master.dbo.PersSplitCSZ @Error out, @hCSZ, @CSZ, 
			@City out, @State out, @Zip5 out, @Zip4 out
		return @Zip4
	end
go

create function fPersCloseCSZ (@hCSZ int)
	returns int as
	begin
		execute master.dbo.PersCloseCSZ @hCSZ
		return NULL
	end
go
