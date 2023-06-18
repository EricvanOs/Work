Connect-MgGraph -Scopes 'User.Read.All','User.ReadWrite.All'

# 
Get-MgUser | Where-Object{$_.DisplayName -eq 'Marcus Aurelius'}

Get-MgUser | Where-Object{$_.DisplayName -eq 'Marcus Aurelius'} | get-member

# change settings
$UserParams = @{
    City = 'Rome'
}

Update-MgUser @UserParams  -UserId 'Caesar@in-li.eu'


Get-MgUser  | Where-Object{$_.DisplayName -eq 'Marcus Aurelius'} | Select-Object -Property JobTitle