# Install-Module -Name Reflection 
# https://winscp.net/eng/docs/library_powershell

Add-Assembly -Path 'C:\Work\PS\_Various Scripts\DLL\WinSCPnet.dll'


$winscp = Get-Assembly | Where-Object{$_.location -like 'C:\temp\*'}

$AType = get-type -Assembly $winscp | Where-Object{$_.name -like 'remotepath*'} 

$Atype  | Get-Method | Where-Object{$_.MemberType -eq 'Method'} | Where-Object{$_.ReflectedType -like 'WinSCP?RemotePath'} |
Select-Object -Property Name

$Atype  | Get-Constructor # merkop er is maar een constructor


[WinSCP.RemotePath]::GetDirectoryName()