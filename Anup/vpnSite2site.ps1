#VPN Site2Site

 

Login-AzureRmAccount

Get-AzureRmSubscription 

Select-AzureRmSubscription -Subscription "Pay-As-You-Go"



#Resource Group

$ResourceGroupName = 'AnupRG' 

$Location = 'France Central' 

 

#Virtual Network

$VirtualNetworkName = 'AnupVnet'

$VirtualNetworkAddressPrefix = '192.168.0.0/16' 

 

#Subnets

$GatewaySubnetName = 'GatewaySubnet'

$GatewayAdressPrefix = '192.168.0.0/27' 

 

$VMSubnetName = 'AnupSubnet'

$VMAdressPrefix = '192.168.11.0/24'

 

#Public IP Address

$PublicIPGatewayName = 'AnupPIP'

$IpAllocation = 'Dynamic'  

 

#Local Network Gateway

$LocalNetworkGatewayName = 'AnupLNGW'

$PublicIpLNG = '0.0.0.0' #the IP address of your on-premises VPN device

$PrivatePrefixLNG = '172.16.1.0/24' #The $PrivatePrefixLNG is your on-premises address space

 

#Virtual Network Gateway

$AzureVirtualGatewayName = 'AnupVnetGW'

$GatewayType = 'vpn'   

$VpnType =   'RouteBased'

$GatewaySku = 'Basic'

 