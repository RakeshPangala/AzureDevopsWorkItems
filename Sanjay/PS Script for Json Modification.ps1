$a = Get-Content 'C:\Users\SANJAY\Desktop\MyJson.json' -raw | ConvertFrom-Json
$a.update | % {if($_.name -eq 'test1'){$_.version=4.0}}
$a | ConvertTo-Json -depth 32| set-content 'C:\Users\SANJAY\DESKTOP\MyJson1.json'