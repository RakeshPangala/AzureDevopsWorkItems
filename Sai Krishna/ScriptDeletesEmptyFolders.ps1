
$Path= 'C:\Krish'



do {



       $directory = gci $Path -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName



       $directory | Foreach-Object { Remove-Item $_ }



    } while ($directory.count -gt 0)