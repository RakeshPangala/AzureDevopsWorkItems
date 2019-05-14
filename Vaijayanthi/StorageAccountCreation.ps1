Login-AzureRmAccount
$resourceGroup = "VaijayanthiRG"
$Location="East us"

# Set the name of the storage account and the SKU name.
$storageAccountName = "vaijayanthistorageacc123"
$skuName = "Standard_LRS"
$Kind="BlobStorage"
$AccessTier="Hot"
$ContainerName="vaijayanthicontainer"

New-AzureRmResourceGroup -NAME $resourceGroup -Location $Location

#Create a Blob Storage account with BlobStorage Kind and hot AccessTier
$storageAccount = New-AzureRmStorageAccount -ResourceGroupName $resourceGroup -AccountName $storageAccountName -Location $Location -SkuName $skuName -Kind $Kind -AccessTier $AccessTier

  # Retrieve the context.
$ctx = $storageAccount.Context

#Create storage container.
$Container=New-AzureStorageContainer -Name $ContainerName -Context $ctx -Permission Off

# upload a file
set-AzureStorageblobcontent -File "C:\Users\Vaijayanthi Solankar\Downloads\beach-exotic-holiday-248797.jpg" `
  -Container $ContainerName `
  -Blob "beach-exotic-holiday-248797.jpg" `
  -Context $ctx 

 #This example downloads the blobs to D:\_TestImages\Downloads on the local disk.

Get-AzureStorageblobcontent -Blob "beach-exotic-holiday-248797.jpg" `
  -Container $containerName `
  -Destination "C:\Users\Vaijayanthi Solankar\Downloads\DownloadedFiles\" `
  -Context $ctx 

