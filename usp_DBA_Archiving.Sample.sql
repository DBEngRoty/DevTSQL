USE [FinancePortal]
GO
/****** Object:  StoredProcedure [dbo].[usp_DBA_Archiving_FinancePortal]    Script Date: 2022-12-12 8:52:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		protariu
-- Create date: 2022-Dec
-- Description:	Archiving Credit Driver
-- See Jira: FIN-10370
-- A tables, child tables to CreditApp
-- B table, Credit App table, child to Contact table
-- C tables: Contcat table
-- =============================================
ALTER   PROCEDURE [dbo].[usp_DBA_Archiving_FinancePortal]
AS
BEGIN
SET NOCOUNT ON;

---- Tests
---- Clean archive ----- TESTS
/*
TRUNCATE TABLE [FinancePortalArchive].DBO.[CLOBDATA];
TRUNCATE TABLE [FinancePortalArchive].DBO.[Contact];
TRUNCATE TABLE [FinancePortalArchive].DBO.[ContactRep];
TRUNCATE TABLE [FinancePortalArchive].DBO.[ContractDetails];
TRUNCATE TABLE [FinancePortalArchive].DBO.[CreditApp];
TRUNCATE TABLE [FinancePortalArchive].DBO.[CreditAppApplicant];
TRUNCATE TABLE [FinancePortalArchive].DBO.[CreditAppDecision];
TRUNCATE TABLE [FinancePortalArchive].DBO.[CreditAppStatusChangeLog];
TRUNCATE TABLE [FinancePortalArchive].DBO.[CreditAppSubmission];
TRUNCATE TABLE [FinancePortalArchive].DBO.[FundDecision];
TRUNCATE TABLE [FinancePortalArchive].DBO.[MsgSendReceiveLog]
TRUNCATE TABLE [FinancePortalArchive].DBO.[NetSolCalculatedResult]
TRUNCATE TABLE [FinancePortalArchive].DBO.[NotificationQueue]
TRUNCATE TABLE [FinancePortalArchive].DBO.[OutboundQueue]
*/


----- A1. ClobData
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[ClobData]; -- Start 244132
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[ClobData]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[ClobData]) SELECT @VM; SELECT @VS+@VM; 

*/
WITH AppsToArchive (CLOBID) AS 
(
SELECT TOP(1000) V.CLOBID FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[ClobData] AS FP_CD ON V.ClobID = FP_CD.ClobId LEFT JOIN
[FinancePortalArchive].DBO.[ClobData] AS FPA_CD ON FP_CD.ClobId = FPA_CD.ClobId
)
INSERT INTO [FinancePortalArchive].DBO.[ClobData]
([ClobId], [ClobData], [LastModifiedDateTime], [LastModifiedById], [LastModifiedByName])
SELECT 
 [ClobId], [ClobData], [LastModifiedDateTime], [LastModifiedById], [LastModifiedByName]
FROM [FinancePortal].[dbo].[ClobData] CD 
WHERE
CD.ClobId IN (SELECT CLOBID FROM AppsToArchive) AND CD.ClobId NOT IN (SELECT CLOBID FROM [FinancePortalArchive].DBO.[ClobData]);
--- Clean UP ---- SEEE TRIGGERS WHEN MANY ROWS RETURNS - DISBALE TRIGGERS
DELETE FROM [FinancePortal].DBO.[ClobData] WHERE  CLOBID IN (SELECT DISTINCT CLOBID FROM  [FinancePortalArchive].DBO.[ClobData]);
------------ END ClobData -------------------------



----- A2. CreditAppApplicant
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditAppApplicant]; -- Start 72413
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditAppApplicant]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[CreditAppApplicant]) SELECT @VM; SELECT @VS+@VM; 

*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[CreditAppApplicant] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[CreditAppApplicant] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[CreditAppApplicant]
([CreditApplicantId], [CreditAppId], [SeqNo], [IsActive], [IsCommercial], [ApplicantTypeRefId], [CompanyName], [FirstName], [LastName], [Phone1], [Phone2], [OfficePhone], [Email], [MasterContactId], [MasterDealerContactId])
SELECT 
 [CreditApplicantId], [CreditAppId], [SeqNo], [IsActive], [IsCommercial], [ApplicantTypeRefId], [CompanyName], [FirstName], [LastName], [Phone1], [Phone2], [OfficePhone], [Email], [MasterContactId], [MasterDealerContactId]
