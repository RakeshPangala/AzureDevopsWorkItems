#Creating three empty folders

New-Item -Path 'C:\krish1' -ItemType Directory
New-Item -Path 'C:\krish2' -ItemType Directory
New-Item -Path 'C:\krish3' -ItemType Directory

# Get folders that are krish1,krish2,krish3

$Folders = Get-ChildItem 'C:\*' | Where-Object -Property Name -in -Value 'krish1','krish2','krish3'


 


# Loop through those folders

foreach ($Folder in $Folders)

{

    $2017Path = Join-Path -Path $Folder.FullName -ChildPath '2017' # Generate path to 2017 folder

    $2018Path = Join-Path -Path $Folder.FullName -ChildPath '2018' # Generate path to 2018 folder

    New-Item -Path $2017Path -Force # Create 2017 folder

    New-Item -Path $2018Path -Force # Create 2018 folder
}