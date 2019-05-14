Get-ExecutionPolicy
Install-Module -Name Az -AllowClobber
Import-Module -Name Az
Connect-AzAccount
Login-AzAccount
New-AzResourceGroup -Name pranithaRG3 -Location centralus
Set the name of the storage account and the SKU name.
$storageAccountName = "storageaccount1"
$skuName = "Standard_LRS"

 Create the storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName pranithaRG3
  -Name $storageAccountName `
  -Location $location `
  -SkuName $skuName
 Retrieve the context
$ctx = $storageAccount.Context