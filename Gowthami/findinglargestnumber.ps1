
$maxValue = function arrayTest {
$array=@(8,4,2,9,1,4,7)
        $mxm = array[0];
       for ($i=0; $i -le $array.length;$i++) {
        if ($array[$i] -gt $mxm) {
          $mxm = $array[$i];
          $array.splice($array.indexOf($array.max), 1); 
                }
             }
           #return $mxm;
           return $mxm;
            
};
arrayTest