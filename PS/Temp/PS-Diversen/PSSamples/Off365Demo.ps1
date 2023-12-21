[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12
Install-Module msonline
Install-Module azureADPreview
Install-Module Microsoft.online.Sharepoint.powershell
Install-Module MicrosoftTeams
Install-Module Exchangeonlinemanagement

$cred=Get-Credential -UserName darwinl@M365x727872.onmicrosoft.com -Message "Off365 pwd?"
Connect-MsolService -Credential $cred
Connect-AzureAD -Credential $cred
Connect-MicrosoftTeams -credential $cred
Connect-SPOService -Credential $cred https://M365x727872-admin.sharepoint.com
Connect-ExchangeOnline -cred $cred

#inventaris
Get-MsolUser
Get-MsolAccountSku
Get-AzureADUser
Get-SPOSite
Get-Team
Get-TeamChannel -groupid (get-team -DisplayName Design).groupid 
Get-TeamUser -GroupId (get-team -DisplayName Design).groupid 
Get-EXOMailbox | select name,primarysmtpaddress
Get-Mailbox

