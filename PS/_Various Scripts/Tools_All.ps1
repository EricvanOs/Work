# create symbolic link and move files to share
$comp = ($env:Computername).substring(0,1).toupper()+($env:Computername).substring(1).tolower()
$path = "\\pantheon\data\misc\Tools_All\$comp"
if ((Test-Path -Path $path) -eq $false)
    {
        New-Item $path -ItemType Directory
        if (Test-Path -Path 'C:\Tools_All')
        {
            Get-ChildItem -Path 'C:\Tools_All' -Recurse | Move-Item -Destination $path 
            Remove-Item -Path 'C:\Tools_All'
        }
        New-Item -Path C:\Tools_All -ItemType SymbolicLink -Value $path
    }


    