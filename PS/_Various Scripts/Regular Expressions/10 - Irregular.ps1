# see: https://github.com/StartAutomating/Irregular

Import-Module -Name Irregular

Get-Command -Module Irregular

Get-RegEx 


?<Digits>                    # Returns the Named Regular Expression Digits
'abc' | ?<Digits>            # Returns nothing, since nothing in abc matches the expression Digits
'123abc456' | ?<Digits>      # Returns two matches, 123 and 456
"abc123" | ?<Digits> -Until  # Returns the content until the next set of digits
'1. one. 2. two.  3. three'| # Returns each number and the content after it
    ?<Digits> -Split -IncludeMatch
'123abc456def' |             # Returns only matches of odd Digits
    ?<Digits> -Where { $_.Digits % 2 } 



    "
    number: 1
    string: 'hello'
    " | 
        ?<NewLine> -Split |     
        Foreach-Object {
            $key, $value  = $_ | ?<Colon> -Split -Count 1
            if ($key) {
                @{$key=$value}
            }
        }