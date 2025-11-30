/*
This is for an uncontrolled environment where developers are allowed to change SPs without change control.
I would suggest to run the procedure every night.

Create a Database called Admin on the server to be scripted or a central server and place the SPs in it (and the dts package).
Schedule Admin..s_ScriptAllDatabases to run each night with the appropriate parameters.
s_ScriptAllDatabases includes a database parameter to enable scripting of a single database, dts packages or jobs.

These procedures will script the fllowing objects in each database on a server via SQL DMO
Stored Procedures
User Defined Functions
Tables
Views
Indexes
Triggers
Defaults
Rules
Jobs
dts package properties (via a dts package activexscript task)

To script DTS packages add the package indicated at
	ScriptDTSProperties


Instances will be scripted int the directory <path>svrname^instancename\ for instance svrname\instancename
The directory will be creted in <path. as for default instances.

You will need to create a shared directory for the output (the subdirectories will be created.
Also a work directory is required - I would advise to place it local to the scripting server if possible.

After the script is run for the first time Add all the files to SourceSafe from the root directory
(Add, Recursive, Check out immediately).

After this for future script runs
I prefer to do this
	Show differences, Show files that are only in the to location, Show files that are different in both places
		check in / add these files keeping them checked out after checking all changes that have been made.

If you don't want to check changes
	Check in, recursive, keep checked out
		(The default options will not create entries for unchanged files)
	Show differences, Show files that are only in the to location
		Add these files keeping them checked out



To script a server run s_ScriptAllDatabases as indicated in the comment.
To script a remote server it must be added as a linked server to the scripting server.


Future enhancements
	Allow spaces in work directory path
	Automatically update SourceSafe with the results


*/


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[s_ScriptAllDatabases]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DBA_ScriptAllDatabases]
GO




CREATE procedure sp_DBA_ScriptAllDatabases
@SourceUID	varchar(128) ,	-- null for trusted connection
@SourcePWD	varchar(128) ,
@OutFilePath	varchar(256) ,	-- Root path - will add directory for object types
@OutFileName	varchar(128) ,	 -- null for separate file per object script
@WorkPath	varchar(256) ,
@SourceSVR	varchar(128) = null ,	-- to script remote server
@Database	varchar(128) = null	-- to script single database / jobs / DTS

