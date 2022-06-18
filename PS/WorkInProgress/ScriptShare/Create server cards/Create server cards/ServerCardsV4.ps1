
<#
	.AUTHOR
		Marco Baars

	.MAIL
		marco.baars@cygnific.com

	.PURPOSE
		Update groups for OpenFire chat solution based on department

	.PARAMETERS
		No parameters required

	.DATE
		11-10-2013

	.VERSION
		1

#>

##################################################################################################################################################################
# Variables : Configure these to your needs
##################################################################################################################################################################

$savepath = "\\cyg7006\Data\ict\System management\Documents\Server cards\" # Path where cards are saved to. IMPORTANT: leave a trailing backslash at end of path

$Domains = @("corp.local","cygnific.corp.local") # Collect all servers for these domains

$wordtemplatepath = "C:\Tasks\Create server cards\ServerCard.dotx" # Path to the Word document template


##################################################################################################################################################################
# Important note:
# Windows 2003 servers need to have the “WMI Windows Installer Provider” installed to collect installed software
# http://blogs.msdn.com/b/wmi/archive/2009/09/16/wmi-remote-query-for-win32-product-class-results-in-generic-failure-error-0x80041001.aspx
##################################################################################################################################################################

cls # Clear screen

#region Load snappins
if (Get-PSSnapin -Name quest.activeroles.admanagement 2>$null) {}
else    {Add-PSSnapin -Name quest.activeroles.admanagement}
#endregion

#region Functions.

$ServerArray = @() # Collect servernames
foreach ($Domain in $Domains)
	{
	  Write-Output $Domain
	  connect-QADService -service $Domain
	  $ServerArray += Get-QADComputer -SearchRoot ($Domain + '/') -OSName '*Server*'-LdapFilter '(!(userAccountControl:1.2.840.113556.1.4.803:=2))' | Select Name,OperatingSystem,Description   # Filter out disabled computer accounts
	}

# Import function for displaying dialogs
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')  # Load assembly needed for the confirmation dialog (for debugging purposes)

# Functions for setting up the Word document

function PreReq # Check if Word is installed
{
	if ((Test-Path  REGISTRY::HKEY_CLASSES_ROOT\Word.Application) -eq $False){
		Write-Host "This script directly outputs to Microsoft Word, please install Microsoft Word"
		exit
	}
	Else
	{
		Write-Host "Microsoft Word Detected"
	}

	$wordrunning = (Get-Process 'WinWord' -ea SilentlyContinue)
	if ( $wordrunning -eq ""){
		Write-Host "Please close all instances of Microsoft Word before running this report."
		exit
	}
	else
	{
	}
}

function InsertTitle ($title)
{
	# Insert Document Title Information
	$objSelection = $msWord.Selection
	$objSelection.Style = "Heading 1"
	$objSelection.TypeText($Title)
	$msword.Selection.EndKey(6)  > Null
	$objSelection.TypeParagraph()
	$msword.Selection.EndKey(6)  > Null
}

function InsertHeader ($title)
{
	# Insert Document Title Information
	$objSelection = $msWord.Selection
	$objSelection.Style = "Heading 3"
	$objSelection.TypeText($Title)
	$msword.Selection.EndKey(6)  > Null
	$objSelection.TypeParagraph()
	$msword.Selection.EndKey(6)  > Null
}

function InsertText ($text)
{
	# Insert Document text
	$objSelection = $msWord.Selection
	$objSelection.Style = "Normal"
	$objSelection.TypeText($text)
	$msword.Selection.EndKey(6)  > Null
	$objSelection.TypeParagraph()
	$msword.Selection.EndKey(6)  > Null
}


function TableOutput ($Heading, $columnHeaders, $columnProperties, $contents)
{
	Write-Host "Creating $Heading Table...Please Wait"
	
	# Number of columns
	$columnCount = $columnHeaders.Count

	# Insert Table Heading
	$Title = $Heading
	InsertTitle $title

	# Create a new table
	$docTable = $wordDoc.Tables.Add($wordDoc.Application.Selection.Range,$contents.Count,$columnCount)

	# Insert the column headers into the table
	for ($col = 0; $col -lt $columnCount; $col++) {
    	$cell = $docTable.Cell(1,$col+1).Range
    	$cell.Font.Name="Arial"
    	$cell.Font.Bold=$true
    	$cell.InsertAfter($columnHeaders[$col])
	}
	$doctable.Rows.Add() > Null

	# Load the data into the table
	$i = 1
	$j = $contents.Count
	for($row = 2; $row -lt ($contents.Count + 2); $row++){
  		if($row -gt 2){
  	}
  	for ($col = 1; $col -le $columnCount; $col++){
		Write-Progress -Activity "Processing Table Information" -Status "Adding Row entry $i of $j" -PercentComplete (100*$i/$j)
    	$cell = $docTable.Cell($row,$col).Range
    	#$cell.Font.Name="Arial"
		$cell.Font.Name="Calibri"
    	$cell.Font.Size="11"
    	$cell.Font.Bold=$FALSE
		$cell.Text = $contents[$row-2].($columnProperties[$col-1])
  	}
	$i++
	}

	# Table style
	$doctable.Style = "Table List 4"
	#$docTable.Columns.AutoFit()  # Optional, does size table to content
	$objSelection = $msWord.Selection
	$msword.Selection.EndKey(6)  > Null
	$objSelection.TypeParagraph()
	$msword.Selection.EndKey(6)  > Null

}
$date = Get-date
Prereq

