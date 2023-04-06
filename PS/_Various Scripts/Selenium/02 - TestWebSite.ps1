# use edge download corresponding chromedriver.exe
# from https://chromedriver.chromium.org/downloads
# copy to C:\Users\administrator.PANTHEON\Documents\PowerShell\Modules\Selenium\3.0.1\assemblies
#edge is not working ?, but chrome is.

$Driver = Start-SeChrome


Enter-SeUrl 'https://powershell.org' -Driver $Driver

$pg = Find-SeElement -Driver $Driver -Selection * 

$pg | get-member

$pg.Text | get-member

$pg.FindElementsByLinkText("About Us")

$Element = Find-SeElement -Driver $Driver -Id "About Us"
Invoke-SeClick -Element $Element


Stop-SeDriver -Target $Driver