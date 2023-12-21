#variabelen

$woord="Hallo"
$getal=654684
$obj=get-service -Name Spooler
$objcoll=Get-Process
$zin="dit is een stukje tekst"

Get-Command -Noun Variable
New-Variable -Name myvar -Value 1321 
$myvar
Get-Variable -Name myvar
Clear-Variable -Name myvar
Remove-Variable -Name myvar

#datatype testen
$woord -is [string]
$getal -is [string]
$obj |Get-Member
$obj -is [System.ServiceProcess.ServiceController]
$woord.GetType()
$obj.GetType().FullName

Get-Variable



#conversie
$getal1=32151
$getal1 +=10
$getal2="6545"
$getal1 + $getal2
$getal2 + $getal1  #niet 'verwacht' resultaat--> concatenatie
[int]$getal2 + [int]$getal1  
$getal3="vijf"
[int]$getal3
$resultaat = $getal3 -as [int]
$resultaat -eq $null  #true voor tekst
$resultaat = $getal2 -as [int]
$resultaat  -is [int] #true omdat $getal2 getal bevat


#string variable
$zin
$zin | gm
$zin.Length
$zin.EndsWith("tekst") 
$zin.IndexOf("tekst")
$zin.IndexOfAny("abc")  #-1 betekent niet gevonden
$zin.Insert(5,"hello")
$zin.Remove(5,3)
$zin.Replace("is","was") 
$zin.Split(" ")
$zin -split " "
$zin.Substring(5,3)

$filename="filename.extension"
$filename.IndexOf(".")
$filename.Substring(0,$filename.IndexOf("."))
$filename.Substring($filename.IndexOf(".") + 1 )
$filename.split(".")

#datetime
Get-Date  | gm
$date1=get-date
$date1.Day
$date1.DayOfYear
$date1.Ticks
$date1.AddHours(152)
$date1.add( (New-TimeSpan -Days 15 -Minutes 456 -Seconds 45) )
$date2=get-date -Year 2023 -Month 12 -Day 15
$date1.Subtract($date2)
[datetime]$date3="3/5/2023"
$date3
$date1.ToLongDateString()
$date1.ToShortDateString()

#array/collections
$comp=@("lon-dc1","lon-cl1","lon-srv1")
$comp | Get-Member
Get-Member -InputObject $comp
$comp.Count
$comp.GetLowerBound(0)
$comp.GetupperBound(0)
$comp[0]
$comp[3]

$objcoll.Count
$objcoll[15,25,30]
$objcoll[15..25]
$objcoll[15..25+30..35]
$objcoll.Remove(12)   #FOUT, WANT FIXED

$nummers=@(6541,65465,646,664,649846,654,678)
$nummers.add(555)
$nummers.IsFixedSize  #$true
$nummers=$nummers + 555
$nummers +=666

#arraylist
$al=New-Object System.Collections.ArrayList
$al.IsFixedSize  #$false
$al.Add("Peter")
$al.Add("Marc")
$al.Insert(0,"Darwin")
$al.RemoveAt(0)
$al.Remove("Peter")
$al
$al += "Ilse"    #gevaarlijk, want Arraylist wordt omgezet naar Array (Fixed Size)!!
$al = $al + "Ilse" #zelfde opmerking als vorige regel
$al[1]  
$al.Remove("Ilse")  #zal niet meer werken !!!
$al -is [ System.Collections.ArrayList]  #false
$al -is [array]   #true


#hashtable
$HT=@{'item1'="Darwin"
      'item2'=13564
      'item3'=Get-Process -Name POWERPNT
    }

$ht
$ht.Keys
$ht.Values
$ht[1]   #werkt niet!!
$HT["item1"]
$ht.item3
$ht.add('item2',"Willy")  #foutmelding
$ht.add('item4',"Willy")  #foutmelding
$ht.Remove("item1")


#split/join
$zin="dit is wat tekst voor demo"
$woorden=$zin -split " "
$woorden -join "#"

#string vars  ' "
$info="dit is wat info"
Write-Host "dit is de tekst:"  $info
Write-Host "dit is de tekst:  $info "
Write-Host 'dit is de tekst:  $info '  #$info variable inhoud niet getoond!
Write-Host "dit is de tekst in de variable `$info :  $info "  
Write-Host "dit is `t  de tekst in `n de variable `$info :  $info "  
#SUBEXPRESSIONS
$obj.Name
Write-Host "DE SERVICE IS : $obj.name" #toont typename
Write-Host "DE SERVICE IS : $($obj.name)"
$objcoll[20].Name
Write-Host "process is  $objcoll[20].Name "  #toont typenames
Write-Host "process is  $($objcoll[20].Name) "

$infodate=get-date
$infodate.ToString("ddd dd MMM yyyy HH:mm:ss")
$logdate=$infodate.ToString("ddMMyyyyHHmmss")
$logdate

New-Item -Path c:\ -Name log$logdate.log -ItemType File
1..100| ForEach-Object {new-item -Path c:\ -Name "testfile$Psitem.txt" -Value "dit is de waarde $psitem"  }

new-item -Path c:\ -Name "newfile$hello.txt" -ItemType File  #$hello als var beschouwd
new-item -Path c:\ -Name 'newfile$hello.txt' -ItemType File  #$ als character beschouwd


#oefening1
$email="darwin.leung@globalknowledge.be"  #input
#te verwachten output: leung darwin
$email.split(".@")   #resultaat is array met leung,darwin,globalknowledge,com
$email.split(".@")[1] + ' ' + $email.split(".@")[0]  #gewoon output naar pipeline/scherm
Write-Host $email.split(".@")[1]  $email.split(".@")[0] -ForegroundColor Yellow #met kleurtjes werken


#oefening2
#druk je leeftijd uit in Ticks
$nu=get-date
$dob=get-date -Year 1971 -Month 7 -Day 8
$nu.Subtract($dob) | select ticks
#op 1 lijn
(Get-Date).Ticks -(get-date -Year 1971 -Month 7 -Day 8).Ticks





















