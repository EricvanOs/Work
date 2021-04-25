function Export-SSRSReports()
{
<#
    .SYNOPSIS
        Downloads report definitions from SSRS into a file structure. Should work with 2005, 2008, 2008 R2 and 2012.
    .DESCRIPTION
        Uses the ReportService2005 WSDL to return a definition of all the reports on a Reporting Services instance. It then writes these definitions to a file structure. This function is recursive from SourceFolderPath.
		The next step for development of this, would be to allow the reports to be piped into another function/cmdlet.
    .PARAMETER ReportServerName
		The Reporting Services server name (not the instance) from which to download the report definitions.
	.PARAMETER DestinationDirectory
		Destination directory (preferably empty!) to save the definitions to. If the folder does not exist it will be created.
	.PARAMETER SourceFolderPath
		The folder path to the location which reports need obtaining from (e.g. "/Financial Reports"). The function will recurse this location for reports.
	.PARAMETER reportServiceWebServiceURL
		The URL for the 'ReportServer' Web service. This is usually http://SERVERNAME/ReportServer, but this parameter allows you to override that if needs be.

    .EXAMPLE
        C:\PS> Export-SSRSReports -ReportServerName "localhost" `
									-DestinationDirectory "C:\SSRS_Reports\" `
									-SourceFolderPath "/Standard Reports"

#>
	Param 
	(
		[parameter(Mandatory=$True)][string] $ReportServerName,
		[parameter(Mandatory=$True)][string] $DestinationDirectory, 
		[parameter(Mandatory=$False)][string] $SourceFolderPath = "/",
		[parameter(Mandatory=$False)][string] $ReportServiceWebServiceURL = "http://$reportServerName/ReportServer/",
		[parameter(Mandatory=$False)][int] $SSRSVersion = 2008
	)

	# initialise variables
	$items = ''
	$WebServiceProxy = ''
	[string] $ReportServerUri = ''
	$item = ''

    [string] $status = "Get definition of reports from {0} to {1}`n`n" -f $reportServerName, $DestinationDirectory
    Write-Host $status
    Write-Progress -activity "Connecting" -status $status -percentComplete -1

    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Xml.XmlDocument")
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.IO")

	if ($ssrsVersion -gt 2005) 
	{
		# SSRS 2008/2012
		$reportServerUri = "$ReportServiceWebServiceURL/ReportService2010.asmx" -f $reportServerName
	} else {
		# SSRS 2005
		$reportServerUri = "$ReportServiceWebServiceURL/ReportService2005.asmx" -f $reportServerName
	}
	$WebServiceProxy = New-WebServiceProxy -Uri $reportServerUri -Namespace SSRS.ReportingService2005 -UseDefaultCredential

    #second parameter in ListChildren declares whether recursive or not.
	#2010 service uses the property TypeName rather than Type which the 2005 service uses.
	if ($ssrsVersion -gt 2005) {		 
		$items = $WebServiceProxy.ListChildren($sourceFolderPath, $true) | `
				 Select-Object TypeName, Path, ID, Name | `
				 Where-Object {$_.typeName -eq "Report"}
	} else {
		$items = $WebServiceProxy.ListChildren($sourceFolderPath, $true) | `
             Select-Object Type, Path, ID, Name | `
             Where-Object {$_.type -eq "Report"}
	}

	# If the local (destination) directory does not exist - create it.
    if(-not(Test-Path $destinationDirectory))
    {
        [System.IO.Directory]::CreateDirectory($destinationDirectory) | out-null
    }

	# Hold a count of items downloaded for our progress bar
    $downloadedCount = 0

    foreach($item in $items)
    {    
        #need to figure out if it has a folder name
        $subfolderName = split-path $item.Path
        $reportName = split-path $item.Path -Leaf
        $fullSubfolderName = $destinationDirectory + $subfolderName;

        $percentDone = (($downloadedCount/$items.Count) * 100)        
        Write-Progress -activity ("Downloading from {0}{1}" -f $reportServerName, $subFolderName) -status $reportName -percentComplete $percentDone

        if(-not(Test-Path $fullSubfolderName))
        {
            #note this will create the full folder hierarchy
            [System.IO.Directory]::CreateDirectory($fullSubfolderName) | out-null
        }

        $rdlFile = New-Object Xml.XmlDocument
        [byte[]] $reportDefinition = $null;
		if ($ssrsVersion -gt 2005) {
			$reportDefinition = $WebServiceProxy.GetItemDefinition($item.Path)
		} else {
			$reportDefinition = $WebServiceProxy.GetReportDefinition($item.Path)
		}

        [System.IO.MemoryStream] $memStream = New-Object IO.MemoryStream(@(,$reportDefinition))
        $rdlFile.Load($memStream)

        $fullReportFileName = $fullSubfolderName + "\" + $item.Name +  ".rdl"

        $rdlFile.Save( $fullReportFileName)
        Write-Host " *`t$subfolderName\$reportName.rdl" -foregroundColor White
        $downloadedCount += 1
    }

	Write-Host "`n`nDownloaded $downloadedCount reports from $reportServerName $subfolderName to $fullSubfolderName" -foreground green
}



