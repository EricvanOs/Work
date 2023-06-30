# Remove temp files located in "C:\Users\USERNAME\AppData\Local\Temp"  
$path = "$env:LOCALAPPDATA\temp"
Write-Host "Removing Junk files in $path" -ForegroundColor Green  
Get-ChildItem -Path $path -Recurse | Remove-Item -Recurse  -Confirm:$false -Force -ErrorAction SilentlyContinue


# Remove Windows Temp Directory
$path = "$env:Windir\temp" 
Write-Host "Removing Junk files in $path" -ForegroundColor Green 
Get-ChildItem -Path $path -Recurse | Remove-Item -Recurse  -Confirm:$false -Force -ErrorAction SilentlyContinue


# Empty Recycle Bin 
Clear-RecycleBin -Force -Verbose -ErrorAction SilentlyContinue


# Run disk cleanup (still to be tested)
C:\Tools\Invoke-WindowsDiskCleanup.ps1 -Section 'Update Cleanup'



