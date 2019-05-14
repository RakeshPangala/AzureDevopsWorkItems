Login-AzAccount

New-AzureRmResourceGroup -Name tej -Location SouthIndia

# create a storage account

$storageacc = New-AzureRmstorageaccount -ResourceGroupName tej -Name tejsa -SkuName Standard_LRS -Location SouthIndia 

$ctx = $storageacc.Context

#create blob container

New-AzureRmStorageContainer -Name tejblobcontainer -Permission Blob -Context $ctx

# uplode the .jpg file

Set-AzureRmStorageBlobContent -File "D:\Tej.jpg" -Container tejblobcontainer -Blob "picture.jpg" -Context $ctx