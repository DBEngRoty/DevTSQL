-- SP_MSFOREACHTABLE is an undocumented SP
-- Just run the below command in a database
-- SQL 2K5 OR ABOVE ONLY

EXEC SP_MSFOREACHTABLE 'SELECT "?",COUNT(*) FROM ?'