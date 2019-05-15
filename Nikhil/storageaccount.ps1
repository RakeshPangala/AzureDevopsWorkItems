#Crreating Resource group
New-AzResourceGroup -Name NIKHIL -Location "East US"

#Creating Storage Acoount
$storageacccount = New-AzStorageAccount -ResourceGroupName NIKHIL -Name nikhilsac -Location "East US" -SkuName Standard_LRS 
$ctx = $storageaccount.Context

#Create blob container
New-AzStorageContainer -Name "nikcontainer" -Permission blob -Context $ctx

 # upload a file
set-AzStorageblobcontent -File "C:\Users\nikhil\downloads" -Container "nikcontainer" -Blob "Image001.jpg" -Context $ctx 




