$input_path = 'K:\_CM\_Various Scripts\Regular Expressions\emails.txt'
$output_file = 'K:\_CM\_Various Scripts\Regular Expressions\extracted_addresses.txt'
$regex = '\b[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,10}\b'

# read file again
Get-Content -Path $input_path

# get all matches
select-string -Path $input_path -Pattern $regex -AllMatches

# look at members
select-string -Path $input_path -Pattern $regex -AllMatches | Get-Member
 
# get the matches and its value
$extracted_addresses = select-string -Path $input_path -Pattern $regex -AllMatches | 
  ForEach-Object { $_.Matches } | 
  ForEach-Object { $_.Value } 


$extracted_addresses |   Set-Content -Path $output_file



# final solution
select-string -Path $input_path -Pattern $regex -AllMatches | 
  ForEach-Object { $_.Matches } | 
  ForEach-Object { $_.Value }  | 
  Set-Content -Path $output_file

#cleanup

Get-Item -path $output_file | Remove-Item