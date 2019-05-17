#----------------------Creates a Folder------------------------------#
New-Item -Path 'F:\' -ItemType Directory -Name 'GOPAL'

#----------Creates a SubFolder inside a Folder-----------------------#

New-Item -Path 'F:\GOPAL' -ItemType Directory -Name KARNA

#-----------Creates a Folder inside a Folder-------------------------#

New-Item -Path 'F:\GOPAL' -ItemType Directory -Name ARJUNA

#----------------------Creates a File--------------------------------#

New-Item -Path 'F:\GOPAL\ARJUNA\Text.Txt' -ItemType File

#----------------------Creates a Folder------------------------------#

New-Item -Path 'F:\GOPAL' -ItemType Directory -Name BHEEMA



#------------Deleting files------------  #


$FileName = 'F:\GOPAL'

do {

       $dir = gci $FileName -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName

       $dir | Foreach-Object { Remove-Item $_ }

    } while ($dir.count -gt 0)