FROM [FinancePortal].[dbo].[CreditAppApplicant] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[CreditAppApplicant] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[CreditAppApplicant]);
------------------------ END CreditAppApplicant -------------------------------------

----- A3. ContractDocumentSigned
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[ContractDocumentSigned]; -- Start 312
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[ContractDocumentSigned]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[ContractDocumentSigned]) SELECT @VM; SELECT @VS+@VM; 
*/

WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[ContractDocumentSigned] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[ContractDocumentSigned] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[ContractDocumentSigned]
([DocumentId], [DocumentCategoryRefId], [DocumentTypeRefId], [CreditAppId], [SignedDate], [Signed], [DocumentName], [DocumentContent], [LastModifiedDateTime], [LastModifiedById], [LastModifiedByName])
SELECT 
 [DocumentId], [DocumentCategoryRefId], [DocumentTypeRefId], [CreditAppId], [SignedDate], [Signed], [DocumentName], [DocumentContent], [LastModifiedDateTime], [LastModifiedById], [LastModifiedByName]
FROM [FinancePortal].[dbo].[ContractDocumentSigned] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[ContractDocumentSigned] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[ContractDocumentSigned]);
------------------------ END ContractDocumentSigned -------------------------------------


----- A4. CreditAppDecision
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditAppDecision]; -- Start 64393
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditAppDecision]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[CreditAppDecision]) SELECT @VM; SELECT @VS+@VM; 
*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[CreditAppDecision] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[CreditAppDecision] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[CreditAppDecision]
([DecisionId], [CreditAppId], [CreditAppStatusRefId], [RawDataClobId], [IsNew], [FullRequestHash], [ActionDateTime], [CreatedDateTime], [CreatedById], [CreatedByName], [CreditScore])
SELECT 
 [DecisionId], [CreditAppId], [CreditAppStatusRefId], [RawDataClobId], [IsNew], [FullRequestHash], [ActionDateTime], [CreatedDateTime], [CreatedById], [CreatedByName], [CreditScore]
FROM [FinancePortal].[dbo].[CreditAppDecision] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[CreditAppDecision] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[CreditAppDecision]);
------------------------ END CreditAppDecision -------------------------------------




----- A5. CreditAppSubmission
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditAppSubmission]; -- Start 57338
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditAppSubmission]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[CreditAppSubmission]) SELECT @VM; SELECT @VS+@VM;
*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[CreditAppSubmission] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[CreditAppSubmission] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[CreditAppSubmission]
([SubmissionId], [CreditAppId], [TypeRefId], [RawDataClobId], [LoggingClobId], [CreatedDateTime], [CreatedByUserId], [CreatedByName])
SELECT 
 [SubmissionId], [CreditAppId], [TypeRefId], [RawDataClobId], [LoggingClobId], [CreatedDateTime], [CreatedByUserId], [CreatedByName]
FROM [FinancePortal].[dbo].[CreditAppSubmission] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[CreditAppSubmission] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[CreditAppSubmission]);
------------------------ END CreditAppSubmission -------------------------------------




----- A6. FundDecision
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[FundDecision]; -- Start 4072
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[FundDecision]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[FundDecision]) SELECT @VM; SELECT @VS+@VM;
*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[FundDecision] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[FundDecision] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[FundDecision]
([FundId], [CreditAppId], [CreditAppStatusRefId], [RawDataClobId], [IsNew], [FullRequestHash], [ActionDateTime], [CreatedDateTime], [CreatedById], [CreatedByName])
SELECT 
 [FundId], [CreditAppId], [CreditAppStatusRefId], [RawDataClobId], [IsNew], [FullRequestHash], [ActionDateTime], [CreatedDateTime], [CreatedById], [CreatedByName]
FROM [FinancePortal].[dbo].[FundDecision] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[FundDecision] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[FundDecision]);
------------------------ END FundDecision -------------------------------------


----- A7. NetSolCalculatedResult
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[NetSolCalculatedResult]; -- Start 2399
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[NetSolCalculatedResult]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[NetSolCalculatedResult]) SELECT @VM; SELECT @VS+@VM;
*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[NetSolCalculatedResult] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[NetSolCalculatedResult] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[NetSolCalculatedResult]
([ID], [CreditAppId], [LenderID], [ClobData], [CreatedById], [CreatedByUser], [CreatedDateTime], [LastModifiedDateTime], [LastModifiedById], [LastModifiedByUser], [Message])
SELECT 
 [ID], [CreditAppId], [LenderID], [ClobData], [CreatedById], [CreatedByUser], [CreatedDateTime], [LastModifiedDateTime], [LastModifiedById], [LastModifiedByUser], [Message]
