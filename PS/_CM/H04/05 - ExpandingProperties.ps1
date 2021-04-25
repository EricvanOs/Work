# 1
Get-ADComputer -Filter ('Name -like "hy*a*"')

# goes wrong
Get-Service -ComputerName (Get-ADComputer -Filter ('Name -like "hy*a*"'))

get-service -ComputerName (Get-ADComputer -Filter ('Name -like "hy*a*"') | Select-Object -Property Name)

# 3
Get-ADComputer -Filter ('Name -like "hy*a*"') | Get-Member

# 4
Help Get-Service -ShowWindow #computername should be a string[]

# 5

Get-ADComputer -Filter ('Name -like "hy*a*"') | Select-Object -Property Name  # merk op een kolom met naam

# 6
Get-ADComputer -Filter ('Name -like "hy*a*"') | Select-Object -Property Name | Get-Member # a string datatype

# dit werkt niet, omdat 't stuk tussen haakjes een kolom met een naam terug geeft 
Get-Service -ComputerName (Get-ADComputer -Filter ('Name -like "hy*a*"') | Select-Object -Property Name)

# 7 create a column without name. only entries, no header
Get-ADComputer -Filter ('Name -like "hy*a*"') | Select-Object -ExpandProperty Name

# 8
Get-ADComputer -Filter ('Name -like "hy*a*"') | Select-Object -ExpandProperty Name | 
  Get-Member #type string

# nu werkt 't wel
Get-Service -ComputerName (Get-ADComputer -Filter ('Name -like "hy*a*"') | 
  Select-Object -ExpandProperty Name)


