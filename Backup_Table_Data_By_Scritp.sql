-- Scritp to get the data content from table

SELECT 'INSERT INTO  LCS.DBO.Task_X (Task_ID, Task_Name, Task_Group_Id, Dependency_Injection_Alias, Audit_Level, Created_Date_Time, Created_By, Last_Modified_date_Time, Last_Modified_By) VALUES ('
+CHAR(39) + CAST(task_id                      AS VARCHAR(100))+CHAR(39)+CHAR(44)+
+CHAR(39) + CAST(task_Name                    AS VARCHAR(100))+CHAR(39)+CHAR(44)+
+CHAR(39) + CAST([task_group_id]              AS VARCHAR(100))+CHAR(39)+CHAR(44)+
+CHAR(39) + CAST([dependency_injection_alias] AS VARCHAR(100))+CHAR(39)+CHAR(44)+
+CHAR(39) + CAST([audit_level]                AS VARCHAR(100))+CHAR(39)+CHAR(44)+
+CHAR(39) + CAST([created_date_time]          AS VARCHAR(100))+CHAR(39)+CHAR(44)+
+CHAR(39) + CAST([last_modified_date_time]    AS VARCHAR(100))+CHAR(39)+CHAR(44)+
+CHAR(39) + CAST([last_modified_by]           AS VARCHAR(100))+CHAR(39)+')' 
FROM LCS.[dbo].[task]; 

-- Next step is to truncate the altered tbales
-- Run the above generated scritp.
