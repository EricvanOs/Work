function UploadReports ($reportServerName = $(throw "reportServerName is required."), 
    $fromDirectory = $(throw "fromDirectory is required."), $serverPath = $(throw "serverPath is required."))
{
    Write-Output "Connecting to $reportServerName"
    $reportServerUri = "http://{0}/ReportServer/ReportService2010.asmx" -f $reportServerName
    $proxy = New-WebServiceProxy -Uri $reportServerUri -Namespace SSRS.ReportingService2010 -UseDefaultCredential
    
    Write-Output "Inspecting $fromDirectory"
    # coerce the return to be an array with the @ operator in case only one file
    $files = @(get-childitem $fromDirectory *.rdl -rec|where-object {!($_.psiscontainer)})
    
    $uploadedCount = 0
    
    foreach ($fileInfo in $files)
    {    
        $file = [System.IO.Path]::GetFileNameWithoutExtension($fileInfo.FullName)        
        $percentDone = (($uploadedCount/$files.Count) * 100)        
        Write-Progress -activity "Uploading to $reportServerName$serverPath" -status $file -percentComplete $percentDone
        Write-Output "%$percentDone : Uploading $file to $reportServerName$serverPath"
        $bytes = [System.IO.File]::ReadAllBytes($fileInfo.FullName)
        $warnings = $proxy.CreateReport($file, $serverPath, $true, $bytes, $null)
        
        if ($warnings)
        {
            foreach ($warn in $warnings)
            {
                Write-Warning $warn.Message
            }
        }
        
        $uploadedCount += 1
    }    
}


# Calling the function is straightforward:

# UploadReports "report-server.domain.com" "c:\temp" "/TEST1/AppName"


UploadReports "selene.pantheon.somewhere" "D:\Upload" "/Test"