
#1.          Login to Azure Portal

 

Login-AzureRmAccount

 

#Creating Resource Group

 

New-AzureRmResourceGroup -Name SuryaRG -Location "East US"

 

#Creating Storage account

 

$storageAcc=New-AzureRmStorageAccount -ResourceGroupName SuryaRG -Name suryastoreaccount -SkuName Standard_LRS -Location "East US" -AccessTier Hot -Kind BlobStorage

 

#Storing Context

 

$ctx=$storageAcc.Context

 

#Creating Container

 

New-AzureStorageContainer -Name ”suryacontainer” -Context $ctx -Permission Off

 

#Upload Blob into a Container

 

Set-AzureStorageBlobContent -Container ”suryacontainer” -File "C:\Users\v-sugada\Downloads\picture.jpg" -Context $ctx

 

#Download the Blob from the Container

#get reference to a list of blobs in a container by using the below script

 

$blobs = Get-AzureStorageBlob -Container ”suryacontainer” -Context $ctx

 

#Creating Folder to store downloaded Image

 

New-Item -Path ”C:\Users\v-sugada\Desktop” -Name Image -ItemType Directory -Force


 

#downloading the blob into the local destination directory.

 
$blobs | Get-AzureStorageBlobContent –Destination "C:\Users\v-sugada\Desktop\Image"Image"