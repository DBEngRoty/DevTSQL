SELECT Total_Recs_In_Queue, Total_Recs_In_Queue_Parked, Total_to_procress, Total_procressing, Date_Time
FROM (
VALUES
	((SELECT COUNT(1) FROM ResponseDriver.dbo.CommandTasksQueue),
	(SELECT COUNT(1)  FROM ResponseDriver.dbo.CommandTasksQueue WHERE CommandTaskStatusID NOT IN (1,0)),
	(SELECT COUNT(1)  FROM ResponseDriver.dbo.CommandTasksQueue WHERE CommandTaskStatusID=0),
	(SELECT COUNT(1)  FROM ResponseDriver.dbo.CommandTasksQueue WHERE CommandTaskStatusID=1),
	(SELECT GETDATE()))
) AS T(Total_Recs_In_Queue,  Total_Recs_In_Queue_Parked, Total_to_procress, Total_procressing, Date_Time);