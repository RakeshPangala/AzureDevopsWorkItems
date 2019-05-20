$FileName = 'c:\Demo'

do {

       $dir = gci $FileName -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName

       $dir | Foreach-Object { Remove-Item $_ }

    } while ($dir.count -gt 0)