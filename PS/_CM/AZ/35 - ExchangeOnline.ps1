# https://learn.microsoft.com/en-us/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps

Import-Module ExchangeOnlineManagement

Connect-ExchangeOnline -UserPrincipalName 'ericvanos@xhelios.onmicrosoft.com'

Get-Command -Module ExchangeOnlineManagement