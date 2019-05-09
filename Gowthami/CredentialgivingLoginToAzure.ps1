


$User = "xxxxxxxx"
$PWord = ConvertTo-SecureString -String "xxxxx" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
Login-AzureRmAccount -Credential $Credential
#Login-AzureRmAccount -Credential $Credential -TenantId "Noted Tenant ID"
#Connect-AzureRmAccount -Credential $Credential
   
$AzureAcct = "rkumar@osibbsi.onmicrosoft.com"
$AzurePwd = ConvertTo-SecureString "XXXX" -AsPlainText -Force
$AzureCreds = New-Object System.Management.Automation.PSCredential($AzureAcct, $AzurePwd)

Login-AzureRmAccount -Credential $AzureCreds -TenantId "d38d2c2c-d50c-46ca-9ad4-1cda22e3036b" -SubscriptionId "fab4f174-2c82-4030-a8c3-3848c2d97f2f"


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









