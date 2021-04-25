$URI = 'http://selene/ReportServer/ReportService2010.asmx?wsdl'
$ssrs = New-WebServiceProxy -Uri $URI -Namespace ReportServer -Class SSRS -UseDefaultCredential 

$ssrs |Get-Member -Type Method | Where-Object {$_.name -like 'get*'}

$ssrs.GetReportServerConfigInfo($false)

$ssrs |Get-Member -Type Method | Where-Object {$_.name -like 'list*'}

$all = $ssrs.ListChildren('/',$true)
$all | Select-Object -Property Name,Path