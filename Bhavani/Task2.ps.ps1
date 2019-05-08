Creating 3 Vnets and make connections between Vnet1 and vnet2,Peering between Vnet2 and vnet3


#creating Vnet1(BhavaniVN1) and subnets (frontSN1,BackSN1,Gatewaysubnet)
$vnet1 = New-AzVirtualNetwork -ResourceGroupName BhavaniRG -Location southindia -Name BhavaniVN1 -AddressPrefix 192.66.0.0/24
$subnetConfig = Add-AzVirtualNetworkSubnetConfig -Name FrontSN1 -AddressPrefix 192.66.0.0/28 -VirtualNetwork $vnet1 
$subnetconfig = Add-AzVirtualNetworkSubnetConfig -Name BackSN1 -AddressPrefix 192.66.0.16/28 -VirtualNetwork $vnet1
$vnet1 | Set-AzVirtualNetwork
$subnetGateway = Add-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix 192.66.0.32/28 -VirtualNetwork $vnet1
$vnet1 | Set-AzVirtualNetwork
#creating vnet2(BhavaniVN2) and subnets(BFrontSN2,BBackSN2,Gatewaysubnet)
$vnet2 = New-AzVirtualNetwork -ResourceGroupName BhavaniRG -Location southindia -Name BhavaniVN2 -AddressPrefix 192.66.1.0/24
$subnetConfig = Add-AzVirtualNetworkSubnetConfig -Name BFrontSN2 -AddressPrefix 192.66.1.0/28 -VirtualNetwork $vnet2
$subnetConfig = Add-AzVirtualNetworkSubnetConfig -Name BBackSN2 -AddressPrefix 192.66.1.16/28 -VirtualNetwork $vnet2
$vnet2 | Set-AzVirtualNetwork
$subnetGateway = Add-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix 192.66.1.32/28 -VirtualNetwork $vnet2
$vnet2 | Set-AzVirtualNetwork
#creating vnet3(BhavaniVN3) And subnets(BFrontSN3,BBackSN3,Gateway)
$vnet3 = New-AzVirtualNetwork -ResourceGroupName BhavaniRG -Location southindia -Name BhavaniVN3 -AddressPrefix 192.66.2.0/24
$subnetConfig = Add-AzVirtualNetworkSubnetConfig -Name BFrontSN3 -AddressPrefix 192.66.2.0/28 -VirtualNetwork $vnet3
$subnetConfig = Add-AzVirtualNetworkSubnetConfig -Name BBackSN3 -AddressPrefix 192.66.2.16/28 -VirtualNetwork $vnet3
$subnetGateway = Add-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix 192.66.2.32/28 -VirtualNetwork $vnet3
$vnet3 | Set-AzVirtualNetwork

#creating  public ips and configure
$gwpip1 = New-AzPublicIpAddress -Name Gwip1 -ResourceGroupName BhavaniRG `
-Location southindia -AllocationMethod Dynamic 
$vnet = Get-AzVirtualNetwork -Name BhavaniVN1 -ResourceGroupName BhavaniRG
$subnet1 = Get-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -VirtualNetwork $vnet
$gwipconf1 = New-AzVirtualNetworkGatewayIpConfig -Name Gateway1 -Subnet $subnet1 -PublicIpAddress $gwpip1
$gwpip2 = New-AzPublicIpAddress -Name Gwip2 -ResourceGroupName BhavaniRG -Location southindia -AllocationMethod Dynamic
$vnet = Get-AzVirtualNetwork -Name BhavaniVN2 -ResourceGroupName BhavaniRG
$subnet2 = Get-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -VirtualNetwork $vnet
$gwipconf2 = New-AzVirtualNetworkGatewayIpConfig -Name Gateway2 -Subnet $subnet2 -PublicIpAddress $gwpip2
#creating gateways
New-AzVirtualNetworkGateway -Name GW1 -ResourceGroupName BhavaniRG -Location southindia -IpConfigurations $gwipconf1 -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw1
New-AzVirtualNetworkGateway -Name GW2 -ResourceGroupName BhavaniRG -Location southindia -IpConfigurations $gwipconf2 -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw1

$vnet1gw = Get-AzVirtualNetworkGateway -Name GW1 -ResourceGroupName BhavaniRG
$vnet2gw = Get-AzVirtualNetworkGateway -Name GW2 -ResourceGroupName BhavaniRG
#connection from vnet1 to vnet2
New-AzVirtualNetworkGatewayConnection -Name Con1 -ResourceGroupName BhavaniRG
-VirtualNetworkGateway1 GW1 -VirtualNetworkGateway2 GW2 -Location southindia
-ConnectionType Vnet2Vnet -SharedKey 'AzureA1b2C3'
#connection from Vnet2 to vnet1
New-AzVirtualNetworkGatewayConnection -Name Con2 -ResourceGroupName BhavaniRG
-VirtualNetworkGateway1 GW2 -VirtualNetworkGateway2 GW1 -Location southindia
-ConnectionType Vnet2Vnet -SharedKey 'AzureA1b2C3'

#peering between BhavaniVN2 to BhavaniVN3
Add-AzVirtualNetworkPeering -Name BhavaniVN2-BhavaniVN3 -VirtualNetwork $vnet2 -RemoteVirtualNetworkId $vnet3.Id -allowgatewaytransit
 
 #peering between BhavaniVN3 to BhavaniVN2
 Add-AzVirtualNetworkPeering -Name BhavaniVN3-BhavaniVN2 -VirtualNetwork $vnet3 -RemoteVirtualNetworkId $vnet2.Id -userremotrgateways

 Get-AzVirtualNetworkPeering -ResourceGroupName BhavaniRG -VirtualNetworkName BhavaniVN2 |Select PeeringState






