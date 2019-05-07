#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Step 2: Create Azure Key Vault

<#1 - Creates a key vault in Azure.
2 - Allows the Azure Backup Service permission to the key vault.
This is required if Recovery Vault will be used for backups.
A key vault is required to enable disk encryption for VM. #>


#>

#-----------------------------------------

#Input Area

$subscriptionName = 'Pay-As-You-Go'
$resourceGroupName = 'KrishRG'
$keyVaultName = 'KrishKeyVaultzz'
$keyVaultLocation = 'South India'

#-----------------------------------------
#Manual login into Azure
Login-AzureRmAccount -SubscriptionName $subscriptionName

#-----------------------------------------


New-AzureRmResourceGroup -Name $resourceGroupName -Location $keyVaultLocation
#--------------------------------------------------------------
#Create Azure Key Vault
New-AzureRmKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -Location $keyVaultLocation -Sku 'Premium'

#-----------------------------------------

#Permit the Azure Backup service to access the key vault
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -PermissionsToKeys 'WrapKey' -PermissionsToSecrets get,list, set -ServicePrincipalName VMEncryptionSvcPrincipal