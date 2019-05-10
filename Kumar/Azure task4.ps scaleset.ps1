Login-AzureRmAccount

#Required fields--------------------

$ResourceGroup='kumar'

$Location='south india'

$VMScaleSetName='kumarSSet'

$SubnetName='FrontendSubnet'

$PublicIpAddressName='kumarPIP'

$LoadBalancerName='KumarLB'

$UpgradePolicyMode='Automatic'

$virtualNetworkName='kumar-Vnet'



#Creating Resource group-----------------

New-AzureRmResourceGroup -Name $ResourceGroup -Location $Location

#Creating Virtual Network---------------------

$VNet=New-AzureRmVirtualNetwork  -ResourceGroupName $ResourceGroup -Location $Location -Name $virtualNetworkName -AddressPrefix 190.168.0.0/24

#Creating Subnet-----------------------

New-azureRmVirtualNetworksubnetconfig -Name $SubnetName -AddressPrefix 190.168.0.0/28

#Creating Virtual machine Scale set-------------------------------------

New-AzureRmVmss -ResourceGroupName $ResourceGroup -Location $Location -VMScaleSetNam