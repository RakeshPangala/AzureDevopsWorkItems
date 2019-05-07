Login-AzureRmAccount

#Required fields--------------------
$RGnNme='PranithaRG'
$Location='Central US'
$VMScaleSetName='PranithaScaleSet'
$SubnetName='FrontendSubnet'
$PublicIpAddressName='pranithaPIP'
$LoadBalancerName='pranithaLB'
$UpgradePolicyMode='Automatic'
$virtualNetworkName='pranitha-Vnet'

#Creating Resource group

New-AzureRmResourceGroup -Name $RGnNme  -Location $Location

#Creating Virtual Network

$VNet=New-AzureRmVirtualNetwork  -ResourceGroupName $RGnNme -Location $Location -Name $virtualNetworkName -AddressPrefix 10.0.0.0/24

#Creating Subnet

New-azureRmVirtualNetworksubnetconfig -Name Anusubnet -AddressPrefix 10.0.0.0/28

#Creating Virtual machine Scale set

New-AzureRmVmss -ResourceGroupName $RGnNme -Location $Location -VMScaleSetName $VMScaleSetName  -VirtualNetworkName $VNet -SubnetName $SubnetName -PublicIpAddressName $PublicIpAddressName -LoadBalancerName $LoadBalancerName  -UpgradePolicyMode $UpgradePolicyMode
