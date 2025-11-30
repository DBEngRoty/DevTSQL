--Call QNCOA API function
--protariu 20060215


CREATE PROCEDURE usp_STDQNCOAFullApp (@vTable VARCHAR(100), @vSwitch Smallint)


AS

IF @vSwitch=1

BEGIN

	DECLARE @vCMD varchar(3000);  SET @vCMD=SPACE(1);

	SET @vCMD = @vCMD + '  UPDATE ' + @vTable + ' SET WorkingField= MASTER.dbo.NCOA_GetTotal(LEFT(RTRIM(PERS_FNAME)+SPACE(1)+RTRIM(PERS_LNAME),30),Q_ParsedAddress,Q_City,Q_Province, Q_PostalCode)  WHERE Q_CorrectStatus IN ('+'''V'',''C'',''N'',''O'',''W'',''D'''+');  '

	SET @vCMD = @vCMD + '  UPDATE ' + @vTable + ' SET 
				QNCOA_COANType=Substring(WorkingField,1,1), 				
				QNCOA_NixxieFlag=Substring(WorkingField,10,1), 			
				QNCOA_NewAddress=Substring(WorkingField,11,80), 		
				QNCOA_NewCity=Substring(WorkingField,91,30), 			
				QNCOA_NewPostalCode=Substring(WorkingField,121,6), 			
				QNCOA_NewProvince=Substring(WorkingField,130,2), 		
				QNCOA_Country=Substring(WorkingField,145,15), 				
				QNCOA_MoveType=Substring(WorkingField,160,1), 				
				QNCOA_SERPStatus=Substring(WorkingField,161,1), 				
				QNCOA_Status=CAST(Substring(WorkingField,162,6) AS SmallInt) 
				 WHERE Q_CorrectStatus IN ('+'''V'',''C'',''N'',''O'',''W'',''D'''+');  '

	SET @vCMD = @vCMD + '  UPDATE ' + @vTable + ' SET 
				QNCOA_MoveDate=CAST(SUBSTRING(WORKINGFIELD,2,8) AS DATETIME)
				WHERE QNCOA_STATUS=1;  '

	EXEC (@vCMD);

END
GO