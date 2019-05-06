Login-AzureRmAccount 
New-AzureRmResourceGroup -Name AnnuRg -Location "South india" 
New-AzureRmKeyVault -Name AnnuKV -ResourceGroupName AnnuRg -Location 'South India'