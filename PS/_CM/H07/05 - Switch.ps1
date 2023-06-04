$computer = 'LON-CL1'
$role = 'unknown role'
$location = 'unknown location'

Switch -wildcard ($computer) {
    '*-CL*'  {$role = 'client'} 
    '*-SRV*' {$role = 'server'}
    '*-DC*'  {$role = 'domain controller'}
    'LON-*'  {$location = 'London'}
    'VAN-*'  {$location = 'Vancouver'}
    Default  {"$computer is not a valid name"}
}

Write-Host "$computer is a $role in $location"


# again met break

$computer = 'LON-CL1'
$role = 'unknown role'
$location = 'unknown location'

Switch -wildcard ($computer) {
    '*-CL*'  {$role = 'client'; break} 
    '*-SRV*' {$role = 'server'}
    '*-DC*'  {$role = 'domain controller'}
    'LON-*'  {$location = 'London'}
    'VAN-*'  {$location = 'Vancouver'}
    Default  {"$computer is not a valid name"}
}

Write-Host "$computer is a $role in $location"


# while-loop and switch
while(($inp = Read-Host -Prompt 'Select a command') -ne 'Q'){
    switch($inp){
        L {'File will be deleted'}
        A {'File will be displayed'}
        R {'File will be write protected'}
        Q {'End'}
        default {'Invalid entry'}
    }
}



# see: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_switch?view=powershell-7.3