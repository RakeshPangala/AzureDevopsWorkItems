
#Creatingfolder(ps),subfolders(ps1,ps2,ps3,ps4)
 
New-Item -Path 'g:\ps\ps1 Folder' -ItemType Directory
New-Item -Path 'g:\ps\ps2 Folder' -ItemType Directory
New-Item -Path 'g:\ps\ps3 Folder' -ItemType Directory
New-Item -Path 'g:\ps\ps4 Folder' -ItemType Directory
#Adding text files(script1,script2,script3)to the subfolders(ps1,ps2,ps4)

New-Item -Path 'g:\ps\ps1 Folder\script1 File.txt' -ItemType File
New-Item -Path 'g:\ps\ps2 Folder\script2 File.txt' -ItemType File
New-Item -Path 'g:\ps\ps2 Folder\script3 File.txt' -ItemType File
New-Item -Path 'g:\ps\ps4 Folder\script4 File.txt' -ItemType File

Set-Content 'g:\ps\ps1 folder\script1 file.txt' 'Welcome to Quadrant'
Set-Content 'g:\ps\ps2 folder\script2 file.txt' 'Welcome to Lenora'
Set-Content 'g:\ps\ps4 folder\script4 file.txt' 'Welcome to Azure'

$FileName = 'g:\ps'

do {

       $dir = gci $FileName -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName

       $dir | Foreach-Object { Remove-Item $_ }

    } while ($dir.count -gt 0)