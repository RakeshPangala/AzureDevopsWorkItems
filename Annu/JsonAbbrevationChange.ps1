$Json = Get-Content 'C:\Sample1.json' -raw | ConvertFrom-Json
$Json.update | % {if($_.Name -eq 'Java script Object Notation'){$_.Abbrevation='JSON'}}
$Json | ConvertTo-Json -depth 32| set-content 'C:\Sample1.json'