FROM [FinancePortal].[dbo].[NetSolCalculatedResult] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[NetSolCalculatedResult] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[NetSolCalculatedResult]);
------------------------ END NetSolCalculatedResult -------------------------------------




----- A8. [CreditAppStatusChangeLog]
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditAppStatusChangeLog]; -- Start 26211
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditAppStatusChangeLog]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[CreditAppStatusChangeLog]) SELECT @VM; SELECT @VS+@VM;
*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[CreditAppStatusChangeLog] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[CreditAppStatusChangeLog] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[CreditAppStatusChangeLog]
([LogId], [CreditAppId], [CreditAppStatusId], [CreatedDateTime], [CreatedById], [CreatedByName], [DecisionId], [SubmissionId], [FundId])
SELECT 
[LogId], [CreditAppId], [CreditAppStatusId], [CreatedDateTime], [CreatedById], [CreatedByName], [DecisionId], [SubmissionId], [FundId]
FROM [FinancePortal].[dbo].[CreditAppStatusChangeLog] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[CreditAppStatusChangeLog] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[CreditAppStatusChangeLog]);
------------------------ END CreditAppStatusChangeLog -------------------------------------


----- A9.[MsgSendReceiveLog]
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[MsgSendReceiveLog]; -- Start 7961
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[MsgSendReceiveLog]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[MsgSendReceiveLog]) SELECT @VM; SELECT @VS+@VM;
*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[MsgSendReceiveLog] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[MsgSendReceiveLog] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[MsgSendReceiveLog]
([MessageId], [CreditAppId], [MessageTypeRefId], [MessageStatusRefId], [IsNew], [FullRequestHash], [MessageContent], [ActionDatetime], [CreatedDateTime], [CreatedById], [CreatedByName], [ReaderById], [ReaderByName])
SELECT 
 [MessageId], [CreditAppId], [MessageTypeRefId], [MessageStatusRefId], [IsNew], [FullRequestHash], [MessageContent], [ActionDatetime], [CreatedDateTime], [CreatedById], [CreatedByName], [ReaderById], [ReaderByName]
FROM [FinancePortal].[dbo].[MsgSendReceiveLog] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[MsgSendReceiveLog] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[MsgSendReceiveLog]);
------------------------ END MsgSendReceiveLog -------------------------------------



