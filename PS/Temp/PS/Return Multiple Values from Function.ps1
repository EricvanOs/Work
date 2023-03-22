
Function Test()
{
    $FirstName = "John"
    $LastName = "Doe"

    return $FirstName, $LastName
}

$firstName, $lastName = Test
$firstName
$lastName


# Return Values Using HashTable

Function Test() {
    $FullName = @{
        FirstName = "John"
        LastName  = "Doe"
    }

    return $FullName
}

$fullName = Test
foreach ($key in $fullName.Keys) {
    Write-Host "$key is $($fullName[$key])"
}


# Return Values Using PSCustomObject

Function Test() {    
    $FullName = [PSCustomObject]@{
        FirstName = "John"
        LastName  = "Doe"
    }

    return $FullName
}

$fullName = Test
Write-Host "FirstName is $($fullName.FirstName)"
Write-Host "LastName is $($fullName.LastName)"
