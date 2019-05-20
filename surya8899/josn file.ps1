﻿#This is Json file

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

$a = Get-Content 'D:\Json.json' -raw | ConvertFrom-Json
$a.update | % {if($_.name -eq 'test1'){$_.version=4.0}}
$a | ConvertTo-Json -depth 32| set-content 'D:\JsonMy\Json1.json'



#After modifying 


{
    "update":  [
                   {
                       "Name":  "test1",
                       "Version":  4
                   },
                   {
                       "Name":  "test2",
                       "Version":  "2.1"
                   }
 
 
               ]
}