
$str1 = $null
if ([string]::IsNullOrEmpty($str1)) { 'null or empty' } else { 'not null or empty' }

$str2 = ''
if ([string]::IsNullOrEmpty($str2)) { 'null or empty' } else { 'not null or empty' }

$str3 = ' '
if ([string]::IsNullOrEmpty($str3)) { 'null or empty' } else { 'not null or empty' }




$str1 = $null
if ($str1) { 'not null or empty' } else { 'null or empty' }

$str2 = ''
if ($str2) { 'not null or empty' } else { 'null or empty' }

$str3 = ' '
if ($str3) { 'not null or empty' } else { 'null or empty' }



$str1 = $null
if ([bool]$str1) { 'not null or empty' } else { 'null or empty' }

$str2 = ''
if ([bool]$str2) { 'not null or empty' } else { 'null or empty' }

$str3 = ' '
if ([bool]$str3) { 'not null or empty' } else { 'null or empty' }
