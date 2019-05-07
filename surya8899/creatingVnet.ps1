#$AzureLoginId=""
#$AzurePassword=ConvertTo-SecureString "" -AsPlainText -Force
#$AzureCreds= New-Object System.Management.Automation.PSCredential($AzureLoginId,$AzurePassword)
#Login-AzureRmAccount -Credential $AzureCreds

#Login to Azure portal with Credenials
Login-AzureRmAccount

#Creating Resource Group
$ResourceGroupName="SuryaRG"
$Location="South india"
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location

#Fields required to create Vnet and subnets
$VirtualNetworkName="SuryaVnet"
$SubnetName1="FrontendSubnet"
#$SubnetName2="BackendSubnet"
$AddressSpace="10.3.0.0/24"
$AddressRange1="10.3.0.0/28"
$AddressRange2="10.3.0.32/28"

#Creating Virtual Network
$VirtualNetwork= New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Location $Location -Name $VirtualNetworkName -AddressPrefix $AddressSpace

#Creating Subnet1
$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name $SubnetName1 -AddressPrefix $AddressRange1 -VirtualNetwork $VirtualNetwork

$virtualNetwork | Set-AzureRmVirtualNetwork

#Creating Subnet2
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name $SubnetName2 -AddressPrefix $AddressRange2 -VirtualNetwork $VirtualNetwork

$virtualNetwork | Set-AzureRmVirtualNetwork