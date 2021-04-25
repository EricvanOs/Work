# class with validation
Class Employee {
     [ValidatePattern("^[a-z]+$")]
     [string]$FirstName
     [ValidatePattern("^[a-z]+$")]
     [string]$LastName
     hidden [string]$UserName
     [ValidateSet('Internal','External')]
     [string]
     $EmployeeType
     [ValidatePattern("^OU=")]
     [string]$OU
     hidden static [string]$DomainName = "DC=District,DC=Local"
}

$employee = [Employee]::new()
$employee | get-member -MemberType Properties

# show hidden properties
$employee | Get-Member -MemberType Properties -Force

# static property
[employee]::DomainName

#example
$NewEmployee = [employee]::new()
$NewEmployee.FirstName = "Jeffrey"
$NewEmployee.LastName = "Snover"
$NewEmployee.EmployeeType = "Internal"
$NewEmployee.OU = "OU=Internal,OU=Users,OU=HQ," + [employee]::DomainName
$NewEmployee