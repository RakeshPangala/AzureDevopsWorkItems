$a = Get-Content 'c:\tej.json' -raw | ConvertFrom-Json
$a.employee | % {if($_.name -eq 'sonoo'){$_.married='false'}}
$a | ConvertTo-Json -depth 32| set-content 'c:\tej.json'
