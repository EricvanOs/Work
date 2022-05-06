$FirstName = 'Abby' 
$LastName = 'Abercombrie'

$QueryParameters = @{
    "Voornaam" = $FirstName;
    "Achternaam" = $LastName;
    };
    
$sqlserver = 'echo'
import-module dbatools
Invoke-DbaQuery -SqlInstance $sqlserver -Database tempdb -Query "Example_SP" -SqlParameter $QueryParameters -CommandType StoredProcedure




 # in db sp 
 <#
use tempdb
go
Create table Person(
    Voornaam nvarchar(50),
    Achternaam nvarchar(50)
)
go
create procedure Example_SP
    @Voornaam nvarchar(50),
    @Achternaam nvarchar(50)
AS
 insert into Person (Voornaam,Achternaam)
 values (@Voornaam,@Achternaam)
go

select * from Person
#>