as
/*
exec	s_ScriptAllDatabases
	@SourceUID	= null ,
	@SourcePWD	= null ,
	@OutFilePath	= 'c:\a\' ,
	@OutFileName	= null ,
	@WorkPath	= 'c:\temp\' ,				-- no spaces
	@SourceSVR	= null

exec	s_ScriptAllDatabases
	@SourceUID	= null ,
	@SourcePWD	= null ,
	@OutFilePath	= 'c:\a\' ,
	@OutFileName	= null ,
	@WorkPath	= 'c:\temp\' ,				-- no spaces
	@SourceSVR	= null ,
	@Database	= 'JOBS'

exec	s_ScriptAllDatabases
	@SourceUID	= null ,
	@SourcePWD	= null ,
	@OutFilePath	= 'c:\a\' ,
	@OutFileName	= null ,
	@WorkPath	= 'c:\temp\' ,				-- no spaces
	@SourceSVR	= null ,
	@Database	= 'DTS'

exec	s_ScriptAllDatabases
	@SourceUID	= null ,
	@SourcePWD	= null ,
	@OutFilePath	= 'c:\a\' ,
	@OutFileName	= null ,
	@WorkPath	= 'c:\temp\' ,				-- no spaces
	@SourceSVR	= null ,
	@Database	= 'mydb'

*/
declare @sql 	varchar(1000) ,
	@cmd	varchar(1000)
	
	if @SourceSVR is null
	begin
		select @SourceSVR = @@servername
	end
	
	if right(@OutFilePath,1) <> '\'
	begin
		select @OutFilePath = @OutFilePath + '\'
	end
	
	if right(@WorkPath,1) <> '\'
	begin
		select @WorkPath = @WorkPath + '\'
	end
	
	select	@OutFilePath = @OutFilePath + '"' + @SourceSVR + '"'
	exec master..xp_cmdshell @cmd
	select	@OutFilePath = @OutFilePath + '\'
	
	select @sql = 	
	'select	name
	from	[' + @SourceSVR + '].master.dbo.sysdatabases
	where	name <> ''tempdb'''
	
	if @Database is not null
	begin
		select @sql = @sql + ' and name = ''' + @Database + ''''
	end
	
	create table #tblDatabases (name varchar(128))
	insert	#tblDatabases
		(name)
	exec (@sql)

declare	@FilePath	varchar(256)

declare	@name		varchar(128) ,
	@maxname	varchar(128)

	select	@name = '' ,
		@maxname = max(name)
	from	#tblDatabases

	while @name < @maxname
	begin
		select	@name = min(name) from #tblDatabases where name > @name

		select	@FilePath = @OutFilePath + '"' + @name + '"'

		-- output current database name
		select CurrentDatabase = @name

		-- create output directory - will fail if already exists but ...
		select	@cmd = 'mkdir ' + @FilePath
		exec master..xp_cmdshell @cmd, no_output
		
		exec	s_ScriptAllObjectsInDatabase
			@SourceDB 	= @name ,
			@SourceUID 	= @SourceUID ,
			@SourcePWD 	= @SourcePWD ,
			@OutFilePath 	= @FilePath ,
			@OutFileName 	= @OutFileName ,	-- null for separate file per object script
			@WorkPath	= @WorkPath ,
			@SourceSVR	= @SourceSVR
	end
	
	if coalesce(@Database, 'JOBS') = 'JOBS'
	begin
		select	@FilePath = @OutFilePath + 'JOBS'
		
		-- create output directory - will fail if already exists but ...
		select	@cmd = 'mkdir ' + @FilePath
		exec master..xp_cmdshell @cmd, no_output
		
		exec	s_ScriptObjects
			@SourceDB	= 'msdb' ,
			@SourceObject	= null ,	-- null for all objects
			@SourceUID 	= @SourceUID ,
			@SourcePWD 	= @SourcePWD ,
			@OutFilePath 	= @FilePath ,
			@OutFileName 	= @OutFileName ,	-- null for separate file per object script
			@ObjectType	= 'JOBS' ,
			@WorkPath	= @WorkPath ,
			@SourceSVR	= @SourceSVR
	end
	
	if coalesce(@Database, 'DTS') = 'DTS'
	begin
		select	@FilePath = @OutFilePath + 'DTS'
		
		-- create output directory - will fail if already exists but ...
		select	@cmd = 'mkdir ' + @FilePath
		exec master..xp_cmdshell @cmd, no_output
		
		exec	s_ScriptObjects
			@SourceDB	= 'msdb' ,
			@SourceObject	= null ,	-- null for all objects
			@SourceUID 	= @SourceUID ,
			@SourcePWD 	= @SourcePWD ,
			@OutFilePath 	= @FilePath ,
			@OutFileName 	= @OutFileName ,	-- null for separate file per object script
			@ObjectType	= 'DTS' ,
			@WorkPath	= @WorkPath ,
			@SourceSVR	= @SourceSVR
	end
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[s_ScriptAllObjectsInDatabase]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[s_ScriptAllObjectsInDatabase]
GO


Create procedure s_ScriptAllObjectsInDatabase
@SourceDB	varchar(128) ,
@SourceUID	varchar(128) ,	-- null for trusted connection
@SourcePWD	varchar(128) ,
@OutFilePath	varchar(256) ,	-- Root path - will add directory for object types
@OutFileName	varchar(128) ,	 -- null for separate file per object script
@WorkPath	varchar(256) ,
@SourceSVR	varchar(128)
as

	if right(@OutFilePath,1) <> '\'
	begin
		select @OutFilePath = @OutFilePath + '\'
	end

	if right(@WorkPath,1) <> '\'
	begin
		select @WorkPath = @WorkPath + '\'
	end

	set nocount on
	declare @tblObjectType table (ObjectType varchar(50))
	insert	@tblObjectType select 'PROCEDURES'
	insert	@tblObjectType select 'FUNCTIONS'
	insert	@tblObjectType select 'TABLES'
	insert	@tblObjectType select 'VIEWS'
	insert	@tblObjectType select 'INDEXES'
	insert	@tblObjectType select 'TRIGGERS'
	insert	@tblObjectType select 'DEFAULTS'
	insert	@tblObjectType select 'RULES'

declare	@FilePath	varchar(256) ,
	@cmd		varchar(1000)

declare	@ObjectType	varchar(50) ,
	@maxObjectType	varchar(50)

	select	@ObjectType = '' ,
		@maxObjectType = max(ObjectType)
	from	@tblObjectType

	while @ObjectType < @maxObjectType
	begin
		select	@ObjectType = min(ObjectType) from @tblObjectType where ObjectType > @ObjectType

		select	@FilePath = @OutFilePath + @ObjectType

		-- create output directory - will fail if already exists but ...
		select	@cmd = 'mkdir ' + @FilePath
		exec master..xp_cmdshell @cmd, no_output

		exec	s_ScriptObjects
			@SourceDB 	= @SourceDB ,
			@SourceObject 	= null ,
			@SourceUID 	= @SourceUID ,
			@SourcePWD 	= @SourcePWD ,
			@OutFilePath 	= @FilePath ,
			@OutFileName 	= null ,		-- null for separate file per object script
			@ObjectType 	= @ObjectType ,
			@WorkPath	= @WorkPath ,
			@SourceSVR	= @SourceSVR
	end

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[s_ScriptObjects]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[s_ScriptObjects]
GO

CREATE procedure s_ScriptObjects
@SourceDB	varchar(128) ,
@SourceObject	varchar(128) ,	-- null for all objects
@SourceUID	varchar(128) ,	-- null for trusted connection
@SourcePWD	varchar(128) ,
@OutFilePath	varchar(256) ,
@OutFileName	varchar(128) ,  -- null for separate file per object script
@ObjectType	varchar(50) ,	-- PROCS, FUNCTIONS, TABLES, VIEWS, INDEXES
@WorkPath	varchar(256) ,
@SourceSVR	varchar(128)
as
/*
exec s_ScriptObjects
@SourceDB	= 'TradarBe' ,
@SourceObject	= 'tbl_CQS_Pricing_BloombergData' ,	-- null for all objects
@SourceUID	=  null ,	-- null for trusted connection
@SourcePWD	=  null ,
@OutFilePath	= 'c:\a\' ,
@OutFileName	= null ,  -- null for separate file per object script
@ObjectType	= 'TABLES' ,	-- PROCS, FUNCTIONS, TABLES, VIEWS, INDEXES
@WorkPath	= 'c:\temp\' ,
@SourceSVR	= 'SVR01'
*/

	set nocount on

declare	@ScriptType	int ,
	@FileName	varchar(256) ,
	@tmpFileName	varchar(256) ,
	@buffer		varchar(8000) ,
	@Collection	varchar(128) ,
	@id		int ,
	@name		varchar(128) ,
	@subname	varchar(128)

declare	@context	varchar(255) ,
	@sql		varchar(1000) ,
	@rc		int

	
	if right(@OutFilePath,1) <> '\'
	begin
		select @OutFilePath = @OutFilePath + '\'
	end

	if right(@WorkPath,1) <> '\'
	begin
		select @WorkPath = @WorkPath + '\'
	end

	select	@SourceDB = replace(replace(@SourceDB,'[',''),'[','')

select	@ScriptType	= 4 | 1 | 64 ,
	@FileName	= @OutFilePath + @OutFileName ,
	@tmpFileName	= @WorkPath + 'ScriptTmp.txt'

declare	@objServer		int ,
	@objTransfer		int ,
	@strResult		varchar(255) ,
	@strCommand		varchar(255)

	-- get objects to script and object type
	create table #Objects (name varchar(128), subname varchar(128) default null, id int identity(1,1))

	if @SourceObject is not null
	begin
		insert	#Objects
			(name)
		select @SourceObject
	end

	if @ObjectType = 'TABLES'
	begin
		if @SourceObject is null
		begin
			select @sql =   	'select 	TABLE_NAME, null '
			select @sql = @sql + 	'from	[' + @SourceDB + '].INFORMATION_SCHEMA.TABLES '
			select @sql = @sql + 	'where	TABLE_TYPE = ''BASE TABLE'''
		end
		select @Collection = 'tables'
	end
	else if @ObjectType in ('PROCS', 'PROCEDURES')
	begin
		if @SourceObject is null
		begin
			select @sql =   	'select 	ROUTINE_NAME, null '
			select @sql = @sql + 	'from	[' + @SourceDB + '].INFORMATION_SCHEMA.ROUTINES '
			select @sql = @sql + 	'where	ROUTINE_TYPE = ''PROCEDURE'''
		end
		select @Collection = 'storedprocedures'
	end
	else if @ObjectType = 'FUNCTIONS'
	begin
		if @SourceObject is null
		begin
			select @sql =   	'select 	ROUTINE_NAME, null '
			select @sql = @sql + 	'from	[' + @SourceDB + '].INFORMATION_SCHEMA.ROUTINES '
			select @sql = @sql + 	'where	ROUTINE_TYPE = ''FUNCTION'''
		end
		select @Collection = 'userdefinedfunctions'
	end
	else if @ObjectType = 'VIEWS'
	begin
		if @SourceObject is null
		begin
			select @sql = 	 	'select 	TABLE_NAME, null '
			select @sql = @sql + 	'from	[' + @SourceDB + '].INFORMATION_SCHEMA.VIEWS '
			select @sql = @sql + 	'where	TABLE_NAME not like ''sys%'''
		end
		select @Collection = 'views'
	end
	else if @ObjectType = 'INDEXES'
	begin
		if @SourceObject is null
		begin
			select @sql = 	 	'select 	o.name, i.name '
			select @sql = @sql + 	'from	[' + @SourceDB + ']..sysobjects o, [' + @SourceDB + ']..sysindexes i '
			select @sql = @sql + 	'where	o.type = ''U'' '
			select @sql = @sql + 	'and 	i.id = o.id and i.indid <> 0 '
			select @sql = @sql + 	'and 	i.name not like ''_WA_%'''
			select @sql = @sql + 	'and 	o.name not like ''dtprop%'''
			select @sql = @sql + 	'and 	i.name not in (select name from [' + @SourceDB + ']..sysobjects)'
		end
		select @Collection = 'tables'
	end
	else if @ObjectType = 'TRIGGERS'
	begin
		if @SourceObject is null
		begin
			select @sql = 	 	'select o2.name, o.name '
			select @sql = @sql + 	'from	[' + @SourceDB + ']..sysobjects o,  [' + @SourceDB + ']..sysobjects o2 '
			select @sql = @sql + 	'where	o.xtype = ''TR'' '
			select @sql = @sql + 	'and	o.parent_obj = o2.id '
		end
		select @Collection = 'tables'
	end
	else if @ObjectType = 'DEFAULTS'
	begin
		if @SourceObject is null
		begin
			select @sql = 	 	'select 	o.name, null '
			select @sql = @sql + 	'from	[' + @SourceDB + ']..sysobjects o '
			select @sql = @sql + 	'where o.type = ''D'' and o.parent_obj = ''0'''
		end
		select @Collection = 'Defaults'
	end
	else if @ObjectType = 'RULES'
	begin
		if @SourceObject is null
		begin
			select @sql = 	 	'select 	o.name, null '
			select @sql = @sql + 	'from	[' + @SourceDB + ']..sysobjects o '
			select @sql = @sql + 	'where type = ''R'''
		end
		select @Collection = 'Rules'
	end
	else if @ObjectType = 'JOBS'
	begin
		if @SourceObject is null
		begin
			select @sql = 	 	'select 	j.name, null '
			select @sql = @sql + 	'from	msdb..sysjobs j '
		end
		select @Collection = 'jobs'
	end
	else if @ObjectType = 'DTS'
	begin
		select	@sql = 'dtsrun /NScript_DTS_Packages /S(local) /E '
					+ '/A"ServerName":8="' + @SourceSVR + '" ' 
					+ '/A"Path":8="' + @OutFilePath + '" ' 
					+ '/A"UserName":8="' + coalesce(@SourceUID,'') + '" ' 
					+ '/A"Password":8="' + coalesce(@SourcePWD,'') + '" ' 
		exec master..xp_cmdshell @sql
		return
	end
	else
	begin
		select 'invalid @ObjectType'
		return
	end
	
	if @SourceSVR <> @@servername
	begin
		select @sql = replace(@sql,'''','''''')
		insert	#Objects (name, subname) exec ('select * from openquery(' + @SourceSVR + ',''' + @sql + ''')')
	end
	else
	begin
		insert	#Objects (name, subname) exec (@sql)
	end
	
	-- create empty output file
	if @OutFileName is not null
	begin
		select	@sql = 'echo. > ' + @FileName
		exec master..xp_cmdshell @sql
	end
	
	-- prepare scripting object
	select @context = 'create dmo object'
	exec @rc = sp_OACreate 'SQLDMO.SQLServer', @objServer OUT
	if @rc <> 0 or @@error <> 0 goto ErrorHnd
	
	if @SourceUID is null
	begin
		select @context = 'set integrated security ' + @SourceSVR
		exec @rc = sp_OASetProperty @objServer, LoginSecure, 1
		if @rc <> 0 or @@error <> 0 goto ErrorHnd
	end
 	
	select @context = 'connect to server ' + @SourceSVR
	exec @rc = sp_OAMethod @objServer , 'Connect', NULL, @SourceSVR , @SourceUID , @SourcePWD
	if @rc <> 0 or @@error <> 0 goto ErrorHnd
	
	select @context = 'scripting'
	-- Script all the objects
	select @id = 0
	while exists (select * from #Objects where id > @id)
	begin
		select	@id = min(id) from #Objects where id > @id
		select @name = name, @subname = subname from #Objects where id = @id
		if @OutFileName is null
		begin
			select	@FileName = @OutFilePath + 'dbo."' + @name + coalesce('[' + @subname + ']','') + '.sql"'
			select	@sql = 'echo. > ' + @FileName
			exec master..xp_cmdshell @sql
		end
		--select @sql = 'echo print ''Create = dbo.[' + @name + ']'+ coalesce('[' + @subname + ']','') + ''' >> ' + @FileName
		--exec master..xp_cmdshell @sql
		if @ObjectType = 'INDEXES'
		begin
			Set @sql = 'databases("' + @SourceDB + '").' + @Collection + '("' + @name + '").indexes("' + @subname + '").script'
		end
		else if @ObjectType = 'TRIGGERS'
		begin
			Set @sql = 'databases("' + @SourceDB + '").' + @Collection + '("' + @name + '").triggers("' + @subname + '").script'
		end
		else if @ObjectType = 'JOBS'
		begin
			Set @sql = 'Jobserver.Jobs("' + @name + '").Script'
		end
		else
		begin
			Set @sql = 'databases("' + @SourceDB + '").' + @Collection + '("' + @name + '").script'
		end
		exec @rc = sp_OAMethod @objServer, @sql , @buffer OUTPUT, @ScriptType , @tmpFileName
		select @sql = 'type ' + @tmpFileName + ' >> ' + @FileName
		exec master..xp_cmdshell @sql
	end
	-- delete tmp file
	select @sql = 'del ' + @tmpFileName
	exec master..xp_cmdshell @sql, no_output

	-- clear up dmo
	exec @rc = sp_OAMethod @objServer, 'Disconnect'
	if @rc <> 0 or @@error <> 0 goto ErrorHnd

	exec @rc = sp_OADestroy @objServer
	if @rc <> 0 or @@error <> 0 goto ErrorHnd

	-- clear up temp table
	drop table #Objects

return
ErrorHnd:
select 'fail', @context
GO

