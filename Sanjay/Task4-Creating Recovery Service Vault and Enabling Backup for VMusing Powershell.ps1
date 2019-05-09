Login-AzAccount
Install-Module -Name Az -AllowClobber

#Login-AzAccount

$username='quadrantit@hotmail.com'
$password='password'
ConvertTo-SecureString $password -AsPlainText -Force
$credential= New-Object System.Management.Automation.PSCredential($username,$password)
Connect-AzAccount -Credential $credential



#----------------------------------Creates a Recovery Service Vault------------------------------------#

$RecSerVault=New-AzRecoveryServicesVault -ResourceGroupName "Sanjay" -Name "RecSerVault" -Location "South India"
Get-AzRecoveryServicesVault -Name "RecSerVault" | Set-AzRecoveryServicesVaultContext

#------------------------------------Creates Policy and Enables backup for Vm--------------------------#

Get-AzRecoveryServicesVault -Name "RecSerVault" | Set-AzRecoveryServicesBackupProperty -BackupStorageRedundancy GeoRedundant
$mypolicy = Get-AzRecoveryServicesBackupProtectionPolicy     -Name "DefaultPolicy"
Enable-AzRecoveryServicesBackupProtection -ResourceGroupName "Sanjay" -Name "VM1" -Policy $mypolicy



$appReg= New-AzADApplication -DisplayName "SanjayAppReg1" -IdentifierUris "https://www.google.com" -HomePage "https://microsoft.com" -ReplyUrls "https://www.goolge.com"
