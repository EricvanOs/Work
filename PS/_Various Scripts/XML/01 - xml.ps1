[xml]$xml = "<note> <to>Tove</to> <from>Jani</from> <heading>Reminder</heading> <body>Don't forget me this weekend!</body></note>"
$xml.GetType()

$xml | get-member

$xml.GetElementsByTagName('note')
$xml.GetElementsByTagName('from')
$xml.ChildNodes

