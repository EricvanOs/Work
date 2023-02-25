
$azc = Connect-AzAccount
# The SubscriptionId in which to create these objects
$SubscriptionId = (Get-AzSubscription -TenantId ($azc.Context.Tenant)).Id
#  $SubscriptionId = (Get-AzContext).Subscription.id  # also possible
# Set subscription context
Set-AzContext -SubscriptionId $subscriptionId 

# Set the resource group name and location for your server
$resourceGroupName = "myResourceGroup-$(Get-Random)"
$location = 'westus'
# Set an admin login and password for your server
$adminSqlLogin = 'SqlAdmin'
$password = ConvertTo-SecureString 'ChangeYourAdminPassword1' -AsPlainText -Force 
$Sqlcredentials = [PSCredential]::new($adminSqlLogin, $password)
# Set server name - the logical server name has to be unique in the system
$serverName = "server-$(Get-Random)"
# The sample database name
$databaseName = 'mySampleDatabase'
# The ip address range that you want to allow to access your server
$startIp = '0.0.0.0'   # not safe
$endIp = '0.0.0.0'

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a server with a system wide unique server name
New-AzSqlServer -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -Location $location `
    -SqlAdministratorCredentials $Sqlcredentials

# Create a server firewall rule that allows access from the specified IP range
New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -FirewallRuleName 'AllowedIPs' -StartIpAddress $startIp -EndIpAddress $endIp

# Create a blank database with an S0 performance level
New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -DatabaseName $databaseName `
    -RequestedServiceObjectiveName 'S0' `
    -SampleName 'AdventureWorksLT'

# Clean up deployment 
 Remove-AzResourceGroup -ResourceGroupName $resourceGroupName