#Step 4: Enable Disk Encryption
#-----------------------------------------

#Input Area
$subscriptionName = 'Pay-As-You-Go'
$resourceGroupName = 'KrishRG'
$keyVaultName = 'KrishKeyVaultzz'
$keyName = 'VMEncryption-KEK'
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipal'
$aadSvcPrinAppPassword = ConvertTo-SecureString '' -AsPlainText -Force
$vmName = 'KrishVM'

#-----------------------------------------

#Manual login into Azure
Login-AzureRmAccount -SubscriptionName $subscriptionName

#-----------------------------------------

#Enable Encryption on Virtual Machine
$keyVault = Get-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName
$diskEncryptionKeyVaultUrl = $KeyVault.VaultUri
$keyVaultResourceId = $KeyVault.ResourceId
$keyEncryptionKeyUri = Get-AzureKeyVaultKey -VaultName $keyVaultName -KeyName $keyName 
$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName 
Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName $resourceGroupName -VMName $vmName -AadClientID $aadSvcPrinApplication.ApplicationId -AadClientSecret $aadSvcPrinAppPassword -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId -KeyEncryptionKeyUrl $keyEncryptionKeyUri.Id -KeyEncryptionKeyVaultId $keyVaultResourceId