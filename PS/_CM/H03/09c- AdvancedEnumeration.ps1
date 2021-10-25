1..100 | ForEach-Object -Process {if ($_ % 2) { return }  "Hello: $_" } 

# parallel
1..100 | ForEach-Object -Parallel {if ($_ % 2) { return }  "Hello: $_" }    

# two script blocks
1..2 | ForEach-Object -Begin {'begin'} -Process {'process'}

# begin, process (2 blocks) and end
1..2 | ForEach-Object -Begin {'begin'}  -process  {'process A'},{'process B'},{'process C'} -End {'end'}


# begin, process (2*), after process and end
1..2 | ForEach-Object -Begin {'begin'}  -process {'process A'},{'process B'},{'process C'} -RemainingScripts {'after process'}  -End {'end'}



# parameter passing
$test1 = 'TestA'
1..2 | Foreach-Object -Parallel {
    $using:test1
}

# throttle
$Message = "Output:"

1..8 | ForEach-Object -Parallel {
    "$using:Message $_"
    Start-Sleep 3
} -ThrottleLimit 4



