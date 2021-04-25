$path = 'K:\_CM\_Various Scripts\Office'

Set-Location -Path $path

Add-Type -AssemblyName Microsoft.Office.Interop.Word 
$wdRemoveDocInfoType = "Microsoft.Office.Interop.Word.wdRemoveDocInfoType" -as [type]    


$wordFiles = Get-ChildItem -Path $path -include *.doc, *.docx -Recurse -Depth 1
$objWord = New-Object -ComObject word.application
$objWord.visible = $false

foreach($wordfile in $wordfiles)
{
    $document = $objword.Documents.Open($wordfile.FullName)

    $document.RemoveDocumentInformation($wdRemoveDocInfoType::wdRDIAll)

    $document.Save()  

    $document.Close()

}

$ObjWord.Quit()