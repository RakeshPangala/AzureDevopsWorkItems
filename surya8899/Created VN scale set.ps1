Login-AzureRmAccount
$rgname='SuryaRG'
$loc='South india'

#----Creating Resource group-------

New-AzureRmResourceGroup -Name $rgname  -Location $loc

#----Creating Virtual Network-------

$vNet=New-AzureRmVirtualNetwork  -ResourceGroupName $rgname -Location $loc -Name SuryaVnet -AddressPrefix 10.0.0.0/24

#-------Creating Subnet---------

New-azureRmVirtualNetworksubnetconfig -Name Suryasubnet -AddressPrefix 10.0.0.0/28 

#Creating Virtual machine Scale set

New-AzureRmVmss -ResourceGroupName $rgname -Location $loc -VMScaleSetName "SuryaScaleSet"  -VirtualNetworkName $vNet -SubnetName "Suryasubnet" -PublicIpAddressName "SuryaPublicIPAddress" -LoadBalancerName "SuryaLoadBalancer" -UpgradePolicyMode "Automatic"
