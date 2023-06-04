function Show-FileInfo ()
{
  [CmdletBinding()]
  param ( [Parameter (ValueFromPipeline)]
          $file
        )

  BEGIN {
    $fn = "$($PSCmdlet.MyInvocation.MyCommand.Name)"
    $st = Get-Date
    Write-Verbose @"
  `r`n  Function: $fn
  Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@
  }


  PROCESS {
    $retVal = "$($file.Name) is {0:N0} bytes long." -f $file.Length
    $retVal
  }

  
  END {
    $et = Get-Date

    $rt = $et - $st  # Run Time

    # Format the output time
    if ($rt.TotalSeconds -lt 1)
      { $elapsed = "$($rt.TotalMilliseconds.ToString('#,0.0000')) Milliseconds" }
    elseif ($rt.TotalSeconds -lt 60)
      { $elapsed = "$($rt.TotalSeconds.ToString('#,0.0000')) Seconds" }
    else
      { $elapsed = "$($rt.TotalMinutes.ToString('#,0.0000')) Minutes" }

    Write-Verbose @"
    `r`n  Function: $fn
    Finished at $($et.ToString('yyyy-MM-dd hh:mm:ss tt'))
    Elapsed Time $elapsed
"@
  }
}  

#test function
Get-ChildItem -Path C:\Work\PS\Temp | Show-FileInfo -Verbose