# delete files

$StartFolder = '\\cyg7091\SQL Integration Services\FileSource\HRM\'

Get-ChildItem -Path $StartFolder -Filter Cygnific_HRM_*.xml | Remove-Item 