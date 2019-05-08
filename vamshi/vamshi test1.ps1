Login-AzureRmAccount
$rm=New-AzureRmResourceGroup -Name 'vamshirg'  -Location 'East US' 
$vn=New-AzureRmVirtualNetwork -Name 'vnet' -ResourceGroupName 'vamshirg'  -AddressPrefix 193.163.1.0/24 -Location 'East US'
Add-AzureRmVirtualNetworkSubnetConfig -Name 'sub1' -VirtualNetwork $vn -AddressPrefix 193.163.1.0/28
Add-AzureRmVirtualNetworkSubnetConfig -Name 'sub2' -VirtualNetwork $vn -AddressPrefix 193.163.1.16/28
   $nsfront=New-AzureRmNetworkSecurityGroup -Name 'nsgfront' -ResourceGroupName 'vamshirg' -Location 'East US' 
 add-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All'-NetworkSecurityGroup $nsfront -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
 add-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SSH-All'-NetworkSecurityGroup  $nsfront -Description 'Allow SSH' -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22
 add-AzureRmNetworkSecurityRuleConfig -Name 'Allow-HTTP-All'-NetworkSecurityGroup $nsfront -Description 'Allow HTTP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 120  -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 80
  $nsback= New-AzureRmNetworkSecurityGroup -Name 'nsgback'  -Location 'East US'
add-AzureRmNetworkSecurityRuleConfig -Name 'Deny-HTTP-All'-NetworkSecurityGroup  -Description 'Deny HTTP' -Access Deny -Protocol Tcp -Direction Outbound -Priority 120  -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 80
add-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All'-NetworkSecurityGroup $nsback -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
  
   