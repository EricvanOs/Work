$StartFolder = '\\cyg7006\data\P&R\Reporting\Data_Sources\Sales\Source\PVECYG'

$Files = Get-ChildItem -Path $StartFolder -Filter "*Cygnific*.csv"  

foreach($file in $files){
    }

if ($file -ne $null){ 

copy-Item -Path $file.FullName -Destination ($StartFolder + "\" + "Archive") 
Rename-item -Path $file.FullName -NewName "Cygnific_Sales.csv"
}