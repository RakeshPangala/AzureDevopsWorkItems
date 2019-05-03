Get-ExecutionPolicy

#login to Azure portal

Login-AzureRmAccount

#creating Resource Group

$rgName='AnnuRG'
$location='eastus'
New-AzureRmResourceGroup -Name $rgName -Location $location 

#Creating Virtual Network

$VN=New-AzureRmVirtualNetwork -ResourceGroupName "AnnuRG" -Location "East Us" -Name "AnnuVNet" -AddressPrefix "198.162.1.0/25"

#Creating Subnets

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.1.0/27 -VirtualNetwork $VN
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.1.32/27 -VirtualNetwork $VN

$VN | Set-AzureRmVirtualNetwork