#Use Get-Content to import data from a text file
Get-Content K:\_CM\H08\computers.txt 
$computers = Get-Content K:\_CM\H08\computers.txt
$computers.count
$computers

# nogmaals
$computers = Get-Content K:\_CM\H08\computers.txt -Raw
$computers.count
$computers


#Use Import-Csv to import data from a .csv file
Import-Csv K:\_CM\H08\users.csv
$users = Import-Csv K:\_CM\H08\users.csv
$users.count
$users[0]
$users[0].First
$users.First


# import csv without header information
Import-Csv K:\_CM\H08\users_no_header.csv  # niet wat je wilt
$users = Import-Csv K:\_CM\H08\users_no_header.csv -Header First,Last,FullName,Department
$users.count
$users[0]
$users[0].First
$users.First


#Use Import-Clixml to import data from an XML file
Import-Clixml K:\_CM\H08\users.xml
$usersXml = Import-Clixml K:\_CM\H08\users.xml
$usersXml.count
$usersXml[0]
$usersXml | Get-Member
$usersXml.First

