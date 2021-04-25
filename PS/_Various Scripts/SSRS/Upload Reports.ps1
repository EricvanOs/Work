<#
.SYNOPSIS
    Bulk import SSRS Reports from a folder and update the reports data source.
.DESCRIPTION
    This script takes all the RDL files in a folder and imports them into a SSRS and updates the reports data source to the Configmgr shared data source.
.NOTES
    File Name  : Upload Reports.ps1
    Version    : 1.03 ,05.jan-2015
    Author     : Thomas Larsen - thomas.larsen@tromsfylke.no
    Requires   : Version 3
.LINK
    Blog
      http://larsenconfigmgr.blogspot.com

.PARAMETER webServiceUrl
Base URL to the report server ,usualy the Configmgr Site server

.PARAMETER reportFolder
 Report Server folder where the reports are imported to, the script creates the folder if it's not there.
 
.PARAMETER SourceDirectory
The local folder where the .rdl files are located.

.Example
& '.\Upload Reports.ps1' -webServiceUrl "http://Reportserver.domain.local" -reportFolder "Larsen Reports -SourceDirectory "c:\ReportsToUpload"

#>
 

Param(
  [Parameter(Mandatory=$True)]
   [string]$webServiceUrl,
	
   [Parameter(Mandatory=$True)]
   [string]$reportFolder,

   [Parameter(Mandatory=$True)]
   [string]$SourceDirectory
   )

#$webServiceUrl = "http://reportserver.domain.local"
#$reportFolder = "Larsen Reports"
#$SourceDirectory = "C:\ReportstoUpload"

$ErrorActionPreference = "Continue"
Write-Host "Thomas Larsen - Januar 2015 - http://larsenconfigmgr.blogspot.com" -ForegroundColor Cyan
Write-Host "This Script is provided AS-IS, no warrenty is provided" 
Write-host ""

#Connect to SSRS
Write-Host "Reportserver: $webServiceUrl" -ForegroundColor Magenta
Write-Host "Creating Proxy, connecting to : $webServiceUrl/ReportServer/ReportService2005.asmx?WSDL"
Write-Host ""
$ssrsProxy = New-WebServiceProxy -Uri $webServiceUrl'/ReportServer/ReportService2010.asmx?WSDL' -UseDefaultCredential
$reportPath = "/"


#######
#Get Configmgr shared datasource
$Items = $ssrsProxy.listchildren("/", $true) | where {$_.Type -eq "Datasource" }
foreach ($item in $items)
{
#Check to see if Datasource name patches Guid Pattern
if ($item.name -match '{([a-zA-Z0-9]{8})-([a-zA-Z0-9]{4})-([a-zA-Z0-9]{4})-([a-zA-Z0-9]{4})-([a-zA-Z0-9]{12})}' -and $item.path -like '/ConfigMgr*')
{
Write-Host "Datasource:" $item.Name -ForegroundColor Magenta  
Write-host "Type:" $item.Type 
Write-Host "Path:" $item.Path

#Save parameters for later use.
$DatasourceName = $item.Name
$DatasourcePath = $item.Path
}}


##########################################    
#Create Folder
        Write-host ""
        try
        {
            $ssrsProxy.CreateFolder($reportFolder, $reportPath, $null)
            Write-Host "Created new folder: $reportFolder"
        }
        catch [System.Web.Services.Protocols.SoapException]
        {
            if ($_.Exception.Detail.InnerText -match "[^rsItemAlreadyExists400]")
            {
                Write-Host "Folder: $reportFolder already exists."
            }
            else
            {
                $msg = "Error creating folder: $reportFolder. Msg: '{0}'" -f $_.Exception.Detail.InnerText
                Write-Error $msg
            }
        }


#############################
#For each RDL file in Folder

foreach($rdlfile in Get-ChildItem $SourceDirectory -Filter *.rdl)
{
Write-host ""


#ReportName
 $reportName = [System.IO.Path]::GetFileNameWithoutExtension($rdlFile);
 write-host $reportName -ForegroundColor Green 
 #Upload File
     try
    {
        #Get Report content in bytes
        Write-Host "Getting file content of : $rdlFile"
        $byteArray = gc $rdlFile.FullName -encoding byte
        $msg = "Total length: {0}" -f $byteArray.Length
        Write-Host $msg
 
        $reportFolder = $reportPath + $reportFolder
        Write-Host "Uploading to: $reportFolder"
 
        #Call Proxy to upload report
        $warnings = $ssrsProxy.CreateReport($reportName,$reportFolder,$force,$byteArray,$null) 
        if($warnings.Length -le 1) { Write-Host "Upload Success." -ForegroundColor Green }
        else { write-host $warnings | % { Write-Warning "Warning: $_" }}
  
    }
    catch [System.IO.IOException]
    {
        $msg = "Error while reading rdl file : '{0}', Message: '{1}'" -f $rdlFile, $_.Exception.Message
        Write-Error msg
    }
    catch [System.Web.Services.Protocols.SoapException]
	{
            if ($_.Exception.Detail.InnerText -match "[^rsItemAlreadyExists400]")
            {
                Write-Error "Report: $reportName already exists." 
            }
            else
            {
                $msg = "Error uploading report: $reportName. Msg: '{0}'" -f $_.Exception.Detail.InnerText
                Write-Error $msg
            }
		
	}



##Change Datasource
$rep = $ssrsProxy.GetItemDataSources($reportFolder+"/"+$reportName)
$rep | ForEach-Object {
$proxyNamespace = $_.GetType().Namespace
    $constDatasource = New-Object ("$proxyNamespace.DataSource")
    $constDatasource.Name = $DataSourceName
    $constDatasource.Item = New-Object ("$proxyNamespace.DataSourceReference")
    $constDatasource.Item.Reference = $DataSourcePath

$_.item = $constDatasource.Item
$ssrsProxy.SetItemDataSources($reportFolder+"/"+$reportName, $_)
Write-Host "Changing datasource `"$($_.Name)`" to $($_.Item.Reference)"
}

#Something in the foreach loop keeps adding forward slashes to the parameter evertime it runs. 
#Strips slashes from the parameter.  
$reportFolder = $reportFolder -replace "/",""
}

Write-host ""
Write-host "Finished" -ForegroundColor Magenta
Write-host ""