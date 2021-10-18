# import with UseWindowsPowerShell for compatibility
Import-Module  -Name Microsoft.PowerShell.Management -UseWindowsPowerShell

get-help Get-EventLog -Online


# of
Get-EventLog -LogName Application #bare minimum
Get-EventLog -LogName Application -Newest 10
# dit mislukt
Get-EventLog -Newest 10

#dit mag ook, maar geen goede gewoonte
Get-EventLog Application

#tweede variant mag ook
Get-EventLog -AsString -ComputerName localhost,sisyphus
Get-EventLog -AsString 
#dit mag niet want -computername staat niet tussen []
Get-EventLog -AsString localhost 
#dit lukt ook niet  
Get-EventLog -ComputerName localhost
#dit mag wel, list parameter geeft geen ambiguïteit
Get-EventLog -List


# conclusie er zijn twee varianten

Get-EventLog -LogName  .......
Get-EventLog -AsString .......


