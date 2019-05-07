Get-executionpolicy
Import-Module AzureRm
Install-Module -Name Az -AllowClobber
Get-AzureRmResourceGroup
Connect-AzAccount


#Step 1: Set up Service Principal in AAD
#Input Area
$subscriptionName = 'Pay-As-You-Go'
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'
$aadSvcPrinAppHomePage = 'http://ThisIsFakeURLBecauseItsNotReallyNeededForThisPurpose'
$aadSvcPrinAppIdentifierUri = 'https://DomainName.com/VMEncryptionSvcPrincipalName'
$aadSvcPrinAppPassword = ConvertTo-SecureString 'Gopal@123' -AsPlainText -Force



#Manual login into Azure
Login-AzureRmAccount -SubscriptionName $subscriptionName



#Create Service Principal App to Use For Encryption of VMs
$aadSvcPrinApplication = New-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName -HomePage $aadSvcPrinAppHomePage -IdentifierUris $aadSvcPrinAppIdentifierUri -Password $aadSvcPrinAppPassword
New-AzureRmADServicePrincipal -ApplicationId $aadSvcPrinApplication.ApplicationId


#Step 2: Create Azure Key Vault

<#1 - Creates a key vault in Azure.
2 - Allows the Azure Backup Service permission to the key vault.
This is required if Recovery Vault will be used for backups.
A key vault is required to enable disk encryption for VM. #>


#>



#Input Area

$subscriptionName = 'Pay-As-You-Go'
$resourceGroupName = 'gopal'
$keyVaultName = 'gopalKeyVault'
$keyVaultLocation = 'East Us'


#Manual login into Azure
Login-AzureRmAccount -SubscriptionName $subscriptionName




New-AzureRmResourceGroup -Name $resourceGroupName -Location $keyVaultLocation


#Create Azure Key Vault
New-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -Location $keyVaultLocation -Sku 'Premium'


#Permit the Azure Backup service to access the key vault
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -PermissionsToKeys 'WrapKey' -PermissionsToSecrets get,list,set -ServicePrincipalName VMEncryptionSvcPrincipalName
#Step 3: Connect Service Principal with Key Vault

#Input Area
$subscriptionName = 'Pay-As-You-Go'
$resourceGroupName = 'gopal'
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'
$keyVaultName = 'gopalKeyVault'
$keyName = 'VMEncryption-Key'
$keyType = 'HSM'


#Manual login into Azure
Login-AzureRmAccount -SubscriptionName $subscriptionName



#Allow the Service Principal Permissions to the Key Vault
$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ServicePrincipalName $aadSvcPrinApplication.ApplicationId -PermissionsToKeys 'WrapKey' -PermissionsToSecrets 'Get','List','Set' -ResourceGroupName $resourceGroupName



#Create KEK in the Key Vault
Add-AzureKeyVaultKey -VaultName $keyVaultName -Name $keyName -Destination $keyType


#Allow Azure platform access to the KEK
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -EnabledForDiskEncryption
#Step 4: Enable Disk Encryption



#Input Area
$subscriptionName = 'Pay-As-You-Go'
$resourceGroupName = 'gopal'
$keyVaultName = 'gopalKeyVault'
$keyName = 'VMEncryption-Key'
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'
$aadSvcPrinAppPassword = ConvertTo-SecureString 'gopal@123' -AsPlainText -Force
$vmName = 'gopalVM'



#Manual login into Azure
Login-AzureRmAccount -SubscriptionName $subscriptionName



#Enable Encryption on Virtual Machine
$keyVault = Get-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName
$diskEncryptionKeyVaultUrl = $KeyVault.VaultUri
$keyVaultResourceId = $KeyVault.ResourceId
$keyEncryptionKeyUri = Get-AzureKeyVaultKey -VaultName $keyVaultName -KeyName $keyName
$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName
Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName $resourceGroupName -VMName $vmName -AadClientID $aadSvcPrinApplication.ApplicationId -AadClientSecret $aadSvcPrinAppPassword -DiskEncryptionKeyVaultUri $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId -KeyEncryptionKeyUrl $keyEncryptionKeyUri.Id -KeyEncryptionKeyVaultId $keyVaultResourceId
