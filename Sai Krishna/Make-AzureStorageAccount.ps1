<# 
Script to create Azure Storage Account and container
Requires Powershell 4

For more information see 
http://superwidgets.wordpress.com/2014/12/11/creating-new-azure-storage-account-using-powershell/

Sam Boutros - 12/11/2014 - v1.0
#>

[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='Low')] 
Param(
    [Parameter(Mandatory=$true,
                Position=0)]
        [String]$StorageAccountName, 
    [Parameter(Mandatory=$true,
                Position=1)]
        [String]$Container, 
    [Parameter(Mandatory=$false,
                Position=2)]
        [String]$Location = "East Us", 
    [Parameter(Mandatory=$false,
                Position=3)]
        [String]$Type = "Standard_LRS"
)

Import-module "C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ServiceManagement\Azure"

if (Test-AzureName -Storage -Name $StorageAccountName) {
    "Storage account name '$StorageAccountName' is already taken, try another one"
} else {
    $Result = New-AzureStorageAccount -StorageAccountName $StorageAccountName -Location $Location -Type $Type
    If ($Result.OperationStatus -eq "Succeeded") {
        $Result | Out-String
        "Created new Storage Account '$StorageAccountName', in '$Location', type '$Type'"
        Set-AzureSubscription –SubscriptionName (Get-AzureSubscription).SubscriptionName -CurrentStorageAccount $StorageAccountName 
        New-AzureStorageContainer -Name $Container -Permission Off 
    } else {
        "Failed to create new Storage Account '$StorageAccountName'"
    }
}