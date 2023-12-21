Get-PSProvider
Get-PSDrive
Get-ChildItem -Path c: -Recurse -File -System  #dynamic paramters
Get-ChildItem -Path cert: -Recurse -SSLServerAuthentication
Get-ChildItem -Path HKLM:\SOFTWARE  
Get-ChildItem -Path alias:

cd Cert:\CurrentUser\My
cd c:\
Set-Location -Path env:
Get-ChildItem  | Select-Object *

New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS 
Set-Location HKU:
gci

Get-Command -Noun item
Get-Command -Noun ItemProperty
get-item C:\procs.html | fl *
get-item Cert:\CurrentUser\my\057A76B145239675CA222811CF5A4F9DF1AEEEB8 | fl *
get-item HKLM:\SOFTWARE\Microsoft\.NETFramework | fl *
Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\.NETFramework\  -Name InstallRoot 
Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Microsoft\.NETFramework\  -Name InstallRoot 

new-item  -Path c:\ -Name newfolder -ItemType Directory


