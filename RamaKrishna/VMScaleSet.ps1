Login-AzureRmAccount

#Required fields--------------------

$ResourceGroup='KrishnaRG'

$Location='Centralindia'

$VMScaleSetName='krishnaSSet'

$SubnetName='FrontendSubnet'

$PublicIpAddressName='krishnaPIP'

$LoadBalancerName='KrishnaLB'

$UpgradePolicyMode='Automatic'

$virtualNetworkName='krishna-Vnet'



#Creating Resource group-----------------

New-AzureRmResourceGroup -Name $ResourceGroup -Location $Location

#Creating Virtual Network---------------------

$VNet=New-AzureRmVirtualNetwork  -ResourceGroupName $ResourceGroup -Location $Location -Name $virtualNetworkName -AddressPrefix 10.0.0.0/24

#Creating Subnet-----------------------

New-azureRmVirtualNetworksubnetconfig -Name $SubnetName -AddressPrefix 10.0.0.0/28

#Creating Virtual machine Scale set-------------------------------------

New-AzureRmVmss -ResourceGroupName $ResourceGroup -Location $Location -VMScaleSetNam