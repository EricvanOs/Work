Configuration FileAndPrint {
    param(
        [string[]]$ComputerName
    )

    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

    Node $ComputerName {

        WindowsFeature PrintServer {
            Name   = 'Print-Server'
            Ensure = 'Present'
        }

        WindowsFeature DataDeduplication {
            Name   = 'FS-Data-Deduplication'
            Ensure = 'Present'
        }

        WindowsFeature BITS {
            Name   = 'BITS'
            Ensure = 'Present'
        }

     } #node
} #configuration


