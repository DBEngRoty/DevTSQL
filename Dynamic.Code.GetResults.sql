declare @cmd varchar(8000)

drop table #tmp1;
create table #tmp1 (Field1 varchar(8000))
set @cmd='insert into #tmp1 select JobID from '+@TableName +'where ID=1';
  exec(@cmd);
select * from #tmp1;

--SAU
-- SAMPLE 1
DECLARE @SQLString NVARCHAR(500)
DECLARE @ParmDefinition NVARCHAR(500)
DECLARE @IntVariable INT
DECLARE @Lastlname varchar(30)
SET @SQLString = N'SELECT @LastlnameOUT = max(lname)
                   FROM pubs.dbo.employee WHERE job_lvl = @level'
SET @ParmDefinition = N'@level tinyint,
                        @LastlnameOUT varchar(30) OUTPUT'
SET @IntVariable = 35
EXECUTE sp_executesql @SQLString, @ParmDefinition, @level = @IntVariable, @LastlnameOUT=@Lastlname OUTPUT
SELECT @Lastlname;
		
-- SAMPLE 2		
CREATE PROCEDURE Myproc
    @parm varchar(10),
    @parm1OUT varchar(30) OUTPUT,
    @parm2OUT varchar(30) OUTPUT
    AS
      SELECT @parm1OUT='parm 1' + @parm
     SELECT @parm2OUT='parm 2' + @parm
GO
DECLARE @SQLString NVARCHAR(500)
DECLARE @ParmDefinition NVARCHAR(500)
DECLARE @parmIN VARCHAR(10)
DECLARE @parmRET1 VARCHAR(30)
DECLARE @parmRET2 VARCHAR(30)
SET @parmIN=' returned'
SET @SQLString=N'EXEC Myproc @parm,
                             @parm1OUT OUTPUT, @parm2OUT OUTPUT'
SET @ParmDefinition=N'@parm varchar(10),
                      @parm1OUT varchar(30) OUTPUT,
                      @parm2OUT varchar(30) OUTPUT'

EXECUTE sp_executesql
    @SQLString,
    @ParmDefinition,
    @parm=@parmIN,
    @parm1OUT=@parmRET1 OUTPUT,@parm2OUT=@parmRET2 OUTPUT

SELECT @parmRET1 AS "parameter 1", @parmRET2 AS "parameter 2"
go
drop procedure Myproc



-- SAMPLE3
set @cmd=N'select @MaxRowIDMergedOut=max(RowIDMerged) from '+@TableName;
exec sp_executesql @cmd, N'@MaxRowIDMergedOut int output',@MaxRowIDMergedOut=@MaxRowIDMerged output;
