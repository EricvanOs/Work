https://powershell.one/tricks/filesystem/filesystemwatcher

https://powershell.one/tricks/performance/strings

https://powershell.one/code/10.html

https://docs.microsoft.com/en-us/azure/data-factory/scripts/copy-azure-blob-powershell?toc=/powershell/module/toc.json


https://docs.microsoft.com/en-us/azure/virtual-machines/windows/ps-common-network-ref

https://docs.microsoft.com/en-us/azure/?product=featured



-- hoe reken je de 2de dinsdag van de maand uit?

1. neem een willekeurige maand jaar combinatie

2. reken de dag uit (....).dayofweek = startday


if startday = sunday -->  2de dinsdag -> startday+2 + 7
if startday = monday -->  2de dinsdag  --> startday + 1 + 7
if startday = tuesday --> 2de dinsdag  --> startday +0 +7
if startday = wednesday -> 2de dinsdag  -> startday + 6 + 7
if startday - thursday  --> 2de dinsdag  -> startday + 5 + 7
if startday = friday    --> 2de dinsdag  -> startday + 4 +7
if startday = saturday  --> 2de dinsdag  --> startday + 3 + 7


------
stel 2de donderdag v/d maand 
if startday = sunday -->  2de donderdag -> startday + 4 + 7


kies 
zondag = 7
monday = 6
tu     - 5
we     = 4
th     = 3
fr     = 2
sa     = 1

if startday = sunday -->  2de dinsdag -> startday+2 + 7 
if startday = sunday -->  2de dinsdag -> startday + (7-5)  + 7
if startday = sunday -->  2de dinsdag -> startday + (7 + (7-5))%7 + 7

if startday = wednesday -> 2de dinsdag  -> startday + 6 + 7
if startday = we -->  2de dinsdag -> startday + (7 + (4-5))%7 + 7


if startday = sunday -->  2de donderdag -> startday + 4 + 7
if startday = sunday -->  2de donderdag -> startday + (7+(7-3))%7 + 7


if startday = x     -->  2de y dag  -->  (7 +(x-y))%7 + 7
if startday = x     -->  zde y dag  -->  (7 +(x-y))%7 + 7(z-1)

