$arr=3,4,2,5,8
for($i=0;$i-le $arr.Length-1 ;$i++){
for($j=1;$j-le $arr.length;$j++){
if($arr[$i]-gt $arr[$j]){
$hold=$i
$arr[$i]=$arr[$j]
$arr[$j]=$hold
}
}
}
echo $arr[1]






