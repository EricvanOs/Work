Import-Module Microsoft.Online.SharePoint.PowerShell -UseWindowsPowerShell    # implicit remoting

# list of commands in module
get-command -Module Microsoft.Online.SharePoint.PowerShell

# make connection
Connect-SPOService -Url https://xhelios-admin.sharepoint.com


Get-SPOTenant

Get-SPOSite