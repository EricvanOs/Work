Set-Location -Path 'c:\work\ps\Temp'

# to HTML
Get-Process | ConvertTo-HTML

# To HTML and save
Get-Process | ConvertTo-HTML | Out-File -FilePath .\Procs.html

# To JSON
Get-Process | ConvertTo-JSON > .\Procs.json

# To CSV
Get-Service | ConvertTo-CSV | Out-File -FilePath .\Serv.csv 
# or run 
Get-Service | Export-CSV -LiteralPath .\Serv2.csv # -NoTypeInformation is since PS6 default

# To XML
$XmlDocument = Get-Service BITS | Convertto-XML -As Document  -NoTypeInformation  
$xmldocument.Objects.Object.Property
$XmlDocument | Get-Member
#also
[xml]$xmlstream = Get-Service BITS | Convertto-XML -As Stream  -NoTypeInformation  
$xmlstream | Get-Member

# to CliXML ( Common Language Infrastructure(CLI) XML)
Get-Service BITS | Export-CliXML -Path .\Serv-TypeInfo.xml

Get-Service | Get-Member                                       # System.ServiceProcess.ServiceController (methods & properties)           

Import-Clixml -Path .\Serv-TypeInfo.xml | Get-Member     # Deserialized.System.ServiceProcess.ServiceController (only properties and some base methods)

# combined
Get-Content .\H03\Patching.json | ConvertFrom-Json | ConvertTo-Csv | Out-File .\ServerPatching.csv


# cleanup
Get-ChildItem -Path .\ -File | Where-Object{$_.Name -like 'serv*' -or $_.name -like 'procs*'} | Remove-Item

