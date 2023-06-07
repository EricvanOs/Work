# Ensures that Invoke-WebRequest uses TLS 1.2

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$j = Invoke-WebRequest 'https://api.github.com/repos/PowerShell/PowerShell/issues' | ConvertFrom-Json
$j


# Convert a DateTime object to a JSON object

Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json

# Additional
enum Colors{
    Red
    Green
    Blue
}

# see resuls
[Colors].GetEnumNames()

[Colors].GetEnumName(1)

[Colors]::Green.GetHashCode()
    
# convert to JSON   
[Colors]::Green,[Colors]::Blue | ConvertTo-Json

[Colors]::Green,[Colors]::Blue | ConvertTo-Json -EnumsAsStrings
    
    
'first'| ConvertTo-JSON

'first' | ConvertTo-JSON -AsArray
    
# convert from JSON   
'["first","second","third"]' | ConvertFrom-JSON | Measure-Object
    
'["first","second","third"]' | ConvertFrom-JSON -NoEnumerate | Measure-Object