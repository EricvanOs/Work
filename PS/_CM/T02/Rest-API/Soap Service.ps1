New-WebServiceProxy
The New-WebServiceProxy command is used to connect to a SOAP web service. 


Throughout this section, localhost and a port are used to connect to the
web service. The port is set by Visual Studio when debugging the simple
SOAP web service and must be updated to use these examples

$params = @{
    Uri = 'http://localhost:62369/Service.asmx'
    Namespace = 'SOAP'
}
 $service = New-WebServiceProxy @params
   

 $service.GetElements() | Select-Object -First 5 | Format-Table

 service.GetAtomicNumber('oxygen')

 $service.GetAtomicMass('H')