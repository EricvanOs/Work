$url = "https://gist.githubusercontent.com/sanderstad/1c47c1add7476945857bff4d8dc2be59/raw/d12f30e4aaf9d2ee18e4539b394a12e63dea0c9c/SampleJSON1.json"
$json = (New-Object System.Net.WebClient).DownloadString($url)

$data = $json | ConvertFrom-Json

$data.colors


$data | ConvertTo-Json

$data | ConvertTo-Json -Depth 3 
$data | ConvertTo-Json -Depth 3 -WarningAction Stop

$data | ConvertTo-Json -Depth 4
$data | ConvertTo-Json -Depth 4 -WarningAction Stop

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertto-json?view=powershell-7.3&WT.mc_id=ps-gethelp&viewFallbackFrom=powershell-7.1