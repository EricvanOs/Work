$freeSpace = 21GB

If ($freeSpace -lt 5GB) {
    Write-Host "Free disk space is less than 5 GB"
} ElseIf ($freeSpace -lt 10GB) {
    Write-Host "Free disk space is less than 10 GB"
} ElseIf ($freeSpace -lt 20GB) {
    Write-Host "Free disk space is less than 20 GB"
} Else {
    Write-Host "Free disk space is 20 GB or more"
}


$fruit = $null
While ($fruit -ne 'X') {
    $fruit = Read-Host 'Name that fruit or X to escape'

    if ($fruit -eq 'Apple') {'I have an Apple'}
    elseif ($fruit -eq 'Banana') {'I have a Banana' }
    elseif ($fruit -eq 'Orange') {'I have an Orange'}
    else {'Sorry, that fruit is not in the list'}
}


$fruit = $null
Do {
    $fruit = Read-Host 'Name that fruit or X to escape'

    if ($fruit -eq 'Apple') {'I have an Apple';BREAK}
    elseif ($fruit -eq 'Banana') {'I have a Banana';BREAK }
    elseif ($fruit -eq 'Orange') {'I have an Orange';BREAK}
    else {'Sorry, that fruit is not in the list'}

} Until ($fruit -eq 'X')
$fruit 