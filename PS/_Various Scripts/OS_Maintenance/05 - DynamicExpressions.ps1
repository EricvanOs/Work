Invoke-Command -ScriptBlock{Get-Process}

$cmd = 'get-service'

Invoke-Command -ScriptBlock{$cmd} # lukt niet

Invoke-Expression -Command ($cmd)

#mag ook op deze wijze
&$cmd
# of ..
Invoke-Command -ScriptBlock{&$cmd}

# anders
$commandString = @('notepad', 'HelloWorld.txt') -join ' '

&([scriptblock]::create($commandstring))

# cleanup if necessary
if (test-path -Path .\HelloWorld.txt) {Get-ChildItem -Path .\HelloWorld.txt | Remove-Item}