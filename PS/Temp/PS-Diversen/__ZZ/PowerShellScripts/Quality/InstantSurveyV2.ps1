
 c:
$filepath = "\\cyg7006\data\p&R\reporting\Data_Sources\quality\source\CSV\InstantSurvey\"
[Reflection.Assembly]::LoadWithPartialname("Microsoft.Office.Interop.Outlook") | out-null
$olFolders = "Microsoft.Office.Interop.Outlook.OlDefaultFolders" -as [type]
$outlook = new-object -comobject outlook.application
$namespace = $outlook.GetNameSpace("MAPI")
$namespace.Logon("Reporting")
$folder = $namespace.getDefaultFolder($olFolders::olfolderinbox)
$subfolder = $folder.Folders | where {$_.name -eq 'Instant Experience Source'}
$Subfolder.items 
 

foreach ($Item in $Subfolder.items ){
	if ($Item.Subject -match "B2C Daily CSAT")
	{
#	Write-Host $Item.Subject
#	Write-Host $item.SenderEmailAddress

	foreach($attach in $item.Attachments) {
#	Write-Host $attach.FileName
		If ($attach.filename -like “B2C?Daily?CSAT*”) {
			$name = "B2C_Daily_CSAT.csv"
			$filename =( Join-path  $filepath $name)
#			Write-Host $filename
			$attach.saveasfile($filename)
	}
	}$Item.delete()
	}
	}
$Outlook.quit() 


 #Write-Host $mBody 