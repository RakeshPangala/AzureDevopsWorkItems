
get-childitem C:\dir\*.txt -exclude "vamshi.txt" -recurse | foreach ($_) {remove-item $_.fullname}