----- A10.[ContractDetails]
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[ContractDetails]; -- Start 23168
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[ContractDetails]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[ContractDetails]) SELECT @VM; SELECT @VS+@VM; 
*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[ContractDetails] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[ContractDetails] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[ContractDetails]
([CreditAppID], [MarketingProgramDetailID], [MSRP], [BaseSellingPrice], [Freight], [PDI], [TaxesAndLevies], [AdminFee], [ExtendedWarranty], [OtherAftermarket], [OtherAftermarketDesc], [LifeInsurance], [AccidentAndHealthInsurance], [CriticalIllnessInsruance], [OtherInsurance], [OtherInsuranceDesc], [Rebate], [DownPayment], [DPaymentAndRebateGSTHSTAmount], [DPaymentAndRebatePSTAmount], [TradeInAllowance], [LienOwing], [TotalCosts], [TotalReductions], [AmortizationAmount], [SecondPaymentDate], [DeliveryDate], [TaxReductionID], [GSTHSTRateID], [PSTRateID], [GSTHSTAmount], [PSTAmount], [PaymentFreqRefID], [CurrentOdometer], [AdditionalKMRefID], [LenderLeaseTypeID], [TotalPermittedKM], [TotalAnnualKM], [TotalMonthlyKM], [EndingOdometer], [ResidualAdjustment], [Residual], [BasePayment], [NumberOfPayments], [TotalPaymentAmount], [FirstPaymentAmount], [ProRataRentAmount], [PPSAFees], [SecurityDeposit], [SecurityDepositWaiver], [LicenseFeeAmount], [OtherNonCapitalizedFeeAmount], [OtherNonCapitalizedFeeDec], [TotalCashOnSigningAmmount], [LenderVehicleID], [GSTHSTRateManual], [PSTRateManual], [Program], [ContractID], [GSTHSTAmountOnPPSA], [PSTAmountOnPPSA], [GSTHSTOnProRataRent], [PSTOnProRataRent], [GSTHSTRateIDOnReserve], [PSTRateIDOnReserve], [GSTHSTAmountOnReserve], [PSTAmountOnReserve], [GSTHSTAmountOnAmountAmortized], [PSTAmountOnAmountAmortized], [FirstPaymentDate], [BasePaymentSubjToGSTAmt], [BasePaymentSubjToPSTAmt], [TotalAmtBorrowed], [BorrowingUnderGSTHSTLOC], [TaxableRebate], [GSTHSTOnRebate], [PSTOnRebate], [ReserveReimbursement], [GSTHSTOnReserveReimbursement], [TotalReserveReimbursement], [TotalDealerReservePayment], [BorrowingUnderWholesaleFundingLOC], [TireTaxAmount], [GSTHSTOnTireTax], [PSTOnTireTax], [NumOfTires], [borrowingUnderDealerReserveLOC])
SELECT 
 [CreditAppID], [MarketingProgramDetailID], [MSRP], [BaseSellingPrice], [Freight], [PDI], [TaxesAndLevies], [AdminFee], [ExtendedWarranty], [OtherAftermarket], [OtherAftermarketDesc], [LifeInsurance], [AccidentAndHealthInsurance], [CriticalIllnessInsruance], [OtherInsurance], [OtherInsuranceDesc], [Rebate], [DownPayment], [DPaymentAndRebateGSTHSTAmount], [DPaymentAndRebatePSTAmount], [TradeInAllowance], [LienOwing], [TotalCosts], [TotalReductions], [AmortizationAmount], [SecondPaymentDate], [DeliveryDate], [TaxReductionID], [GSTHSTRateID], [PSTRateID], [GSTHSTAmount], [PSTAmount], [PaymentFreqRefID], [CurrentOdometer], [AdditionalKMRefID], [LenderLeaseTypeID], [TotalPermittedKM], [TotalAnnualKM], [TotalMonthlyKM], [EndingOdometer], [ResidualAdjustment], [Residual], [BasePayment], [NumberOfPayments], [TotalPaymentAmount], [FirstPaymentAmount], [ProRataRentAmount], [PPSAFees], [SecurityDeposit], [SecurityDepositWaiver], [LicenseFeeAmount], [OtherNonCapitalizedFeeAmount], [OtherNonCapitalizedFeeDec], [TotalCashOnSigningAmmount], [LenderVehicleID], [GSTHSTRateManual], [PSTRateManual], [Program], [ContractID], [GSTHSTAmountOnPPSA], [PSTAmountOnPPSA], [GSTHSTOnProRataRent], [PSTOnProRataRent], [GSTHSTRateIDOnReserve], [PSTRateIDOnReserve], [GSTHSTAmountOnReserve], [PSTAmountOnReserve], [GSTHSTAmountOnAmountAmortized], [PSTAmountOnAmountAmortized], [FirstPaymentDate], [BasePaymentSubjToGSTAmt], [BasePaymentSubjToPSTAmt], [TotalAmtBorrowed], [BorrowingUnderGSTHSTLOC], [TaxableRebate], [GSTHSTOnRebate], [PSTOnRebate], [ReserveReimbursement], [GSTHSTOnReserveReimbursement], [TotalReserveReimbursement], [TotalDealerReservePayment], [BorrowingUnderWholesaleFundingLOC], [TireTaxAmount], [GSTHSTOnTireTax], [PSTOnTireTax], [NumOfTires], [borrowingUnderDealerReserveLOC]
FROM [FinancePortal].[dbo].[ContractDetails] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[ContractDetails] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[ContractDetails]);
------------------------ END MsgSendReceiveLog -------------------------------------


----- A11.OutboundQueue  ----- 
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[OutboundQueue]; -- Start 144675
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[OutboundQueue]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[OutboundQueue]) SELECT @VM; SELECT @VS+@VM;  
*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[OutboundQueue] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[OutboundQueue] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[OutboundQueue]
([OutboundQueueId], [MessageTypeRefId], [MessageStatusRefId], [CreditAppId], [CreditAppStatusRefId], [ClobId], [InboundMessageId], [LoggingClobId], [DestinationId], [RetryCount], [ScheduledSendDateTime], [ErrorMessage], [CreatedDateTime], [CreatedById], [LastModifiedDateTime])
SELECT 
[OutboundQueueId], [MessageTypeRefId], [MessageStatusRefId], [CreditAppId], [CreditAppStatusRefId], [ClobId], [InboundMessageId], [LoggingClobId], [DestinationId], [RetryCount], [ScheduledSendDateTime], [ErrorMessage], [CreatedDateTime], [CreatedById], [LastModifiedDateTime]
FROM [FinancePortal].[dbo].[OutboundQueue] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[OutboundQueue] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[OutboundQueue]);
------------------------ END OutboundQueue -------------------------------------



