#Login to Azure portal with Credenials
$AzureLoginId=Write-Host "Please enter Azure Login Id"
$Password=Write-Host "Please enter Azure Password"
$AzurePassword=ConvertTo-SecureString $Password -AsPlainText -Force
$AzureCreds= New-Object System.Management.Automation.PSCredential($AzureLoginId,$AzurePassword)
Login-AzureRmAccount -Credential $AzureCreds

#Creating Resource Group
$ResourceGroupName=Write-Host "Please enter Resource Group Name"
$Location=Write-Host "Please enter Resource Group Location"
New-AzureRmResourceGroup -NAME $ResourceGroupName -Location $Location

#Fields required to create Vnet and subnets
$VirtualNetworkName=Write-Host "Please enter Virtual Network Name"
$SubnetName1=Write-Host "Please enter 1st Subnet Name"
$SubnetName2=Write-Host "Please enter 2nd Subnet Name"
$AddressSpace=Write-Host "Please enter AddressSpace"
$AddressRange1=Write-Host "Please enter AddressRange for 1st Subnet"
$AddressRange2=Write-Host "Please enter AddressRange for 2nd Subnet"

#Creating Virtual Network
$VirtualNetwork= New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Location $Location -Name $VirtualNetworkName -AddressPrefix $AddressSpace

#Creating Subnet1
$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name $SubnetName1 -AddressPrefix $AddressRange1 -VirtualNetwork $VirtualNetwork

$virtualNetwork | Set-AzureRmVirtualNetwork

#Creating Subnet2
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name $SubnetName2 -AddressPrefix $AddressRange2 -VirtualNetwork $VirtualNetwork

$virtualNetwork | Set-AzureRmVirtualNetwork

