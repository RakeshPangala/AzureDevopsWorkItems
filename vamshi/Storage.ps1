Login-AzAccount


$resourceGroupName= New-AzResourceGroup -Name "vamshirm" -Location 'South India'


$storageAccountName= New-AzStorageAccount -ResourceGroupName "vamshirm" -Name vamshistorageacc -SkuName Standard_LRS -Location 'south india' -Kind StorageV2 -AccessTier Hot


$context = $storageAccountName.Context

$storageContainer = New-AzStorageContainer -Name "vamshicontainer" -Permission Container -Context $context

Set-AzStorageBlobContent -File "C:\Users\Vamshi\Desktop\minions.jpg" -Container "container" -Blob "minions.jpg" -Context $context
