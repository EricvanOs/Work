function Show-FileInfo ()
{
  [CmdletBinding()]
  param ( [Parameter (ValueFromPipeline)]
          $file
        )
 
  begin
  {
    $fn = "$($PSCmdlet.MyInvocation.MyCommand.Name)"
    $st = Get-Date
    Write-Verbose @"
  `r`n  Function: $fn
  Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@
  }
 
  process
  {
    $retVal = "$($file.Name) is {0:N0} bytes long." -f $file.Length
    $retVal
  }
 
  end
  {
    $et = Get-Date
 
    $rt = $et - $st  # Run Time
 
    # Format the output time
    if ($rt.TotalSeconds -lt 1)
      { $elapsed = "$($rt.TotalMilliseconds.ToString('#,0.0000')) Milliseconds" }
    elseif ($rt.TotalSeconds -gt 60)
      { $elapsed = "$($rt.TotalMinutes.ToString('#,0.0000')) Minutes" }
    else
      { $elapsed = "$($rt.TotalSeconds.ToString('#,0.0000')) Seconds" }
 
 
    Write-Verbose @"
  `r`n  Function: $fn
  Finished at $($et.ToString('yyyy-MM-dd hh:mm:ss tt'))
  Elapsed Time $elapsed
"@
  }
}  


Get-ChildItem -Path k:\temp | Show-FileInfo -Verbose