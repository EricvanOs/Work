# 1
Get-ChildItem -Path 'c:\work\ps\Temp' -Directory -recurse 
   | Where-Object Name -eq xx 
   | ForEach-Object  {$PSItem.CreateSubdirectory('Test')} 
   | Select-Object -ExpandProperty FullName

#2  cleanup of #1
# Alle folders xx met daar direct onder Test

$dirs = Get-ChildItem -Path 'c:\work\ps\Temp' -Directory -recurse | Where-Object{$_.Name -eq 'xx'} 

foreach ($dir in $dirs){

   Get-ChildItem -Path $dir.fullname -Directory | Where-Object{$_.Name -eq 'Test'} | Remove-Item  -WhatIf

}


