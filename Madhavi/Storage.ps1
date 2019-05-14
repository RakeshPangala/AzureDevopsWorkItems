
Login-AzureRmAccount

New-AzureRmResourceGroup -Name MadhuRG -Location eastus

$storageAcc=New-AzureRmStorageAccount -ResourceGroupName MadhuRG -Name madhustorage958acc -SkuName Standard_LRS -Location eastus -AccessTier Hot -Kind BlobStorage 

$ctx=$storageAcc.Context

New-AzureStorageContainer -Name ”madhavicontainer” -Context $ctx -Permission Off


Set-AzureStorageBlobContent -Container ”madhavicontainer” -File "C:\Users\v-makont\Desktop\Capture" -Context $ctx

$blobs = Get-AzureStorageBlob -Container ”madhavicontainer” -Context $ctx


