# werkt alleen met collections (kolom zonder header)
$coll = 'one','two','three','four'
$coll -contains 'one'
'one' -in $coll


# Dit werkt niet
$coll = Get-Service
$coll -contains 'BITS'

# ook niet
$coll = Get-Service
$slt = Get-Service | Where-Object{$_.name -like 'BITS'} 
$coll -contains $slt

# ook niet
$coll = Get-Service | select-object -Property name
$slt = Get-Service | Where-Object{$_.name -like 'BITS'} | select-object -Property name
$coll -contains $slt

# maar dit wel
$coll = Get-Service | select-object -ExpandProperty name
$slt = Get-Service | Where-Object{$_.name -like 'BITS'} | select-object -ExpandProperty name
$coll -contains $slt
$slt -in $coll
# of
$coll -contains 'BITS'