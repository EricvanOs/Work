Import-Module Microsoft.Online.SharePoint.PowerShell -UseWindowsPowerShell    # implicit remoting install also @ps5.1
# make connection
Connect-SPOService -Url https://xhelios-admin.sharepoint.com

# list of commands in module
get-command -Module Microsoft.Online.SharePoint.PowerShell

Get-SPOTenant

Get-SPOSite

Disconnect-SPOService