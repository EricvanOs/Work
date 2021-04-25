New-LocalUser -Name Notepad -NoPassword

Start-Process -FilePath Notepad -WindowStyle Hidden

Get-LocalUser | Where-Object{$_.name -eq 'Notepad'} | Stop-Process  # ?? klopt 


Get-LocalUser | get-member  # name --> datatype string (ihb string Name)

get-help stop-process -online  # Accept pipeline input?       True (ByPropertyName)

# Het lukt omdat datatype=string, input=string and "True (ByPropertyName)" en naam van kolom is 't zelfde

# dit mislukt, naam van kolom is anders
Get-LocalUser | Where-Object{$_.name -eq 'Notepad'} | select-object -Property @{n='xyz';e={$_.name}} | Stop-Process


# cleanup

Remove-LocalUser -Name Notepad

