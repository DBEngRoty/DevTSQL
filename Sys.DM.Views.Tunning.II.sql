/*
Overview
Dynamic Management Views (DMVs) were a giant leap forward for SQL Server in the 2005 release.   
DMVs provide a simple and familiar relational interface for gathering critical system information from your SQL Server.
This document will focus on a handful of DMVs that I have found most useful for isolating performance issues.
Prerequisites
There are a few things you should know about DMVs before we get started.
1)      First you can’t use DMVs without “Dynamic Management Functions” (DMFs).   The two are inseparable.   Both behave as their names imply.  DMVs present the data.  DMFs are called when additional processing is needed.  Table functions are accessed via the new OUTER/CROSS APPLY operator.  There will be two examples of DMFs presented later in this document.
2)      It is also important to understand the concept of a “handle”.  They play a big role in DMVs.  A handle is a SQL Server system generated hash value that takes the place of some large value (text, xml, etc.).  The data type for a handle is typically varbinary(64).  DMVs use handles instead of the actual text for performance reasons. 
The two most widely used handles are:
o   sql_handle - Hash value of a sql statement.  This value is guaranteed to be unique.  As a matter of fact, SQL Server will always generate the same sql_handle on any server for a specific query.   This value is extremely useful for comparing query activity across servers using the DMVs described below.
o   plan_handle - Hash value of the execution plan for the current sql_handle.

DMV/DMF Overview
The remainder of this document will focus on a handful DMVs (and DMFs) that I have found most useful.  I have also included suggestions on how best to use them.  
Query Execution Statistics (DMV) - sys.dm_exec_query_stats
Overview
This is arguably the most important DMV.  For the first time, we now have a direct view into a SQL Server's plan cache.   We can now see what queries have been cached and for how long.  We also have easy access to aggregated totals such as how many times a query has been executed, the average CPU for each execution, etc.    
Best Practices
ü  This view is a much faster alternative to Profiler for isolating performance issues.  If you can get exclusive access to an environment, free the SQL Server procedure cache (via DBCC FREEPROCCACHE) then repro the workflow in question.  When complete, the results of this DMV will contain aggregated performance statistics for all queries executed.  (If you do not have exclusive access, just filter by the “last_execution_time” column).
ü  It’s generally a good idea to archive the results of this view periodically.   Historical data will give you insight into troubleshooting future performance issues.   For example, if a query is misbehaving out of the blue, check your historical data to see how it has behaved in the past.  Is the query new?  If not, is the query being executed more than normal?
ü  If your database server is suffering from chronic CPU issues, isolate your worst offending queries by querying this view ordered by total_worker_time in descending order.  (If the CPU spiked recently then include last_execution_time > [start time of issue], etc.)
ü  If your query is not showing up in this DMV, its most likely being forced to “recompile” every time.  Recompiled queries are never left in cache.  To confirm, run a trace against the server with StmtRecompile enabled.
ü  If you are monitoring a stored procedure that executes multiple sql statements, keep in mind there will be multiple rows returned in this view.  SQL Server 2005 breaks up procedure calls into individual SQL statements then caches each separately.  
ü  The Performance Dashboard is a very effective tool to access the data in this DMV (and others).  You should be familiar with it and use it whenever you can but you must also be aware of the fact there are limitations with it.  It’s designed to handle typical scenarios not all scenarios.  This DMV (and others) have more flexibility with accessing the underlying data.   Here are a few examples:  1) in the dashboard you cannot view all queries within specific time ranges.  2) Large SQL strings are hard to read.  3) Data on the screen is a hard to save and analyze at a later date.  4) It’s also hard to compare query activity across servers, etc. 
Notes
When a compiled plan is removed from cache, the rows corresponding to query plan are deleted from the DMV.  
This DMV is updated only after the query execution is completed successfully.
Sample Queries


The following query pulls the top 10 worst CPU consuming queries on the SQL Server (since the last time the server was restarted)
*/ 

SELECT TOP 10
        sql.text as sql
      , qp.query_plan
   , creation_time
   , last_execution_time
   , execution_count
   , (total_worker_time / execution_count) as avg_cpu
   , total_worker_time as total_cpu
   , last_worker_time as last_cpu
   , min_worker_time as min_cpu
   , max_worker_time as max_cpu
   , (total_physical_reads + total_logical_reads) as total_reads
   , (max_physical_reads + max_logical_reads) as max_reads
   , (total_physical_reads + total_logical_reads) / execution_count as avg_reads
   , max_elapsed_time as max_duration
   , total_elapsed_time as total_duration
   , ((total_elapsed_time / execution_count)) / 1000000 as avg_duration_sec
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(sql_handle) sql
CROSS APPLY sys.dm_exec_query_plan (plan_handle) qp
ORDER BY qs. total_worker_time DESC
 
--*Note: dm_exec_sql_text & dm_exec_query_plan will be discussed in more detail in the next sections
 

 

