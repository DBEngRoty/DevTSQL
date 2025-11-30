SELECT
object_name(a.object_id) AS table_name,
COALESCE(name, 'table with no clustered index') AS index_name,
type_desc AS index_type, user_seeks,user_scans,user_lookups,user_updates  
FROM sys.dm_db_index_usage_stats a INNER JOIN sys.indexes b  ON a.index_id = b.index_id  AND a.object_id = b.object_id 
WHERE database_id = DB_ID('ProspectPool')   AND a.object_id > 1000

/*
If you find that certain indexes are seldom used but are frequently updated, this indicates that that index's cost outweighs its benefits. 
You should consider removing such indexes and potentially adding indexes on other columns. 
*/
