# letop ldap properties kunnen ook leeg zijn 
Get-ADUser -Filter {(Department -eq 'Legal')} | Measure-Object 
Get-ADUser -Filter {(Department -ne 'Legal')} | Measure-Object 
Get-ADUser -Filter {(Department -notlike '*')} | Measure-Object  
Get-ADUser -Filter {(Department -like '*')} | Measure-Object 
Get-ADUser -Filter '*' | Measure-Object 


$users = Get-ADUser -Filter {Department -ne 'Legal' -or Department -notlike '*'}

Write-Host "Users to be modified: $($users.count)"

ForEach ($user in $users) {
    Write-Host "Modifying user: $($user.Name)"
    Set-ADUser $user -Department 'Business Development' -WhatIf
}





