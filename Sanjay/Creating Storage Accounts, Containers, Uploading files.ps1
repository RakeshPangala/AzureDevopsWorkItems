Login-AzAccount


#----------------------------------Creates a Resource Group--------------------------------#

$resourceGroupName= New-AzResourceGroup -Name Sanjay -Location 'South India'

#----------------------------------Creates a Storage Account-------------------------------#

$resourceGroupName='Sanjay'


$storageAccountName= New-AzStorageAccount -ResourceGroupName Sanjay -Name sanjaystorageacc -SkuName Standard_LRS -Location 'south india' -Kind StorageV2 -AccessTier Hot

#----------------------------------Creates Context----------------------------------------#

$context = $storageAccountName.Context

#----------------------------------Creates a Storage Container------------------------------#

$storageContainer = New-AzStorageContainer -Name sanjaycontainer -Permission Container -Context $context

#-----------------------------------Uploading an image in Container-------------------------#

Set-AzStorageBlobContent -File "C:\Users\SANJAY\Desktop\minions.jpg" -Container "sanjaycontainer" -Blob "minions.jpg" -Context $context