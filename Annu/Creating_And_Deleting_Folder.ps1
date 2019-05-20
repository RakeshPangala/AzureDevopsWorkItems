#creating a folder
$Local = "C:\Users"
$Users = $Local+"\aa\" ,$Local+"\bb\" ,$Local+"\cc\" ,$Local+"\dd\" 
New-Item -ItemType Directory $Users

#creating Files inside the folder
$files = ('aa','bb','cc','dd')

foreach($Users in $files)

{

    New-Item -ItemType Directory $files -ErrorAction SilentlyContinue

    New-Item -ItemType file $Users\'test.txt' -ErrorAction SilentlyContinue

    Add-Content $file\test.txt 'this is the test content in the file.'
}
#Deleting folders
$FileName = 'C:\Users'
do {
$dir = gci $FileName -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName
$dir | Foreach-Object { Remove-Item $_ }

 } 
 while ($dir.count -gt 0)






md $Users

New-Item -Path 'C:\Users' -ItemType Directory

New-Item -Path 'C:\Users' -ItemType Directory

New-Item -Path 'C:\Users' -ItemType Directory


$Folders = Get-ChildItem 'C:\*' | Where-Object -Property Name -in -Value 'A , B , C'

© 2019 GitHub, Inc.