#This is Json file



{

    "update": [

        {

            "Name": "Rakesh1",        

            "Version": "2.1"

        },

        {

            "Name": "Rakesh2",        

            "Version": "2.1"

        }   

    ]

}





#Updating this Json file using Powershell



$a = Get-Content 'C:\Users\Rakesh\Desktop\MyJson.json' -raw | ConvertFrom-Json

$a.update | % {if($_.name -eq 'Rakesh1'){$_.version=3.0}}

$a | ConvertTo-Json -depth 32| set-content 'C:\Users\Rakesh\DESKTOP\MyJson1.json'







#After modifying 





{

    "update":  [

                   {

                       "Name":  "Rakesh1",

                       "Version":  3

                   },

                   {

                       "Name":  "Rakesh2",

                       "Version":  "2.1"

                   }

               ]

}

