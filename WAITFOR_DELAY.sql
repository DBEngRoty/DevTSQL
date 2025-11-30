-- Using WAITFOR DELAY

-- The following example executes the stored procedure after a two-hour delay.  
BEGIN  
    WAITFOR DELAY '02:00';  
    EXECUTE sp_helpdb;  
END;  
GO  

