#Json file

{
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


#Updating this Json file using Powershell

$a = Get-Content 'C:\Users\vineela\Desktop\MyJson.json' -raw | ConvertFrom-Json
$a.update | % {if($_.name -eq 'test1'){$_.version=4.2}}
$a | ConvertTo-Json -depth 32| set-content 'C:\Users\vineela\DESKTOP\MyJson1.json'



#After modifying 


{
    "update":  [
                   {
                       "Name":  "test1",
                       "Version":  4.2
                   },
                   {
                       "Name":  "test2",
                       "Version":  "2.1"
                   }
               ]
}