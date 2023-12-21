<#
https://evotec.xyz/easy-way-to-create-diagrams-using-powershell-and-pswritehtml/
http://geojson.io/#map=2/36.9/-0.7
Install-Module pswriteword -force
Install-Module pswritehtml -force
Install-Module psgraph -force
import-module pswritehtml 
#>
New-HTML -TitleText 'My diagram' -UseCssLinks -UseJavaScriptLinks -FilePath "c:\pssamples\Example-Easy3.html" {
    New-HTMLDiagram -Height '1000px' {
        New-DiagramNode -Label 'One node' -To 'Second node', 'Third node' -ColorBackground Bisque
        New-DiagramNode -Label 'Second node'
        New-DiagramNode -Label 'Third node' -IconBrands  amazon -IconColor Brown
        New-DiagramNode -Label 'Fourth node' -IconRegular    building -IconColor Brown
        New-DiagramNode -Label 'Fifth node' -IconSolid align-left -IconColor Brown
        New-DiagramNode -Label 'Bart Simson' -Image 'https://cdn.imgbin.com/5/2/1/imgbin-bart-simpson-homer-simpson-supreme-drawing-bart-simpson-bard-simpsons-jAfrtPtYNPTK5rQrcKULn5XBn.jpg' -To 'Second node'
        New-DiagramNode -Label 'Sixth node' -IconRegular angry -IconColor Red
        New-DiagramNode -Label 'Seventh node' -IconRegular address-book -IconColor Blue
        New-DiagramNode -Label 'Eight node' -IconRegular bell -IconColor  Green -to 'Seventh node','Sixth node'
        New-DiagramNode -Label '9th node' -Iconsolid air-freshener -IconColor green
        New-DiagramNode -Label '10th node' -IconRegular keyboard   -IconColor Purple
        New-DiagramNode -Label '11th node' -IconBrands airbnb -IconColor Red -FixedX 150 -FixedY 300 -to '10th node'
    }
} -ShowHTML


$Processes = Get-Process | Select-Object -First 10
$TableID = 'RandomID'
New-HTML -TitleText 'My Title' -UseCssLinks -UseJavaScriptLinks -FilePath c:\pssamples\Example30-LinkedProcesses.html -ShowHTML {
    New-HTMLSection -Invisible {
        New-HTMLPanel {
            New-HTMLTable -DataTable $Processes -DataTableID $TableID
        }
        New-HTMLPanel {
            New-HTMLDiagram -Height '1000px' {
                New-DiagramEvent -ID $TableID -ColumnID 1
                New-DiagramNode -Label 'Processes' -IconBrands delicious
                foreach ($_ in $Processes) {
                    New-DiagramNode -Label $_.ProcessName -Id $_.Id -To 'Processes'
                }
            }
        }
    }
}
