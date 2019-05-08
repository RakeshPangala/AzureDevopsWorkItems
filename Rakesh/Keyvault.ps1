Login-AzureRmAccount 

New-AzureRmResourceGroup -Name RakeshRG -Location "South india" 

New-AzureRmKeyVault -Name RakeshKeyVault -ResourceGroupName RakeshRG -Location 'South India'