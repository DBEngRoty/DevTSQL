--UPDATE AEROPLAN_STAGE SET FLAG_AERO_INVALID_SCORE_VCL=0 WHERE LEN(FLAG_AERO_NEWMEMB)=8 AND SCORE_VCL IS NULL
--UPDATE AEROPLAN_STAGE SET FLAG_AERO_INVALID_SCORE_VIG=0 WHERE LEN(FLAG_AERO_NEWMEMB)=8 AND SCORE_VIG IS NULL

--SELECT FLAG_AERO_INVALID_SCORE_VIG, SCORE_VIG, FLAG_AERO_NEWMEMB FROM AEROPLAN WHERE SCORE_VIG IS NULL
--SELECT FLAG_AERO_INVALID_SCORE_VIG, COUNT(*) AS NUMB FROM AEROPLAN GROUP BY FLAG_AERO_INVALID_SCORE_VIG
--SELECT FLAG_AERO_INVALID_SCORE_VCL, COUNT(*) AS NUMB FROM AEROPLAN GROUP BY FLAG_AERO_INVALID_SCORE_VCL


--SELECT STAGEdb.DBO.udf_Flag_Aero_Invalid_WeightedRFM('0.2')
--UPDATE AEROPLAN_STAGE SET Flag_Aero_Invalid_WeightedRFM=0 WHERE Flag_Aero_Invalid_WeightedRFM=1
--CHECKPOINT

--UPDATE AEROPLAN_STAGE SET Flag_Aero_Invalid_WeightedRFM=STAGEdb.DBO.udf_Flag_Aero_Invalid_WeightedRFM(WEIGHTED_RFM)
--SELECT Flag_Aero_Invalid_WeightedRFM, COUNT(*) AS NUMB FROM AEROPLAN GROUP BY  Flag_Aero_Invalid_WeightedRFM
--UPDATE Aeroplan SET  Flag_Aero_OUT_EXCL_Business_Rules=0 WHERE Flag_Aero_OUT_EXCL_Business_Rules=1
--SELECT Flag_Aero_OUT_EXCL_Business_Rules, COUNT(*) AS NUMB FROM AEROPLAN GROUP BY Flag_Aero_OUT_EXCL_Business_Rules
--SELECT Flag_Aero_Invalid_Language, COUNT(*) AS NUMB FROM AEROPLAN_STAGE GROUP BY Flag_Aero_Invalid_Language

/*
UPDATE Aeroplan 
SET  Flag_Aero_OUT_EXCL_Business_Rules=1
WHERE 
	 Flag_Aero_Invalid_CUST_NB = 1 OR
	 Flag_Aero_Invalid_Language = 1 OR
	 Flag_Aero_Invalid_Flight_Level  = 1 OR
	 Flag_Aero_Invalid_Freq_Bucket  = 1 OR
	 Flag_Aero_Invalid_WeightedRFM =1 OR
	 Flag_Aero_Invalid_Tenure   =  1 OR
	 Flag_Aero_Invalid_ActivityIndicator   =  1 OR
	 Flag_Aero_Invalid_BOTTOM_BAL   =   1 OR
	 Flag_Aero_Invalid_BOTTOM_DAY   =  1 OR
	 Flag_Aero_Invalid_TOP_BAL   =   1 OR
	 Flag_Aero_Invalid_TOP_DAY   =  1 OR
	 Flag_Aero_Invalid_SCORE_VIG   =   1 OR
	 Flag_Aero_Invalid_SCORE_VCL   =  1 OR
	 Flag_Aero_Invalid_Email_FLG = 1 OR
	 Flag_Aero_Invalid_Email_History = 1 OR
	 Flag_Aero_Invalid_PREV_CONTACT = 1 OR
	 Flag_Aero_Invalid_TRIG1   =  1 OR
	 Flag_Aero_Invalid_TRIG2   =   1 OR
	 Flag_Aero_Invalid_TRIG3   =   1 OR
	 Flag_Aero_Invalid_TRIG4   =   1 OR
	 Flag_Aero_Invalid_TRIG5   =   1 OR
	 Flag_Aero_Invalid_TRIG6   =   1 OR
	 Flag_Aero_Invalid_TRIG7   =   1 OR
	 Flag_Aero_Invalid_TRIG8   =   1 OR
	 Flag_Aero_Invalid_TRIG9   =   1 OR
	 Flag_Aero_Invalid_TRIG10   =  1 OR
	 Flag_Aero_Invalid_TRIG11   =  1 OR
	 Flag_Aero_Invalid_TRIG12   =  1 OR
	 Flag_Aero_Invalid_TRIG13   =  1 OR
	 Flag_Aero_Invalid_TRIG14   =  1 OR
	 Flag_Aero_Invalid_TRIG15   =  1 OR
	 Flag_Aero_Invalid_TRIG16   =  1 OR
	 Flag_Aero_Invalid_TRIG17   =  1 OR
	 Flag_Aero_Invalid_TRIG18   =  1 OR
	 Flag_Aero_Invalid_TRIG19   =  1 OR
	 Flag_Aero_Invalid_TRIG20   =  1
*/