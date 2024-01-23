# start developer command promt for vs 2019
# move to c:\work\ps\_cm\t02
# csc /target:library MyMathLib.cs

[Reflection.Assembly]::LoadFile("c:\work\ps\_cm\t02\Calculator.dll")

[Calculator]::Add(10, 2)

[Calculator] | Get-Member -Static 

[Calculator]::Multiply(10, 2)