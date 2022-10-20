<#
Set-ExecutionPolicy RemoteSigned
Enable-PSRemoting

# If you get an error about a network connection being Public, 
# run Enable-PSRemoting -SkipNetwork instead. 
# It's one you'll see a lot.
#>

#1
Get-PSSession   # no sessions

# 2
Enter-PSSession -ComputerName sisyphus 

# 3
Get-Process

# 4
Exit-PSSession

# 5
Invoke-Command -ComputerName sisyphus,tantalus  -ScriptBlock { Get-EventLog -LogName Security -Newest 10 }






