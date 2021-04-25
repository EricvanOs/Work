$path = 'K:\_CM\_Various Scripts\SSIS'
Set-Location -Path $path

$PackageName = 'Audit.ispac'
$ProjectFilePath = Join-Path -Path $path -ChildPath $PackageName
$server  = 'eos'

# Load the IntegrationServices Assembly            
$loadStatus = [Reflection.Assembly]::Load("Microsoft"+            
".SqlServer.Management.IntegrationServices" +            
", Version=14.0.0.0, Culture=neutral" +            
", PublicKeyToken=89845dcd8080cc91")            
            
# Store the IntegrationServices Assembly namespace to avoid typing it every time            
$ISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"                     
   
# Create a connection to the server            
$constr = "Data Source=$server;Initial Catalog=master;Integrated Security=SSPI;"            
            
$con = New-Object System.Data.SqlClient.SqlConnection $constr            
            
# Create the Integration Services object            
$ssis = New-Object $ISNamespace".IntegrationServices" $con            
            
 $ssis | Get-Member  
            
# Create a new folder            
Write-Host "Creating Folder ..."            
$folder = New-Object $ISNamespace".CatalogFolder" ($ssis.Catalogs["SSISDB"], "MyFolder", "MyDescription")            
$folder.Create()            
            
# Read the project file, and deploy it to the folder            
Write-Host "Deploying ExecutionDemo project ..."            
[byte[]] $projectFile = [System.IO.File]::ReadAllBytes($ProjectFilePath )       
 
$folder.DeployProject("Audit", $projectFile)            
            
    
            
# we can specify the value of parameters to be either constants or             
# to take the value from  environment variables            
            
$package = $project.Packages["ComplexPackage.dtsx"]            
            
# setting value of parameter to constant            
$package.Parameters["Servername"].Set(            
    [Microsoft.SqlServer.Management.IntegrationServices.ParameterInfo+ParameterValueType]::Literal,            
    "Foobar");            
$package.Alter()            
            
# binding value of parameter to value of an env variable is a little more complex            
# 1) create environment            
# 2) add variable to environment            
# 3) make project refer to this environment            
# 4) make package parameter refer to this environment variable            
# These steps are shown below            
            
# 1) creating an environment            
$environment = New-Object $ISNamespace".EnvironmentInfo" ($folder, "Env1", "Env1 Desc.")            
$environment.Create()            
            
# 2) adding variable to our environment             
# Constructor args: variable name, type, default value, sensitivity, description            
$environment.Variables.Add("Variable1", [System.TypeCode]::Int32, "10", "false", "Desc.")            
$environment.Alter()            
            
# 3) making project refer to this environment            
$project = $folder.Projects[$SSISProjectName]            
$project.References.Add($SSISEnv, $folder.Name)            
$project.Alter()            
            
# 4) making package parameter refer to this  environment variable            
$package.Parameters["CoolParam"].Set(            
    [Microsoft.SqlServer.Management.IntegrationServices.ParameterInfo+ParameterValueType]::Referenced,            
    $SSISEnvVar)            
$package.Alter()            
            
# retrieving environment reference            
$environmentReference = $project.References.Item($SSISEnv, $folder.Name)            
$environmentReference.Refresh()            
            
# executing with environment reference - Note: if you don't have any env reference,            
# then you specify null as the second argument            
$package.Execute("false", $environmentReference)            
            
Write-Host "Package Execution ID: " $executionId    