----- A12.NotificationQueue  ----- 
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[NotificationQueue]; -- Start 139979
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[NotificationQueue]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[NotificationQueue]) SELECT @VM; SELECT @VS+@VM;  
*/
WITH AppsToArchive (CreditAppId) AS
(
SELECT TOP(1000) V.CreditAppId FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V INNER JOIN 
[FinancePortal].[dbo].[NotificationQueue] AS FP_CAA ON V.CreditAppId = FP_CAA.CreditAppId LEFT JOIN
[FinancePortalArchive].DBO.[NotificationQueue] AS FPA_CAA ON FP_CAA.CreditAppId = FPA_CAA.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[NotificationQueue]
([NotificationQueueId], [MessageTypeRefId], [MessageStatusRefId], [CreditAppId], [InboundMessageId], [RetryCount], [ScheduledSendDateTime], [ErrorMessage], [CreatedDateTime], [CreatedById], [LastModifiedDateTime])
SELECT 
[NotificationQueueId], [MessageTypeRefId], [MessageStatusRefId], [CreditAppId], [InboundMessageId], [RetryCount], [ScheduledSendDateTime], [ErrorMessage], [CreatedDateTime], [CreatedById], [LastModifiedDateTime]
FROM [FinancePortal].[dbo].[NotificationQueue] WHERE CreditAppId IN (SELECT CreditAppId FROM AppsToArchive);
--- Clean UP
DELETE FROM [FinancePortal].DBO.[NotificationQueue] WHERE CreditAppId  IN (SELECT CreditAppId FROM  [FinancePortalArchive].DBO.[NotificationQueue]);
------------------------ END NotificationQueue -------------------------------------



----- B1.[CreditApp]  ----- 
/*
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditApp]; -- Start 51951
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[CreditApp]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[CreditApp]) SELECT @VM; SELECT @VS+@VM;  
*/
;
WITH AppsToArchive ([CreditAppId]) AS
(
SELECT TOP(100) V.[CreditAppId] FROM  [FinancePortal].[dbo].[vw_CreditAppsIDsToArchive] AS V 
LEFT JOIN  [FinancePortalArchive].DBO.[CreditApp] AS FPACA ON V.CreditAppId = FPACA.CreditAppId
LEFT JOIN  [FinancePortal].DBO.[FundDecision] FPFD ON V.CreditAppId = FPFD.CreditAppId
)
INSERT INTO [FinancePortalArchive].DBO.[CreditApp]
([CreditAppId], [ContactId], [CreditAppStatusRefId], [LenderId], [InternalRefNo], [LenderRefNo], [ContractNo], [VehicleYear], [VehicleMake], [VehicleModel], [VehicleStockNo], [VehicleVIN], [ClobId], [CreatedById], [CreatedDateTime], [LastModifiedDateTime], [LastModifiedById], [LastModifiedByName], [ExternalLeadId], [ExternalBatchId], [IsDeleted])
SELECT 
 [CreditAppId], [ContactId], [CreditAppStatusRefId], [LenderId], [InternalRefNo], [LenderRefNo], [ContractNo], [VehicleYear], [VehicleMake], [VehicleModel], [VehicleStockNo], [VehicleVIN], [ClobId], [CreatedById], [CreatedDateTime], [LastModifiedDateTime], [LastModifiedById], [LastModifiedByName], [ExternalLeadId], [ExternalBatchId], [IsDeleted]
FROM [FinancePortal].[dbo].[CreditApp] WHERE
CreditAppId IN (SELECT CreditAppId FROM AppsToArchive) AND 
CreditAppId NOT IN (SELECT CreditAppId FROM [FinancePortalArchive].DBO.[CreditApp]
);

--LEFT JOIN [FinancePortal].DBO.[FundDecision] FPFD ON CA.CreditAppId = FPFD.CreditAppId)
--WHERE CA.[CreditAppId] NOT IN (SELECT [CreditAppId] FROM [FinancePortalArchive].DBO.[CreditApp]

--- Clean UP
DELETE FROM [FinancePortal].DBO.[CreditApp] WHERE 
[CreditAppId]  IN     (SELECT [CreditAppId] FROM  [FinancePortalArchive].DBO.[vw_CreditAppsIDs_Dependants]) AND 
[CreditAppId]  NOT IN (SELECT [CreditAppId] FROM  [FinancePortal].DBO.[vw_CreditAppsIDs_Dependants]);
------------------------ END CreditApp -----------------------------------------------------------------------------------------------------------





----- C1.[ContactRep]  ----- 
/*  
SELECT TOP(10) * FROM [FinancePortal].DBO.[ContactRep];
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[ContactRep]; -- Start 98366
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[ContactRep]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[ContactRep]) SELECT @VM; SELECT @VS+@VM; 
*/
WITH AppsToArchive (ContactRepId) AS
(
SELECT TOP(1000) FPCR.ContactRepId FROM  [FinancePortal].[dbo].[ContactRep] AS FPCR
INNER JOIN [FinancePortal].DBO.[Contact] AS FPC ON FPCR.ContactId = FPC.ContactId
INNER JOIN [FinancePortal].DBO.[vw_CreditAppsIDsToArchive] AS V ON FPCR.ContactId = V.ContactId
LEFT JOIN  [FinancePortalArchive].DBO.[ContactRep] AS FPACR ON FPCR.ContactRepId = FPACR.ContactRepId
LEFT JOIN  [FinancePortal].[dbo].[CreditApp] AS FPCA ON FPCR.ContactId = FPCA.ContactId
)
INSERT INTO [FinancePortalArchive].DBO.[ContactRep]
([ContactRepId], [ContactId], [RepID], [IsOwner])
SELECT 
 [ContactRepId], [ContactId], [RepID], [IsOwner]
FROM [FinancePortal].[dbo].[ContactRep] WHERE ContactRepId IN (SELECT ContactRepId FROM AppsToArchive);
--- Clean UP

DELETE FROM [FinancePortal].DBO.[ContactRep] WHERE ContactRepId  IN (SELECT ContactRepId FROM  [FinancePortalArchive].DBO.[ContactRep]);
------------------------ END Contact -------------------------------------





----- C2.[Contact]  ----- 
/*  
SELECT TOP(10) * FROM [FinancePortal].DBO.[Contact];
SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[Contact]; -- Start 98404
DECLARE @VS INT =(SELECT COUNT(1) AS QTY FROM [FinancePortal].DBO.[Contact]); SELECT @VS;
DECLARE @VM INT =(SELECT COUNT(1) AS QTY FROM [FinancePortalArchive].DBO.[Contact]) SELECT @VM; SELECT @VS+@VM; 
*/
WITH AppsToArchive (ContactId) AS
(
SELECT TOP(1000) FPC.ContactId FROM  [FinancePortal].[dbo].[Contact] AS FPC
LEFT JOIN [FinancePortal].[dbo].[CreditApp] AS FPCA ON FPC.ContactId = FPCA.ContactId
LEFT JOIN [FinancePortalArchive].DBO.[Contact] AS FPAC ON FPC.ContactId = FPAC.ContactId 
LEFT JOIN [FinancePortal].[dbo].[ContactRep] AS FPCR ON FPC.ContactId = FPCR.ContactId
)
INSERT INTO [FinancePortalArchive].DBO.[Contact]
([ContactId], [RDContactId], [ContactTypeRefId], [SciDealerId], [CompanyName], [FirstName], [LastName], [CreatedDateTime], [CreatedById], [LastModifiedbyId], [LastModifiedByName], [MasterContactID])
SELECT 
 [ContactId], [RDContactId], [ContactTypeRefId], [SciDealerId], [CompanyName], [FirstName], [LastName], [CreatedDateTime], [CreatedById], [LastModifiedbyId], [LastModifiedByName], [MasterContactID]
FROM [FinancePortal].[dbo].[Contact] WHERE ContactId IN (SELECT ContactId FROM AppsToArchive) AND ContactId NOT IN (SELECT ContactId FROM [FinancePortalArchive].DBO.[Contact]);
--- Clean UP

DELETE FROM [FinancePortal].DBO.[Contact] WHERE
ContactId IN (SELECT ContactId FROM  [FinancePortalArchive].DBO.[Contact]) AND
ContactId NOT IN (SELECT ContactId FROM  [FinancePortal].DBO.[CreditApp]) AND
ContactId NOT IN (SELECT ContactId FROM  [FinancePortal].DBO.[ContactRep]);
------------------------ END Contact -------------------------------------

-- Test
/*
EXEC [FinancePortal].[dbo].[usp_DBA_Archiving_FinancePortal];



*/
END
;