$i = 0 
While ($i -lt 10){     
    "Value is $i"     
     $i += 1     
     if ($i % 5 -eq 0){Break} 
} 



For ($i=1;$i -lt 10;$i++){
    if ($i % 2 -eq 0){Continue}
     "Value is $i" 
}