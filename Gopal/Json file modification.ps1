-------- JSON FILE-------------
<#{
    "update": [
        {
            "Name": "test1",        
            "Version": "2.1"
        },
        {
            "Name": "test2",        
            "Version": "2.1"
        }   
    ]
}

#>


----------POWERSHELL SCRIPT-------------

$a = Get-Content 'F:\gopal\sample.json' -raw | ConvertFrom-Json
$a.update | % {if($_.name -eq 'test1'){$_.version=3.0}}
$a | ConvertTo-Json -depth 32| set-content 'F:\gopal\resample.json'


$b=get-content 'F:\gopal\sample.json' -raw |ConvertFrom-json
$b.update |%{if($_.name -eq 'test2'){$_.version=5.0}}
$b | ConvertTo-Json -Depth 32| Set-Content 'F:\gopal\resampl22.json'


------------AFTER MODIFICATION--------------

<#
 
{
    "update":  [
                   {
                       "Name":  "test1",
                       "Version":  3
                   },
                   {
                       "Name":  "test2",
                       "Version":  "2.1"
                   }
               ]
  #>
<#
{
    "update":  [
                   {
                       "Name":  "test1",
                       "Version":  "2.1"
                   },
                   {
                       "Name":  "test2",
                       "Version":  5
                   }
               ]
#>


