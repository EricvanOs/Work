#archive files
$StartFolder = '\\cyg7091\SQL Integration Services\FileSource\HRM\'
$d = (get-date).ToString("yyyy-MM-dd");


$BackupLocation = Test-Path -Path ($StartFolder + "Archive" + "\" +"$d")
 if (!($BackupLocation)){
     New-Item -Path ($StartFolder + "Archive" + "\" + "$d") -ItemType Directory 
    }

 Get-ChildItem -Path $StartFolder -Filter Cygnific_HRM_*.xml | Copy-Item -Destination ($StartFolder + "Archive" + "\" + "$d") -Force