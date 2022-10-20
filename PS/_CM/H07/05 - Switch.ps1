$computer = 'LON-CL1'
$role = 'unknown role'
$location = 'unknown location'

Switch -wildcard ($computer) {
    "*-CL*"  {$role = 'client'} 
    "*-SRV*" {$role = 'server'}
    "*-DC*"  {$role = 'domain controller'}
    "LON-*"  {$location = 'London'}
    "VAN-*"  {$location = 'Vancouver'}
    Default  {"$computer is not a valid name"}
}

Write-Host "$computer is a $role in $location"


# again met break

$computer = 'LON-CL1'
$role = 'unknown role'
$location = 'unknown location'

Switch -wildcard ($computer) {
    "*-CL*"  {$role = 'client'; break} 
    "*-SRV*" {$role = 'server'}
    "*-DC*"  {$role = 'domain controller'}
    "LON-*"  {$location = 'London'}
    "VAN-*"  {$location = 'Vancouver'}
    Default  {"$computer is not a valid name"}
}

Write-Host "$computer is a $role in $location"


