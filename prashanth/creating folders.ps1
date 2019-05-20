 $files = ('aa','bb','cc','dd')
foreach($file in $files)
{
    New-Item -ItemType Directory $files 
    new-item -ItemType file $file\'test.txt' 
    Add-Content $file\test.txt 'this is the test content in the file.'
}

foreach ($file in $files) {
    if($file -ne 'aa'){
    Remove-Item $file
    }
}