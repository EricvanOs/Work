# 1
Get-ItemProperty -Path HKCU:\Network\* | ForEach-Object -Process { Set-ItemProperty -Path $PSItem.PSPath -Name RemotePath -Value $PSItem.RemotePath.ToUpper() }

# 2
New-PSDrive -Name K -Root C:\Work\PS\Temp -PSProvider FileSystem  

Get-ChildItem -Path K:\ -Directory -recurse | Where-Object Name -eq xx | ForEach-Object  {$PSItem.CreateSubdirectory('Test')} | Select-Object -ExpandProperty FullName

Remove-PSDrive K