# 1
Get-Process | ConvertTo-HTML

# 2
Get-Process | ConvertTo-HTML | Out-File -FilePath K:\Temp\Procs.html

# 3
Get-Process | ConvertTo-JSON > K:\Temp\Procs.json

# 4
Get-Service | ConvertTo-CSV | Out-File -FilePath K:\Temp\Serv.csv 
# or run 
Get-Service | Export-CSV -LiteralPath K:\Temp\Serv2.csv -NoTypeInformation   # betere optie


# 6
Get-Service | Export-CliXML -Path k:\Temp\Serv.xml

Get-Service | Get-Member                                   # System.ServiceProcess.ServiceController (methods & properties)
Get-Service | Export-CliXML -Path k:\Temp\Serv.xml                

Import-Clixml -Path K:\Temp\Serv.xml |Get-Member           # Deserialized.System.ServiceProcess.ServiceController (only properties and some base methods)


# cleanup
Get-ChildItem -Path k:\Temp\ -File | Where-Object{$_.Name -like 'serv*' -or $_.name -like 'procs*'} | Remove-Item

