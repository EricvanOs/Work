$cred= Get-Credential -UserName Administrator -Message "pwd voor remote system?"
$cred
ConvertFrom-SecureString $cred.Password
#cleartext password eruit halen
$user=New-Object System.Net.NetworkCredential "ikke",($cred.Password)
$user.Password

Get-WmiObject -Class win32_operatingsystem -ComputerName 192.168.92.19 -Credential $cred

#out-gridview
get-service |Out-GridView -OutputMode Multiple | Stop-Service



#om psd1 Manifest aan te maken bij psm1 module file: (moet in dezelfde folder staan als psm1)

New-ModuleManifest -Path 'C:\Program Files\WindowsPowerShell\Modules\PStools\pstools.psd1' `
    -Author Darwin -CompanyName GK -ModuleVersion 1.0.0.0 -RootModule PSTools.psm1 `
    -PowerShellVersion 8.0 -RequiredModules activedirectory 

