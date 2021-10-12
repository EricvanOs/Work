New-PSDrive -Name K -Root C:\Work\PS\Temp -PSProvider FileSystem 

# 1
Get-Process | ConvertTo-HTML

# 2
Get-Process | ConvertTo-HTML | Out-File -FilePath K:\Procs.html

# 3
Get-Process | ConvertTo-JSON > K:\Procs.json

# 4
Get-Service | ConvertTo-CSV | Out-File -FilePath K:\Serv.csv 
# or run 
Get-Service | Export-CSV -LiteralPath K:\Serv2.csv -NoTypeInformation   # betere optie


# 6
Get-Service | Export-CliXML -Path k:\Serv.xml

Get-Service | Get-Member                               # System.ServiceProcess.ServiceController (methods & properties)
Get-Service | Export-CliXML -Path k:\Serv.xml                

Import-Clixml -Path K:\Serv.xml |Get-Member            # Deserialized.System.ServiceProcess.ServiceController (only properties and some base methods)




# cleanup


Get-ChildItem -Path k:\ -File | Where-Object{$_.Name -like 'serv*' -or $_.name -like 'procs*'} | Remove-Item


Remove-PSDrive K
