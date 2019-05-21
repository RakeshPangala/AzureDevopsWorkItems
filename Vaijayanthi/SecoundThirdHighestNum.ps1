$arr=2,6,1,8,3,9,48,7,8,0,0,8,8,49389,-99
$fln=$arr[0]
$sln=$arr[0]
$tln=$arr[0]

function SecondAndThirdlargestNum()
{
#To get fisrt highest number
for($i=0; $i-le $arr.Length-1; $i++)
{
 if($fln -lt $arr[$i])
 {
 $fln=$arr[$i]
 }
}
#To get second highest number
for($i=0; $i-le $arr.Length-1; $i++)
{
 if($sln -lt $arr[$i] -and $fln -ne $arr[$i])
 {

 $sln=$arr[$i]
 
 }
}
#To get third highest number
for($i=0; $i-le $arr.Length-1; $i++)
{
 if($tln -lt $arr[$i] -and $fln -ne $arr[$i] -and $sln -ne $arr[$i])
 {

 $tln=$arr[$i]
 
 }
}
Write-Host "Second highest number=" $sln
Write-Host "Third highest number=" $tln
}
SecondAndThirdlargestNum