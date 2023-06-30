# Dynamic ValidateSet values using classes

Class SoundNames : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $SoundPaths =   '/System/Library/Sounds/',
                        '/Library/Sounds',
                        '~/Library/Sounds'
        $SoundNames = ForEach ($SoundPath in $SoundPaths) {
            If (Test-Path $SoundPath) {
                (Get-ChildItem $SoundPath).BaseName
            }
        }
        return [string[]] $SoundNames
    }
}

# usage
Param(
    [ValidateSet([SoundNames])]
    [string]$Sound
)


$sound = 'bell'