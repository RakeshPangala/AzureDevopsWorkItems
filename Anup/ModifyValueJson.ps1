$Json = Get-Content 'C:\Users\v-anugho\Pictures\Azure\ModifyValue.json' -raw | ConvertFrom-Json

$Json.update | % {if($_.Name -eq 'WebConfigFile'){$_.Abbrevation='WF'}}

$Json | ConvertTo-Json -depth 32| set-content 'C:\Users\v-anugho\Pictures\Azure\ModifyValue.json'