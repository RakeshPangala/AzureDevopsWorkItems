Login-AzureRMAccount

# Set up Service Principal in AAD

$subscriptionName = 'Pay-As-You-Go'

$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'

$aadSvcPrinAppHomePage = 'http://ThisIsFakeURLBecauseItsNotReallyNeededForThisPurpose'

$aadSvcPrinAppIdentifierUri = 'https://DomainName.com/VMEncryptionSvcPrincipalName'

$aadSvcPrinAppPassword = ConvertTo-SecureString 'Gmpo@123' -AsPlainText -Force

$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'

$keyVaultName = 'KeyVault'

$keyName = 'VMEncryption-Key'

$vmName = 'pratapVM'

$keyType = 'HSM'


#Create Service Principal App to Use For Encryption of VMs

$aadSvcPrinApplication = New-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName -HomePage $aadSvcPrinAppHomePage -IdentifierUris $aadSvcPrinAppIdentifierUri -Password $aadSvcPrinAppPassword

New-AzureRmADServicePrincipal -ApplicationId $aadSvcPrinApplication.ApplicationId

$resourceGroupName= 'pratapRG'

$keyVaultName = 'KeyVault'

$keyVaultLocation = 'westus2'

#Create Azure Key Vault

New-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -Location $keyVaultLocation -Sku 'Premium'


#Permit the Azure Backup service to access the key vault

Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -PermissionsToKeys 'WrapKey' -PermissionsToSecrets get,list,set -ServicePrincipalName VMEncryptionSvcPrincipalName

# Connect Service Principal with Key Vault

#Allow the Service Principal Permissions to the Key Vault

$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName

Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ServicePrincipalName $aadSvcPrinApplication.ApplicationId -PermissionsToKeys 'WrapKey' -PermissionsToSecrets 'Get','List','Set' -ResourceGroupName $resourceGroupName



#Create KEK in the Key Vault

Add-AzureKeyVaultKey -VaultName $keyVaultName -Name $keyName -Destination $keyType

#Allow Azure platform access to the KEK

Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -EnabledForDiskEncryption

#Step 4: Enable Disk Encryption

#Enable Encryption on Virtual Machine

$keyVault = Get-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName

$diskEncryptionKeyVaultUrl = $KeyVault.VaultUri

$keyVaultResourceId = $KeyVault.ResourceId

$keyEncryptionKeyUri = Get-AzureKeyVaultKey -VaultName $keyVaultName -KeyName $keyName

$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName

Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName $resourceGroupName -VMName $vmName -AadClientID $aadSvcPrinApplication.ApplicationId -AadClientSecret $aadSvcPrinAppPassword -DiskEncryptionKeyVaultUri $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId -KeyEncryptionKeyUrl $keyEncryptionKeyUri.Id -KeyEncryptionKeyVaultId $keyVaultResourceId

