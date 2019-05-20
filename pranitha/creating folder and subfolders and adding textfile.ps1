#creating folder
New-Item -Path 'D:\temp\Folder' -ItemType Directory
#creating subfolder1 inside folder
New-Item -Path 'D:\temp\Folder\subfolder1' -ItemType Directory 
#creating subfolder2 inside folder
New-Item -Path 'D:\temp\Folder\subfolder2' -ItemType Directory 
#creating subfolder3 inside folder
New-Item -Path 'D:\temp\Folder\subfolder3' -ItemType Directory 





#creating Newfile in subfolder3 and adding text in file
New-Item -Path 'D:\temp\Folder\subfolder3\Test File.txt' -ItemType File
Set-Content D:\temp\test\test.txt 'Hello'
Get-Content D:\temp\test\test.txt