Login-AzureRmAccount

$RGnNme='AnupRG'

$Location='France Central'

$VMScaleSetName='AnupSSet'

$SubnetName='FrontendSubnet'

$PublicIpAddressName='ANupPIP'

$LoadBalancerName='AnupLB'

$UpgradePolicyMode='Automatic'

$virtualNetworkName='Anup-Vnet'



#Creating Resource group-----------------



New-AzureRmResourceGroup -Name $RGnNme  -Location $Location



#Creating Virtual Network---------------------



$VNet=New-AzureRmVirtualNetwork  -ResourceGroupName $RGnNme -Location $Location -Name $virtualNetworkName -AddressPrefix 10.0.0.0/24



#Creating Subnet-----------------------



New-azureRmVirtualNetworksubnetconfig -Name Anusubnet -AddressPrefix 10.0.0.0/28



#Creating Virtual machine Scale set-------------------------------------



New-AzureRmVmss -ResourceGroupName $RGnNme -Location $Location -VMScaleSetName $VMScaleSetName  -VirtualNetworkName $VNet -SubnetName $SubnetName -PublicIpAddressName $PublicIpAddressName -LoadBalancerName $LoadBalancerName  -UpgradePolicyMode $UpgradePolicyMode