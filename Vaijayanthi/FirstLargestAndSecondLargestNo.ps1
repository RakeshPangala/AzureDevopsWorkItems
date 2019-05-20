$mylist=1,2,3,4,5,6

$first=$second=0

$i=0

for($i=0;$i-le $mylist.Count;$i++)
{

if($mylist[$i] -gt $first)

{
$second=$first

$first=$mylist[$i]

}

}

Write-Host("The First and Second Highest Numbers in an Array is:"+($first,$second))