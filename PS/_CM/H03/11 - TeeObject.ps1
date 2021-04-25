notepad

Get-Process -Name notepad | Tee-Object -Variable proc | Select-Object processname,handles

$proc

$proc.kill()

# or

$Path = 'K:\'

Get-ChildItem -Path $Path -File -Recurse | Tee-Object -FilePath $Path\AllSystemFiles.txt -Append | 
                                        Out-File $Path\NewSystemFiles.txt

#equivalent with
Get-ChildItem -Path $Path -File -Recurse | Out-File -FilePath $Path\AllSystemFiles.txt -Append
Get-ChildItem -Path $Path -File -Recurse | Out-File -FilePath $Path\NewSystemFiles.txt

# cleanup

"$Path\AllSystemFiles.txt" , "$Path\NewSystemFiles.txt" | Remove-Item