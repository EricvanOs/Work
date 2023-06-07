# https://github.com/iRon7/Join-Object
# Install-Module -name JoinModule
# also  needed
# https://github.com/iRon7/ConvertFrom-SourceTable
# Install-Script -Name ConvertFrom-SourceTable

Import-Module -Name JoinModule

$Employee = ConvertFrom-SourceTable '
Id  Name    Country  Department  Age ReportsTo
--  ----    -------  ----------  --- ---------
1  Aerts   Belgium  Sales        40         5
2  Bauer   Germany  Engineering  31         4
3  Cook    England  Sales        69         1
4  Duval   France   Engineering  21         5
5  Evans   England  Marketing    35
6  Fischer Germany  Engineering  29         4'

$employee | Format-Table

$Department = ConvertFrom-SourceTable '
Name        Country
----        -------
Engineering Germany
Marketing   England
Sales       France
Purchase    France'


$Changes = ConvertFrom-SourceTable '
Id  Name      Country  Department   Age  ReportsTo
--  ----      -------  ----------   ---  ---------
  3  Cook     England  Sales         69         5
  6  Fischer  France   Engineering   29         4
  7  Geralds  Belgium  Sales         71         1'


# inner join
$Employee | InnerJoin $Department -On Country | Format-Table

# again
$Employee | InnerJoin $Department -On Department -Equals Name -Discern Employee, Department | Format-Table

# changes
$Employee | Merge $Changes -On Id | Format-Table

# self-join (left join)
LeftJoin $Employee -On ReportsTo -Equals Id -Property @{ Name = 'Left.Name' }, @{ Manager = 'Right.Name' }

# Add an Id to the department list
1..9 |Join $Department -ValueName Id

