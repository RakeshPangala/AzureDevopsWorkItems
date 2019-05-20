
#To find first highest and second highest number

$a=3,5
$i=0
if($a[$i]-gt$i)
{
$first=$a[1];
$second=$a[0];
}
else
{

$first=$a[0];
$second=$a[1];}

Write-Host("The First and Second Highest Numbers in an Array is:"+($first,$second))

# To find highest number
$a = 242
$b = 12
$c = 31
$d = 24
($a,$b,$c,$d|Measure-Object -Maximum).Maximum
