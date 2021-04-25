# Some additional formatting
Get-Service | Format-Table -property @{n='alias'; e={$_.name}; align='left';width=40},@{n='status'; e={$_.status}; align='right';width=8},displayname 

Get-Process | Format-Table name,@{n='VM(MB)' ; e={$_.VM / 1MB -as [int]}}


# of
Get-Process | Select-Object -First 5 |  Select-Object name,@{n='VM(MB)' ; e={$_.VM / 1MB -as [int]}}

# name,n,label,l ; expression,e
# of
$prop = @{n='VM(MB)'  
          e={$_.VM / 1MB -as [int]}
         }

Get-Process | Select-Object -First 5 |  Select-Object -Property name,$prop