Install-Module -name AzureRm -AllowClobber
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Login-AzureRmAccount
#Give a Subscription 
Select-AzureRmSubscription -Subscriptionid ''
#creating a resorce group and sunets
New-AzureRmResourceGroup -Name SaiVNet -Location 'North Europe'
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix '10.8.1.0/28'
$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name 'FrontSubnet1' -AddressPrefix '10.8.0.0/27'
$subnet2 = New-AzureRmVirtualNetworkSubnetConfig -Name 'BackSubnet1' -AddressPrefix '10.8.0.32/27'

New-AzureRmVirtualNetwork -Name SaiVNet1 -ResourceGroupName SaiVNet -Location 'North Europe' -AddressPrefix 10.8.0.0/16 -Subnet $subnet,$subnet1,$subnet2
#creat a publicip
$pubIP = New-AzureRmPublicIpAddress -Name pubIP1 -ResourceGroupName SaiVNet -Location 'North Europe' -AllocationMethod Dynamic
#Create a virtual network gateway

$vnet = Get-AzureRmVirtualNetwork -Name SaiVNet1 -ResourceGroupName SaiVNet
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet
$pubIPconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name pubIP1 -SubnetId $subnet.Id -PublicIpAddressId $pubIP.Id
 
New-AzureRmVirtualNetworkGateway -Name SaiVNet1GW -ResourceGroupName SaiVNet -Location 'North Europe' -IpConfigurations $pubIPconfig -GatewayType Vpn -VpnType RouteBased

$subnet3 = New-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix '10.9.1.0/28'
$subnet4 = New-AzureRmVirtualNetworkSubnetConfig -Name 'FrontSubnet2' -AddressPrefix '10.9.0.0/27'
$subnet5 = New-AzureRmVirtualNetworkSubnetConfig -Name 'BackSubnet2' -AddressPrefix '10.9.0.32/27'

New-AzureRmVirtualNetwork -Name SaiVNet2 -ResourceGroupName SaiVNet -Location 'North Europe' -AddressPrefix 10.9.0.0/16 -Subnet $subnet3,$subnet4,$subnet5
#creat a publicip
$pubIP1 = New-AzureRmPublicIpAddress -Name pubIP2 -ResourceGroupName SaiVNet -Location 'North Europe' -AllocationMethod Dynamic
#Create a virtual network gateway

$vnet1 = Get-AzureRmVirtualNetwork -Name SaiVNet2 -ResourceGroupName SaiVNet
$subnet3 = Get-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet1
$pubIPconfig1 = New-AzureRmVirtualNetworkGatewayIpConfig -Name pubIP2 -SubnetId $subnet3.Id -PublicIpAddressId $pubIP1.Id
 
New-AzureRmVirtualNetworkGateway -Name SaiVNet2GW -ResourceGroupName SaiVNet -Location 'North Europe' -IpConfigurations $pubIPconfig1 -GatewayType Vpn -VpnType RouteBased

$SaiVNet1GW = Get-AzureRmVirtualNetworkGateway -Name SaiVNet1GW -ResourceGroupName SaiVNet
$SaiVNet2GW = Get-AzureRmVirtualNetworkGateway -Name SaiVNet2GW -ResourceGroupName SaiVNet
 
New-AzureRmVirtualNetworkGatewayConnection -Name con1 -ResourceGroupName SaiVNet -VirtualNetworkGateway1 $SaiVNet1GW -VirtualNetworkGateway2 $SaiVNet2GW -Location 'North Europe' -ConnectionType Vnet2Vnet -SharedKey '12345678'
$SaiVNet1GW = Get-AzureRmVirtualNetworkGateway -Name SaiVNet2GW -ResourceGroupName SaiVNet
$SaiVNet2GW = Get-AzureRmVirtualNetworkGateway -Name SaiVNet1GW -ResourceGroupName SaiVNet
New-AzureRmVirtualNetworkGatewayConnection -Name con2 -ResourceGroupName SaiVNet -VirtualNetworkGateway1 $SaiVNet1GW -VirtualNetworkGateway2 $SaiVNet2GW -Location 'North Europe' -ConnectionType Vnet2Vnet -SharedKey '12345678'