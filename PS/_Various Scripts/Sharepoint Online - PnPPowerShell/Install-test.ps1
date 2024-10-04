# read pdf to setup registered application

<#
1. install latest pnp.powershell module
2. Register-PnPEntraIDApp -ApplicationName "PnP PowerShell" -Tenant xhelios.onmicrosoft.com -Interactive
    This creates the app and grants necessary permissions, creates a PFX and CER files and gives you the Client ID and Thumbprint values
    Save PFX-file in a vault or use password (as it contains the private-key)
3. import pfx file on clients (to use connect-PnPOnline)


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
$SiteURL = "https://xhelios.sharepoint.com/sites/Legal"
$ClientID = $env:ENTRAID_CLIENT_ID

# Connect to SharePoint Online site (interactively; a login is needed)
Connect-PnPOnline -Url $SiteURL -Interactive -ClientId $ClientID

# Test AccessToken
Import-Module -name JWTDetails
Get-PnPAppAuthAccessToken | Get-JWTDetails

#Get All Lists
Get-PnPList

# disconnect
Disconnect-PnPOnline

# Connect to SharePoint Online site with certificate via registered application
$Thumbprint = 'A29126B563E8E36C3429DEA74A9ADC69D904421B'
$TenantID = 'c395f110-ab2e-44ab-b096-7000e2511b32'

$Connection = Connect-PnPOnline -Url $SiteURL -Thumbprint $Thumbprint  -Tenant  $TenantID  -Clientid $ClientID

# Test AccessToken
Import-Module -name JWTDetails
Get-PnPAppAuthAccessToken | Get-JWTDetails

## Office 365 SharePoint Online -- Audiance 00000003-0000-0ff1-ce00-000000000000
## See https://learn.microsoft.com/en-us/troubleshoot/azure/entra/entra-id/governance/verify-first-party-apps-sign-in

#Get All Lists
Get-PnPList
Get-PnPSite -Connection $Connection

# upload file to sharepoint
$RelativeUrl = '/sites/Legal/Shared Documents'
$file = 'C:\Work\PS\_Various Scripts\Sharepoint Online - PnPPowerShell\myfile.txt'

Add-PnPFile -Path $file -Folder $RelativeUrl

# disconnect
Disconnect-PnPOnline
