

Login-AzureRmAccount
Get-AzureRmSubscription 
Select-AzureRmSubscription -Subscription "Pay-As-You-Go"

#Resource Group

$ResourceGroupName = 'KrishnaRG' 
$Location = 'Centralindia' 

 
#Virtual Network

$VirtualNetworkName = 'KrishnaVnet'
$VirtualNetworkAddressPrefix = '192.168.0.0/16' 

#Subnets

$GatewaySubnetName = 'GatewaySubnet'
$GatewayAdressPrefix = '192.168.0.0/27' 

$VMSubnetName = 'KrishnaSubnet'
$VMAdressPrefix = '192.168.11.0/24'

 

#Public IP Address

$PublicIPGatewayName = 'KrishnaPIP'
$IpAllocation = 'Dynamic' 

 
#Local Network Gateway

$LocalNetworkGatewayName = 'KrishnaLNGW'
$PublicIpLNG = '0.0.0.0' 
$PrivatePrefixLNG = '172.16.1.0/24'

#Virtual Network Gateway

$AzureVirtualGatewayName = 'KrishnaVnetGW'

$GatewayType = 'vpn'   #Vpn, ExpressRoute

$VpnType = 'RouteBased' #PolicyBased, RouteBased

$GatewaySku = 'Basic'

#Gateway Connection properties

$GatewayConnectionName = 'Local'

$SharedKey = 'Krishna1582' 

$ConnectionType = 'IPSec'

$RoutingWeight = '10' 

#--------------------------------------------------------------------------------------------------------------

#Create a resource group

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location



#---------------------------------------------------------------------------------------------------------------

#Creates the configuration of the virtual network subnets

$subnetGateway = New-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName -AddressPrefix $GatewayAdressPrefix

 

$subnetVM = New-AzureRmVirtualNetworkSubnetConfig -Name $VMSubnetName -AddressPrefix $VMAdressPrefix

#---------------------------------------------------------------------------------------------------------------

#Create the Virtual Network

New-AzureRmVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName -Location $Location -AddressPrefix $VirtualNetworkAddressPrefix -Subnet $subnetGateway, $subnetVM

#--------------------------------------------------------------------------------------------------------------------

#Create the local network gateway

New-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName -ResourceGroupName $ResourceGroupName -Location $Location -GatewayIpAddress $PublicIpLNG -AddressPrefix $PrivatePrefixLNG

#---------------------------------------------------------------------------------------------------------------

#Request a Public IP address

$gatewaypip= New-AzureRmPublicIpAddress -Name $PublicIPGatewayName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod $IpAllocation

#----------------------------------------------------------------------------------------------------------

#Create the gateway IP addressing configuration

$vnet = Get-AzureRmVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

 

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName -VirtualNetwork $vnet

 

$gatewayipconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name gwipconfig1 -SubnetId $subnet.Id -PublicIpAddressId $gatewaypip.Id

#-----------------------------------------------------------------------------------------------------------

#Create the VPN gateway

New-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $ResourceGroupName -Location $Location -IpConfigurations $gatewayipconfig -GatewayType $GatewayType -VpnType $VpnType -GatewaySku $GatewaySku

#------------------------------------------------------------------------------------------------------

#Create the VPN connection

$gateway1 = Get-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $ResourceGroupName

$local = Get-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName -ResourceGroupName $ResourceGroupName

 

New-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName -ResourceGroupName $ResourceGroupName -Location $Location -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local -ConnectionType $ConnectionType -RoutingWeight $RoutingWeight -SharedKey $SharedKey

#-------------------------------------------------------------------------------------------------------------

#Verify VPN Connection

Get-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName -ResourceGroupName $ResourceGroupName