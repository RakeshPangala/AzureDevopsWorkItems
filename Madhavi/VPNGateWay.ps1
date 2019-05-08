Login-AzureRmAccount
$ResourceGroupName = MadhuRG 
$Location = westus2 

$VirtualNetworkName = MadhuVnet

$VirtualNetworkAddressPrefix = '193.168.0.0/24' 

#Subnets

$GatewaySubnetName = 'GatewaySubnet'

$GatewayAdressPrefix = '193.168.0.0/28' 

$VMSubnetName = 'GowthamiSubnet'

$VMAdressPrefix = '193.168.1.0/24'

#Public IP Address

$PublicIPGatewayName = 'PIP'

$IpAllocation = 'Dynamic'   

#Local Network Gateway

$LocalNetworkGatewayName = 'Madhu'

$PublicIpLNG = '0.0.0.0' #the IP address of your on-premises VPN device

$PrivatePrefixLNG = '172.16.1.0/24' #The $PrivatePrefixLNG is your on-premises address space

#Virtual Network Gateway

$AzureVirtualGatewayName = 'VPNGateway'

$GatewayType = 'vpn'   

$VpnType =   'RouteBased' 

$GatewaySku = 'Basic'

#Gateway Connection properties

$GatewayConnectionName = 'Local'

$SharedKey = 'Gowthami123' #The value here must match the value that you are using for your VPN device

$ConnectionType = 'IPSec' #IPsec, #Resource Group

$RoutingWeight = '10' #Default value 10 (optional)

#Creates the configuration of the virtual network subnets

$subnetGateway = New-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName -AddressPrefix $GatewayAdressPrefix

$subnetVM = New-AzureRmVirtualNetworkSubnetConfig -Name $VMSubnetName -AddressPrefix $VMAdressPrefix

#Create the Virtual Network

New-AzureRmVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName  -Location $Location -AddressPrefix $VirtualNetworkAddressPrefix -Subnet $subnetGateway, $subnetVM

#Create the local network gateway

New-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName -ResourceGroupName $ResourceGroupName -Location $Location -GatewayIpAddress $PublicIpLNG -AddressPrefix $PrivatePrefixLNG                             

# Public IP address

$gatewaypip= New-AzureRmPublicIpAddress -Name $PublicIPGatewayName  -ResourceGroupName $ResourceGroupName -Location $Location  -AllocationMethod $IpAllocation


#Create the gateway IP addressing configuration

$vnet = Get-AzureRmVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName -VirtualNetwork $vnet

$gatewayipconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name gwipconfig1 -SubnetId $subnet.Id -PublicIpAddressId $gatewaypip.Id


#Create the VPN gateway

New-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $ResourceGroupName -Location $Location -IpConfigurations $gatewayipconfig  -GatewayType $GatewayType 
                                 -GatewaySku $GatewaySku
                                 -VpnType $VpnType 


#Create the VPN connection

$gateway1 = Get-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $ResourceGroupName
 
$local = Get-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName -ResourceGroupName $ResourceGroupName

New-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName -ResourceGroupName $ResourceGroupName -Location $Location -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local -ConnectionType $ConnectionType -RoutingWeight $RoutingWeight -SharedKey $SharedKey
                                       
#Verify VPN Connection

Get-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName 

                                           -ResourceGroupName $ResourceGroupName