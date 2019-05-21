#-->Print array numbers 
$array=33,34,99,1,2,3,90,39,29

$Num1=$Num2=$Num3=$array[0]

#Function 

function SecThirdLargestNums()

{

#To get second highest number

for($i=0; $i-le $array.Length-1; $i++)

{

 if($Num2 -lt $array[$i] -and $Num1 -ne $array[$i])

 {

 $Num2=$array[$i]


 }

}



#To get third highest number

for($i=0; $i-le $array.Length-1; $i++)
{
 if($Num3 -lt $array[$i] -and $Num1 -ne $array[$i] -and $Num2 -ne $array[$i])

 {

 $Num3=$array[$i]

 }

}

Write-Host "Second highest number=" $Num2

Write-Host "Third highest number=" $Num3

}

SecThirdLargestNums 