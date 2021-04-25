# Download Json.NET
# Popular high-performance JSON framework for .NET
# https://www.newtonsoft.com/json


# set-location to folder where ddl resides
Set-Location -Path 'C:\Temp\Powershell and SQL\_CM\JSON'

# Adds a Microsoft .NET Framework type (a class) to a Windows PowerShell session
Add-Type -Path .\Newtonsoft.Json.dll

[XML]$members = '<?xml version="1.0"?>
<members>
	<member id="1">
		<user>juanito</user>
		<group>ventas</group>
	</member>
	<member id="2">
		<user>luis</user>
		<group>ventas</group>
	</member>
</members>'

$json = [Newtonsoft.Json.JsonConvert]::SerializeXmlNode($members) | ConvertFrom-Json


$json.members.member

$json.members.member | ForEach-Object -Process {
    $_.user
    $_.group
}


# let's have a closer look

$storageAssemblyPath = 'C:\Temp\Powershell and SQL\_CM\JSON\Newtonsoft.Json.dll'
$bytes = [System.IO.File]::ReadAllBytes($storageAssemblyPath)
[System.Reflection.Assembly]::Load($bytes) | Select-Object -Property *

#show all ExportedTypes
[System.Reflection.Assembly]::Load($bytes) | Select-Object -ExpandProperty ExportedTypes

