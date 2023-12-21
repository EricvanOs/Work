[System.AppDomain]::CurrentDomain.GetAssemblies() | 
Where-Object Location | Sort-Object -Property FullName | 
Select-Object -Property FullName, Location, GlobalAssemblyCache, IsFullyTrusted | Out-GridView

[system.AppDomain]::CurrentDomain.GetAssemblies().gettypes()

[system.math].GetMembers
[system.math].GetProperties()
[system.math].Getmethods() | select name
