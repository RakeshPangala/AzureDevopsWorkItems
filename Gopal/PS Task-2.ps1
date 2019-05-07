
Get-executionpolicy
Import-Module AzureRm
Install-Module -Name Az -AllowClobber
Get-AzureRmResourceGroup
Connect-AzAccount

New-AzureRmResourceGroup -Name "gopal" -Location "East Us"


#creating a Virtual Network-1

$VN1=New-AzureRmVirtualNetwork -ResourceGroupName "gopal" -Location "East Us" -Name "gopal" -AddressPrefix "10.1.0.0/16"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix10.1.0.0/24 -VirtualNetwork $VN1
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 10.1.1.0/24 -VirtualNetwork $VN1
$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 10.1.2.0/24 -VirtualNetwork $VN1
$VN1 | Set-AzureRmVirtualNetwork
#Creating Public Ip and configuring into vpn-gateway for Virtual Network-

$gwpip = New-AzureRmPublicIpAddress -Name "gopalPIP" -ResourceGroupName "gopal" -Location "East Us" -AllocationMethod Dynamic

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -VirtualNetwork $VN1
$gwipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name VPNGatewayipconf -Subnet $subnet -PublicIpAddress $gwpip



#Creating VPN gateway

New-AzureRmVirtualNetworkGateway -Name VPNGateway -ResourceGroupName gopal -Location "East Us" -IpConfigurations $gwipconf -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw1


#Setting connections in VPN gateway
Set-VpnConnection -Name Vnet1



#Creating Vnet-1 to Vnet-2 Peering here it is trieted as a hub
Add-AzureRmVirtualNetworkPeering -Name VnetPeering1 -RemoteVirtualNetworkId gopalRemote -VirtualNetwork $VN3 -AllowForwardedTraffic





#creating a Virtual Network-2

$VN2=New-AzureRmVirtualNetwork -ResourceGroupName "gopal" -Location "East Us" -Name "gopalVnet2" -AddressPrefix  "10.2.0.0/16"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 10.2.0.0/24 -VirtualNetwork $VN2
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 10.2.1.0/24 -VirtualNetwork $VN2
$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 10.2.2.0/24 -VirtualNetwork $VN2
$VN2 | Set-AzureRmVirtualNetwork
#Creating Public Ip and configuring into vpn-gateway for Virtual Network-

$gwpip = New-AzureRmPublicIpAddress -Name "gopalPIP2" -ResourceGroupName "gopal" -Location "East Us" -AllocationMethod Dynamic

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $Gatesubway -VirtualNetwork $VN2

$gwipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name $gwpip -Subnet $subnet -PublicIpAddress $gwpip

#Creating VPN gateway

New-AzureRmVirtualNetworkGateway -Name VNet1GW -ResourceGroupName gopal 
-Location 'East US' -IpConfigurations $gwipconfig -GatewayType Vpn -VpnType VPN -GatewaySku Basic



#Setting connections in VPN gateway
Set-VpnConnection -Name Vnet2



#Creating Vnet-1 to Vnet-2 Peering here it is trieted as a hub
Add-AzureRmVirtualNetworkPeering -Name VnetPeering1 -RemoteVirtualNetworkId gopalRemote -VirtualNetwork $VN2 -AllowForwardedTraffic





#creating a Virtual Network-3

$VN3=New-AzureRmVirtualNetwork -ResourceGroupName "gopal" -Location "East Us" -Name "gopalVnet3" -AddressPrefix "10.4.0.0/16"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 10.4.0.0/24  -VirtualNetwork $VN3
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 10.4.1.0/24 -VirtualNetwork $VN3
   $Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 10.4.2.0/24 -VirtualNetwork $VN3
$VN3 | Set-AzureRmVirtualNetwork

#Creating Vnet-3 to Vnet-2 Peering here it is trieted as a Spoke


Add-AzureRmVirtualNetworkPeering -Name VnetPeering2 -RemoteVirtualNetworkId gopalRemote2 -VirtualNetwork $VN3 -AllowGatewayTransit