Login-AzureRmAccount

#--------------------------Create a resource group-------------------------
#Resource Group

$rgname='AnnuRG'

$loc='East US'

New-AzureRmResourceGroup -Name $rgname -Location $loc


#----------------Creates the configuration of the virtual network subnets-------------

#Subnets

$GatewaySubnetName = 'GatewaySubnet'

$GatewayAdressPrefix = '10.0.0.0/28' 

$VMSubnetName = 'AnnuSubnet'

$VMAdressPrefix = '10.0.0.0/24'

$subnetGateway = New-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName -AddressPrefix $GatewayAdressPrefix

$subnetVM = New-AzureRmVirtualNetworkSubnetConfig -Name $VMSubnetName -AddressPrefix $VMAdressPrefix

#---------------------------------------------------------------------------------------------------------------

#Create the Virtual Network

#Virtual Network

$VNetName = 'AnnuVnet'

$VNetAddPrefix = '10.0.0.0/24' 

 New-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $rgname -Location $loc -AddressPrefix $VNetAddPrefix -Subnet $subnetGateway, $subnetVM

#--------------------------------------------------------------------------------------------------------------------

#Create the local network gateway
#Local Network Gateway

$LocalNetworkGatewayName = 'AnnuLNG'

# on-premises VPN device IP address

$PublicIpLNG = '0.0.0.0' 

$PrivatePrefixLNG = '176.16.1.0/24' #The $PrivatePrefixLNG is your on-premises address space

New-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName -ResourceGroupName $rgname -Location $loc -GatewayIpAddress $PublicIpLNG -AddressPrefix $PrivatePrefixLNG


#--------------------------------Request a Public IP address-----------------------------------
#Public IP Address

$PublicIPGatewayName = 'AnnuPIP'

$IpAllocation = 'Dynamic'  

$gatewaypip= New-AzureRmPublicIpAddress -Name $PublicIPGatewayName -ResourceGroupName $rgname -Location $loc -AllocationMethod $IpAllocation


#--------------------------Create the gateway IP addressing configuration---------------------------------

$vnet = Get-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $rgname

$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $GatewaySubnetName -VirtualNetwork $vnet

$gatewayipconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name gwipconfig1 -SubnetId $subnet.Id -PublicIpAddressId $gatewaypip.Id

#----------------------------------Create the VPN gateway----------------------------------------------------
#Virtual Network Gateway

$AzureVirtualGatewayName = 'AnnuVnetGW'

$GatewayType = 'vpn'   

$VpnType =   'RouteBased'

$GatewaySku = 'Basic' 

New-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $rgname -Location $loc -IpConfigurations $gatewayipconfig -GatewayType $GatewayType -VpnType $VpnType -GatewaySku $GatewaySku


#---------------------------------------Create the VPN connection----------------------------------------------
#Gateway Connection properties

$GatewayConnectionName = 'Local'

#The value here must match the value that you are using for your VPN device

$SharedKey = 'Annu@123' 

$ConnectionType = 'IPSec' 

$RoutingWeight = '10' 

$gateway1 = Get-AzureRmVirtualNetworkGateway -Name $AzureVirtualGatewayName -ResourceGroupName $rgname

$local = Get-AzureRmLocalNetworkGateway -Name $LocalNetworkGatewayName -ResourceGroupName $rgname

New-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName -ResourceGroupName $rgname -Location $loc -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local -ConnectionType $ConnectionType -RoutingWeight $RoutingWeight -SharedKey $SharedKey


#---------------------------------------Verify VPN Connection----------------------------------------------------------

Get-AzureRmVirtualNetworkGatewayConnection -Name $GatewayConnectionName -ResourceGroupName $rgname