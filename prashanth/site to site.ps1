Login-AzureRmAccount


#Resource Group
$ResourceGroupName = 'kprg' 
$Location = 'South India' 


#Virtual Network
$VirtualNetworkName = 'kpVnet'
$VirtualNetworkAddressPrefix = '192.168.0.0/16' 


#Subnets
$GatewaySubnetName = 'GatewaySubnet'

$GatewayAdressPrefix = '192.168.0.0/27' 

$VMSubnetName = 'kpSubnet'

$VMAdressPrefix = '192.168.11.0/24'


#Public IP Address

$PublicIPGatewayName = 'kpPIP'

$IpAllocation = 'Dynamic'   



#Local Network Gateway

$LocalNetworkGatewayName = 'kpNGW'

$PublicIpLNG = '0.0.0.0' #the IP address of your on-premises VPN device

$PrivatePrefixLNG = '172.16.1.0/24' #The $PrivatePrefixLNG is your on-premises address space



#Virtual Network Gateway

$AzureVirtualGatewayName = 'kpVnetGW'

$GatewayType = 'vpn'   #Vpn, ExpressRoute

$VpnType =   'RouteBased' #PolicyBased, RouteBased

$GatewaySku = 'Basic' #Basic, Standard, HighPerformance, UltraPerformance 


#Gateway Connection properties

$GatewayConnectionName = 'Local'

$SharedKey = 'kp789
' 
$ConnectionType = 'IPSec' 

$RoutingWeight = '10' 


#Create a resource group

New-AzureRmResourceGroup -Name $ResourceGroupName  -Location $Location


#Creates the configuration of the virtual network subnets


$subnetGateway = New-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName  -AddressPrefix $GatewayAdressPrefix

$subnetVM = New-AzureRmVirtualNetworkSubnetConfig -Name $VMSubnetName -AddressPrefix $VMAdressPrefix

#Create the Virtual Network



New-AzureRmVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName  -Location $Location -AddressPrefix $VirtualNetworkAddressPrefix  -Subnet $subnetGateway, $subnetVM


#Create the local network gateway

New-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName  -ResourceGroupName $ResourceGroupName  -Location $Location  -GatewayIpAddress $PublicIpLNG  -AddressPrefix $PrivatePrefixLNG


#Request a Public IP address

$gatewaypip= New-AzureRmPublicIpAddress -Name $PublicIPGatewayName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod $IpAllocation



#Create the gateway IP addressing configuration

$vnet = Get-AzureRmVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName  -VirtualNetwork $vnet

$gatewayipconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name gwipconfig1  -SubnetId $subnet.Id  -PublicIpAddressId $gatewaypip.Id


#Create the VPN gateway

New-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $ResourceGroupName -Location $Location  -IpConfigurations $gatewayipconfig -GatewayType $GatewayType -VpnType $VpnType -GatewaySku $GatewaySku

#Create the VPN connection

$gateway1 = Get-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $ResourceGroupName

$local = Get-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName  -ResourceGroupName $ResourceGroupName


New-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName  -ResourceGroupName $ResourceGroupName -Location $Location  -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local `

-ConnectionType $ConnectionType 
`
-RoutingWeight $RoutingWeight `

-SharedKey $SharedKey

#Verify VPN Connection

Get-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName -ResourceGroupName $ResourceGroupName
                                           