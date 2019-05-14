Install-Module -Name Az -AllowClobber

#login Azure portal

$rg = "vineela"
$loc = "central us"

#create a resource group

New-AzResourceGroup -Name $rg -Location $loc
 
# create a storage account

$storageacc = New-AzStorageAccount -ResourceGroupName $rg -Name "vineelastorageaccount" -SkuName "Standard_LRS" -Location $loc 

$ctx = $storageacc.Context

#create blob container

New-AzStorageContainer -Name "vineelablobcontainer" -Permission "Blob" -Context $ctx

# uplode the .jpg file

Set-AzStorageBlobContent -File "E:\samples\picture1.jpg" -Container "vineelablobcontainer" -Blob "picture1.jpg" -Context $ctx