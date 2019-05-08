#create encryption
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'
$aadSvcPrinAppHomePage = 'http://ThisIsFakeURLBecauseItsNotReallyNeededForThisPurpose'
$aadSvcPrinAppIdentifierUri = 'https://DomainName.com/VMEncryptionSvcPrincipalName'
$aadSvcPrinAppPassword = ConvertTo-SecureString 'VJsol@123' -AsPlainText -Force

# login into Azure
Login-AzureRmAccount 

#Create Service Principal App to Use For Encryption of VMs
$aadSvcPrinApplication = New-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName -HomePage $aadSvcPrinAppHomePage -IdentifierUris $aadSvcPrinAppIdentifierUri -Password $aadSvcPrinAppPassword
New-AzureRmADServicePrincipal -ApplicationId $aadSvcPrinApplication.ApplicationId


# Create Azure Key Vault

#  Creates a key vault in Azure.
2# - Allows the Azure Backup Service permission to the key vault.
#This is required if Recovery Vault will be used for backups.
#A key vault is required to enable disk encryption for VM.

#Input Area


$ResourceGroupName = 'vineela'
$keyVaultName = 'vineelaKeyVault'
$Location = 'south india'


New-AzureRmResourceGroup -Name $ResourceGroupName -Location $keyVaultLocation

#Create Azure Key Vault
New-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $ResourceGroupName -Location $Location -Sku 'Premium'


#Permit the Azure Backup service to access the key vault
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $ResourceGroupName -PermissionsToKeys 'WrapKey' -PermissionsToSecrets get,list,set -ServicePrincipalName VMEncryptionSvcPrincipalName


# Connect Service Principal with Key Vault

#Input Area

$ResourceGroupName = 'vineela'
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'
$keyVaultName = 'vineelaKeyVault'
$keyName = 'VMEncryption-Key'
$keyType = 'HSM'

 
#Allow the Service Principal Permissions to the Key Vault
$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ServicePrincipalName $aadSvcPrinApplication.ApplicationId -PermissionsToKeys 'WrapKey' -PermissionsToSecrets 'Get','List','Set' -ResourceGroupName $ResourceGroupName


#Create KEK in the Key Vault
Add-AzureKeyVaultKey -VaultName $keyVaultName -Name $keyName -Destination $keyType


#Allow Azure platform access to the KEK
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $ResourceGroupName -EnabledForDiskEncryption


#  Disk Encryption
#Input Area

$ResourceGroupName = 'vineela'
$keyVaultName = 'vineelaKeyVault'
$keyName = 'VMEncryption-Key'
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipalName'
$aadSvcPrinAppPassword = ConvertTo-SecureString 'Visol@432' -AsPlainText -Force
$vmName = 'VaijayanthiVM'


#Enable Encryption on Virtual Machine
$keyVault = Get-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $ResourceGroupName
$diskEncryptionKeyVaultUrl = $KeyVault.VaultUri
$keyVaultResourceId = $KeyVault.ResourceId
$keyEncryptionKeyUri = Get-AzureKeyVaultKey -VaultName $keyVaultName -KeyName $keyName 
$aadSvcPrinApplication = Get-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName 
Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName $resourceGroupName -VMName $vmName -AadClientID $aadSvcPrinApplication.ApplicationId -AadClientSecret $aadSvcPrinAppPassword -DiskEncryptionKeyVaultUri $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId -KeyEncryptionKeyUrl $keyEncryptionKeyUri.Id -KeyEncryptionKeyVaultId $keyVaultResourceId
    