#$name="quadrantit@hotmail.com"
#$passwd = ConvertTo-SecureString "password" -AsPlainText -Force
#$credential = New-Object System.Management.Automation.PSCredential($name, $passwd)
#Login-AzAccount -Credential $credential


Login-AzAccount

$ResouregroupName="tej"
$ResourcegroupLocation="southindia"
$Resourcegroup= New-AzResourceGroup -Name $ResourcegroupName -Location $ResourcegroupLocation


$frontendSubnet1 = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "193.168.1.0/28"
$backendSubnet1  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "193.168.1.16/28" 
$gatewaysubnet1  = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "193.168.1.32/28"
$VNet1=New-AzVirtualNetwork -Name VNet1 -ResourceGroupName tej -Location southindia -AddressPrefix "193.168.1.0/24" -Subnet $frontendSubnet1,$backeendSubnet1,$gatewaysubnet1



$frontendSubnet2 = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "193.168.2.0/28"
$backendSubnet2  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "193.168.2.16/28"
$gatewaysubnet2 = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "193.168.2.32/28"
$Vnet2=New-AzVirtualNetwork -Name VNet2 -ResourceGroupName tej -Location southindia -AddressPrefix "193.168.2.0/24" -Subnet $frontendSubnet2,$backendSubnet2,$gatewaysubnet2



$frontendSubnet3 = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "193.168.3.0/28"
$backendSubnet3  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "193.168.3.16/28"
$gatewaysubnet3 = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "193.168.3.32/28"
$Vnet3=New-AzVirtualNetwork -Name VNet3 -ResourceGroupName tej -Location southindia -AddressPrefix "193.168.3.0/24" -Subnet $frontendSubnet3,$backendSubnet3,$gatewaysubnet3



$Gateway1         = "VNet1GateWay"
$GatewayIP1       = "VNet1GateWayIP"
$GatewayIPConf1   = "gatewayipconf1"


$gatewayip     = New-AzPublicIpAddress -Name Gateway1PublicIP -ResourceGroupName tej -Location southindia -AllocationMethod Dynamic
$subnetip      = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $VNet1
$gatewayipconf = New-AzVirtualNetworkGatewayIpConfig -Name $GatewayIPConf1 -Subnet $subnetip1 -PublicIpAddress $gatewayip1


$Gateway1=New-AzVirtualNetworkGateway -Name $Gateway1 -ResourceGroupName tej -Location 'South India' -IpConfigurations $gatewayipconf -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw1 

   

$Gateway2         = "VNet2Gateway"
$GatewayIP2       = "VNet2GateWayIP"
$GatewayIPConf2   = "gatewayipconf2"


$gatewayip2     = New-AzPublicIpAddress -Name Gateway2PublicIP -ResourceGroupName tej -Location southindia -AllocationMethod Dynamic
$subnetip2      = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $Vnet2
$gatewayipconf2 = New-AzVirtualNetworkGatewayIpConfig -Name $GatewayIPConf2 -Subnet $subnetip2 -PublicIpAddress $gatewayip2


$Gateway1=New-AzVirtualNetworkGateway -Name $Gateway2 -ResourceGroupName tej -Location 'South India' -IpConfigurations $gatewayipconf2 -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw1 


$vnet1gateway = Get-AzVirtualNetworkGateway -Name $Gateway1 -ResourceGroupName $Resourcegroup


$vnet2gateway = Get-AzVirtualNetworkGateway -Name $Gateway2 -ResourceGroupName $Resourcegroup



$Connection="Vnet1-Vnet2"

$gatewayconnection=New-AzVirtualNetworkGatewayConnection -Name $Connection -ResourceGroupName $Resourcegroup -VirtualNetworkGateway1 $vnet1gateway -VirtualNetworkGateway2 $vnet2gateway -Location $Location -ConnectionType Vnet2Vnet -SharedKey '3741'

$Connection="Vnet2-Vnet1"

$gatewayconnection=New-AzVirtualNetworkGatewayConnection -Name $Connection -ResourceGroupName $Resourcegroup -VirtualNetworkGateway1 $vnet2gateway -VirtualNetworkGateway2 $vnet1gateway -Location $Location -ConnectionType Vnet2Vnet -SharedKey '3741'


Add-AzVirtualNetworkPeering -Name 'myVnet1ToMyVnet2' -VirtualNetwork $VNet2 -RemoteVirtualNetworkId $Vnet3.Id -AllowGatewayTransit

Add-AzVirtualNetworkPeering -Name 'myVnet2ToMyVnet1' -VirtualNetwork $Vnet3 -RemoteVirtualNetworkId $VNet2.Id -UseRemoteGateways
