$a = ('pallas','hypnos')
$a

get-process -ComputerName pallas,hypnos
Get-Process -ComputerName 'pallas','hypnos'
Get-Process -ComputerName ('pallas','hypnos')
Get-Process -ComputerName $a


$b = 'pallas','hypnos'
$b
Get-Process -ComputerName $b

Get-Help about_if -ShowWindow

if ($a -eq $b)
        {
            Write-Host "The value $a is equal to $b."
        }
else
        {
            Write-Host "The value $a is not equal to $b."
        }

$a.gettype() #array
$b.gettype() #array


Compare-Object -ReferenceObject $a  -DifferenceObject $b

$a = 'pallas','hypnos'
$c = 'pandora','hypnos','eos'

Compare-Object -ReferenceObject $a -DifferenceObject $c #    
Compare-Object -ReferenceObject $c -DifferenceObject $a 

$d = 'hypnos','pandora'
Compare-Object -ReferenceObject $a -DifferenceObject $d

Compare-Object -ReferenceObject $a  -DifferenceObject $b  # empty -> $a ~ $b



[int]$a=2 
$a | Get-Member
$a.GetType()

[string]$b='2'
$b | Get-Member
$b.GetType()


