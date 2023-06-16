# https://learn.microsoft.com/en-us/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps

Import-Module ExchangeOnlineManagement  -SkipEditionCheck

Connect-ExchangeOnline -UserPrincipalName 'ericvanos@xhelios.onmicrosoft.com'

Get-Command -Module ExchangeOnlineManagement

Get-EXOMailbox 

Get-EXOMailboxFolderStatistics -UserPrincipalName 'evanos@in-li.eu'

Get-ConnectionInformation

