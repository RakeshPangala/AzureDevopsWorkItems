#Array function

$maximum = function maxArray {
#Array 
$array=@(8,0,0,4,9,3,7)

$max = $array[0];

for ($i=0; $i -le $array.length;$i++) {

 if ($array[$i] -gt $max) {

          $max = $array[$i];

         # $array.splice($array.indexOf($array.max), 1); 

                }

             }

           return $max;         

};
#-----------Call function 
maxArray