#Creates a Folder
New-Item -Path 'D:\' -ItemType Directory -Name 'PowerShell'

#Creates a SubFolder inside a Folder

New-Item -Path 'D:\PowerShell' -ItemType Directory -Name Subfolder1

#Creates a Folder inside a Folder

New-Item -Path 'D:\PowerShell' -ItemType Directory -Name Subfolder2

#Creates a File

New-Item -Path 'D:\PowerShell\SubFolder2\Text.Txt' -ItemType File

#Creates a Folder

New-Item -Path 'D:\PowerShell' -ItemType Directory -Name Subfolder3


