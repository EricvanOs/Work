<#
Problem PowerShell warns you when it tries to load a script from an Intranet (UNC) path. 
Solution If it makes sense, copy the file locally and run it from your local location. 
If you want to keep the script on the UNC path, enable Internet Explorer’s UncAsIntranet setting, 
or add the UNC path to the list of trusted sites. 

Adding a server to the list of trusted hosts 
#>

$server = 'MyServer'
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\" + "ZoneMap\Domains\$server" 
New-Item -Path $path | New-ItemProperty -Name File -PropertyType DWORD -Value 2