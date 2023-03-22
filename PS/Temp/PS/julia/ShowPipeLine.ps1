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

$result = 1..3 | Show-Pipeline



####################
function Invoke-Return {
    process {
        if ($_ -gt 2) {return 7}
        $_
    }
    end {
        'All done'
    }
 }
  
 1..10 | Invoke-Return


function Invoke-Break {
    process {
        if ($_ -gt 2) {break}
        $_
    }
    end {
        'All done'
    }
}

1..10 | Invoke-Break


function Invoke-Continue {
    process {
        if ($_ -gt 2 ) {continue}
        $_
    }
    end {
        'All done'
    }
}

1..10 | Invoke-Continue