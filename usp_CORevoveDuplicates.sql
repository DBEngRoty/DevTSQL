



CREATE     proc dbo.usp_CoRemoveDuplicates
        @chvTableName    varchar(100)

as


DECLARE @chvCMD1		varchar(8000)

set @chvCMD1 =''

SET @chvCMD1 = @chvCMD1 + '
create table #Dups (rowId int) 
create clustered index ix_rowId on #Dups(rowId)  '


SET @chvCMD1 = @chvCMD1 + '
insert into #Dups
select rowId 
from ' + @chvTableName + '
where rowId not in
(select min(rowId) from '+ @chvTableName + '
GROUP BY  M_Postal, M_LName, M_FName, M_CivicNum, M_Street, M_SuiteNum, m_General, m_POBox,m_Rural, m_GD )  '

SET @chvCMD1 = @chvCMD1 + '
insert into #Dups
select rowId 
from ' + @chvTableName + '
where rowId not in
(select min(rowId) from ' + @chvTableName + ' GROUP BY  M_Postal, M_LName, M_FName, M_CivicNum, M_Street, M_SuiteNum)
and ltrim(rtrim(M_CivicNum)) <> '''' and ltrim(rtrim(M_SuiteNum)) <> '''' and ltrim(rtrim(M_Street)) <> ''''  '

SET @chvCMD1 = @chvCMD1 + '
insert into #Dups
select rowId 
from '+ @chvTableName + '
where rowId not in
(select min(rowId) from ' + @chvTableName + ' GROUP BY  M_Postal, M_LName, M_FName, M_Street, M_SuiteNum)
and ltrim(rtrim(M_Street)) <> '''' and ltrim(rtrim(M_SuiteNum)) <> ''''  '

SET @chvCMD1 = @chvCMD1 + '
insert into #Dups
select rowId 
from ' + @chvTableName + '
where rowId not in
(select min(rowId) from ' + @chvTableName + ' GROUP BY  M_Postal, M_LName, M_FName, M_CivicNum, M_SuiteNum)
and ltrim(rtrim(M_CivicNum)) <> '''' and ltrim(rtrim(M_SuiteNum)) <> ''''  '

SET @chvCMD1 = @chvCMD1 + '
insert into #Dups
select rowId 
from ' + @chvTableName + '
where rowId not in
(select min(rowId) from ' + @chvTableName + ' GROUP BY  M_Postal, M_LName, M_FName, M_CivicNum, M_Street)
and ltrim(rtrim(M_CivicNum)) <> '''' and ltrim(rtrim(M_Street)) <> ''''  '

SET @chvCMD1 = @chvCMD1 + '
insert into #Dups
select rowId 
from ' + @chvTableName + '
where rowId not in
(select min(rowId) from ' + @chvTableName +' GROUP BY  M_Postal, M_LName, M_FName, M_General)
and ltrim(rtrim(M_General)) <> ''''  '

SET @chvCMD1 = @chvCMD1 + '
insert into #Dups
select rowId 
from ' + @chvTableName + '
where rowId not in
(select min(rowId) from ' + @chvTableName +' GROUP BY  M_Postal, M_LName, M_FName, M_POBox)
and ltrim(rtrim(M_POBox)) <> ''''  '

SET @chvCMD1 = @chvCMD1 + '
insert into #Dups
select rowId 
from ' + @chvTableName + '
where rowId not in
(select min(rowId) from ' +  @chvTableName + ' GROUP BY  M_Postal, M_LName, M_FName, M_Rural)
and ltrim(rtrim(M_Rural)) <> ''''  '

SET @chvCMD1 = @chvCMD1 + '
insert into #Dups
select rowId 
from ' + @chvTableName + '
where rowId not in
(select min(rowId) from ' + @chvTableName + ' GROUP BY  M_Postal, M_LName, M_FName, M_GD)
and ltrim(rtrim(M_GD)) <> ''''  '

SET @chvCMD1 = @chvCMD1 + '
delete ' + @chvTableName + '
from ' + @chvTableName + ' where rowId in ( select distinct  rowId from #Dups)  ' + 'drop table #Dups '

--print @chvCMD1
EXEC (@chvCMD1)
RETURN 0

GO
