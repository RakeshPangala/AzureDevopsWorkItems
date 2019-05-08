#creating a resource group
$AnupRG = New-AzureRmResourceGroup -Name "AnupRG" -Location 'France Central'
New-AzureRmResourceGroup -Name "AnupRG1" -Location 'France Central'

# creating Virtual Network
$AnupVn = New-AzureRmVirtualNetwork -ResourceGroupName "AnupRG" -Location 'France Central' -Name 'AnupVN' -AddressPrefix "198.162.4.0/24"
$SubnetConfig1 = Add-AzureRmVirtualNetworkSubnetConfig -Name FrontEndSubnet -AddressPrefix 198.162.4.0/27 -VirtualNetwork $AnupVN
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.4.32/27 -VirtualNetwork $AnupVN
$AnupVn | Set-AzureRmVirtualNetwork

#creating security rule
$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'HTTP' -Description 'AllowHTTP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80

$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name 'RDP' -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 

#creating NSG
$nsg= New-AzureRmNetworkSecurityGroup -Name AnupNSG -ResourceGroupName "AnupRG" -Location "France Central" -SecurityRules $rule1,$rule2