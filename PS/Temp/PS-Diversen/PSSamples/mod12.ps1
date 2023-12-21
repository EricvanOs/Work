function export-secret
{param([string]$secret,[string]$path,[byte[]]$key)
    $SString=ConvertTo-SecureString -String $secret -AsPlainText -Force
    ConvertFrom-SecureString -SecureString $SString -key $key | Set-Content -Path $path
}


function import-secret
{param([string]$path,[byte[]]$key)
    Get-Content -Path $path | Convertto-SecureString -Key $key
}

#locaal exporteren en importeren--> geen key nodig indien zelfde user en machine!!
export-secret -secret "P@ssw0rd" -path C:\PSSamples\localsecret.txt
$sstring=import-secret -Path C:\PSSamples\localsecret.txt 
#check
$cred=New-Object System.Net.NetworkCredential "user",$sstring
$cred.Password



#op machine 1
[byte[]]$simplekey=(1..16)
export-secret -secret "P@ssw0rd" -path C:\PSSamples\secret.txt -key $simplekey


#op machine 2
[byte[]]$simplekey=(1..16) #moet dezelfde key als op machine 1 zijn !!!
$sstring=import-secret -Path C:\PSSamples\secret.txt -key $simplekey
#ConvertFrom-SecureString $sstring -Key $simplekey
#check
$cred=New-Object System.Net.NetworkCredential "user",$sstring
$cred.Password




function Set-Permisssions
{
[cmdletbinding()]
param([string]$path,[string]$user,[string]$Permission="FullControl")
if (Test-Path $path)
    {
    $ACL = get-acl -Path $path
    #[System.Security.AccessControl.FileSystemAccessRule]::new
    #[enum]::GetValues("System.Security.AccessControl.FileSystemRights")
    
    $ACE=New-Object System.Security.AccessControl.FileSystemAccessRule $User,$Permission,"allow"
    $acl.AddAccessRule($ace)
    Set-Acl -Path $path -AclObject $ACL
    }
else
    {
    Write-Output "invalid path: $path"
    }

}

Get-LocalUser

Set-Permisssions -user $env:COMPUTERNAME\Darwin -path C:\PSSamples -Permission FullControl