Login-AzureRmAccount

New-AzureRmResourceGroup -Name MadhuRG -Location westus2

$virtualNetwork1 = New-AzureRmVirtualNetwork -ResourceGroupName MadhuRG -Location westus2 -Name 'Vnet1' -AddressPrefix 195.163.0.0/24 
$subnetfront = Add-AzureRmVirtualNetworkSubnetConfig -Name FrnotEnd -AddressPrefix 195.163.0.0/28  -VirtualNetwork $virtualNetwork1
$subnetBackend = Add-AzureRmVirtualNetworkSubnetConfig -Name Backend -AddressPrefix 195.163.0.32/28  -VirtualNetwork $virtualNetwork1 
$virtualNetwork1 | Set-AzureRmVirtualNetwork

$NSGfrontend=New-AzureRmNetworkSecurityGroup -Name NSGf -ResourceGroupName MadhuRG -Location  westus2
Add-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP'-NetworkSecurityGroup $NSGfrontend -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
Add-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SSH'-NetworkSecurityGroup  $NSGfrontend -Description 'Allow SSH' -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22
Add-AzureRmNetworkSecurityRuleConfig -Name 'Allow-HTTP'-NetworkSecurityGroup $NSGfrontend -Description 'Allow HTTP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 120  -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 80

$NSGBackend=New-AzureRmNetworkSecurityGroup -Name NSGb1 -ResourceGroupName MadhuRG -Location westus2
 Add-AzureRmNetworkSecurityRuleConfig -Name 'Deny-HTTP'-NetworkSecurityGroup $NSGBackend -Description 'Deny HTTP' -Access Deny -Protocol Tcp -Direction Outbound -Priority 150  -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 80
 Add-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP' -NetworkSecurityGroup $NSGBackend  -Description 'Allow RDP' -Access Allow  -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

 
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $virtualNetwork1 -Name FrnotEnd -AddressPrefix 195.163.0.0/28 -NetworkSecurityGroup $NSGfrontend

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork1 -Name Backend -AddressPrefix 198.163.0.32/28 -NetworkSecurityGroup $NSGBackend