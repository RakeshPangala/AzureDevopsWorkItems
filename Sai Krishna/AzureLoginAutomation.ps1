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