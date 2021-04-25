'Microsoft.PowerShell.Core','Microsoft.PowerShell.Host' | ForEach-Object {$_.Split('.')} 

'Microsoft.PowerShell.Core','Microsoft.PowerShell.Host' | ForEach-Object -MemberName Split -ArgumentList '.' 

'Microsoft.PowerShell.Core','Microsoft.PowerShell.Host' | Foreach Split '.' 

'Microsoft.PowerShell.Core','Microsoft.PowerShell.Host' | % Split '.' 