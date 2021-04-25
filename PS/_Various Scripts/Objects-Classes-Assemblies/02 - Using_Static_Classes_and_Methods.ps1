# Referring to the Static System.Environment Class

# not correct
[System.Environment] | Get-Member  # System.RuntimeType

#correct as it is a static class (IsAbstract and IsSealed)  --> cannot be inherited from it 

[System.Environment]  | Select-Object -Property *

# get all methods and properties
[System.Environment] | Get-Member -Static # System.Environment


# example
[System.Environment]::OSVersion


# An other static class
[System.Math] | Get-Member -Static -MemberType Methods

# use
[Math]::Sqrt(2)
