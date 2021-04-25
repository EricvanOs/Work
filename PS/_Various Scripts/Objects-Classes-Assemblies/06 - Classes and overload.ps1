class Xpression
{
    [string]$Name
    [scriptblock]$Expression
    [hashtable] getExpression() { 
        return @{ Name = $this.Name; Expression = $this.Expression }
    }
}

# The second class is an array of the first class. 
# This class also have overloaded methods for adding expressions or property names. 
# The Get() method returns all expressions and properties (converted to expressions). 

class XpressionArray
{
    [Xpression[]]$Expression
    [array] Get() { 
        return $this.Expression.getExpression()
    }
    Add([string]$n, [scriptblock]$x) { 
        $temp = New-Object -TypeName Xpression
        $temp.Name = $n
        $temp.Expression = $x
        $this.Expression += $temp
    }
    Add([string]$n) { 
        $temp = New-Object -TypeName Xpression
        $temp.Name = $n
        $temp.Expression = [Scriptblock]::Create('$_.' + $n ) 
        $this.Expression += $temp
         
    }
}

# So how can we use this? Its quite easy actually. First create an object with TypeName "XpressionArray". 
$exp = New-Object -TypeName XpressionArray

# Then add the properties or expressions you need using the Add() method. 

$exp.Add('Name')
$exp.Add('Id')
$exp.Add('KB',{ $_.WorkingSet / 1Kb })
$exp.Add('MB',{ $_.WorkingSet / 1Mb })

#Now lets see if this works. Run the following command to use the method Get() in the pipeline. 
Get-Process -Name powershell* | Select-Object $exp.Get() | Format-Table
Get-Process -Name powershell* | Select-Object $exp.Get() | Get-Member