Test-NetConnection -ComputerName holland.not.here -Port 3389 -InformationLevel Detailed

Test-NetConnection -ComputerName holland.not.here -Port 3388 -InformationLevel Detailed

Test-NetConnection -ComputerName hypnos -Port 1433 -InformationLevel Detailed

Test-NetConnection -ComputerName hypnos -Port 1436 -InformationLevel Detailed

Test-NetConnection -ComputerName hypnoz -Port 1436 -InformationLevel Detailed



$conn  = Test-NetConnection -ComputerName holland.not.here  -Port 3389 -InformationLevel Detailed
$conn2 = Test-NetConnection -ComputerName onetawan.ddns.net -Port 3389 -InformationLevel Detailed

if ($conn.PingSucceeded -eq $false)
{
    write-host 'Ip-Number of holland.not.here is not know or modem of holland.not.here is not online'
}
elseif ($conn.TCPtestSucceeded -eq $false)
{
     write-host 'modem online of holland.not.here, but port 3389 not open on Holland.not.here'
}
else
{
    write-host 'holland.not.here is online and port 3389 is open'
}

$cred = Get-Credential -Message 'connection to holland.not.here' -UserName admin

$response = Invoke-WebRequest http://holland.not.here -Credential $cred

if ($response.StatusCode -eq 200)
{
    write-host 'connection is ok'
}
else
{
    write-host 'connection is not possible'
}


