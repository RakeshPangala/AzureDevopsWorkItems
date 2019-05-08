#$name="quadrantit@hotmail.com"
#$passwd = ConvertTo-SecureString "password" -AsPlainText -Force
#$credential = New-Object System.Management.Automation.PSCredential($name, $passwd)
#Login-AzAccount -Credential $credential


Login-AzAccount

#-----------------------Creates a Resource Group--------------------#

$RgName="Sanjay"
$RgLocation="southindia"
$Rg= New-AzureRmResourceGroup -Name $RgName -Location $RgLocation


#-----------------------Creates a Vitual Network 1 with 2 Subnets and GatewaySubnet-------------#
$feSubnet1 = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "194.168.1.0/28"
$beSubnet1  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "194.168.1.16/28" 
$gwsubnet1 = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "194.168.1.32/28"
$VNet1=New-AzVirtualNetwork -Name VNet1 -ResourceGroupName Sanjay -Location southindia -AddressPrefix "194.168.1.0/24" -Subnet $feSubnet1,$beSubnet1,$gwsubnet1

#-----------------------Created a Vitual Network 2 with 2 Subnets and GatewaySubnet-------------#

$feSubnet2 = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "194.168.2.0/28"
$beSubnet2  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "194.168.2.16/28"
$gwsubnet2 = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "194.168.2.32/28"
$Vnet2=New-AzVirtualNetwork -Name VNet2 -ResourceGroupName Sanjay -Location southindia -AddressPrefix "194.168.2.0/24" -Subnet $feSubnet2,$beSubnet2,$gwsubnet2

#-----------------------Created a Vitual Network 3 with 2 Subnets and GatewaySubnet-------------#

$feSubnet3 = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "194.168.3.0/28"
$beSubnet3  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "194.168.3.16/28"
$gwsubnet3 = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "194.168.3.32/28"
$Vnet3=New-AzVirtualNetwork -Name VNet3 -ResourceGroupName Sanjay -Location southindia -AddressPrefix "194.168.3.0/24" -Subnet $feSubnet3,$beSubnet3,$gwsubnet3

#-----------------------Requesting PublicIP for VPN Gatway 1-----------------------------------#

$Gw1         = "VNet1GW"
$GwIP1       = "VNet1GWIP"
$GwIPConf1   = "gwipconf1"


$gwpip    = New-AzPublicIpAddress -Name Gw1PublicIP -ResourceGroupName Sanjay -Location southindia -AllocationMethod Dynamic
$subnetip   = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $VNet1
$gwipconf = New-AzVirtualNetworkGatewayIpConfig -Name $GwIPConf1 -Subnet $subnetip -PublicIpAddress $gwpip


#---------------------- Create a VPN gate way----------------------------------------------------#

$Gw1=New-AzVirtualNetworkGateway -Name $Gw1 -ResourceGroupName $Rg -Location 'South India' -IpConfigurations $gwipconf -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw1 

   
#-----------------------Requesting PublicIP for VPN Gatway 2-----------------------------------#

$Gw2         = "VNet2GW"
$GwIP2       = "VNet2GWIP"
$GwIPConf2   = "gwipconf2"


$gwpip2    = New-AzPublicIpAddress -Name Gw2PublicIP -ResourceGroupName Sanjay -Location southindia -AllocationMethod Dynamic
$subnetip2   = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $Vnet2
$gwipconf2 = New-AzVirtualNetworkGatewayIpConfig -Name $GwIPConf2 -Subnet $subnetip2 -PublicIpAddress $gwpip2


#-----------------------Create a VPN gate way2---------------------------------------------------#
$Gw1=New-AzVirtualNetworkGateway -Name $Gw2 -ResourceGroupName Sanjay -Location 'South India' -IpConfigurations $gwipconf2 -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw1 

#$Gw1         = "VNet1GW"
#$GwIP1       = "VNet1GWIP"
#$GwIPConf1   = "gwipconf1"

#-----------------------Getting VPN Gateways-------------------------------------------------------#

$vnet1gw = Get-AzVirtualNetworkGateway -Name $Gw1 -ResourceGroupName $Rg

#$Gw2         = "VNet2GW"
#$GwIP2       = "VNet2GWIP"
#$GwIPConf2   = "gwipconf2"

$vnet2gw = Get-AzVirtualNetworkGateway -Name $Gw2 -ResourceGroupName $Rg



#-----------------------Create a VNet2VNet COnnection---------------------------------------------#
$Connection="Vnet1-Vnet2"

$gwconnection=New-AzVirtualNetworkGatewayConnection -Name $Connection -ResourceGroupName $Rg -VirtualNetworkGateway1 $vnet1gw -VirtualNetworkGateway2 $vnet2gw -Location $Location -ConnectionType Vnet2Vnet -SharedKey '3761'

$Connection="Vnet2-Vnet1"

$gwconnection=New-AzVirtualNetworkGatewayConnection -Name $Connection -ResourceGroupName $Rg -VirtualNetworkGateway1 $vnet2gw -VirtualNetworkGateway2 $vnet1gw -Location $Location -ConnectionType Vnet2Vnet -SharedKey '3761'

#-----------------------Creates a VNet-VNet Peering and VNet2 as Hub and VNet3 as Spoke-----------#

Add-AzVirtualNetworkPeering -Name 'myVnet1ToMyVnet2' -VirtualNetwork $VNet2 -RemoteVirtualNetworkId $Vnet3.Id -AllowGatewayTransit

Add-AzVirtualNetworkPeering -Name 'myVnet2ToMyVnet1' -VirtualNetwork $Vnet3 -RemoteVirtualNetworkId $VNet2.Id -UseRemoteGateways