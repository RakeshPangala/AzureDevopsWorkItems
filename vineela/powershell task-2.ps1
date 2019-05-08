Install-Module -name AzureRm -AllowClobber
Login-AzureRmAccount
$ResourceGroupName = 'vineela' 
$Location = 'South india' 
 
#Virtual Network
$VirtualNetworkName = 'VineelaVnet'
$VirtualNetworkAddressPrefix = '192.168.0.0/16' 
 
#Subnets
$GatewaySubnetName = 'GatewaySubnet'
$GatewayAdressPrefix = '192.168.0.0/27' 
 
$VSubnetName = 'vineelasubnet'
$VAdressPrefix = '192.168.11.0/24'
 
#Public IP Address
$PublicIPGatewayName = 'vineelaPIP'
$Allocation = 'Dynamic'   #Dynamic,Static
 
#Local Network Gateway
$LocalNetworkGatewayName = 'VineelaLocalNGW'
$PublicIpLNGW = '0.0.0.0' #the IP address of your on-premises VPN device
$PrivatePrefixLNG = '172.16.1.0/24' #The $PrivatePrefixLNG is your on-premises address space
 
#Virtual Network Gateway
$AzureVirtualGatewayName = 'vineelavnetGW'
$GatewayType = 'vpn'   #Vpn, ExpressRoute
$VpnType =   'RouteBased' #PolicyBased, RouteBased
$GatewaySku = 'Basic' #Basic, Standard, HighPerformance, UltraPerformance 
#VpnGw1, VpnGw2, VpnGw3, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ, ErGw1AZ, ErGw2AZ, ErGw3AZ
 
#Gateway Connection properties
$GatewayConnectionName = 'Local'
$SharedKey = 'vineela432' #The value here must match the value that you are using for your VPN device
$ConnectionType = 'IPSec' #IPsec, #Resource Group
$RoutingWeight = '10' #Default value 10 (optional)

#Create a resource group
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location

#Creates the configuration of the virtual network subnets
$SGateway = New-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName -AddressPrefix $GatewayAdressPrefix
 
$subnetV = New-AzureRmVirtualNetworkSubnetConfig -Name $VSubnetName -AddressPrefix $VAdressPrefix

#Create the Virtual Network
New-AzureRmVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName -Location $Location -AddressPrefix $VirtualNetworkAddressPrefix -Subnet $SGateway, $subnetV

#Create the local network gateway
New-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName -ResourceGroupName $ResourceGroupName -Location $Location -GatewayIpAddress $PublicIpLNGW -AddressPrefix $PrivatePrefixLNG

#Request a Public IP address
$Vgatewaypip= New-AzureRmPublicIpAddress -Name $PublicIPGatewayName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod $Allocation

#Create the gateway IP addressing configuration
$vnet = Get-AzureRmVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName
 
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName -VirtualNetwork $vnet
 
$gatewayipconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name gwipconfig -SubnetId $subnet.Id -PublicIpAddressId $Vgatewaypip.Id

#Create the VPN gateway
New-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $ResourceGroupName -Location $Location -IpConfigurations $gatewayipconfig -GatewayType $GatewayType -VpnType $VpnType -GatewaySku $GatewaySku

#Create the VPN connection
$gateway1 = Get-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $ResourceGroupName
$local = Get-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName -ResourceGroupName $ResourceGroupName
 
New-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName -ResourceGroupName $ResourceGroupName -Location $Location -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local -ConnectionType $ConnectionType -RoutingWeight $RoutingWeight -SharedKey $SharedKey

#Verify VPN Connection
Get-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName -ResourceGroupName $ResourceGroupName