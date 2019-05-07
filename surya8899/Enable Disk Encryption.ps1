# Enable Disk Encryption

#Input Area
$subscriptionName = 'Pay-As-You-Go'
$resourceGroupName = 'SuryaRG'
$keyVaultName = 'SuryaKeyVault'
$keyName = 'VMEncryption-Suryakname'
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipal'
$aadSvcPrinAppPassword = ConvertTo-SecureString '' -AsPlainText -Force
$vmName = 'SuryaVm'


#Manual login into Azure
Login-AzureRmAccount -SubscriptionName $subscriptionName



#Enable Encryption on Virtual Machine

$keyVault = Get-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName
$diskEncryptionKeyVaultUrl = $KeyVault.VaultUri
$keyVaultResourceId = $KeyVault.ResourceId
$keyEncryptionKeyUri = Get-AzureKeyVaultKey -VaultName $keyVaultName -KeyName $keyName 
$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName 
Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName $resourceGroupName -VMName $vmName -AadClientID $aadSvcPrinApplication.ApplicationId -AadClientSecret $aadSvcPrinAppPassword -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId -KeyEncryptionKeyUrl $keyEncryptionKeyUri.Id -KeyEncryptionKeyVaultId $keyVaultResourceId