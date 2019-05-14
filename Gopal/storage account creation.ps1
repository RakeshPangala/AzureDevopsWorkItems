Set-ExecutionPolicy RemoteSigned
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Get-ExecutionPolicy

Login-AzAccount



#Install-Module -Name Az -AllowClobber

#login Azure portal

$rg = "gopal"
$loc = "central us"

#create a resource group

New-AzResourceGroup -Name $rg -Location $loc
 
# create a storage account

$storageacc = New-AzStorageAccount -ResourceGroupName $rg -Name "gopalstorageaccount" -SkuName "Standard_LRS" -Location $loc 

$ctx = $storageacc.Context

#create blob container

New-AzStorageContainer -Name "gopalblobcontainer" -Permission "Blob" -Context $ctx

# uplode the .jpg file

Set-AzStorageBlobContent -File "Desktop\car123.jpg" -Container "gopalblobcontainer" -Blob "car123.jpg" -Context $ctx
