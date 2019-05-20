$a = Get-Content 'c:\vamshi.json' -raw | ConvertFrom-Json
$a.employee | % {if($_.name -eq 'sonoo'){$_.married='false'}}
$a | ConvertTo-Json -depth 32| set-content 'c:\vamshi.json'