SQL Text (DMF) - sys.dm_exec_sql_text
 
/*
Overview
 As mentioned above, for performance reasons DMVs refer to SQL statements by their “sql_handle” only.  Use this function if you need to retrieve the SQL text for a given handle.   
 This DMF accepts either the sql_handle or plan_handle as input criteria.
Notes
 This DMF (and others) will not work in a database with 8.0 (SQL Server 2000) compatibility enabled.  
 To get around this, execute your query from a system database (such as master) then refer to the DMF using a three-part name.  For example:  CROSS APPLY yourdatabase. sys.dm_exec_sql_text(plan_handle).
Sample Queries
ü  Examples of this DMF can be found in the “Query Execution Statistics” and “Requests” sections.
*/

/*
Query Execution Plan (DMF) - sys.dm_exec_query_plan
Overview
This DMF returns the Showplan (or “execution plan”) in XML format for the batch specified by the plan handle. The plan specified by the plan handle can either be cached or currently executing.
Best Practices
ü  Execution plans in XML format are hard to read.  To view graphically in “Management Studio”, do the following:  1) When returning data from this function, SQL Server automatically creates a hyperlink for the showplan XML, 2) Click hyperlink to bring up the document in the Internet Explorer, 3) Do File-Save As to your local drive with a .SQLPLAN file extension, 4) Go back to SQL Management Studio and open document saved above.
ü  SQL Server builds the query plan for a query based on the parameters entered during the execution of the first query.  This is commonly known as “Parameter Sniffing”.  All subsequent requests use this plan regardless of their own parameter combinations.  A bad combination of parameters for the first execution can cause issues with subsequent requests.  The parameters used to “seed” the execution plan are saved in the execution plan XML.  This data can be extremely helpful if you suspect a query is generating different query plans depending on the initial criteria entered.  If you find one set of parameters work better than another, create an “OPTIMIZE FOR” plan guide to force this parameter combination.
ü  It is a good idea to archive the execution plan xml from your most heavily used queries every month or two.  This data can be retrieved if performance goes sour at a later date.  This historical data will allow you to do side-by-side comparisons of query plans before and after the event enabling you to quickly pinpoint the cause.  Worse comes to worse, if you are unable to regenerate the old plan again, there is always the option of forcing the old saved plan via a plan guide, especially in SQL 2008.
ü  Generating the execution plan XML is a fairly CPU intensive process.  Tread lightly when using this function on production servers.  For example, keep query results below 100-500 records, etc.
Sample Queries
ü  Examples of this DMF can be found in the “Query Execution Statistics” section.
*/

/*
Missing Indexes (DMV/DMF) - sys.dm_db_missing_index_details
Overview
When SQL Server generates a query plan, it analyzes what are the best indexes for a particular filter condition.  If these indexes do not exist, the query optimizer generates a suboptimal query plan then stores information about the optimal indexes for later retrieval. The missing indexes feature enables you to access this data so you can decide whether these optimal indexes should be implemented at a later date.
*/ 

/*
Here’s a quick overview of the different Missing Index DMVs/DMFs
-          sys.dm_db_missing_index_details (DMV) – Returns indexes the optimizer considers are missing.
-          sys.dm_db_missing_index_columns (DMF) - Returns the columns for a missing index.
-          sys.dm_db_missing_index_group_stats (DMV) - Returns usage and access details for the missing indexes similar to sys.dm_db_index_usage_stats .

Best Practices
SQL Server is not that smart.  Never blindly implement indexes suggested in this view.  
Before implementing, create recommended indexes on a test server then do your best to simulate a typical workload (via a trace replay, etc).  
You should confirm new indexes are being used and with positive results.  
If you introduce an index that is not being used, you are wasting disk space and more importantly you are potentially increasing compile time for all queries against the table in question.
These DMVs will take a while to be populated.  You should check these views only after your server has been up and running for a while. 
If this view is empty, you're not missing any indexes that are obvious enough for the SQL Server to detect. 

Sample Query
The following query returns a prioritized list of the missing indexes in the current database.
*/
 

SELECT so.name
   , (avg_total_user_cost * avg_user_impact) * (user_seeks + user_scans) as Impact
   , mid.equality_columns
   , mid.inequality_columns
   , mid.included_columns
FROM sys.dm_db_missing_index_group_stats AS migs 
INNER JOIN sys.dm_db_missing_index_groups AS mig ON migs.group_handle = mig.index_group_handle 
INNER JOIN sys.dm_db_missing_index_details AS mid ON mig.index_handle = mid.index_handle 
INNER JOIN sys.objects so WITH (nolock) ON mid.object_id = so.object_id
WHERE migs.group_handle IN (
   SELECT     TOP (5000) group_handle
   FROM sys.dm_db_missing_index_group_stats WITH (nolock)
   ORDER BY (avg_total_user_cost * avg_user_impact) * (user_seeks + user_scans) DESC)
 

 
