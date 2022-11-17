Import-Module Microsoft.Graph.Mail


get-command -module Microsoft.Graph.Mail

$userId = 'ericvanos@xhelios.onmicrosoft.com'

Connect-MgGraph -Scopes "User.Read.All" 

get-command -module Microsoft.Graph.Authentication

Get-MgContext

get-command -Module Microsoft.Graph.Mail

Get-MgUserMessage -UserId $userId
get-help Get-MgUserMessage -Online


# A UPN can also be used as -UserId.
Get-MgUserMessageAttachment -UserId $userId -MessageId $messageId -AttachmentId $attachmentId

 Disconnect-MgGraph