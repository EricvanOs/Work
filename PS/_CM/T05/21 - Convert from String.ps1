﻿Get-Item -Path '\\aphrodite\Public' | Out-Null

$netstatOutput = netstat -p tcp 
$netstatOutput

$netstatConverted = ($netstatOutput[4..$netstatOutput.Count]).Trim() | 
                ConvertFrom-String -Delimiter '[ ]{2,}' -PropertyNames Proto,LocalAddress,ForeignAddress,State
$netstatConverted

$netstatConverted | Where-Object -Property 'ForeignAddress' -Like 'Aphrodite:*' 
