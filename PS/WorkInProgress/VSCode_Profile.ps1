test-path $profile

new-item -type File -Force $profile

<#
Set-Location -Path C:\
Import-Module -Name dbatools
Clear-Host
Invoke-Sqlcmd -ServerInstance clio -Database Quotes -Query "exec spquote" |  Select-Object -ExpandProperty Column1
Start-Transcript -Path C:\Work\PS\MyTranscript.txt | Out-Null
#>

