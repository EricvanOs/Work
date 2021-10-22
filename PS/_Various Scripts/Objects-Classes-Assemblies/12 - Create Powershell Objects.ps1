#Convert Hashtables to [PSCustomObject]

[pscustomobject]@{
    firstname = 'Marius'
    lastname = 'Nixs'
}

    
# Using Select-Object cmdlets
    
Select-Object @{n='firstname';e={'Marius'}},@{n='lastname';e={'Nixs'}} -InputObject ''
    # alternatively
'' | Select-Object @{n='firstname';e={'Marius'}},@{n='lastname';e={'Nixs'}}
    
    
    
# Using New-Object and Add-Member
    
$obj = New-Object -TypeName psobject
$obj | Add-Member -MemberType NoteProperty -Name firstname -Value 'Marius'
$obj | Add-Member -MemberType NoteProperty -Name lastname -Value 'Nixs'
    
# add a method to an object
$obj | Add-Member -MemberType ScriptMethod -Name "GetName" -Value {$this.firstname +' '+$this.lastname}
    
    
    
# Using New-Object and hashtables
$properties = @{
firstname = 'Marius'
lastname = 'Nixs'
}
$o = New-Object psobject -Property $properties 
$o


$properties2 =[ordered] @{
firstname = 'Marius'
lastname = 'Nixs'
}
$o2 = New-Object psobject -Property $properties2
$o2