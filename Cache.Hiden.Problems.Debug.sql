


-- 1) Hidden Cache Problem - for sql 2005
SELECT SUM(single_pages_kb+multi_pages_kb) AS "CurrentSizeOfTokenCache(kb)"
FROM sys.dm_os_memory_clerks
WHERE [name] ='TokenAndPermUserStore'
 
--Under 10MB - OK, 10MB - 50MB - warm, over 50MB - problem
--Fix: install SP3 for SQL 2005
--See articles in Internet like: the size of the TokenAndPermUserStore - long running queries