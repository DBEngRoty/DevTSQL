---- Mask DOB with stuff !!!!!
DECLARE @VXMLS VARCHAR(MAX) = '<lName>Test</lName>, <dob>2004-12-12</dob>, 	<gender>314</gender>, 	<dob>2005-12-13</dob>, 	<gender>314</gender>, 	<dob>2008-12-13</dob>, <gender>314</gender>';


SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>');
SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>');
SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>');
SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>');
SET @VXMLS = STUFF(@VXMLS,PATINDEX('%<dob>%',@VXMLS),21,'< dob>1800-12-12</dob>');
SET @VXMLS = REPLACE(@VXMLS,'< dob>','<dob>'); --- Remove back the space

PRINT @VXMLS;
