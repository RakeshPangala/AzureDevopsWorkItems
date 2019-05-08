Login-AzureRmAccount


#creating a resorce group and subnets

New-AzureRmResourceGroup -Name RakeshVNet -Location 'North Europe'

$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix '10.8.1.0/28'

$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name 'FrontSubnet1' -AddressPrefix '10.8.0.0/27'

$subnet2 = New-AzureRmVirtualNetworkSubnetConfig -Name 'BackSubnet1' -AddressPrefix '10.8.0.32/27'



New-AzureRmVirtualNetwork -Name RakeshVNet1 -ResourceGroupName RakeshVNet -Location 'North Europe' -AddressPrefix 10.8.0.0/16 -Subnet $subnet,$subnet1,$subnet2

#creat a publicip

$pubIP = New-AzureRmPublicIpAddress -Name pubIP1 -ResourceGroupName RakeshVNet -Location 'North Europe' -AllocationMethod Dynamic

#Create a virtual network gateway



$vnet = Get-AzureRmVirtualNetwork -Name RakeshVNet1 -ResourceGroupName RakeshVNet

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet

$pubIPconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name pubIP1 -SubnetId $subnet.Id -PublicIpAddressId $pubIP.Id

 

New-AzureRmVirtualNetworkGateway -Name RakeshVNet1GW -ResourceGroupName RakeshVNet -Location 'North Europe' -IpConfigurations $pubIPconfig -GatewayType Vpn -VpnType RouteBased



$subnet3 = New-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix '10.9.1.0/28'

$subnet4 = New-AzureRmVirtualNetworkSubnetConfig -Name 'FrontSubnet2' -AddressPrefix '10.9.0.0/27'

$subnet5 = New-AzureRmVirtualNetworkSubnetConfig -Name 'BackSubnet2' -AddressPrefix '10.9.0.32/27'



New-AzureRmVirtualNetwork -Name RakeshVNet2 -ResourceGroupName RakeshVNet -Location 'North Europe' -AddressPrefix 10.9.0.0/16 -Subnet $subnet3,$subnet4,$subnet5

#creat a publicip

$pubIP1 = New-AzureRmPublicIpAddress -Name pubIP2 -ResourceGroupName RakeshVNet -Location 'North Europe' -AllocationMethod Dynamic

#Create a virtual network gateway



$vnet1 = Get-AzureRmVirtualNetwork -Name RakeshVNet2 -ResourceGroupName RakeshVNet

$subnet3 = Get-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet1

$pubIPconfig1 = New-AzureRmVirtualNetworkGatewayIpConfig -Name pubIP2 -SubnetId $subnet3.Id -PublicIpAddressId $pubIP1.Id

 

New-AzureRmVirtualNetworkGateway -Name RakeshVNet2GW -ResourceGroupName RakeshVNet -Location 'North Europe' -IpConfigurations $pubIPconfig1 -GatewayType Vpn -VpnType RouteBased



$RakeshVNet1GW = Get-AzureRmVirtualNetworkGateway -Name RakeshVNet1GW -ResourceGroupName RakeshVNet

$RakeshVNet2GW = Get-AzureRmVirtualNetworkGateway -Name RakeshVNet2GW -ResourceGroupName RakeshVNet

 

New-AzureRmVirtualNetworkGatewayConnection -Name con1 -ResourceGroupName RakeshVNet -VirtualNetworkGateway1 $RakeshVNet1GW -VirtualNetworkGateway2 $RakeshVNet2GW -Location 'North Europe' -ConnectionType Vnet2Vnet -SharedKey '12345678'

$RakeshVNet1GW = Get-AzureRmVirtualNetworkGateway -Name RakeshVNet2GW -ResourceGroupName RakeshVNet

$RakeshVNet2GW = Get-AzureRmVirtualNetworkGateway -Name RakeshVNet1GW -ResourceGroupName RakeshVNet

New-AzureRmVirtualNetworkGatewayConnection -Name con2 -ResourceGroupName RakeshVNet -VirtualNetworkGateway1 $RakeshVNet1GW -VirtualNetworkGateway2 $RakeshVNet2GW -Location 'North Europe' -ConnectionType Vnet2Vnet -SharedKey '12345678'