function Backup-SSIS{ 
<#
.SYNOPSIS
Backups SSIS folder of machines
.DESCRIPTION
Backups SSIS folder of machines.
.PARAMETER ComputerName
The computernames
.EXAMPLE
.\Backup-SSIS -ComputerName 'Hypnos','Eos'
#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string[]]
    $ComputerName
)



#hypnos en anderen folder per machine


$backupfolder = '\\pantheon\data\misc\Backups\SSIS\'
$d = (get-date).ToString("yyyy-MM-dd");


foreach($comp in $computername){

    $backuplocation = Test-Path -Path ($backupfolder + "$comp")
    if (!($backuplocation)){
        New-Item -Path ($backupfolder + "$comp") -ItemType Directory
        }
    New-Item -Path ($backupfolder + "$comp" + '\' + "$d") -ItemType Directory
    Copy-Item -path ('\\' + $comp + '\c$\SSIS\*') -Destination ($backupfolder + "$comp" + '\' + "$d" +'\') -Recurse 
}

}

