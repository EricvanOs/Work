
# PowerShell is built on .NET. You can interact with .NET in many ways with PowerShell. 
# Many PowerShell modules are also .NET assemblies. Different ways to load .NET Assemblies into PowerShell.


# Add-Type
# You can load assemblies using the Add-Type cmdlet. Specify the -AssemblyName parameter to load assemblies from either the global assembly cache or from a path.
Add-Type -AssemblyName 'System.Windows.Forms'
Add-Type -AssemblyName 'C:\src\universal\src\output\Universal.Cmdlets.dll'

# Assembly.LoadFrom
# You can also load assemblies using the System.Reflection.Assembly.LoadFrom method. This method accepts a path and will return the assembly object after loading it.
[System.Reflection.Assembly]::LoadFrom('C:\src\universal\src\output\Universal.Cmdlets.dll')

# Assembly.LoadWithPartialName
# The Assembly.LoadWithPartialName method will load an assembly from the global assembly cache based on a partial name of the assembly. 
# This is similar to how Add-Type -AssemblyName works.
[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')

# Import-Module
# Import-Module will also load assemblies. It will also expose any cmdlets provided by the assembly if they exist. You cannot load exe assemblies with Import-Module.
Import-Module 'C:\src\universal\src\output\Universal.Cmdlets.dll'

# using Statement
# You can also load assemblies with the using statement. This loads the assemblies at parse time rather than execution time and is used when defining PowerShell classes.
using assembly C:\src\universal\src\output\Universal.Cmdlets.dll