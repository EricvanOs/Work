$freeSpace = 21GB

If ($freeSpace -le 5GB) {
    Write-Host "Free disk space is less than or equal 5 GB"
} ElseIf ($freeSpace -le 10GB) {
    Write-Host "Free disk space is less than or equal 10 GB"
} ElseIf ($freeSpace -le 20GB) {
    Write-Host "Free disk space is less than or equal 20 GB"
} Else {
    Write-Host "Free disk space is more than 20 GB"
}



While ($fruit -ne 'X') {
    $fruit = Read-Host 'Name that fruit or X to escape'

    if ($fruit -eq 'Apple') {'I have an Apple'}
    elseif ($fruit -eq 'Banana') {'I have a Banana' }
    elseif ($fruit -eq 'Orange') {'I have an Orange'}
    elseif ($fruit -eq 'X') {}
    else {'Sorry, that fruit is not in the list'}
}