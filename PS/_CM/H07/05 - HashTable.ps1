#Create a hash table of user names and their department
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
#Name and Expression are the required items
#You can shorten to n and e
$prop = @{n='Size(KB)';e={$_.Length/1KB}}
$prop
Get-ChildItem C:\Windows -File | Format-Table Name,Length
Get-ChildItem C:\Windows -File | Format-Table Name,$prop
Get-ChildItem C:\Windows -File | Select-Object -Property Name,$prop

##
$comps = 'eos','hypnos'

Get-Process -ComputerName $comps | Sort-Object id | 
  Select-Object -Property MachineName,ProcessName -First 5

$comps | Get-Process  # gaat fout

#hash table definitie aanmaken
$prop = @{n='ComputerName';e={$PSItem}}

#dan gebruiken
$comps | Select-Object -Property $prop | Get-Process  | Sort-Object id | 
  Select-Object -Property ProcessName -First 5

# mag ook zo
Get-Process -ComputerName $comps  | Sort-Object id | 
  Select-Object -Property MachineName,ProcessName -First 5

# andere opbouw als input file
$comps = 'eos,hypnos'
Get-Process -ComputerName ($comps -split ',') | Sort-Object id | 
  Select-Object -Property MachineName,ProcessName -First 5


# ordered hash table
$ordered = [ordered]@{a=1;c=3;b=2}
$nonordered = @{a=1;c=3;b=2}

$ordered
"`r"
$nonordered

