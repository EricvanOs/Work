# Ensures that Invoke-WebRequest uses TLS 1.2

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$j = Invoke-WebRequest 'https://api.github.com/repos/PowerShell/PowerShell/issues' | ConvertFrom-Json
$j


# Convert a DateTime object to a JSON object

Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json