/*  BufferCacaheHitRation
IF > 90% good 
IF < 90% bad - need mpre RAM
To take a look at how you can use this view to obtain systeminformation rather than running Windows Performance Monitor,
run the query. This query will return the Buffer Cache Hit Ratio for the current moment on the server.
The Buffer Cache Hit Ratio is the percentage ofpages requested by SQL Server that were found in memory. 
If all is well on yourserver, you will typically see this value at over 90%. 
If this value is muchlower than that, it means that your server is going to disk to retrieve datapages, and it may be a sign that your server needs more memory.
*/
SELECT      (CAST(SUM(CASE LTRIM(RTRIM(counter_name)) WHEN 'Buffer cache hit ratio' THEN CAST(cntr_value AS INTEGER) ELSE NULL END) AS FLOAT) /      CAST(SUM(CASE LTRIM(RTRIM(counter_name)) WHEN 'Buffer cache hit ratio base' THEN CAST(cntr_value AS INTEGER) ELSE NULL END) AS FLOAT)) * 100      AS BufferCacheHitRatio
FROM       sys.dm_os_performance_counters 
WHERE       LTRIM(RTRIM([object_name])) LIKE '%:Buffer Manager' AND       [counter_name] LIKE 'Buffer Cache Hit Ratio%'


/*
This dynamicmanagement function returns information regarding data and index information for data tables and views.
A field of particular interest returned from thisfunction is the avg_page_space_used_in_percent field,
which tells how full the data pages are. From the query, you find that the datapage is approximately .25 of 1% full. 
You can use this figure to develop routines to check the database tables and reindexthem as necessary, depending upon the criteria set in the routines.

*/
SELECT       OBJECT_NAME([object_id]),* 
FROM
sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID('DMVTest'),NULL,NULL, 'DETAILED')



/*
This view shows informationregarding each request occurring in the SQL Server instance. 
The informationprovided by this view is especially useful when you are investigating blockingon your server. The reads, writes, session settings, and blocking_session_idare some of the useful data returned from this view. The blocking_session_idcolumn indicates the session that is blocking the database request on thesystem. Later in the article, I will take a look at an example of how todetermine the statement the user is running that is blocking your request.
*/
SELECT * FROM sys.dm_exec_requests;


/*
See current activity
*/
SELECT       r.session_id,       r.blocking_session_id,       s.program_name,       s.host_name,        t.text
FROM      sys.dm_exec_requests r      INNER JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id      CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE      s.is_user_process = 1









