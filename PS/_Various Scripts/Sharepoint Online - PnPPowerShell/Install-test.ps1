# read pdf to setup registered application

<#
1. install latest pnp.powershell module
2. Register-PnPEntraIDApp -ApplicationName "PnP PowerShell" -Tenant xhelios.onmicrosoft.com -Interactive
This creates the app and grants necessary permissions, creates a PFX and CER files and gives you the Client ID and Thumbprint values
3. import pfx file on clients (to use connect-)


Define the App ID (once)
$ENTRAID_APP_ID = "4b0325b0-39d4-4d93-bdbd-f5ea3f16ccb5"

[System.Environment]::SetEnvironmentVariable("ENTRAID_CLIENT_ID", $ENTRAID_APP_ID, [EnvironmentVariableTarget]::User)

-- Tip -- restart powershell 

$env:ENTRAID_CLIENT_ID

# for my environment
Appid = '4b0325b0-39d4-4d93-bdbd-f5ea3f16ccb5'
certificate-thumbprint = 'A29126B563E8E36C3429DEA74A9ADC69D904421B'
#>

# Variables
$SiteURL = "https://xhelios.sharepoint.com"
$ClientID = $env:ENTRAID_CLIENT_ID

# Connect to SharePoint Online site (interactively; a login is needed)
Connect-PnPOnline -Url $SiteURL -Interactive -ClientId $ClientID

#Get All Lists
Get-PnPList

# disconnect
Disconnect-PnPOnline

# thumbprint
$Thumbprint = 'A29126B563E8E36C3429DEA74A9ADC69D904421B'
$TenantID = 'c395f110-ab2e-44ab-b096-7000e2511b32'

Connect-PnPOnline -Url $SiteURL -Thumbprint $Thumbprint  -Tenant  $TenantID  -Clientid $ClientID

#Get All Lists
Get-PnPList

# disconnect
Disconnect-PnPOnline
