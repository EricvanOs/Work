# Variables
$SSISNamespace = 'Microsoft.SqlServer.Management.IntegrationServices'
$TargetServerName = 'eos'
$TargetFolderName = 'MyProjectFolder'
$ProjectFilePath = 'K:\_CM\_Various Scripts\SSIS\Aggregate.ispac'
$ProjectName = 'Aggregate'

# Load the IntegrationServices assembly
$loadStatus = [System.Reflection.Assembly]::Load('Microsoft.SQLServer.Management.IntegrationServices, '+
    'Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL')

# Create a connection to the server
$sqlConnectionString = 'Data Source=' + $TargetServerName + ';Initial Catalog=master;Integrated Security=SSPI;'
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString

# Create the Integration Services object
$integrationServices = New-Object $SSISNamespace'.IntegrationServices' $sqlConnection

# get-member info
$integrationServices | Get-Member

# Get the Integration Services catalog
$catalog = $integrationServices.Catalogs['SSISDB']

# Create the target folder
$folder = New-Object $SSISNamespace'.CatalogFolder' ($catalog, $TargetFolderName,'Folder description')
$folder.Create()

Write-Host 'Deploying ' $ProjectName ' project ...'

# Read the project file and deploy it
[byte[]] $projectFile = [System.IO.File]::ReadAllBytes($ProjectFilePath)
$folder.DeployProject($ProjectName, $projectFile)

Write-Host 'Done.'

