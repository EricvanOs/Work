﻿$name ='Bad'
Try {
  Get-WmiObject -Class Win32_Service -ComputerName $name -ErrorAction Stop
} 
  Catch {
  Write-Host "Error connecting to $name" -ForegroundColor DarkCyan
}



# werkt niet 

Try {
  Get-Process -Name Notepad | ForEach-Object { $PSItem.Kill() }  -ErrorAction Stop  # ErrorAction werkt niet
} 
  Catch {
  Write-Host "Cannot kill process $PSItem"
}


# werkt wel
$ErrorActionPreference  # default setting = Continue 

Try {
  $ErrorActionPreference='stop'  # maw als iets gebeurt stop
  Get-Process -Name Notepad | ForEach-Object { $PSItem.Kill() } 
} 
  Catch {
  Write-Host "Cannot kill process"
}
  Finally{
  $ErrorActionPreference='Continue'
}


# test setting
$ErrorActionPreference 