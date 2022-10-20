# to HTML
Get-Process | ConvertTo-HTML

# To HTML and save
Get-Process | ConvertTo-HTML | Out-File -FilePath K:\Temp\Procs.html

# To JSON
Get-Process | ConvertTo-JSON > K:\Temp\Procs.json

# To CSV
Get-Service | ConvertTo-CSV | Out-File -FilePath K:\Temp\Serv.csv 
# or run 
Get-Service | Export-CSV -LiteralPath K:\Temp\Serv2.csv # -NoTypeInformation is since PS6 default

# To XML
$XmlDocument = Get-Service BITS | Convertto-XML -As Document  -NoTypeInformation  
$xmldocument.Objects.Object.Property
$XmlDocument | Get-Member
#also
[xml]$xmlstream = Get-Service BITS | Convertto-XML -As Stream  -NoTypeInformation  
$xmlstream | Get-Member

# to CliXML ( Common Language Infrastructure(CLI) XML)
Get-Service BITS | Export-CliXML -Path k:\Temp\Serv-TypeInfo.xml

Get-Service | Get-Member                                       # System.ServiceProcess.ServiceController (methods & properties)           

Import-Clixml -Path K:\Temp\Serv-TypeInfo.xml | Get-Member     # Deserialized.System.ServiceProcess.ServiceController (only properties and some base methods)

# combined
Get-Content K:\_CM\H03\Patching.json | ConvertFrom-Json | ConvertTo-Csv | Out-File K:\Temp\ServerPatching.csv


# cleanup
Get-ChildItem -Path k:\Temp\ -File | Where-Object{$_.Name -like 'serv*' -or $_.name -like 'procs*'} | Remove-Item

