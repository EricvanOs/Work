# default values:
$VerbosePreference = 'SilentlyContinue'
$DebugPreference = 'SilentlyContinue'


Resolve-DnsName -Name sisyphus 
Resolve-DnsName -Name sisyphus -verbose
Resolve-DnsName -Name sisyphus -debug


Invoke-RestMethod 'https://jsonplaceholder.typicode.com/posts' -Method Post -Body @{title="test post";user=2}
Invoke-RestMethod 'https://jsonplaceholder.typicode.com/posts' -Method Post -Body @{title="test post";user=2} -Verbose
Invoke-RestMethod 'https://jsonplaceholder.typicode.com/posts' -Method Post -Body @{title="test post";user=2} -Debug


############################
$DebugPreference = 'SilentlyContinue'
Write-Debug -Message "Hello, World"
Write-Debug -Message "Hello, World" -Debug


$DebugPreference = "Continue"
Write-Debug -Message "Hello, World"
Write-Debug -Message "Hello, World" -Debug:$false


$DebugPreference = "Stop"
Write-Debug -Message "Hello, World"
Write-Debug -Message "Hello, World" -Debug:$false


$DebugPreference = "Inquire"
Write-Debug -Message "Hello, World"
Write-Debug -Message "Hello, World" -Debug:$false


# reset default value
$DebugPreference = 'SilentlyContinue'


###########
Connect-AzAccount

Get-AzResourceGroup -debug