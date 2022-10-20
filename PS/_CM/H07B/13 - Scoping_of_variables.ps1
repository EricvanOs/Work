#scoping of variables

$myLogText = 'Rene'  # outer variable
function AddLog2 ($Message)
{
    $myLogText += ($Message)  # letop variable mylogtext is slechts in de scope (Addlog2) beschikbaar; inner variable
    Write-Host $myLogText
}
AddLog2 ('Hallo')
AddLog2 ('Hallo')
Write-Host $myLogText


# vergelijk met

$global:myLogText = 'Rene'
function AddLog ($Message)
{
    $global:myLogText += ($Message)
}
AddLog (' Hallo')
AddLog (' Hallo')
Write-Host $global:myLogText