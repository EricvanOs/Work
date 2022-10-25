# 1
Get-ADComputer -Filter * | Get-HotFix   # gaat fout 

# 2
Get-ADComputer -Filter * | Get-Member

# 3  iets anders zoeken
Get-Help Get-Hotfix -Online  # ByPropertyName  -- ComputerName

Get-HotFix -ComputerName Hydra,Apate
Get-HotFix -Description Update 
Get-HotFix -Id KB5013888


# maw een computername,id of description als input voor get-hotfix
# alleen Accept pipeline input: True voor ComputerName

Get-ADComputer -Filter("Name -like 'hy*ra*' ") | 
  Select-Object -Property @{n='ComputerName';e={$_.Name}}  | 
  Get-HotFix 





