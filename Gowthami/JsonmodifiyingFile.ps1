#Before modifiying Json file
{
    "update":  [
                   {
                       "Name":  "GowthamiSample",
                    "Version": "2.1",
                    "Abbrevation": "G"
                   },
                   {
                       "Name":  "Gowthami",
                    "Version": "6.0",
                      "Abbrevation": "G"
                   },
                   {
                       "Name":  "Potharju",
                    "Version": "2.3",
                    "Abbrevation": "P"
                   },
                   {
                       "Name":  "Potharaju Gowthami",
                    "Version": "2.4",
                    "Abbrevation": "P"
                   },
                   {
                       "Name":  "Session",
                    "Version": "2.5",
                    "Abbrevation": "S"
                   },
                   {
                       "Name":  "Divya",
                    "Version": "2.6",
                    "Abbrevation": "D"
                   }
               ]
}


#Powershell script for midifying json file

$Json = Get-Content 'C:\Users\Gowthami\GowthamiSample1.json' -raw | ConvertFrom-Json
$Json.update | % {if($_.Name -eq 'Potharaju Gowthami'){$_.Abbrevation='PG'}}
$Json | ConvertTo-Json -depth 32| set-content 'C:\Users\Gowthami\GowthamiSample1.json'


#After modifying json file 

{
    "update":  [
                   {
                       "Name":  "GowthamiSample",
                       "Version":  "2.1",
                       "Abbrevation":  "S"
                   },
                   {
                       "Name":  "Gowthami",
                       "Version":  "6.0",
                       "Abbrevation":  "G"
                   },
                   {
                       "Name":  "Potharaju",
                       "Version":  "2.3"
                       "Abbrevation":  "P"
                   },
                   {
                       "Name":  "Potharaju Gowthami",
                       "Version":  "2.4",
                       "Abbrevation":  "PG"
                   },
                   {
                       "Name":  "Session",
                       "Version":  "2.5",
                       "Abbrevation":  "S"
                   },
                   {
                       "Name":  "Divya",
                       "Version":  "2.6",
                       "Abbrevation":  "D"
                   }
               ]
}

#Json Abbriviation change


$Json = Get-Content 'C:\Users\Gowthami\GowthamiSample1.json' -raw | ConvertFrom-Json
$Json.update | % {if($_.Name -eq 'Potharaju Gowthami'){$_.Abbrevation='PG'}}
$Json | ConvertTo-Json -depth 32| set-content 'C:\Users\Gowthami\GowthamiSample1.json'
