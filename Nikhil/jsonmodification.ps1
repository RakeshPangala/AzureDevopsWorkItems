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



$a = Get-Content 'C:\Users\v-nidach\Desktop\Azure cls\demo.json' -raw | ConvertFrom-Json

$a.update | % {if($_.name -eq 'Nikhil1'){$_.version=3.0}}

$a | ConvertTo-Json -depth 32| set-content 'C:\Users\v-nidach\Desktop\Azure cls\demo.json'







#After modifying 





{

    "update":  [

                   {

                       "Name":  "Nikhil1",

                       "Version":  3

                   },

                   {

                       "Name":  "Nikhil",

                       "Version":  "2.1"

                   }

               ]

}