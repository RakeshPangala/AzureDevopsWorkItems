#create Resourcegroup
Login-AzureRmAccount

New-AzureRmResourceGroup -Name "PranithaRG" -Location "East Us"


#create a VirtualNetwork-1 in pranithaRG

$VN1=New-AzureRmVirtualNetwork -ResourceGroupName "PranithaRG" -Location "East Us" -Name "PranithaVnet1 " -AddressPrefix "10.0.0.0/24"
$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 10.0.0.0/28 -VirtualNetwork $VN1
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 10.0.0.16/28-VirtualNetwork $VN1
$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 10.0.0.32/28 -VirtualNetwork $VN1
$VN1 | Set-AzureRmVirtualNetwork

#Creating Public Ip and configuring into vpn-gateway for Virtual Network1

$ip = New-AzureRmPublicIpAddress -Name "pranithaip1" -ResourceGroupName "PranithaRG" -Location "East Us" -AllocationMethod Dynamic
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -VirtualNetwork $VN1
$ipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name VPNGatewayipconf -Subnet $subnet -PublicIpAddress $ip

#$ipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name "pranithaIP" -Subnet $SubnetConfig1 -PublicIpAddress $ip

#Creating VPN gateway
New-AzureRmVirtualNetworkGateway -Name VPNGateway1 -ResourceGroupName PranithaRG -Location "East Us" -IpConfigurations $ipconf -GatewayType Vpn -VpnType RouteBased -GatewaySku Basic

#Setting connections in VPN gateway
Set-VpnConnection -Name Vnet1

#creating a Virtual Network-2

$VN2=New-AzureRmVirtualNetwork -ResourceGroupName "PranithaRG" -Location "East Us" -Name "PranithaVnet2" -AddressPrefix "10.0.1.0/24"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 10.0.1.0/28 -VirtualNetwork $VN2
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 10.0.1.16/28 -VirtualNetwork $VN2
$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 10.0.1.32/28 -VirtualNetwork $VN2
$VN2 | Set-AzureRmVirtualNetwork
#Creating Public Ip and configuring into vpn-gateway for Virtual Network2
$ip = New-AzureRmPublicIpAddress -Name "pranithaip2" -ResourceGroupName "PranithaRG" -Location "East Us" -AllocationMethod Dynamic
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $Gatesubway -VirtualNetwork $VN2
$ipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name vpngatewayipconf -Subnet $subnet -PublicIpAddress $ip

#Creating VPN gateway
New-AzureRmVirtualNetworkGateway -Name VPNgateway2 -ResourceGroupName PranithaRG 
-Location 'East US' -IpConfigurations $gwipconfig -GatewayType Vpn -VpnType VPN -GatewaySku Basic

#Setting connections in VPN gateway
Set-VpnConnection -Name Vnet2
#giving connection between vnet1 to vnet2 and vnet2 to vnet1

New-AzureRmVirtualNetworkGatewayConnection -Name con1 -ResourceGroupName PranithaRG -VirtualNetworkGateway1 VPNgateway1 -VirtualNetworkGateway2 VPNgateway2 -Location 'East-Us' -ConnectionType Vnet2Vnet -SharedKey '12345678'
$pranithaVNet1GW = Get-AzureRmVirtualNetworkGateway -Name VPNgateway1 -ResourceGroupName PranithaRG
$pranithaVNet2GW = Get-AzureRmVirtualNetworkGateway -Name VPNgateway2 -ResourceGroupName PranithaRG
New-AzureRmVirtualNetworkGatewayConnection -Name con2 -ResourceGroupName PranithaRG -VirtualNetworkGateway1 VPNgateway1 -VirtualNetworkGateway2 VPNgateway2 -Location 'East-Us' -ConnectionType Vnet2Vnet -SharedKey '12345678'




#creating a Virtual Network-3

$VN3=New-AzureRmVirtualNetwork -ResourceGroupName "PranithaRG" -Location "East Us" -Name "Pranithavnet3" -AddressPrefix "10.0.2.0/24"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 10.0.2.0/24 -VirtualNetwork $VN3
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 10.0.1.16/28 -VirtualNetwork $VN3
$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 10.0.1.32/28 -VirtualNetwork $VN3
$VN3 | Set-AzureRmVirtualNetwork


#Creating Vnet-3 to Vnet-2 Peering 


Add-AzureRmVirtualNetworkPeering -Name VnetPeering2 -RemoteVirtualNetworkId PranithaRemote2 -VirtualNetwork $VN3 -AllowGatewayTransit






