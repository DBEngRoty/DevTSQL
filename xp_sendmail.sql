EXEC master.dbo.xp_sendmail @recipients = 'protariu@cstonecanada.com',   
@query = 'SELECT COUNT(*) AS QTY FROM ProspectPool.dbo.TMP_SCAVENGE ',   
@subject = 'Scavenge Left' ,    
@message = '',    
@attach_results = 'FALSE', 
@width = 250