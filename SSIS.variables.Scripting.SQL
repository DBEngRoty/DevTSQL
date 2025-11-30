Imports System
Imports System.Data
Imports System.Math
Imports Microsoft.SqlServer.Dts.Runtime

Public Class ScriptMain
      Public Sub Main()
        Dim strFolder As String
        Dim strFilename As String
        Dim strTomorrow As String
        Dim strNewFullPath As String


        'do path in script
        strFolder = Dts.Variables("FolderName").Value.ToString
        strFilename = Dts.Variables("FileName").Value.ToString()
        strTomorrow = CStr(Format(Today().AddDays(+1), "yyyyMMdd"))
  strNewFullPath = strFolder & strFilename.Substring(0,    strFilename.IndexOf(".txt")) & "_" & strTomorrow & ".txt"
        'display new value of path 
        'MsgBox(strNewFullPath)
        Dts.Variables("FullPath").Value = strNewFullPath
        Dts.TaskResult = Dts.Results.Success
      End Sub


End Class

 

