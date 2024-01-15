# by value
Function Test($data)
{
    Write-Host "`$var is $var and `$data is $data"
    $data = 3
    $var = 7
    Write-Host "`$var is $var and `$data is $data"
}

$var = 10
Test -data $var
$var


# by reference
Function Test([ref]$data)
{
    $data.Value = 3
}
# To pass a variable to a parameter that expects a reference, you must type cast your variable as a reference.
# maw in de functie gebruik je $data maar 't is $var
# When using references, you must use the Value property to access your data.
# The brackets and parenthesis are BOTH required.

$var = 10
Test -data ([ref]$var)
$var