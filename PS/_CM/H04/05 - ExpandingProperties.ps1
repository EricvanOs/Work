
# run the following script in ISE 
# get-service has changed in ps 7

# 1
Get-ADComputer -Filter ('Name -like "e*us"')

# goes wrong
Get-Service -ComputerName (Get-ADComputer -Filter ('Name -like "e*us"'))

get-service -ComputerName (Get-ADComputer -Filter ('Name -like "e*us"') | Select-Object -Property Name)

# 3
Get-ADComputer -Filter ('Name -like "e*us"') | Get-Member

# 4
Help Get-Service -online #computername should be a string[]

# 5

Get-ADComputer -Filter ('Name -like "e*us"') | Select-Object -Property Name  # merk op een kolom met naam

# 6
Get-ADComputer -Filter ('Name -like "e*us"') | Select-Object -Property Name | Get-Member # Selected....ADComputer

# dit werkt niet, omdat 't stuk tussen haakjes een kolom met een naam terug geeft 
Get-Service -ComputerName (Get-ADComputer -Filter ('Name -like "e*us"') | Select-Object -Property Name)

# 7 create a column without name. only entries, no header
Get-ADComputer -Filter ('Name -like "e*us"') | Select-Object -ExpandProperty Name

# 8
Get-ADComputer -Filter ('Name -like "e*us"') | Select-Object -ExpandProperty Name |   Get-Member #type string

# nu werkt 't wel
Get-Service -ComputerName (Get-ADComputer -Filter ('Name -like "e*us"') | 
  Select-Object -ExpandProperty Name)

Get-Service -ComputerName (Get-ADComputer -Filter ('Name -like "e*us"') | 
  Select-Object -ExpandProperty Name) | Select-Object -Property MachineName,DisplayName,Status



