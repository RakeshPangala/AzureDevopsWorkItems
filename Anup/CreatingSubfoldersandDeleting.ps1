#----------------------Creates a Folder------------------------------#

New-Item -Path 'C:\Users\v-anugho\Pictures\Azure\create and delete' -ItemType Directory -Name 'MainFolder'

#----------Creates a SubFolder inside a Folder-----------------------#

New-Item -Path 'C:\Users\v-anugho\Pictures\Azure\create and delete\MainFolder' -ItemType Directory -Name SubFolder1

#-----------Creates a Folder inside a Folder-------------------------#

New-Item -Path 'C:\Users\v-anugho\Pictures\Azure\create and delete\MainFolder' -ItemType Directory -Name SubFolder2

#----------------------Creates a File--------------------------------#

New-Item -Path 'C:\Users\v-anugho\Pictures\Azure\create and delete\MainFolder\SubFolder2\text.txt' -ItemType File

#----------------------Creates a Folder------------------------------#

New-Item -Path 'C:\Users\v-anugho\Pictures\Azure\create and delete\MainFolder' -ItemType Directory -Name SubFolder3


#----------------------Deleting a Folder------------------------------#


