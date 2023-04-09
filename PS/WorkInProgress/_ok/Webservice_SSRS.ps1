$URI = "http://eos/ReportServer/ReportService2010.asmx?wsdl"
$ssrs = New-WebServiceProxy -Uri $URI -Namespace WebServiceProxy -Class SSRS -UseDefaultCredential 

$ssrs |Get-Member -type Method | Where-Object {$_.name -like 'get*'}

$ssrs.GetReportServerConfigInfo($false)

$ssrs |Get-Member -type Method | Where-Object {$_.name -like 'list*'}

$all = $ssrs.ListChildren("/",$true)
$all | select-object Name,path