# load assemblies
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Xml.XmlDocument")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.IO")

$Computer = 'selene'
$BackupPath = '\\pantheon\data\misc\Backups\Reporting'
$ReportServerUri = "http://$Computer/ReportServer/ReportService2010.asmx"
$Proxy = New-WebServiceProxy -Uri $ReportServerUri -Namespace SSRS.ReportingService2010 -UseDefaultCredential

#to check out all members of $Proxy
#$Proxy | Get-Member
#http://msdn.microsoft.com/en-us/library/aa225878(v=SQL.80).aspx

#get all reports
#second parameter means recursive
$items = $Proxy.ListChildren("/", $true) | Where-Object {$_.TypeName -eq "Report"}

#create a new folder where we will save the files
#PowerShell datetime format codes http://technet.microsoft.com/en-us/library/ee692801.aspx

#create a timestamped folder, format similar to 2011-Mar-28-0850PM
$folderName = Get-Date -format "yyyy-MM-dd"
$fullFolderName = "$($BackupPath)\$($Computer)\" + $folderName
[System.IO.Directory]::CreateDirectory($fullFolderName) | out-null

foreach($item in $items)
{

    #need to figure out if it has a folder name
    $subfolderName = split-path $item.Path
    $reportName = split-path $item.Path -Leaf
    $fullSubfolderName = $fullFolderName + $subfolderName
    if(-not(Test-Path $fullSubfolderName))
    {
        #note this will create the full folder hierarchy
        [System.IO.Directory]::CreateDirectory($fullSubfolderName) | out-null
    }
    
    $rdlFile = New-Object System.Xml.XmlDocument
    [byte[]] $reportDefinition = $null
    $reportDefinition = $Proxy.GetReportDefinition($item.Path)
    
    [System.IO.MemoryStream] $memStream = New-Object IO.MemoryStream(@(,$reportDefinition))
    $rdlFile.Load($memStream)
    
    #note here we're forcing the actual definition to be 
    #stored as a byte array
    #if you take out the @() from the MemoryStream constructor, you'll 
    #get an error
    $fullReportFileName = $fullSubfolderName + "\" + $item.Name +  ".rdl"

    #Write-Host $fullReportFileName;
    $rdlFile.Save( $fullReportFileName)

}

Write-Host "Done downloading your RDL files to $fullSubfolderName"
