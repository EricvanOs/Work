#region Script Information
<#
	.AUTHOR
		Marco Baars

	.MAIL
		marco.baars@cygnific.com

	.PURPOSE
		Save cvs attachement from Instant Survey emails AF

	.PARAMETERS
		N/A

	.DATE
		12-01-2018

	.VERSION
		1

#>
#endregion

#region Define variables
$Sender = 'mail.dssbi@airfrance.fr'
$Subject =  'Icare'
$SavePath = '\\cyg7006\data\P&R\Reporting\Data_Sources\CustomerCare\Source\'
$MarkMailasRead = $true
$ArchiveMail = $true
$MailArchivePath = 'Icare Archive'
#$MailProfile = 'Reporting@cygnific.com'
$MailProfile = 'Outlook'
#endregion
Clear-Host

Add-Type -Assembly "Microsoft.Office.Interop.Outlook"

$olFolders = "Microsoft.Office.Interop.Outlook.olDefaultFolders" -as [type]

$Outlook = New-Object -ComObject Outlook.Application 
$NameSpace = $Outlook.GetNameSpace("MAPI")
$NameSpace.Logon($MailProfile)

$Folder = $namespace.GetDefaultFolder($olFolders::olFolderInBox)

$Mails = $Folder.Items | Where-Object {$_.Subject -match $Subject -and $_.SenderName -match $Sender}


foreach ($objMessage in $Mails) 
{
    $intCount = $objMessage.Attachments.Count
    $objMessage.Subject
    if ($intCount -gt 0)
    {
        for ($i = 1; $i -le $intCount; $i++)
        {
			If ($objMessage.Subject.Contains("Stocks")) {
				$objMessage.Attachments.Item($i).SaveAsFile($SavePath + "Istock.csv")
				}
			If ($objMessage.Subject.Contains("volumes and costs")) {
				$objMessage.Attachments.Item($i).SaveAsFile($SavePath + "IVolume.csv")
				}
			If ($objMessage.Subject.Contains("Created")) {
				$objMessage.Attachments.Item($i).SaveAsFile($SavePath + "ICreated.csv")
				}
			If ($objMessage.Subject.Contains("C_full")) {
				$objMessage.Attachments.Item($i).SaveAsFile($SavePath + "ICreated_FULL.csv")
					}
}
	}
	
	if($MarkMailasRead -eq $true){$objMessage.Unread = $false}
    if($ArchiveMail -eq $true){$objMessage.Move($folder.Folders($MailArchivePath))}
}

$Namespace.Logoff()
$Outlook.Close

#Extra check if Outlook is closed. If not then try by releasing the COM object
function release-comobject($ref) {
	while ([System.Runtime.InteropServices.Marshal]::ReleaseComObject($ref) -gt 0) { }
	[System.GC]::Collect()
  }
  
  release-comobject $Outlook