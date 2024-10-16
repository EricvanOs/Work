#archive files
$StartFolder = '\\cyg7006\Data\P&R\Reporting\Data_Sources\CustomerCare\Source\'
$csvPath = "\\cyg7006\Data\P&R\Reporting\Data_Sources\CustomerCare\Source\*.*"
$d = (get-date).ToString("yyyy-MM-dd");

$BackupLocation = Test-Path -Path ($StartFolder + "Archive" + "\" +"$d")
 if (!($BackupLocation)){
     New-Item -Path ($StartFolder + "Archive" + "\" + "$d") -ItemType Directory 
    }

Move-Item -Path $csvPath -Destination ($StartFolder + "Archive" + "\" + "$d") -Force -Confirm:$false