#endregion

#region Query servers and create Word document.


# Now start collecting data 

# Process all servers
foreach ($Server in $ServerArray)
{
$computer = $Server.Name
$description = $Server.Description
##################################################################################################################################################
		 
	
# [Microsoft.VisualBasic.Interaction]::MsgBox("Create card for  " + $computer) # For debugging purposes

# Collect all server data
$namespace = "root\CIMV2" 

$ComputerInfo = Get-WmiObject -class Win32_ComputerSystem -computername $computer -namespace $namespace
$OS = Get-WmiObject -class Win32_OperatingSystem -computername $computer -namespace $namespace
$CPUs = Get-WmiObject -class Win32_Processor -computername $computer -namespace $namespace
$Disks = Get-WmiObject -class Win32_LogicalDisk -computername $computer -namespace $namespace | Select-Object "Caption","FileSystem","Size","FreeSpace","Description"
$Nics = Get-WmiObject -class Win32_NetworkAdapterConfiguration -computername $computer 
$InstalledSoftware = Get-WmiObject -class "Win32_Product" -computername $computer -namespace $namespace  #| Select-Object "Caption","Version","Vendor"

foreach ($CPU in $CPUs) 
{
	$ProcessorName = $CPU.Name 
}

$ComputerName = $computerInfo.name
$ComputerDomain = $computerInfo.domain
$ComputerManufacturer = $computerInfo.Manufacturer 
$ComputerModel = $computerInfo.Model 
$ComputerMemory = "{0:N0}" -f ($computerInfo.TotalPhysicalMemory / 1024000)
$OperatingSystem = $OS.Caption 
$OSSP = $OS.CSDVersion 
$OSSerial = $OS.SerialNumber 

# Get Word Ready for Input
# Launch instance of Microsoft Word
Write-Host "Creating New Server Card"
$msWord = New-Object -Com Word.Application


# Create new document

#$wordDoc = $msWord.Documents.Add() # Required when not using template and starting a new document
$wordDoc = $msword.Documents.add($wordtemplatepath)
# Make word visible (optional)
$msWord.Visible = $false
# Activate the new document
$wordDoc.Activate()

# Insert Document Title

$Title = $computer.ToUpper() + "  -  " + $description
InsertTitle $title

$Title = "Created on " + $date
InsertText $title
#InsertHeader "General computer information"

$contents = @{}

$content = "" | select-Object Name, Description
$content.Name = "Computername"
$content.Description = $ComputerName
$contents.Add(0,$content)
$content = "" | select-Object Name, Description
$content.Name = "Domain"
$content.Description = $ComputerDomain
$contents.Add(1,$content)
$content = "" | select-Object Name, Description
$content.Name = "Manufacturer"
$content.Description = $ComputerManufacturer
$contents.Add(2,$content)
$content = "" | select-Object Name, Description
$content.Name = "Computer model"
$content.Description = $ComputerModel
$contents.Add(3,$content)
$content = "" | select-Object Name, Description
$content.Name = "Memory"
$content.Description = ($ComputerMemory + " MB")
$contents.Add(4,$content)
$content = "" | select-Object Name, Description
$content.Name = "Processor"
$content.Description = $ProcessorName
$contents.Add(5,$content)
$content = "" | select-Object Name, Description
$content.Name = "OS"
$content.Description = $OperatingSystem
$contents.Add(6,$content)
$content = "" | select-Object Name, Description
$content.Name = "Service Pack"
$content.Description = $OSSP
$contents.Add(7,$content)

$columnHeaders = @('Name','Description')
$columnProperties = @('Name','Description')
$Heading = "Computer Information"
Tableoutput $Heading $columnHeaders $columnProperties $contents


#InsertHeader "List of Disks"

$disknr = 1
foreach ($Disk in $Disks) # Get all disk partitions
{
	if ($Disk.Description -eq "Local Fixed Disk") 
	{	
		#InsertHeader ("Disk " + $disknr)
		$contents = @{}

		$content = "" | select-Object Name, Description
		$content.Name = "Disk label"
		$content.Description = ($Disk.Caption + "\")
		$contents.Add(0,$content)
		$content = "" | select-Object Name, Description
		$content.Name = "Filesystem"
		$content.Description = $Disk.FileSystem
		$contents.Add(1,$content)
		$content = "" | select-Object Name, Description
		$content.Name = "Disk Size"
		$content.Description = ("{0:N0}" -f ($Disk.Size / 1GB) + " GB")
		$contents.Add(2,$content)
		$content = "" | select-Object Name, Description
		$content.Name = "Free Space"
		$content.Description = ("{0:N0}" -f ($Disk.FreeSpace / 1GB) + " GB")
		$contents.Add(3,$content)
		
		$columnHeaders = @('Name','Description')
		$columnProperties = @('Name','Description')
		$Heading = ("Disk " + $disknr)
		Tableoutput $Heading $columnHeaders $columnProperties $contents
		
		$disknr = $disknr + 1
	}
	
}

#InsertText ""
#InsertHeader "Network Adapters"
$intnr = 1
$tablerow = 0
$contents = @{}

foreach ($Nic in $Nics) # Get all network interfaces
{

if ($Nic.IPAddress -like "172*" -or $Nic.IPAddress -like "10*" -or $Nic.IPAddress -like "130*" -or $Nic.IPAddress -like "115*")
  {
    $Description = ""
	$tablerow = 0
	
	$InterfaceCollection = get-wmiobject -class "Win32_NetworkAdapter" -namespace "root\CIMV2" -computername $computer
    foreach ($adapter in $InterfaceCollection) 
	  {
			if ($adapter.InterfaceIndex -eq $Nic.InterfaceIndex)
				{
					$Description = $adapter.NetConnectionID
				}
      }
			
	#InsertHeader ("Network interface " + $intnr)

	$content = "" | select-Object Name, Description
	$content.Name = "Interface label"
	$content.Description = ($Description)
	$contents.Add($tablerow,$content)
	$tablerow = $tablerow + 1
	$content = "" | select-Object Name, Description
	$content.Name = "IP Adress"
	$content.Description = ($Nic.IPAddress)
	$contents.Add($tablerow,$content)
	$tablerow = $tablerow + 1
	$content = "" | select-Object Name, Description
	$content.Name = "Subnet"
	$content.Description = ($Nic.IPSubnet)
	$contents.Add($tablerow,$content)
	$tablerow = $tablerow + 1
	$content = "" | select-Object Name, Description
	$content.Name = "Gateway"
	$content.Description = ($Nic.DefaultIPGateway)
	$contents.Add($tablerow,$content)
	$tablerow = $tablerow + 1
	$content = "" | select-Object Name, Description
	$content.Name = "DHCP"
	$content.Description = ($Nic.DHCPEnabled)
	$contents.Add($tablerow,$content)
	$tablerow = $tablerow + 1
	$content = "" | select-Object Name, Description
	$content.Name = "MAC Adress"
	$content.Description = ($Nic.MACAddress )
	$contents.Add($tablerow,$content)
	$tablerow = $tablerow + 1
		
	$dnscount = 1	
	foreach ($DNSserver in $Nic.DNSServerSearchOrder)
	    {   
			$content = "" | select-Object Name, Description
	        $content.Name = "DNS Server " + $dnscount
	        $content.Description = $DNSserver
	        $contents.Add($tablerow,$content)
	        $tablerow = $tablerow + 1
			$dnscount = $dnscount + 1
		}
	
	#Optionally you can add WINS servers with $Nic.WINSPrimaryServer and $Nic.WINSSecondaryServer
	
	$columnHeaders = @('Name','Description')
    $columnProperties = @('Name','Description')
    $Heading = ("Network interface " + $intnr)
    Tableoutput $Heading $columnHeaders $columnProperties $contents
	$intnr = $intnr + 1 # Raise interface number with one
  }	

  # Reset variables  
  $Description = ""
  $tablerow = 0
  $content = ""
  $contents = @{}
}


$myCol = @()
foreach ($Item in $InstalledSoftware) # Get all installed software items
{
	$softwarelist = "" | select-Object Caption, Version, Vendor
	$softwarelist.Caption = $Item.Caption
	$softwarelist.Version = $Item.Version
	$softwarelist.Vendor = $Item.Vendor
	$myCol += $softwarelist
}

$contents = $myCol
$columnHeaders = @('Caption', 'Version', 'Vendor')
$columnproperties = @('Caption', 'Version', 'Vendor')
$Heading = "Installed software"
if ($contents[0] -eq $null){
        Write-Host "No entries for $Heading found"
}
else
{
        Tableoutput $Heading $columnHeaders $columnProperties $contents
}
#endregion

#region Save server card.

# Check save path
$pathexist = Test-Path ($SavePath + "\" + $computer + "\")
if ($pathexist -eq $false){New-Item -ItemType directory -Path ($SavePath + "\" + $computer + "\")}

# Save the document
$saveto = ($SavePath + "\" + $computer + "\" + $computer + ".docx")
Write-Host "Saving server card " + $saveto
$wordDoc.SaveAs([REF]$saveto)
$wordDoc.Close 
$msWord.Application.quit()
#endregion

#################################################################################################################################

}
Write-Host "Finished !!!"
