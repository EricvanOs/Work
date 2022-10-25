$ComputerName = 'localhost'

# 
$Port = Get-NetTCPConnection | 
Where-Object{$_.OwningProcess -eq ((Get-Process -Name PBIDesktop ).id)} |
Where-Object{$_.RemotePort -ne 0} | Group-Object RemotePort |
Select-Object -ExpandProperty  Name -First 1

"$($computerName):$Port"

# Add the AMO namespace
$loadInfo = [Reflection.Assembly]::LoadWithPartialName(“Microsoft.AnalysisServices”)
[Reflection.Assembly]::LoadFrom('C:\Windows\assembly\GAC_MSIL\Microsoft.AnalysisServices\12.0.0.0__89845dcd8080cc91\Microsoft.AnalysisServices.DLL')

## Connect and get the edition of the local server
$connection = "$($computerName):$Port"
$server = New-Object Microsoft.AnalysisServices.Server
$server.connect($connection)

foreach ($d in $server.Databases )
{   

    Write-Output ( “Database: {0}, String {1}:” -f $d.Name, $d.DataSources.ConnectionString)        

} # Databases

$connectionString = "Provider=MSOLAP;Data Source=$($computerName):$Port;Initial Catalog=d1a7f64d-6ee7-4ed2-b0f8-0aa527030e71;"
$query = @'
EVALUATE Categories
'@
 
Get-PSProvider
cd sqlserver:

$connection = New-Object -TypeName System.Data.OleDb.OleDbConnection

$connection.ConnectionString = $connectionString
$command = $connection.CreateCommand()
$command.CommandText = $query
$adapter = New-Object -TypeName System.Data.OleDb.OleDbDataAdapter $command
$dataset = New-Object -TypeName System.Data.DataSet 
$adapter.Fill($dataset) | Out-Null

$dataset.Tables[0] 
   
$connection.Close()