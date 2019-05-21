$array1=@(3,6,5,1,7,9,1)
$array

$a1=$array1|Measure-Object -Maximum

$a1

$b1=$a1|Where-Object |Select-Object -Property "maximum" -ExpandProperty Maximum

$b1

$skip=$true
$array2 = $array1 | ForEach-Object { if (($_ -eq $b1) -and $skip) { $skip=$false } else { $_ } }

$array2

$a2=$array2|Measure-Object -Maximum
$a2
$b2=$a2|Where-Object |Select-Object -Property "maximum" -ExpandProperty Maximum

$b2

