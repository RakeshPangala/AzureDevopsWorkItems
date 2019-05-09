

Install-Module -Name Az -AllowClobber

Login-AzAccount 

$rg = "vineela"
$loc = "south india"
$vnet ="vineela-vnet"
$Fsubnet = "frontend"
$GWsubnet = "GatewaySubnet"
$address = "192.168.0.0/16"
$Fsubnetprefix = "192.168.11.0/24"
$GWsubnetprefix = "192.168.0.0/27"

#create resource group

New-AzResourceGroup -Name $rg -Location $loc 
 #create virtual networks  

 $Fsubnet1 = New-AzVirtualNetworkSubnetConfig -Name $Fsubnet -AddressPrefix $Fsubnetprefix 

 $GWsubnet1 = New-AzVirtualNetworkSubnetConfig -Name $GWsubnet -AddressPrefix $GWsubnetprefix

 $vnet1 = New-AzVirtualNetwork -Name $vnet -ResourceGroupName $rg -Location $loc -AddressPrefix $address -Subnet $Fsubnet1,$GWsubnet1

#public ip address

$gwpubIp = New-AzPublicIpAddress -Name "vineela-ip" -ResourceGroupName $rg -Location $loc -AllocationMethod "Dynamic" 

$subnet = Get-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet1 

$gwipcon = New-AzVirtualNetworkGatewayIpConfig -Name "gwipcon1" -subnet $subnet -PublicIpAddress $gwpubIp
 

 #create vpn gateway

New-AzVirtualNetworkGateway -Name "vineela-Vpn" -ResourceGroupName $rg -Location $loc -IpConfigurations $gwipcon -GatewayType "Vpn" -VpnType "RouteBased" -GatewaySku "VpnGw1"


#create vnet

$vvnet = "vineela-vnet1"
$Fsubnet1 = "frontend"
$GWsubnet1 = "GatewaySubnet"
$address1 = "198.162.4.0/24"
$Fsubnetprefix1 = "198.162.4.32/27"
$GWsubnetprefix1 = "198.162.4.0/28"


$Fsubnet2 = New-AzVirtualNetworkSubnetConfig -Name $Fsubnet1 -AddressPrefix $Fsubnetprefix1 

 $GWsubnet2 = New-AzVirtualNetworkSubnetConfig -Name $GWsubnet1 -AddressPrefix $GWsubnetprefix1

 $vnet2 = New-AzVirtualNetwork -Name $vvnet -ResourceGroupName $rg -Location $loc -AddressPrefix $address1 -Subnet $Fsubnet2,$GWsubnet2

#public ip address

$gwpubIp1 = New-AzPublicIpAddress -Name "vineela-ip1" -ResourceGroupName $rg -Location $loc -AllocationMethod "Dynamic" 

$subnet1 = Get-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet2 

$gwipcon3 = New-AzVirtualNetworkGatewayIpConfig -Name "gwipcon2" -subnet $subnet1 -PublicIpAddress $gwpubIp1

#create vpn gateway

New-AzVirtualNetworkGateway -Name "vineela-Vpn1" -ResourceGroupName $rg -Location $loc -IpConfigurations $gwipcon3 -GatewayType "Vpn" -VpnType "RouteBased" -GatewaySku "VpnGw1"

#create the vnet connections

$gw1 = Get-AzVirtualNetworkGateWay -Name "vineela-Vpn" -ResourceGroupName $rg
$gw2 = Get-AzVirtualNetworkGateWay -Name "vineela-Vpn1" -ResourceGroupName $rg


New-AzVirtualNetworkGatewayConnection -Name "connection1" -ResourceGroupName $rg -Location $loc -ConnectionType "Vnet2Vnet" -VirtualNetworkGateway1 $gw1 -VirtualNetworkGateway2 $gw2 -SharedKey "vineela1234" 

New-AzVirtualNetworkGatewayConnection -Name "connection2" -ResourceGroupName $rg -Location $loc -ConnectionType "Vnet2Vnet" -VirtualNetworkGateway1 $gw2 -VirtualNetworkGateway2 $gw1 -SharedKey "vineela1234" 

#create vnet peering

$vvnet1 = "vineela-vnet3"
$Fsubnet2 = "frontend"
$GWsubnet2 = "GatewaySubnet"
$address2 = "198.162.5.0/24"
$Fsubnetprefix2 = "198.162.5.32/27"
$GWsubnetprefix2 = "198.162.5.0/28"

$Fsubnet3 = New-AzVirtualNetworkSubnetConfig -Name $Fsubnet2 -AddressPrefix $Fsubnetprefix2

 $GWsubnet3 = New-AzVirtualNetworkSubnetConfig -Name $GWsubnet2 -AddressPrefix $GWsubnetprefix2

 $vnet3 = New-AzVirtualNetwork -Name $vvnet1 -ResourceGroupName $rg -Location $loc -AddressPrefix $address2 -Subnet $Fsubnet3,$GWsubnet3


Add-AzVirtualNetworkPeering -Name "vnet3-vnet1" -VirtualNetwork $vnet3 -RemoteVirtualNetworkId $vnet1.id

Add-AzVirtualNetworkPeering -Name "vnet1-vnet3" -VirtualNetwork $vnet1 -RemoteVirtualNetworkId $vnet3.id
