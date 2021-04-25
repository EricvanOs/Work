# from article at : https://4sysops.com/archives/powershell-classes-part-1-objects/

# create powershell object

$Properties = @{
	"FirstName" = 'Stéphane'
	"LastName" = 'van Gulick'
	"WebSite" = 'www.powershelldistrict.com'
}
$Object = New-object -TypeName psobject -Property $properties
$Object

# create class

Class Author {
    $FirstName = 'Stéphane'
    $LastName = 'van Gulick'
    $WebSite = 'www.powershelldistrict.Com'
}

#Instantiating a class method n°1
    [Author]::new()
#Instantiating a class method n°2
    New-Object Author


# clas with no pre-defined values

Class Employee {
    [string]$FirstName
    [string]$LastName
    [string]$UserName
    [string]$EmployeeType
}


$NewEmployee = [employee]::new()
$NewEmployee.FirstName = "Stephane"