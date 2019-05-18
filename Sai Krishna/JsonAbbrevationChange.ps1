$Json = Get-Content 'C:\Users\v-saikka\Sample1.json' -raw | ConvertFrom-Json
$Json.update | % {if($_.Name -eq 'Krishna Kumar'){$_.Abbrevation='KK'}}
$Json | ConvertTo-Json -depth 32| set-content 'C:\Users\v-saikka\Sample1.json'