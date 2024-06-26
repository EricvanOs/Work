c:

function release-comobject($ref) {
      while ([System.Runtime.InteropServices.Marshal]::ReleaseComObject($ref) -gt 0) { }
      [System.GC]::Collect()
}

$d = (get-date).ToString("yyyy-MM-dd")
$filepath = "\\cyg7006\data\p&R\reporting\Data_Sources\quality\source\CSV\InstantSurvey\"
[Reflection.Assembly]::LoadWithPartialname("Microsoft.Office.Interop.Outlook") | out-null
$olFolders = "Microsoft.Office.Interop.Outlook.OlDefaultFolders" -as [type]
$outlook = new-object -comobject outlook.application
$namespace = $outlook.GetNameSpace("MAPI")
$namespace.Logon("Reporting")
$folder = $namespace.getDefaultFolder($olFolders::olfolderinbox)
$folder.GetExplorer().Display()
$subfolder = $folder.Folders | where {$_.name -eq 'Instant Experience Source'}
$Subfolder.items 
 

foreach ($Item in $Subfolder.items ){
                if ($Item.Subject -match "CSAT B2C Daily")
                {
#                Write-Host $Item.Subject
#               Write-Host $item.SenderEmailAddress

                foreach($attach in $item.Attachments) {
#                Write-Host $attach.FileName
                                If ($attach.filename -like “CSAT?B2C?Daily*”) {
                                                $name = "CSAT_B2C_Daily_$d.csv"
                                                $filename =$filepath + $name
 #                                              Write-Host $filename
                                                $attach.saveasfile($filename)
                                                
                }
                }
				$desfolder = $folder.Folders | where {$_.name -eq 'Instant Experience Archive'}
				$Item.Move($desfolder) 
                }
                }
				
$outlook.quit()

If (Get-Process outlook) {
    Get-Process outlook | stop-process
}
