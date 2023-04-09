function DFS_ExportSettings{
    param()
    
    $ses = New-PSSession -ComputerName sisyphus
    Invoke-Command -Session $ses -ScriptBlock{

    $path = '\\pantheon\data\misc\Backups\DFS\'
    $d = (get-date).ToString("yyyy-MM-dd");
    new-item -Path $path  -name $d -ItemType directory;
    $fullpath = $path + $d + '\'

    # get all dfsn roots
    $roots = Get-DfsnRoot

    # get all roottargets belonging to each root path
    $roottargets = foreach($root in $roots){
        Get-DfsnRootTarget  -path $root.Path 
    }


    # get all folders belonging to each root path
    $folders = foreach ($root in $roots){
        Get-DfsnFolder -path ($root.path + '\*')
    }


    # get all foldertargets belonging to each folder path
    $targets = foreach($folder in $folders){
        Get-DfsnFolderTarget -Path ($folder.path)
    }


    $serverconfig = Get-DfsnServerConfiguration -ComputerName tantalus

    #opslaan in xmlcli

    $roots |  Export-Clixml -Path ($fullpath + 'roots.xml')
    $roottargets | Export-Clixml -Path ($fullpath + 'roottargets.xml')
    $folders | Export-Clixml -Path ($fullpath + 'folders.xml')
    $targets | Export-Clixml -Path ($fullpath + 'targets.xml')
    $serverconfig | Export-Clixml -Path ($fullpath + 'serverconfig.xml')

    }

    Remove-PSSession $ses
}
