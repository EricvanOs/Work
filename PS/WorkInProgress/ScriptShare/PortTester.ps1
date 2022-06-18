$ip = 'holland.not.online'
$port = 3389

$cerberus = New-PSSession -ComputerName cerberus
Import-Module -PSSession $cerberus -Name 'NetTCPIP' 


$conn = Test-NetConnection -ComputerName $ip -Port $port -InformationLevel Detailed

if ($conn.PingSucceeded -eq $false)
{
    $out =  'IP is not know or modem is not online'
}
elseif ($conn.TCPtestSucceeded -eq $false)
{
     $out = "modem online, but port $port not open"
}
else
{
    $out =  "$ip is online and port $port is open"
}

Get-PSSession | Remove-PSSession

[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

[System.Windows.Forms.MessageBox]::Show("$out","Status: holland.not.here")



