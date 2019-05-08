#Step 1: Set up Service Principal in AAD

#Input Area

$subscriptionName = 'Pay-As-You-Go'

$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'

$aadSvcPrinAppHomePage = 'http://google.com'

$aadSvcPrinAppIdentifierUri = 'https://DomainName.com/VMEncryptionSvcPrincipalName'

$aadSvcPrinAppPassword = ConvertTo-SecureString 'Ansol@123' -AsPlainText -Force

Login-AzureRmAccount -SubscriptionName $subscriptionName


#Create Service Principal App to Use For Encryption of VMs

$aadSvcPrinApplication = New-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName -HomePage $aadSvcPrinAppHomePage -IdentifierUris $aadSvcPrinAppIdentifierUri -Password $aadSvcPrinAppPassword

New-AzureRmADServicePrincipal -ApplicationId $aadSvcPrinApplication.ApplicationId

#Step 2: Create Azure Key Vault

$subscriptionName = 'Pay-As-You-Go'

$resourceGroupName = 'AnupRG'

$keyVaultName = 'AnupKeyVault'

$keyVaultLocation = 'France Central'

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

$resourceGroupName = 'AnupRG'

$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'

$keyVaultName = 'AnupKeyVault'

$keyName = 'VMEncryption-Key'

$keyType = 'HSM'


Login-AzureRmAccount -SubscriptionName $subscriptionName


#Allow the Service Principal Permissions to the Key Vault

$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName

Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ServicePrincipalName $aadSvcPrinApplication.ApplicationId -PermissionsToKeys 'WrapKey' -PermissionsToSecrets 'Get','List','Set' -ResourceGroupName $resourceGroupName


#Create KEK in the Key Vault

Add-AzureKeyVaultKey -VaultName $keyVaultName -Name $keyName -Destination $keyType

#Allow Azure platform access to the KEK

Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -EnabledForDiskEncryption

#Step 4: Enable Disk Encryption

#-----------------------------------------



#Input Area

$subscriptionName = 'Pay-As-You-Go'

$resourceGroupName = 'AnupRG'

$keyVaultName = 'AnupKeyVault'

$keyName = 'VMEncryption-Key'

$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'

$aadSvcPrinAppPassword = ConvertTo-SecureString 'Ansol@123' -AsPlainText -Force

$vmName = 'AnupVM'

Login-AzureRmAccount -SubscriptionName $subscriptionName

#Enable Encryption on Virtual Machine------------------------

$keyVault = Get-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName

$diskEncryptionKeyVaultUrl = $KeyVault.VaultUri

$keyVaultResourceId = $KeyVault.ResourceId

$keyEncryptionKeyUri = Get-AzureKeyVaultKey -VaultName $keyVaultName -KeyName $keyName 

$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName 

Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName $resourceGroupName -VMName $vmName -AadClientID $aadSvcPrinApplication.ApplicationId -AadClientSecret $aadSvcPrinAppPassword -DiskEncryptionKeyVaultUri $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId -KeyEncryptionKeyUrl $keyEncryptionKeyUri.Id -KeyEncryptionKeyVaultId $keyVaultResourceId

    