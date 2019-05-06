Login-AzureRmAccount
$rgname='AnnuRG'
$loc='East US'

#----Creating Resource group-------

New-AzureRmResourceGroup -Name $rgname  -Location $loc

#----Creating Virtual Network-------

$vNet=New-AzureRmVirtualNetwork  -ResourceGroupName $rgname -Location $loc -Name anuVnet -AddressPrefix 10.0.0.0/24

#-------Creating Subnet---------

New-azureRmVirtualNetworksubnetconfig -Name Anusubnet -AddressPrefix 10.0.0.0/28 

#Creating Virtual machine Scale set

New-AzureRmVmss -ResourceGroupName $rgname -Location $loc -VMScaleSetName "AnnuScaleSet"  -VirtualNetworkName $vNet -SubnetName "Anusubnet" -PublicIpAddressName "annuPublicIPAddress" -LoadBalancerName "annuLoadBalancer" -UpgradePolicyMode "Automatic"