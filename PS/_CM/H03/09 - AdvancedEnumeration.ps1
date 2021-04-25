# 1
Get-ItemProperty -Path HKCU:\Network\* | ForEach-Object -Process { Set-ItemProperty -Path $PSItem.PSPath -Name RemotePath -Value $PSItem.RemotePath.ToUpper() }

# 2
Get-ChildItem -Path K:\ -Directory -recurse | Where-Object Name -eq xx | ForEach-Object  {$PSItem.CreateSubdirectory('Test')} | Select-Object -ExpandProperty FullName