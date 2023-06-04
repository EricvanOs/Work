1..3    | Foreach-Object -PipelineVariable First -Process { $_ }  
        | Foreach-Object -PipelineVariable Second -Process { 7..8 } 
        | Foreach-Object -Process {"$First,$Second" + ' --> ' + "$First*$Second = " + ($First*$Second) }