/*
Index Usage Statistics (DMV) - sys.dm_db_index_usage_stats
 Overview
 This view reports aggregated totals for all indexes in the current database.   With this view, we not only know if its being used but how it’s being used.  We now know the number of times a index has been involved in a seek (user_seeks), a scan (user_scans ),or a bookmark lookup (user_lookups) .   
Best Practices
 An index is not being used and can be removed from the server if its corresponding user_seeks + user_scans + user_lookups = 0.  Note you should never blindly drop indexes without testing first.  For example all indexes have statistics behind them.   It is possible the query optimizer is still using the statistics behind your unused index and not the index itself.
 Removing unused indexes could be a large performance improvement.  1) Indexes slow down inserts/updates/deletes.  2) Indexes slow down compile times for all queries accessing the table in question.  3) SQL Server will make a best guess for an execution plan after a certain period of time.   If you have too many indexes on a table, you are increasing the chances for the optimizer to give up before reaching the optimal index. 
 When defragging indexes, most users prioritize indexes based on data from sys.dm_db_index_physical_stats only.   This DMV is only part of the picture.  Why rebuild an index that is not used?  Why rebuild an index that will not benefit from a rebuild?  Per Paul Randal from SQL Skills.com (formerly SQL Server project team), “there’s little to be gained by removing fragmentation of indexes that are not involved in range scans”.   When prioritizing indexes, you should also pay close attention to the “user_scan” column in sys.dm_db_index_usage_stats.  The higher the value, the higher the priority to rebuild and/or reorganize.
 Like most DMVs, the data is lost after SQL is restarted.  It’s a good idea to periodically archive this DMV. 

 Sample Queries
 1)      This query finds all unused indexes in the current database.
*/
 
select t.name as TableName
     , i.name as IndexName
from sys.indexes i
inner join sys.dm_db_index_usage_stats s on s.object_id = i.object_id and s.index_id = i.index_id
inner join sys.tables t on i.object_id = t.object_id
where ((user_seeks = 0 and user_scans = 0 and user_lookups = 0) or s.object_id is null)
 

--2)      This query builds a list of indexes that could benefit from ALTER INDEX REBUILD or ALTER INDEX REGORGANIZE. 


select t.name as TableName
     , i.name as IndexName
from sys.indexes i
inner join sys.dm_db_index_usage_stats s on s.object_id = i.object_id and s.index_id = i.index_id
inner join sys.tables t on i.object_id = t.object_id
inner join #frag_indexes f on i.object_id = f.object_id and i.index_id = f.index_id
order by s.user_scans desc, f.priority asc
 

--Note #frag_indexes was generated/prioritized above based on data from sys.dm_db_index_physical_stats.  Code was not included for readability.

/* 
System Requests (DMV) - sys.dm_exec_requests
Overview
The System Requests DMV displays information regarding each request occurring on the SQL Server.   
This view combined with the sessions DMV (sys.dm_exec_sessions) are basically a “selectable” version of “sp_who2” with a lot more columns to choose from and of course a lot more control over the records you are viewing.  

Best Practices
Ever wonder when a long task is going to finish?  The percent_complete & estimated_completion_time columns in this view will allow you to estimate the completion times for the following events:  ALTER INDEX REORGANIZE, ROLLBACK, BACKUP DATABASE , DBCC CHECKDB, DBCC SHRINKDATABASE, and DBCC SHRINKFILE.
For users who want more control over block monitoring, this view is good alternative to sp_blocker and sp_who2.   Requests are blocked by the SPIDs identified in the blocking_session_id column.   However, you must be careful joining blocking_session_id back to sys.dm_exec_requests.  It is possible for a record to be blocked by a SPID that no longer exists in sys.dm_exec_requests.  For example, if the blocking query is complete but a transaction is left open, etc.
Sample Queries
1)      This query finds all active queries with estimated completion time (if available)
*/

select e.session_id
    , sql.text
    , e.start_time
    , s.login_name
    , s.nt_user_name
    , e.percent_complete
    , e.estimated_completion_time
from sys.dm_exec_requests e
join sys.dm_exec_sessions s on e.session_id = s.session_id
cross apply sys.dm_exec_sql_text(plan_handle) sql
where e.status = 'running'
 

--2)      This query finds all active queries with estimated completion time (if available)

 
select er.session_id as spid
   , sql.text as sql
   , er.blocking_session_id as block_spid
   , case when erb.session_id is null then 'unknown' else sqlb.text end as block_sql
   , er.wait_type
   , (er.wait_time / 1000) as wait_time_sec
FROM sys.dm_exec_requests er
LEFT OUTER JOIN sys.dm_exec_requests erb on er.blocking_session_id = erb.session_id
CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) sql
CROSS APPLY sys.dm_exec_sql_text(isnull(erb.sql_handle,er.sql_handle)) sqlb
where er.blocking_session_id > 0
 
