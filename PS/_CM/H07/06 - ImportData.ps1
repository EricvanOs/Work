Set-Location -Path 'C:\Work\PS\_CM\H07'

#Use Get-Content to import data from a text file
Get-Content .\computers.txt 
$computers = Get-Content .\computers.txt
$computers
$computers.count


# nogmaals
$computers = Get-Content .\computers.txt -Raw
$computers
$computers.count



#Use Import-Csv to import data from a .csv file
Import-Csv .\users.csv
$users = Import-Csv .\users.csv
$users
$users.count
$users[0]
$users[0].FirstName
$users.FirstName


# import csv without header information
Import-Csv .\users_no_header.csv  # niet wat je wilt
$users = Import-Csv .\users_no_header.csv -Header FirstName,LastName,FullName,Department
$users
$users.count
$users[0]
$users[0].FirstName
$users.FirstName


#Use Import-Clixml to import data from an XML file
Import-Clixml .\users.xml
$usersXml = Import-Clixml .\users.xml
$usersXml
$usersXml.count
$usersXml[0]
$usersXml | Get-Member
$usersXml.FirstName

