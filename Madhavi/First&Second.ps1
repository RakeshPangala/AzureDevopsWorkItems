
$mylist=6,8,1,2,3

$first=$second=0

for($i=0;$i-le $mylist.Count;$i++)

{


if($mylist[$i] -gt $first)

{

$second=$first

$first=$mylist[$i]

}

}

Write-Host("The First and Second Highest Numbers in an Array is:"+($first,$second))