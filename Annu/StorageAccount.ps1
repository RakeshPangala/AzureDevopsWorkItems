#1.	Login to Azure Portal

Login-AzureRmAccount

#Creating Resource Group

New-AzureRmResourceGroup -Name AnnuRG -Location "East US"

#Creating Storage account

$storageAcc=New-AzureRmStorageAccount -ResourceGroupName AnnuRG -Name annustoracc -SkuName Standard_LRS -Location "East US" -AccessTier Hot -Kind BlobStorage 

#Storing Context 

$ctx=$storageAcc.Context

#Creating Container

New-AzureStorageContainer -Name ”annucontainer” -Context $ctx -Permission Off

#Upload Blob into a Container

Set-AzureStorageBlobContent -Container ”annucontainer” -File "C:\Users\Annu Choubey\Downloads\2019-04-27-17-27-26-267.jpg" -Context $ctx

#Download the Blob from the Container
#get reference to a list of blobs in a container by using the below script

$blobs = Get-AzureStorageBlob -Container ”annucontainer” -Context $ctx

#Creating Folder to store downloaded Image

New-Item -Path ”C:\ANNU\Azure Offshore Training” -Name Image -ItemType Directory -Force 

#downloading the blob into the local destination directory.

$blobs | Get-AzureStorageBlobContent –Destination "C:\ANNU\Azure Offshore Training\Image"



