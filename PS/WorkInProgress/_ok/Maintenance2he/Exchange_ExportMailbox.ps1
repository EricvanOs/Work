function Exchange_ExportMailbox{
    param()

    $Ses = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://iris.pantheon.somewhere/PowerShell/ -Authentication Kerberos

    Import-PSSession $Ses

    $BackupPath = '\\pantheon\data\misc\Backups\Exchange'  + '\' + (get-date).ToString("yyyy-MM-dd")
    New-Item $BackupPath  -type directory

    $FilePath =  "$BackupPath" + '\' + 'administrator.pst'
    New-MailboxExportRequest -Mailbox 'administrator' -FilePath  $FilePath

    $FilePath = "$BackupPath" + '\' + 'Eric van Os.pst'
    New-MailboxExportRequest -Mailbox 'Eric van Os' -FilePath  $FilePath

    Remove-PSSession $Ses
}

