
Try {
   1/0
} 
  Catch {
  Write-Host $Error[0]  -ForegroundColor DarkCyan
}



$name ='Bad'
Try {
  Get-CimInstance -Class Win32_Service -ComputerName $name -ErrorAction Stop
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