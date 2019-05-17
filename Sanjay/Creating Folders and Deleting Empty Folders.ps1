#----------------------Creates a Folder------------------------------#
New-Item -Path 'D:\' -ItemType Directory -Name 'PowerShell'

#----------Creates a SubFolder inside a Folder-----------------------#

New-Item -Path 'D:\PowerShell' -ItemType Directory -Name SubFolder1

#-----------Creates a Folder inside a Folder-------------------------#

New-Item -Path 'D:\PowerShell' -ItemType Directory -Name SubFolder2

#----------------------Creates a File--------------------------------#

New-Item -Path 'D:\PowerShell\SubFolder2\Text.Txt' -ItemType File

#----------------------Creates a Folder------------------------------#

New-Item -Path 'D:\PowerShell' -ItemType Directory -Name SubFolder3




$FileName = 'D:\PowerShell'

do {

       $dir = gci $FileName -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName

       $dir | Foreach-Object { Remove-Item $_ }

    } while ($dir.count -gt 0)








#
#$FileName = 'D:\PowerShell'
##$testpath=Test-Path -Path "D:\PowerShell" -Include *.dir -Exclude SubFolder2
##If (true)
#{
   #Remove-Item $FileName -Include *.dir -Exclude *.txt -Recurse 

  #$childitem=Get-ChildItem -Exclude *.txt | Remove-Item

   #Remove-Item -Path 'D:\Powershell' -Exclude $childitem -Include *.txt

   #Test-Path -Path "D:\PowerShell" -Exclude *.txt -Include *.dir


}#




