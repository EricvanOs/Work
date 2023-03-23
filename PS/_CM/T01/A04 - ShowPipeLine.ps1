function Show-Pipeline {
    begin {
        $position = $myinvocation.PipelinePosition
        Write-Host "Pipeline position ${position}: Start"
    }
    process {
        Write-Host "Pipeline position ${position}: $_"
    $_
    }
    end {
        Write-Host "Pipeline position ${position}: End"
    }
}

$list = 1..3 | Show-Pipeline
1..3 | Show-Pipeline
1..3 | Out-Null | Show-Pipeline
1..3 | Out-Default | Show-Pipeline

####################
function Invoke-Return {
    process {
        if ($_ -gt 2 -and $_ -lt 8) {return 'A'}
        $_
    }
    end {
        'All done'
    }
 }
  
 1..10 | Invoke-Return

function Invoke-Break {
    process {
        if ($_ -gt 2 -and $_ -lt 8) {break}
        $_
    }
    end {
        'All done'
    }
}

1..10 | Invoke-Break

