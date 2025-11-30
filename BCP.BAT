REM SAMPLE 1 - create XML format FILE FROM A GIVEN TABLE!
rem "C:\Program Files\Microsoft SQL Server\90\Tools\Binn\BCP.EXE" Test.dbo.Table1 format nul -T -c -x -f C:\Cur.xml
REM "C:\Program Files\Microsoft SQL Server\90\Tools\Binn\BCP.EXE" StageDB.dbo.EFX_Output format nul -T -c -x -f C:\EFX.xml

REM SAMPLE 3 Upload with a XML WITH A GIVEN xml
"C:\Program Files\Microsoft SQL Server\90\Tools\Binn\BCP.EXE" CustomerPool.dbo.FDR_CDCI_Transaction in "F:\Prototype System environment\txtInputFiles\ccd_cdci_txn.dat" -S CDI14 -T -f "F:\Prototype System environment\Bcp\ccd_kdw_txn.dat.xml"

"C:\Program Files (x86)\Microsoft SQL Server\90\Tools\Binn\BCP.EXE " StageDB.dbo.MailableFSA_LookUp format nul -T -c -x -f C:\FSA.xml


REM SAMPLE 2 - upload with a XML format WITH A GIVEN xml
"C:\Program Files\Microsoft SQL Server\90\Tools\Binn\BCP.EXE" Test.dbo.UploadWXML in WelcomeEmailCampaign.txt -T -f WelcomeEmailCampaignLoad.xml



