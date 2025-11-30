		
USE [RepositoryDB]
CREATE VIEW [LPS_V2]
AS
SELECT A.[addr_id]
      ,A.[address1]
      ,A.[address2]

      ,A.[Result_IndvMerge]
      ,A.[RowID]
      ,A.[SECONDHEAD]
      ,A.[seq_num]
      ,A.[suffix]
      ,A.[WorkingField]
      ,A.[RowIDMerged]
      ,A.[Result]
      ,A.[D_Address]

	  ,	(SELECT MAX(B.RowIDMerged) FROM 
			[RepositoryDB].[dbo].[VAL_LPS_IND_ADDRESS__Merged] B 
			WHERE B.DataSourceID='LPS_DE_ID_ONTARIO' AND A.result=B.result
		)	
		as CorrRowIDMergedforAddressID
	 ,	(SELECT MAX(B.RowIDMerged) FROM [RepositoryDB].[dbo].[VAL_LPS_IND_ADDRESS__Merged] B 
			WHERE B.DataSourceID='LPS_DE_ID_ONTARIO' AND A.[Result_IndvMerge]=B.[Result_IndvMerge]
		)	
		as CorrRowIDMergedforIndividualID
  FROM [RepositoryDB].[dbo].[VAL_LPS_IND_ADDRESS__Merged] A  WHERE A.DataSourceID='LPS_DE_UC_ONTARIO_BM'






USE [RepositoryDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [LPS_V3]
AS
SELECT A.*
	  ,B.[Orig_Fullname] AS ID_Orig_Fullname
      ,B.[phone1] as ID_phone1
      ,B.[indiv_id] as ID_indiv_id
      ,B.[addr_id] as ID_addr_id
      ,B.[addressln] as ID_addressln
      ,B.[city] as ID_city
      ,B.[province] as ID_province
      ,B.[postal] as ID_postal
      ,B.[cust_type] as ID_cust_type
      ,B.[indiv_id] as _IndividualID
	  ,C.[addr_id] as _AddressID

	  , CASE WHEN B.[indiv_id] is null 
		THEN  'OB'+CONVERT(CHAR(13),(Select  max(CONVERT(INT,SUBSTRING(M.[indiv_id],3,13))) from [RepositoryDB].[dbo].[VAL_LPS_IND_ADDRESS__Merged] M where LEFT(M.[indiv_id],2)='OB') 
			+(ROW_Number() over (ORDER BY B.[indiv_id]))) 
		ELSE	B.[indiv_id] 
		END 
		AS IndividualID
	  , CASE WHEN C.[addr_id] is null 
		THEN  'OB'+CONVERT(CHAR(13),(Select  max(CONVERT(INT,SUBSTRING(M.[addr_id],3,13))) from [RepositoryDB].[dbo].[VAL_LPS_IND_ADDRESS__Merged] M where LEFT(M.[Addr_id],2)='OB') 
			+(ROW_Number() over (ORDER BY C.[Addr_id]))) 
		ELSE	C.[Addr_id] 
		END 
		AS AddressID
	  , CASE WHEN B.RowIDMerged=(SELECT MAX(P.RowIDMerged) from [RepositoryDB].[dbo].[VAL_LPS_IND_ADDRESS__Merged] P where  P.phone1=B.phone1 AND P.DataSourceID='LPS_DE_ID_ONTARIO') -- Can be any other condition like QNCOA_MoveDate
			THEN 
					1
			ELSE	
					0
			END
		AS	 Flag_Phone_Condition8
  FROM [RepositoryDB].[CORNERSTONE2005\vnasqidashvili].[VAL_LPS_IND_ADD_MATCH] A
	LEFT JOIN [RepositoryDB].[dbo].[VAL_LPS_IND_ADDRESS__Merged] B
		On A.CorrRowIDMergedforIndividualID=B.RowIDMerged	
	LEFT JOIN [RepositoryDB].[dbo].[VAL_LPS_IND_ADDRESS__Merged] C
		On A.CorrRowIDMergedforAddressID=C.RowIDMerged
		
		
		
		
		
		
		
		
		
