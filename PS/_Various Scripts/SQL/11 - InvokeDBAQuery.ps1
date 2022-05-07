$FirstName = 'Abby' 
$LastName = 'Abercombrie'
$ID = 1533

$QueryParameters = @{
    "Voornaam" = $FirstName;
    "Achternaam" = $LastName;
    "ID" = $ID;
    };
    
$sqlserver = 'echo'
Invoke-DbaQuery -SqlInstance $sqlserver -Database tempdb -Query "Example_SP" -SqlParameter $QueryParameters -CommandType StoredProcedure




 # in db sp 
 <#
use tempdb
go
Create table Person(
    Voornaam nvarchar(50),
    Achternaam nvarchar(50),
    ID int
)
go
create procedure Example_SP
    @Voornaam nvarchar(50),
    @Achternaam nvarchar(50),
    @ID int
AS
 insert into Person (Voornaam,Achternaam,ID)
 values (@Voornaam,@Achternaam,@ID)
go

select * from Person
go
-- cleanup
drop procedure Example_SP
drop table Person
go
#>


