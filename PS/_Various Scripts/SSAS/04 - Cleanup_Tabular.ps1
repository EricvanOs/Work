$Computer = 'selene'

# import module if needed
If ( ! (Get-module sqlserver )) { Import-Module sqlserver | Out-Null}

Push-Location SQLSERVER:\sqlas\$($Computer)\default\databases

$Databases = Get-ChildItem
$NotDelete = 'AdventureWorksTab' 


foreach ($Database in $Databases){
    if ($Database.Name -notin $NotDelete)
    {
     $Database.Drop()
    }
    
}

Pop-Location