Import-Module Microsoft.Graph.Mail


get-command -module Microsoft.Graph.Mail

$userId = 'evanos@in-li.eu'

Connect-MgGraph -Scopes "User.Read.All","Mail.Read"

get-command -module Microsoft.Graph.Authentication

Get-MgContext

get-command -Module Microsoft.Graph.Mail

Get-MgUserMessage -UserId $userId
get-help Get-MgUserMessage -Online

Get-MgUserMessage -UserId $userId | Where-Object{$_.hasAttachments -eq $true} | Select-Object -Property *

$id = (Get-MgUserMessage -UserId $userId | Where-Object{$_.hasAttachments -eq $true}).id


# A UPN can also be used as -UserId.
Get-MgUserMessageAttachment -UserId $userId -MessageId $Id | Select-Object -Property *

Disconnect-MgGraph