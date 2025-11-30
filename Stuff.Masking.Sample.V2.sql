

--- POC
DECLARE @VXMLS VARCHAR(MAX) = '<lName>Test</lName>, <dob>2004-12-12</dob>, 	<gender>314</gender>, 	<dob>2005-12-13</dob>, 	<gender>314</gender>, 	<dob>2008-12-13</dob>, <gender>314</gender>';
IF PATINDEX('%<dob>%',@VXMLS) > 0  SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>'); PRINT @VXMLS;
IF PATINDEX('%<dob>%',@VXMLS) > 0  SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>'); PRINT @VXMLS;
IF PATINDEX('%<dob>%',@VXMLS) > 0  SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>'); PRINT @VXMLS;
IF PATINDEX('%<dob>%',@VXMLS) > 0  SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>'); PRINT @VXMLS;
IF PATINDEX('%<dob>%',@VXMLS) > 0  SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>'); PRINT @VXMLS;
SET @VXMLS = REPLACE(@VXMLS,'< dob>','<dob>'); --- Remove back the space
PRINT @VXMLS;
--- END POC

--- Sample on table
UPDATE [FinancePortalAudit].[dbo].[_TMP_AuditCreditApp] SET [ClobDataContent] = STUFF([ClobDataContent],PATINDEX('%<dob>%',[ClobDataContent]),21,'< dob>1800-12-12</dob>') WHERE PATINDEX('%<dob>%',[ClobDataContent]) > 0  and ISJSON(ClobDataContent)=0 AND CreatedDateTime < '2023-10-10';
UPDATE [FinancePortalAudit].[dbo].[_TMP_AuditCreditApp] SET [ClobDataContent] = STUFF([ClobDataContent],PATINDEX('%<dob>%',[ClobDataContent]),21,'< dob>1800-12-12</dob>') WHERE PATINDEX('%<dob>%',[ClobDataContent]) > 0  and ISJSON(ClobDataContent)=0 AND CreatedDateTime < '2023-10-10';
UPDATE [FinancePortalAudit].[dbo].[_TMP_AuditCreditApp] SET [ClobDataContent] = STUFF([ClobDataContent],PATINDEX('%<dob>%',[ClobDataContent]),21,'< dob>1800-12-12</dob>') WHERE PATINDEX('%<dob>%',[ClobDataContent]) > 0  and ISJSON(ClobDataContent)=0 AND CreatedDateTime < '2023-10-10';
UPDATE [FinancePortalAudit].[dbo].[_TMP_AuditCreditApp] SET [ClobDataContent] = STUFF([ClobDataContent],PATINDEX('%<dob>%',[ClobDataContent]),21,'< dob>1800-12-12</dob>') WHERE PATINDEX('%<dob>%',[ClobDataContent]) > 0  and ISJSON(ClobDataContent)=0 AND CreatedDateTime < '2023-10-10';
UPDATE [FinancePortalAudit].[dbo].[_TMP_AuditCreditApp] SET [ClobDataContent] = STUFF([ClobDataContent],PATINDEX('%<dob>%',[ClobDataContent]),21,'< dob>1800-12-12</dob>') WHERE PATINDEX('%<dob>%',[ClobDataContent]) > 0  and ISJSON(ClobDataContent)=0 AND CreatedDateTime < '2023-10-10';
UPDATE [FinancePortalAudit].[dbo].[_TMP_AuditCreditApp] SET [ClobDataContent] = REPLACE([ClobDataContent] ,'< dob>','<dob>'); --- Remove back the space


SELECT [ClobDataContent] FROM [FinancePortalAudit].[dbo].[_TMP_AuditCreditApp] WHERE ISJSON(ClobDataContent)=0;








