#Place items into an array
$computers = 'LON-DC1','LON-SRV1','LON-CL1'
$users = Get-ADUser -Filter *

#View the items in an array
$computers
$users
$users.count
$users[93]

#View propterties and methods for array items
$computers | Get-Member
$users | Get-Member
$users[93].UserPrincipalName

#Add an item to an array
$computers += 'LON-SRV2'
$computers

#Create an ArrayList
[System.Collections.ArrayList]$usersList = Get-ADUser -Filter *
$usersList.IsFixedSize

#Remove an item from an ArrayList
$usersList.count
$usersList[93]
$usersList.RemoveAt(93)
$usersList.count
$usersList[-1]
