BCP.EXE
  {[[database_name.][owner].]{table_name | view_name} | "query"}
    {in | out | queryout | format} data_file
    [-mmax_errors] [-fformat_file] [-x] [-eerr_file]
    [-Ffirst_row] [-Llast_row] [-bbatch_size]
    [-n] [-c] [-N] [-w] [-V (60 | 65 | 70 | 80)] [-6] 
    [-q] [-C { ACP | OEM | RAW | code_page } ] [-tfield_term] 
    [-rrow_term] [-iinput_file] [-ooutput_file] [-apacket_size]
    [-Sserver_name[\instance_name]] [-Ulogin_id] [-Ppassword]
    [-T] [-v] [-R] [-k] [-E] [-h"hint [,...n]"]


	
BCP.EXE " SELECT TransactionID,Ge_Account_Nbr, Ge_Sub_Business FROM StageDB.dbo.CCSDMerchantLevelSuppressions_Stage " queryout "F:\Prototype System environment\ExportDirectory\Export_Suppression_Merchant_File.txt"    -T  -c 

--bcp "select UniqueID as UniqueID from CAADB.CAA201105.Output where isnull(List_Code,'')<>'SEED' order by UniqueID" queryout "\\ws444\Public\abc.txt" -c -t, -T -S cdi12 -f "\\ws444\Public\abc.fmt"


--bcp "select UniqueID as UniqueID from CAADB.CAA201105.Output where isnull(List_Code,'')<>'SEED' order by UniqueID" format nul -c -t, -T -S cdi12 –the format file goes to the root folder where the bcp command started


--bcp "select Pers_Prefix,Q_ParsedAddress,Q_City,Kit_Code from CAADB.CAA201105.Output where isnull(List_Code,'')<>'SEED'" queryout "\\ws444\Public\abc.txt" -t, -T -S cdi12 -f "\\ws444\Public\abc_xml.fmt"

--WOKABLE BELLOW SAMPEL
  
 BCP.EXE "  SELECT CAST(TransactionID AS CHAR(20)), CAST(Ge_Account_Nbr AS CHAR(16)), CAST(Ge_Sub_Business AS CHAR(4))  FROM StageDB.dbo.CCSDMerchantLevelSuppressions_Stage    WHERE ReconciledFlag=0 and isnull(TransactionId,space(0))!=space(0)  "  queryout "F:\Prototype System environment\ExportDirectory\Export_Suppression_Merchant_File.txt"    -T   -f "F:\Prototype System environment\System Interface Descriptions\Export interfaces\To CCSD\system_export_CCSDMerchantSuppression_Stage.xml" 

 
 <?xml version="1.0"?>
<BCPFORMAT xmlns="http://schemas.microsoft.com/sqlserver/2004/bulkload/format" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">


<!--<systemexportjob name="CCSDMerchantLevelSuppressions_Stage" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="C:\CORNERSTONE\XML experiments\Prototype system environment - bcp\SSIS directory\SystemExportJob language schema.xsd">

 --export sample in fixed field

-->

<RECORD>
  <FIELD ID="1" xsi:type="CharFixed" LENGTH="20" />
  <FIELD ID="2" xsi:type="CharFixed" LENGTH="16" />
  <FIELD ID="3" xsi:type="CharTerm"  TERMINATOR="\r\n" MAX_LENGTH="4" />
</RECORD>
    
<ROW>
  <COLUMN SOURCE="1" NAME="TransactionID" xsi:type="SQLVARYCHAR"/>
  <COLUMN SOURCE="2" NAME="ge_account_nbr" xsi:type="SQLVARYCHAR"/>
  <COLUMN SOURCE="3" NAME="ge_sub_business" xsi:type="SQLVARYCHAR"/>
</ROW>

</BCPFORMAT>




--- !!! Import samle XML

<?xml version="1.0"?>
<BCPFORMAT xmlns="http://schemas.microsoft.com/sqlserver/2004/bulkload/format" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">



 <RECORD>
  <FIELD ID="1" xsi:type="CharTerm" TERMINATOR="\t" MAX_LENGTH="12"/>
  <FIELD ID="2" xsi:type="CharTerm" TERMINATOR="\t" MAX_LENGTH="12"/>
  <FIELD ID="3" xsi:type="CharTerm" TERMINATOR="\t" MAX_LENGTH="20" />
  <FIELD ID="4" xsi:type="CharTerm" TERMINATOR="\r\n" MAX_LENGTH="20" />
 </RECORD>


 <ROW>
  <COLUMN SOURCE="1" NAME="ID1" xsi:type="SQLINT"/>
  <COLUMN SOURCE="2" NAME="ID2" xsi:type="SQLINT"/>
  <COLUMN SOURCE="3" NAME="Value1" xsi:type="SQLNCHAR"/>
  <COLUMN SOURCE="4" NAME="Value2" xsi:type="SQLNCHAR"/>
 </ROW>
 
 
</BCPFORMAT>









