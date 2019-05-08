Login-AzureRmAccount

$RGname='MadhuRG'

$location='westus2'

#Creating Virtual Network

$VirtualNetwork=New-AzureRmVirtualNetwork  -ResourceGroupName $RGname -Location $location -Name MadhuVnet -AddressPrefix 198.163.0.0/24

#Creating Subnet

$subnet1=New-azureRmVirtualNetworksubnetconfig -Name Gowthamisubnet -AddressPrefix 198.163.0.0/28

#Creating VMSS

New-AzureRmVmss -ResourceGroupName $RGname -Location $location -VMScaleSetName "MadhuScaleSet"  -VirtualNetworkName $VirtualNetwork -SubnetName $subnet1 -PublicIpAddressName "PbcIPAd" -LoadBalancerName "LdBalancer" -UpgradePolicyMode "Automatic"