Disconnect-MgGraph


Connect-MgGraph -Scopes "User.Read.All","MailboxSettings.Read"


Get-MgUser -UserId 'ericvanos@xhelios.onmicrosoft.com' -Property MailboxSettings | Select @{Name = 'days'; Expression = {$_.MailboxSettings.WorkingHours.DaysofWeek}}