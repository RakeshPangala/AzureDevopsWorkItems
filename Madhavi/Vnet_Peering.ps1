Login-AzureRmAccount

New-AzureRmResourceGroup -Name Madhavi1 -Location WestUS

$virtualNetwork1 = New-AzureRmVirtualNetwork  -ResourceGroupName Madhavi1 -Location WestUS -Name T2Vnet1 -AddressPrefix 192.163.0.0/24 
$subnetfriont1 = Add-AzureRMVirtualNetworkSubnetConfig -Name FrnotEnd -AddressPrefix 192.163.0.0/28  -VirtualNetwork $virtualNetwork1
$subnetBackend1 = Add-AzureRMVirtualNetworkSubnetConfig -Name Backend -AddressPrefix 192.163.0.32/28  -VirtualNetwork $virtualNetwork1 
$virtualNetwork1 | Set-AzureRMVirtualNetwork

$virtualNetwork2 = New-AzureRmVirtualNetwork  -ResourceGroupName Madhavi1 -Location WestUS -Name T2Vnet2 -AddressPrefix 192.163.1.0/24 
$subnetfriont2 = Add-AzureRMVirtualNetworkSubnetConfig -Name FrnotEnd2 -AddressPrefix 192.163.1.0/28  -VirtualNetwork $virtualNetwork2
$subnetBAckend2 = Add-AzureRMVirtualNetworkSubnetConfig -Name Backend2 -AddressPrefix 192.163.1.32/28  -VirtualNetwork $virtualNetwork2
$virtualNetwork2| Set-AzureRMVirtualNetwork

$virtualNetwork3 = New-AzureRmVirtualNetwork  -ResourceGroupName Madhavi1 -Location WestUS -Name T2Vnet3 -AddressPrefix 192.163.2.0/24 
$subnetfriont3 = Add-AzureRMVirtualNetworkSubnetConfig -Name FrnotEnd3 -AddressPrefix 192.163.2.0/28  -VirtualNetwork $virtualNetwork3
$subnetbackend3 = Add-AzureRMVirtualNetworkSubnetConfig -Name Backend3 -AddressPrefix 192.163.2.32/28  -VirtualNetwork $virtualNetwork3
$virtualNetwork3 | Set-AzureRMVirtualNetwork 


$Madhupip = New-AzureRmPublicIpAddress -Name MadhuPublicIP -ResourceGroupName Madhavi1 -Location WestUS -AllocationMethod Dynamic
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name FrnotEnd -VirtualNetwork $virtualNetwork1
$Madhuipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name VPNGatewayipconf -Subnet $subnet -PublicIpAddress $Madhupip


New-AzureRmVirtualNetworkGateway -Name VPNGateway -ResourceGroupName Madhavi1 -Location WestUS -IpConfigurations $Madhuipconf -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw1
Add-AzureRmVirtualNetworkPeering -Name VnetPeering1 -RemoteVirtualNetworkId MadhaviRmt -VirtualNetwork $virtualNetwork1 -AllowForwardedTraffic
