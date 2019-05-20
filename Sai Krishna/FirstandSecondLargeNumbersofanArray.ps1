
#Create an array list 

$list=8,0,0,4,9,3,7,2





$Flarge=0
$Slarge=0



$i=0

#For loop excecution 

for($i=0;$i-le $list.Count;$i++)

{



if($list[$i] -gt $Flarge)



{

$Slarge=$Flarge



$Flarge=$list[$i]





}





}



Write-Host("The First & Second Highest Numbers in an Array is:"+($Flarge,$Slarge))