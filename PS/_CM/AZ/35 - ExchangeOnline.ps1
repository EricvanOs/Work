Install-Module -Name ExchangeOnlineManagement 

get-command -Module ExchangeOnlineManagement

<#
winrm get winrm/config/client/auth
winrm set winrm/config/client/auth '@{Basic="true"}'
#>

Connect-ExchangeOnline 

Get-EXOMailbox
get-mailbox #fails, see winrm remarks

# if module is not needed anymore
# Uninstall-Module -Name ExchangeOnlineManagement 

# use in cloudshell (don't want to change my local/gpo settings)

# Install-Module -Name ExchangeOnlineManagement

Connect-ExchangeOnline

get-mailbox

