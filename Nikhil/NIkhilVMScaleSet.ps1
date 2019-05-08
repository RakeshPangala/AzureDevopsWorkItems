Login-AzureRmAccount
$rgname='NIKHILRG'
$loc='East US'

#----Creating Resource group-------

New-AzureRmResourceGroup -Name $rgname  -Location $loc

#----Creating Virtual Network-------

$vNet=New-AzureRmVirtualNetwork  -ResourceGroupName $rgname -Location $loc -Name NikhilVnet -AddressPrefix 199.172.0.0/24

#-------Creating Subnet---------

New-azureRmVirtualNetworksubnetconfig -Name Nikhilsubnet -AddressPrefix 199.172.0.0/28

#Creating Virtual machine Scale set

New-AzureRmVmss -ResourceGroupName $rgname -Location $loc -VMScaleSetName "NikhilScaleSet"  -VirtualNetworkName $vNet -SubnetName "Nikhilsubnet" -PublicIpAddressName "NikhilPublicIPAddress" -LoadBalancerName "NikhilLoadBalancer" -UpgradePolicyMode "Automatic"