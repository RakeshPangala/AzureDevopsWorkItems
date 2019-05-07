


$User = "quadrantit@hotmail.com"
$PWord = ConvertTo-SecureString -String "Quadrant@8484" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
Login-AzureRmAccount -Credential $Credential
#Login-AzureRmAccount -Credential $Credential -TenantId "Noted Tenant ID"
#Connect-AzureRmAccount -Credential $Credential
   



#Otherer way to giving a credential


#To store password in an encrypted format use below cmd
read-host -assecurestring | convertfrom-securestring | out-file C:\cred.txt
#create a username and password variables
$userId = "applicationId@azuredomain.onmicrosoft.com"
#Path where the password is stored in
$password = get-content -Path "C:\cred.txt" | ConvertTo-SecureString
#Set the powershell credential object
$cred = New-Object -TypeName System.Management.Automation.PSCredential($userId ,$password)
#log On To Azure Account
Login-AzureRmAccount -Credential $cred -TenantId "Noted Tenant ID"









