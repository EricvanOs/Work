# An array, which is sometimes referred to as a collection, stores a list of items. 
# A hash table, which is sometimes called a dictionary or an associative array, stores a paired list of items.


$list = "A","B","C","1","2","3"

foreach ( $item in $list ) { $item }

$list | ForEach-Object { $_ }

for ( $i = 0; $i -lt $list.Count; $i++ ) { $list[$i] }


$list -is [array]
[array]$a = 1,2,'C'
$a[2]
$a[-1]

$list = $list + 'D'


####
$hash = @{"server1" = "192.168.17.21";
  "server2" = "192.168.17.22";
  "server3" = "192.168.17.23"}

$hash["server1"]
$hash.server1
$hash.'server1'

$hash -is [hashtable]
$hash -is [array]

$hash = $hash + @{'server4' = '192.168.17.24'}
$hash.Add('server5','192.168.17.25')

####
$colorPicker = @('blue','white','yellow','black')
$colorPicker -is [array]
$colorPicker += 'brown'
$colorPicker[0] = 'green'
$colorPicker.Remove('brown')    # fails, but no error appears in interface

# again
$colorPicker = [System.Collections.ArrayList]@('blue','white','yellow','black')
$colorPicker -is [hashtable]
$colorPicker -is [System.Collections.ArrayList]
$colorPicker += 'brown'   # vreemd, implicit type casting naar array; maw niet gebruiken
$colorPicker.Add('pink')
$colorPicker[0] = 'green'
$colorPicker.Remove('pink') 
$colorPicker.IndexOf('yellow')
$colorPicker.Insert(2,'gray')  # er tussen zetten
$colorPicker.RemoveAt(3)    # item met index[3] weghalen