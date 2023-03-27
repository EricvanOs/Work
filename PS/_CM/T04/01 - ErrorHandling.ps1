Get-Service -Name BITS,Nobody1,WinRM -ErrorAction Continue ; $error[0] # zie $ErrorActionPreference  # default setting = Continue 
Get-Service -Name BITS,Nobody2,WinRM -ErrorAction SilentlyContinue  ; $error[0] 
Get-Service -Name BITS,Nobody3,WinRM -ErrorAction Inquire  ; $error[0] 
Get-Service -Name BITS,Nobody4,WinRM -ErrorAction Ignore  ; $error[0] 
Get-Service -Name BITS,Nobody5,WinRM -ErrorAction Stop  ; $error[0] 



Try {
   1/0
} 
  Catch {
  Write-Host $Error[0]  -ForegroundColor DarkCyan
}

# does not work
$name ='Bad'
Try {
  Get-CimInstance -Class Win32_Service -ComputerName $name 
} 
  Catch {
  Write-Host "Error connecting to $name" -ForegroundColor DarkCyan
}


# force a "Stop" when an error occurs
$name ='Bad'
Try {
  Get-CimInstance -Class Win32_Service -ComputerName $name -ErrorAction Stop
} 
  Catch {
  Write-Host "Error connecting to $name" -ForegroundColor DarkCyan
}


# does not work: A terminating error in one scriptblocks may not cause the termination of the Foreach-Object cmdlet
Try {
  Get-Process -Name Notepad | ForEach-Object { $PSItem.Kill() }  -ErrorAction Stop  # ErrorAction werkt niet
} 
  Catch {
  Write-Host "Cannot kill process $PSItem"
}


# werkt wel
$ErrorActionPreference  # default setting = Continue 

Try {
  $ErrorActionPreference='stop'  # if error occurs then stop
  Get-Process -Name Notepad | ForEach-Object { $PSItem.Kill() } 
} 
  Catch {
  Write-Host "Cannot kill process" -ForegroundColor DarkCyan
}
  Finally {
  $ErrorActionPreference='Continue'
}


# test setting
$ErrorActionPreference 