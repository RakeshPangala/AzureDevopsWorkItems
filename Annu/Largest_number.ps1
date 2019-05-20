$array=@(3,6,5,1,7,9,1)
$array

$x=$array|Measure-Object -Maximum
$x
$y=$x|Where-Object |Select-Object -Property "maximum" -ExpandProperty Maximum
$y


$z=$x|Where-Object |Select-Object -Property "maximum" 

$z

