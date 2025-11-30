USE PROSPECTPOOL;

/*
TRUNCATE TABLE DedupedProspects;
truncate table InfoDirect
truncate table UCPhase2
truncate table UCPhase3
truncate table Application
truncate table Visa
truncate table Aeroplan_DM
truncate table Aeroplan_TM
truncate table Application_Dedups
truncate table EnhancedScan
truncate table RSMCustomer
truncate table aeroplan_tm
truncate table aeroplan_dm
truncate table VisaID_Inactive_History
truncate table Sources_History
truncate table ValidPhones
truncate table suppressions
truncate table sources
DELETE FROM ProspectAcquisitionDate
*/


DELETE FROM PROSPECT where prospectid<4000000
checkpoint
PRINT '4MIL '+CAST(GETDATE() AS CHAR)
DELETE FROM PROSPECT where prospectid<8000000
checkpoint
PRINT '8MIL '+CAST(GETDATE() AS CHAR)

DELETE FROM PROSPECT where prospectid<10000000
checkpoint
PRINT '10MIL '+CAST(GETDATE() AS CHAR)

DELETE FROM PROSPECT where prospectid<12000000
checkpoint
PRINT '12MIL '+CAST(GETDATE() AS CHAR)
DELETE FROM PROSPECT where prospectid<16000000
checkpoint
PRINT '16MIL '+CAST(GETDATE() AS CHAR)
DELETE FROM PROSPECT where prospectid<20000000
checkpoint
PRINT '20MIL '+CAST(GETDATE() AS CHAR)
DELETE FROM PROSPECT where prospectid<25000000
checkpoint
PRINT '25MIL '+CAST(GETDATE() AS CHAR)
DELETE FROM PROSPECT where prospectid<30000000
checkpoint
PRINT '30MIL '+CAST(GETDATE() AS CHAR)
DELETE FROM PROSPECT where prospectid<35000000
checkpoint
PRINT '35MIL '+CAST(GETDATE() AS CHAR)
DELETE FROM PROSPECT where prospectid<40000000
checkpoint
PRINT '40MIL '+CAST(GETDATE() AS CHAR)
DELETE FROM PROSPECT where prospectid<45000000
checkpoint
PRINT '45MIL '+CAST(GETDATE() AS CHAR)
DELETE FROM PROSPECT 
checkpoint
PRINT 'ALL '+CAST(GETDATE() AS CHAR)


USE STROREDB
TRUNCATE TABLE RPT_STATS_QCODE
TRUNCATE TABLE RPT_STATS_QNCOA





