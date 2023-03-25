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

# The following will run the above and produce
# MOFs in C:\FileAndPrint. One MOF per node.
FileAndPrint -OutputPath C:\FileAndPrint -ComputerName LON-SVR1

# Notice that you cannot just run the script containing a Configuration.
# They are like functions; they must be explicitly called. Adding a line
# at the end of the script to call the function, as we have done here,
# is one option.


