# start five background jobs each running 1 second
Measure-Command {1..5 | ForEach-Object {Start-Job {Start-Sleep 1}} | Wait-Job} | Select-Object TotalSeconds
Measure-Command {1..5 | ForEach-Object {Start-ThreadJob {Start-Sleep 1}} | Wait-Job} | Select-Object TotalSeconds