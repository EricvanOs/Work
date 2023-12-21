$profile #heeft andere waarde in ISE/Console/Externe editor

#array test
$namen=@("Marc","Els","Ben","Darwin")
$namen -contains "Marc"
"Darwin" -in $namen

#multidimensional array
$wSheet = new-object 'int[,]'(2,3)
$wSheet[0,0]=5466
$wSheet[0,1]=54
$wSheet[0,2]=5684768
$wSheet[0,3]=5466 #fout!!
$wSheet[1,0]=54
$wSheet
$wSheet.Count
$wSheet.Rank   #aantal dimensies
$wSheet.GetLength(0) #aantal rijen
$wSheet.GetLength(1) #aantal kolommen
$wSheet.GetUpperBound(0)

#JaggedArray
$JaggedArr=@(@(654,684),@(6847,798,684984,98,689,8488,4),@(64,6847,54))
$JaggedArr[1][4]



#formatting
Get-Process | Select-Object  Vm,@{N='VM(MB)';e={($psitem.VM/1MB)}}
Get-Process | Select-Object  Vm,@{N='VM(MB)';e={"{0,15:N2}"  -f  ($psitem.VM/1MB)}}
get-process | Format-Table  processname,VM,@{N='VM(MB)';e={($psitem.VM/1MB)};f="{0:N2}";a='center' }
get-process | select-object  processname,VM,@{N='VM(MB)';e={($psitem.VM/1MB)};f="{0:N2}";a='center' } #fout!!

#NTFS permissies
get-acl -Path C:\PSSamples | select -ExpandProperty Access



#passwoord/securestring
$pwd=Read-Host -Prompt "PWD?" -AsSecureString
$pwd
$mysecret=ConvertFrom-SecureString -SecureString $pwd
$importedPWD=ConvertTo-SecureString $mysecret   #werkt ALLEEN op machine waar pwd is aangemaakt!!
$fakeUser=New-Object System.Net.NetworkCredential "ikke",$importedPWD
$fakeUser.Password


#$cred=Get-Credential
#ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force


