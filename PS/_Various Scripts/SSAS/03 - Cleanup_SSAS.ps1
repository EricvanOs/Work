# delete all databases except 'Adventure Works DW EE', 'Contoso_Retail' , .....

$Computer = 'selene'
$NotDelete = 'Adventure Works DW EE', 'Contoso_Retail' , 'FoodMart' , 'MDX','GalacticOLAP','Waremart 2005','FAA_MD_P_cci'

# import module if needed
If ( ! (Get-module sqlserver )) { Import-Module sqlserver | Out-Null}

Push-Location SQLSERVER:\sqlas\$($computer)\alpha\databases

$Databases = Get-ChildItem

foreach ($Database in $Databases){
    if ($Database.Name -notin $NotDelete)
    {
     $Database.Drop()
    }
    
}

Pop-Location