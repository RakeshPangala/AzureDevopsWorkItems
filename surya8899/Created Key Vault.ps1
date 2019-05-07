# Create a Azure key vault

# Input Area

$subscriptionName='Pay-As-You-Go'
$ResourceGroupName='SuryaRG'
$Location='South india'
$KeyVaultName='SuryaKEyVault'


# login Azure Account

Login-AzureRmAccount -SubscriptionName -$SubscriptionName

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $KeyVaultName


#Create Azure Key Vault

New-AzureRmKeyVault -VaultName $KeyVaultName -ResourceGroupName $ResourceGroupName -Location $KeyVaultLocation -Sku 'Standard'


#Permit the Azure Backup service to access the key vault

Set-AzureRmKeyVaultAccessPolicy -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -PermissionsToKeys 'WrapKey' -PermissionsToSecrets get,list,set -ServicePrincipalName VMEncryptionSvcPrincipalName
