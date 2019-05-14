

#Login into the azure portal
Login-AzAccount
# Get list of locations and select one.
Get-AzLocation | select Location
$location = "eastus"

# Create a new resource group.
$resourceGroup = "GowthamiRG"
New-AzResourceGroup -Name $resourceGroup -Location $location

# Set the name of the storage account and the SKU name.
$storageAccountName = "gowthamistorageaccount"
$skuName = "Standard_LRS"
$ContainerName="containertest"

# Create the storage account.
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroup `
  -Name $storageAccountName `
  -Location $location `
  -SkuName $skuName

# Retrieve the context.
$ctx = $storageAccount.Context




#Create storage container.
$Container=New-AzStorageContainer -Name $ContainerName -Context $ctx -Permission Off

# upload a file
set-AzStorageblobcontent -File "C:\Users\Gowthami\Downloads\download.png" 
  -Container $ContainerName `
  -Blob "image.jpg" `
  -Context $ctx 

 #This example downloads the blobs to D:\_TestImages\Downloads on the local disk.

Get-AzStorageblobcontent -Blob "image.jpg" 
  -Container $containerName 
  -Destination "C:\Users\Gowthami\Desktop\SSH" 
  -Context $ctx 





