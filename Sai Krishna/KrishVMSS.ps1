
Login-AzureRmAccount

#Input--------------------
$RG='KrishRG'
$Loc='South India'
$VMScaleSetName='KrsihSSet'
$SubnetName='FrontendSubnet'
$PublicIpAddressName='KrishPIP'
$LoadBalancerName='KrishLB'
$UpgradePolicyMode='Automatic'
$virtualNetworkName='KrishVnet'

#Creating Resource group-----------------

New-AzureRmResourceGroup -Name $RG  -Location $Loc

#Creating Virtual Network---------------------

$VNet=New-AzureRmVirtualNetwork  -ResourceGroupName $RG -Location $Loc -Name $virtualNetworkName -AddressPrefix 10.9.0.0/25

#Creating Subnet-----------------------

New-azureRmVirtualNetworksubnetconfig -Name Krishsubnet -AddressPrefix 10.9.0.0/27

#Creating Virtual machine Scale set-------------------------------------

New-AzureRmVmss -ResourceGroupName $RG -Location $Loc -VMScaleSetName $VMScaleSetName  -VirtualNetworkName $VNet -SubnetName $SubnetName -PublicIpAddressName $PublicIpAddressName -LoadBalancerName $LoadBalancerName  -UpgradePolicyMode $UpgradePolicyMode