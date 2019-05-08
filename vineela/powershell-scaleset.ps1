#creating scale set

$ResourceGroupName = 'vineela' 
$Location = 'South india' 
 
$VMScaleSetName='vineelaSSet'
$SubnetName='FrontendSubnet'
$PublicIpAddressName='vineelaPIP'
$LoadBalancerName='vineelaLB'
$UpgradePolicyMode='Automatic'
$VirtualNetworkName = 'VineelaVnet'

#Creating Resource group

New-AzureRmResourceGroup -Name $ResourceGroupName  -Location $Location

#Creating Virtual Network

$Vnet=New-AzureRmVirtualNetwork  -ResourceGroupName $ResourceGroupName  -Location $Location -Name $virtualNetworkName -AddressPrefix 10.0.0.0/24

#Creating Subnet

New-azureRmVirtualNetworksubnetconfig -Name vineelasubnet -AddressPrefix 10.0.0.0/28

#Creating Virtual machine Scale set

New-AzureRmVmss -ResourceGroupName $ResourceGroupName -Location $Location -VMScaleSetName $VMScaleSetName  -VirtualNetworkName $Vnet -SubnetName $SubnetName -PublicIpAddressName $PublicIpAddressName -LoadBalancerName $LoadBalancerName  -UpgradePolicyMode $UpgradePolicyMode
© 2019 GitHub, Inc.