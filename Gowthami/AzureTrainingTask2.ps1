#creating Resource-Group
Login-AzureRmAccount
New-AzureRmResourceGroup -Name "GowthamiRG" -Location "South india"

#creating a Virtual Network-1

New-AzureRmVirtualNetwork -ResourceGroupName GowthamiRG -Name "GowthamiVnet1" -Location "South india"  -AddressPrefix  "10.1.0.0/24"



New-AzureRmVirtualNetworkSubnetConfig -Name "frontendsubnet" -AddressPrefix "10.1.0.0/28" -VirtualNetwork "GowthamiVnet1"
New-AzureRmVirtualNetworkSubnetConfig -Name "backendsubnet"  -AddressPrefix "10.1.0.16/28" -VirtualNetwork "GowthamiVnet1"
New-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -AddressPrefix  "10.1.0.32/28"  -VirtualNetwork "GowthamiVnet1"

$gwipconfig = New-AzureVirtualNetworkGatewayIpConfig -Name gwipconfig1 -SubnetId $subnet.Id -PublicIpAddressId $gwpip.Id
New-AzureVirtualNetworkGateway -Name "VPNgateway" -ResourceGroupName GowthamiRG
-Location 'South india' -IpConfigurations $gwipconfig -GatewayType Vpn `
-VpnType RouteBased -GatewaySku VpnGw1



#creating Virtual Network-2


New-AzureRmVirtualNetwork -ResourceGroupName "GowthamiRG" -Name "GowthamiVnet2" -Location "South india" -AddressPrefix  "10.2.0.0/24"


#creating subnets


New-AzureRmVirtualNetworkSubnetConfig -Name "frontendsubnet" -AddressPrefix "10.2.0.0/28"  -VirtualNetwork "GowthamiVnet2"
New-AzureRmVirtualNetworkSubnetConfig -Name "backendsubnet"  -AddressPrefix "10.2.0.16/28" -VirtualNetwork "GowthamiVnet2"
New-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -AddressPrefix "10.2.0.32/28"  -VirtualNetwork "GowthamiVnet2"



#creating Virtual Network-3


New-AzureRmVirtualNetwork -ResourceGroupName "GowthamiRG"  -Name "GowthamiVnet3" -Location "South india" -AddressPrefix  "10.3.0.0/24"


#creating subnets


New-AzureRmVirtualNetworkSubnetConfig -Name "frontendsubnet" -AddressPrefix "10.3.0.0/28" -VirtualNetwork "GowthamiVnet3"
New-AzureRmVirtualNetworkSubnetConfig -Name "backendsubnet" -AddressPrefix "10.3.0.16/28" -VirtualNetwork "GowthamiVnet3" 
New-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -AddressPrefix "10.3.0.32/28"  -VirtualNetwork "GowthamiVnet3"

