Login-AzureRmAccount
#----------------------------------------------------------------------------------------------------
#input Variables

$resourceGroup = "KrishRG"

$Location="South India"

$storageAccountName = "krishnatorage"

$skuName = "Standard_LRS"

$Kind="BlobStorage"

$AccessTier="Hot"

$ContainerName="krishcontainer"

#--------------------------------------------------------------------------------------------------
# Resource group creation

New-AzureRmResourceGroup -NAME $resourceGroup -Location $Location



#Creating a Blob Storage account with BlobStorage Kind and selecting its AccessTier also get the context

$storageAccount = New-AzureRmStorageAccount -ResourceGroupName $resourceGroup `
 -AccountName $storageAccountName -Location $Location -SkuName $skuName -Kind $Kind -AccessTier $AccessTier


$context = $storageAccount.Context
#----------------------------------------------------------------------------------------------------

#Creating  a storage container.

$Container=New-AzureStorageContainer -Name $ContainerName -Context $context -Permission Off



# upload a file

set-AzureStorageblobcontent -File "C:\Images" `

  -Container $ContainerName `

  -Blob "Bestscene.jpg" `

  -Context $context
#-----------------------------------------------------------------------------------------------------

#download blob

Get-AzureStorageblobcontent -Blob "Bestscene.png" `

  -Container $containerName `

  -Destination "C:\Users\Sai" `

  -Context $context