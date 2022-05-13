# run ISE, not yet compatible with powershell 7

#if needed
# Install-Module -Name Microsoft.Online.SharePoint.PowerShell 

#if needed
# Update-Module -Name Microsoft.Online.SharePoint.PowerShell


Import-Module -Name Microsoft.Online.SharePoint.PowerShell -verbose  #with verbose is necessary

# list of commands in module
get-command -Module Microsoft.Online.SharePoint.PowerShell

# make connection
Connect-SPOService -Url https://xhelios-admin.sharepoint.com


Get-SPOTenant

Get-SPOSite