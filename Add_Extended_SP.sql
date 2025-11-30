-- ADD
EXEC sp_dropextendedproc xp_qcodebase
EXEC sp_addextendedproc xp_qcodebase, 'xp_qcode.dll'

EXEC sp_dropextendedproc xp_ssqcodebase
EXEC sp_addextendedproc  xp_ssqcodebase, 'xp_ssqcode.dll'

EXEC sp_dropextendedproc xp_ssncoabase
EXEC sp_addextendedproc  xp_ssncoabase, 'xp_ssncoa.dll'
-- DROP