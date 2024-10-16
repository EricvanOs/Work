﻿#Create a hash table of user names and their department
$users = @{'Lara'='IT';'Peter'='Managers';'Sang'='Sales'}

#Display the contents of the hash table
$users
$users.Lara

#Update a value in the hash table
$users.Sang = 'Marketing'
$users

#Add an item to the hash table
$users.Add('Tia','Research')

#Remove an item from the hash table
$users.Remove('Sang')
$users

#Creating calculated properties uses a hash table
$prop = @{n='Size(KB)';e={$_.Length/1KB}}
$prop
Get-ChildItem C:\Windows -File | Format-Table Name,Length
Get-ChildItem C:\Windows -File | Format-Table Name,$prop
Get-ChildItem C:\Windows -File | Select-Object -Property Name,$prop

# ordered hash table
$o = [ordered]@{a=1;b=2;c=3;d=4}
$o

$no = @{a=1;b=2;c=3;d=4}
$no