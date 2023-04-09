function WSUSServer_Cleanup{
    param()

    $NoTimeout = New-PSSessionOption -OperationTimeout 0
    $ses = New-PSSession -ComputerName athena.pantheon.somewhere -SessionOption $NoTimeout -Name 'WSUSCleanUp'
    Invoke-Command -Session $ses -ScriptBlock{

        Get-WsusServer |  Invoke-WsusServerCleanup -CleanupObsoleteUpdates;
        Get-WsusServer |  Invoke-WsusServerCleanup -CleanupUnneededContentFiles;
        Get-WsusServer |  Invoke-WsusServerCleanup -DeclineExpiredUpdates;
        Get-WsusServer |  Invoke-WsusServerCleanup -DeclineSupersededUpdates;
    } -AsJob -JobName 'Cleanup'

    Get-Job 'Cleanup' | Wait-Job

    Receive-Job 'Cleanup' 

    Remove-Job 'Cleanup'

    Get-PSSession -Name 'WSUSCleanup' | Remove-PSSession
}
