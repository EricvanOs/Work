1..3    | Foreach-Object -PipelineVariable Left -Process { $_ }  
        | Foreach-Object -PipelineVariable Right -Process { 7..8 } 
        | Foreach-Object -Process { "$Left * $Right = " + ($Left*$Right) }


