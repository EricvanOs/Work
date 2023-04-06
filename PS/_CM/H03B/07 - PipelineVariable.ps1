1..10 | Foreach-Object -PipelineVariable Left -Process { $_ } | 
        Foreach-Object -PipelineVariable Right -Process { 1..10 } | 
        Foreach-Object -Process { "$Left * $Right = " + ($Left*$Right) }