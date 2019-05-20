$array=@(3,6,5,1,7,9,1)
$array

$a=$array|Measure-Object -Maximum
$a
$b=$a|Where-Object |Select-Object -Property "maximum" -ExpandProperty Maximum
$b


$c=$a|Where-Object |Select-Object -Property "maximum" 
$c

$d=$array.slice($array.indexOf(max), 1); # remove max from the array
$d
$output=Math.max.apply(null, arr); #get the 2nd max
$output
