-- Add Pers API Extended Procedures.Sql
--
--   Adds the Personator API extended stored procedures to SQL Server.
--
-- SQL Server 2000:
--   Replace 'c:\persapi\sqlpersdll.dll' with just 'sqlpersdll.dll'
--   You must copy these files:
--
--     PersDll32.Dll
--     pSortNt.Dll
--     SqlPersDll.Dll
--
--   into the \Binn\ directory in your SQL Server 2000 installation.
--
-- SQL Server 7:
--   Replace 'c:\persapi\sqlpersdll.dll' with the location where you installed the Personator API.
--   Be sure to keep the sqlpersdll.dll file name at the end!
--
-- Change 'public' in the 'grant...' to change executtion rights to specific users or groups.

declare @persapi varchar(256)
set @persapi='c:\persapi\sqlpersdll.dll'

execute sp_addextendedproc 'PersRegister', @persapi
execute sp_addextendedproc 'PersVersion', @persapi
execute sp_addextendedproc 'PersFileLoc', @persapi
execute sp_addextendedproc 'PersLastError', @persapi
execute sp_addextendedproc 'PersInitName', @persapi
execute sp_addextendedproc 'PersAddNameConnector', @persapi
execute sp_addextendedproc 'PersSplitName', @persapi
execute sp_addextendedproc 'PersCloseName', @persapi
execute sp_addextendedproc 'PersInitGenderizer', @persapi
execute sp_addextendedproc 'PersGenderize', @persapi
execute sp_addextendedproc 'PersCloseGenderizer', @persapi
execute sp_addextendedproc 'PersInitSalutation', @persapi
execute sp_addextendedproc 'PersSalutate', @persapi
execute sp_addextendedproc 'PersCloseSalutation', @persapi
execute sp_addextendedproc 'PersInitStreet', @persapi
execute sp_addextendedproc 'PersSplitStreet', @persapi
execute sp_addextendedproc 'PersCloseStreet', @persapi
execute sp_addextendedproc 'PersInitCSZ', @persapi
execute sp_addextendedproc 'PersSplitCSZ', @persapi
execute sp_addextendedproc 'PersCloseCSZ', @persapi

grant execute on PersRegister to public
grant execute on PersVersion to public
grant execute on PersFileLoc to public
grant execute on PersLastError to public
grant execute on PersInitName to public
grant execute on PersAddNameConnector to public
grant execute on PersSplitName to public
grant execute on PersCloseName to public
grant execute on PersInitGenderizer to public
grant execute on PersGenderize to public
grant execute on PersCloseGenderizer to public
grant execute on PersInitSalutation to public
grant execute on PersSalutate to public
grant execute on PersCloseSalutation to public
grant execute on PersInitStreet to public
grant execute on PersSplitStreet to public
grant execute on PersCloseStreet to public
grant execute on PersInitCSZ to public
grant execute on PersSplitCSZ to public
grant execute on PersCloseCSZ to public
