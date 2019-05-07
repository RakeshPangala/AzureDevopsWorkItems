
#Step 3: Connect Service Principal with Key Vault

#Input Area
$subscriptionName = 'Pay-As-You-Go'
$resourceGroupName = 'KrishRG'
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipal'
$keyVaultName = 'KrishKeyVaulzz'
$keyName = 'VMEncryption-KEK'
$keyType = 'HSM'

#-----------------------------------------

#Manual login into Azure
Login-AzureRmAccount -SubscriptionName $subscriptionName

#-----------------------------------------

#Allow the Service Principal Permissions to the Key Vault
$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ServicePrincipalName $aadSvcPrinApplication.ApplicationId -PermissionsToKeys 'WrapKey' -PermissionsToSecrets 'Set' -ResourceGroupName $resourceGroupName

#-----------------------------------------

#Create KEK in the Key Vault
Add-AzureKeyVaultKey -VaultName $keyVaultName -Name $keyName -Destination $keyType

#-----------------------------------------

#Allow Azure platform access to the KEK
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -EnabledForDiskEncryption