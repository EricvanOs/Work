#Create SMO Server Object
#An SMO object, or SQL Server Management Object, allows you to programmatically access and manipulate SQL Server:
# import module if needed
If ( ! (Get-module sqlserver )) { Import-Module sqlserver | Out-Null}
$instanceName = 'Hypnos'
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName


$server | Get-Member

# for example

$server.VersionMajor
$server.Collation
$server.EnumLocks() | Format-Table -AutoSize