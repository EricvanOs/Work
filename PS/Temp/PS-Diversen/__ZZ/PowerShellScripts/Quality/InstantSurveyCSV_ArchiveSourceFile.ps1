#Set-PSDebug -Trace 0
#cls
C:



#archive files
$StartFolder = '\\cyg7006\Data\P&R\Reporting\Data_Sources\Quality\Source\CSV\InstantSurvey\'
$EndFolder = '\\cyg7006\Data\P&R\Reporting\Data_Sources\Quality\Source\Archive\'


Get-ChildItem -Path $StartFolder -Filter *_CSAT.csv | Move-Item -Destination ($EndFolder) -Force
 
 