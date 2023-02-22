#Verify script location
Set-Location k:\_cm\H08\
Get-ChildItem HelloWorld.ps1

#Run a script using a full path
k:\_cm\H08\HelloWorld.ps1

#Run a script fromt the current directory
HelloWorld.ps1 #gaat fout
.\HelloWorld.ps1

#Set the execution policy
Get-ExecutionPolicy -List
Set-ExecutionPolicy Unrestricted -Scope CurrentUser  # lukt niet vanwege GPO
.\HelloWorld.ps1 
Changing execution policy
# Set-ExecutionPolicy Restricted -Scope CurrentUser

# cleanup
Set-Location c:
