Login-AzureRmAccount
$rgname='GowthamiRG'
$loc='East US'

#----Creating Resource group-------

New-AzureRmResourceGroup -Name $rgname  -Location $loc

#----Creating Virtual Network-------

$vNet=New-AzureRmVirtualNetwork  -ResourceGroupName $rgname -Location $loc -Name GowthamiVnet -AddressPrefix 198.162.0.0/24

#-------Creating Subnet---------

New-azureRmVirtualNetworksubnetconfig -Name Gowthamisubnet -AddressPrefix 198.162.0.0/28

#Creating Virtual machine Scale set

New-AzureRmVmss -ResourceGroupName $rgname -Location $loc -VMScaleSetName "GowthamiScaleSet"  -VirtualNetworkName $vNet -SubnetName "Gowthamisubnet" -PublicIpAddressName "GowthamiPublicIPAddress" -LoadBalancerName "GowthamiLoadBalancer" -UpgradePolicyMode "Automatic"
