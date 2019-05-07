#creating Resource-Group
Login-AzureRmAccount
$ResourceGroupName="GowthamiRG"
$Location="East Us"
$GatewaySku="Vnet1GatewaySku"
$AzureVirtualGatewayName="VirtualGatewaySku"
$RG=New-AzureRmResourceGroup -Name "GowthamiRG" -Location "East Us"

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
#-----------------------------------------------------------------------------------------------------------
#Create the VPN gateway
New-AzureRmVirtualNetworkGateway -Name Vnet1VPNGateway -ResourceGroupName $ResourceGroupName -Location $Location -IpConfigurations $gwipconf -GatewayType $GatewayType -VpnType $VpnType -GatewaySku $GatewaySku
#------------------------------------------------------------------------------------------------------
#Create the VPN connection
$gateway1 = Get-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $ResourceGroupName
$local = Get-AzureRmLocalNetworkGateway -Name LocalNetworkGatewayName -ResourceGroupName $ResourceGroupName
 
New-AzureRmVirtualNetworkGatewayConnection -Name GatewayConnectionName -ResourceGroupName $ResourceGroupName -Location $Location -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local -ConnectionType $ConnectionType -RoutingWeight $RoutingWeight -SharedKey $SharedKey
#-------------------------------------------------------------------------------------------------------------
#Verify VPN Connection
Get-AzureRmVirtualNetworkGatewayConnection -Name GatewayConnectionName -ResourceGroupName $ResourceGroupName



#creating a Virtual Network-2

$VN2=New-AzureRmVirtualNetwork -ResourceGroupName "GowthamiRG" -Location "East Us" -Name "GowthamiVnet-2" -AddressPrefix "198.162.2.0/25"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.2.0/28 -VirtualNetwork $VN2
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.2.32/28 -VirtualNetwork $VN2
$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 198.162.2.48/28 -VirtualNetwork $VN2
$VN2 | Set-AzureRmVirtualNetwork
#Creating Public Ip and configuring into vpn-gateway for Virtual Network-2

$gwpip = New-AzureRmPublicIpAddress -Name "GowthamiPIP2" -ResourceGroupName "GowthamiRG" -Location "East Us" -AllocationMethod Dynamic

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $Gatesubway -VirtualNetwork $VN2

$gwipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name $gwpip -Subnet $subnet -PublicIpAddress $gwpip

#Create the VPN gateway
New-AzureRmVirtualNetworkGateway -Name Vnet1VPNGateway -ResourceGroupName $ResourceGroupName -Location $Location -IpConfigurations $gwipconf -GatewayType $GatewayType -VpnType $VpnType -GatewaySku $GatewaySku
#------------------------------------------------------------------------------------------------------
#Create the VPN connection
$gateway1 = Get-AzureRmVirtualNetworkGateway -Name AzureVirtualGatewayName2 -ResourceGroupName $ResourceGroupName
$local = Get-AzureRmLocalNetworkGateway -Name LocalNetworkGatewayName2 -ResourceGroupName $ResourceGroupName
 
New-AzureRmVirtualNetworkGatewayConnection -Name GatewayConnectionName2 -ResourceGroupName $ResourceGroupName -Location $Location -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local -ConnectionType $ConnectionType -RoutingWeight $RoutingWeight -SharedKey $SharedKey
#-------------------------------------------------------------------------------------------------------------
#Verify VPN Connection
Get-AzureRmVirtualNetworkGatewayConnection -Name GatewayConnectionName2 -ResourceGroupName $ResourceGroupName

#Creating Vnet-2 to Vnet-3 Peering here it is trieted as a Hub


#Add-AzureRmVirtualNetworkPeering -Name VnetPeering2 -RemoteVirtualNetworkId GowthamiRemote2 -VirtualNetwork $VN3 -AllowGatewayTransit

Add-AzureRmVirtualNetworkPeering -Name GowthamiVnet-3-GowthamiVnet-2 -VirtualNetwork $VN2 -RemoteVirtualNetworkId $VN3.Id -AllowForwardedTraffic


#Add-AzureRmVirtualNetworkPeering -Name GowthamiVnet-3-GowthamiVnet-2 -VirtualNetwork $VN3 -RemoteVirtualNetworkId $VN3.Id

Get-AzVirtualNetworkPeering -ResourceGroupName GowthamiRG -VirtualNetworkName $VN2 | Select PeeringState

















#creating a Virtual Network-3

$VN3=New-AzureRmVirtualNetwork -ResourceGroupName "GowthamiRG" -Location "East Us" -Name "GowthamiVnet-3" -AddressPrefix "198.162.3.0/25"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.3.0/28 -VirtualNetwork $VN3
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.3.32/28 -VirtualNetwork $VN3
$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 198.162.3.48/28 -VirtualNetwork $VN3
$VN3 | Set-AzureRmVirtualNetwork

#Creating Vnet-3 to Vnet-2 Peering here it is trieted as a Spoke


#Add-AzureRmVirtualNetworkPeering -Name VnetPeering2 -RemoteVirtualNetworkId GowthamiRemote2 -VirtualNetwork $VN3 -AllowGatewayTransit

Add-AzureRmVirtualNetworkPeering -Name GowthamiVnet-3-GowthamiVnet-2 -VirtualNetwork $VN3 -RemoteVirtualNetworkId $VN2.Id -AllowGatewayTransit


#Add-AzureRmVirtualNetworkPeering -Name GowthamiVnet-3-GowthamiVnet-2 -VirtualNetwork $VN3 -RemoteVirtualNetworkId $VN3.Id

Get-AzVirtualNetworkPeering -ResourceGroupName GowthamiRG -VirtualNetworkName $VN3 | Select PeeringState


