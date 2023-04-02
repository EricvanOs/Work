Get-Help Get-Process -Online

# test 
Start-Process -FilePath Notepad -WindowStyle Hidden
Get-Process notepad
$id = (Get-Process notepad).id
Get-Process $id   # fail because parameter id is a "named" parameter 
Get-Process -Id $id




# looking for hotfixes on specific computers

Get-Help Get-HotFix -Online

# doesn't work 
Get-ADComputer -Filter * | Get-HotFix
# neither works (still an object)
Get-ADComputer -Filter * | Select-Object -Property name | Get-HotFix

# want to use name (from get-adcomputer) as computername in get-hotfix
# create an extra column with correct name

Get-ADComputer -Filter 'Name -like "e*us"' | Select-Object @{n='ComputerName';e={$_.name}} 

# now a pipe into get-hotfix

Get-ADComputer -Filter 'Name -like "e*us"' | Select-Object @{n='ComputerName';e={$_.name}} | Get-HotFix


# Verify if an update is installed and if not, write computer name to a file
# looks as if it doesn't work, but it does, albeit error messages

Set-Location -Path k:\
$hotfixid = 'KB957095'
$servers = Get-Content -Path .\Servers.txt
$servers | ForEach-Object { if (!(Get-HotFix -Id $hotfixid -ComputerName $_)){ 
    Add-Content $_ -Path .\"Missing-$($hotfixid).txt" }
}

# test
Get-HotFix -ComputerName erebus -Id xyz
Get-HotFix -ComputerName erebus -Id xyz -ErrorAction SilentlyContinue

# again
Set-Location -Path k:\
$hotfixid = 'KB957095'
$servers = Get-Content -Path .\Servers.txt
$servers | ForEach-Object { if (!(Get-HotFix -Id $hotfixid -ComputerName $_  -ErrorAction SilentlyContinue)){ 
    Add-Content $_ -Path .\"Missing-$($hotfixid).txt" }
}

# test output
Get-Content -Path .\"Missing-$($hotfixid).txt"

#cleanup
"Missing-$($hotfixid).txt" | Remove-Item 

