# Variables
$ServerName = 'eos'
$Catalog = 'SSISDB'
$FolderName = 'Alles'
$ProjectName = 'Audit'
$PackageName = 'Audit.dtsx'

$Path = "sqlserver:\ssis\$ServerName\default\Catalogs\$Catalog\Folders\$FolderName\Projects\$ProjectName\Packages"

Invoke-Command -ComputerName $ServerName -ScriptBlock{
    import-module -name sqlserver    
    (Get-ChildItem -Path $using:Path | Where-Object{$_.name -eq $using:PackageName}).execute($false,$null)

}

