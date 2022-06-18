$user = New-Object System.Security.Principal.NTAccount("pantheon", "ericvanos")

$sid = $user.Translate([System.Security.Principal.SecurityIdentifier])

$sid.Value

