#creating Resource-Group
Login-AzureRmAccount
New-AzureRmResourceGroup -Name "GowthamiRG" -Location "East Us"


#creating a Virtual Network-1

$VN1=New-AzureRmVirtualNetwork -ResourceGroupName "GowthamiRG" -Location "East Us" -Name "GowthamiVnet-1" -AddressPrefix "198.162.1.0/25"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.1.0/28 -VirtualNetwork $VN1
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.1.32/28 -VirtualNetwork $VN1
$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 198.162.1.48/28 -VirtualNetwork $VN1
$VN1 | Set-AzureRmVirtualNetwork
#Creating Public Ip and configuring into vpn-gateway for Virtual Network-

$gwpip = New-AzureRmPublicIpAddress -Name "GowthamiPIP" -ResourceGroupName "GowthamiRG" -Location "East Us" -AllocationMethod Dynamic

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -VirtualNetwork $VN1
$gwipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name VPNGatewayipconf -Subnet $subnet -PublicIpAddress $gwpip

#$gwipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name "GowthamiPIP" -Subnet $SubnetConfig1 -PublicIpAddress $gwpip

#Creating VPN gateway

New-AzureRmVirtualNetworkGateway -Name VPNGateway -ResourceGroupName GowthamiRG -Location "East Us" -IpConfigurations $gwipconf -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw1


#Setting connections in VPN gateway
Set-VpnConnection -Name Vnet1



#Creating Vnet-1 to Vnet-2 Peering here it is trieted as a hub
Add-AzureRmVirtualNetworkPeering -Name VnetPeering1 -RemoteVirtualNetworkId GowthamiRemote -VirtualNetwork $VN3 -AllowForwardedTraffic





#creating a Virtual Network-2

$VN2=New-AzureRmVirtualNetwork -ResourceGroupName "GowthamiRG" -Location "East Us" -Name "GowthamiVnet-2" -AddressPrefix "198.162.2.0/25"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.2.0/28 -VirtualNetwork $VN2
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.2.32/28 -VirtualNetwork $VN2
$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 198.162.2.48/28 -VirtualNetwork $VN2
$VN2 | Set-AzureRmVirtualNetwork
#Creating Public Ip and configuring into vpn-gateway for Virtual Network-

$gwpip = New-AzureRmPublicIpAddress -Name "GowthamiPIP2" -ResourceGroupName "GowthamiRG" -Location "East Us" -AllocationMethod Dynamic

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $Gatesubway -VirtualNetwork $VN2

$gwipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name $gwpip -Subnet $subnet -PublicIpAddress $gwpip

#Creating VPN gateway

New-AzureRmVirtualNetworkGateway -Name VNet1GW -ResourceGroupName GowthamiRG 
-Location 'East US' -IpConfigurations $gwipconfig -GatewayType Vpn -VpnType VPN -GatewaySku Basic



#Setting connections in VPN gateway
Set-VpnConnection -Name Vnet2



#Creating Vnet-1 to Vnet-2 Peering here it is trieted as a hub
Add-AzureRmVirtualNetworkPeering -Name VnetPeering1 -RemoteVirtualNetworkId GowthamiRemote -VirtualNetwork $VN2 -AllowForwardedTraffic





#creating a Virtual Network-3

$VN3=New-AzureRmVirtualNetwork -ResourceGroupName "GowthamiRG" -Location "East Us" -Name "GowthamiVnet-3" -AddressPrefix "198.162.3.0/25"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.3.0/28 -VirtualNetwork $VN3
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.3.32/28 -VirtualNetwork $VN3
   $Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 198.162.3.48/28 -VirtualNetwork $VN3
$VN3 | Set-AzureRmVirtualNetwork

#Creating Vnet-3 to Vnet-2 Peering here it is trieted as a Spoke


Add-AzureRmVirtualNetworkPeering -Name VnetPeering2 -RemoteVirtualNetworkId GowthamiRemote2 -VirtualNetwork $VN3 -AllowGatewayTransit