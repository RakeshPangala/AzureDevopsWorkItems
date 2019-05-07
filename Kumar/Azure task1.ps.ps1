Connect-AzureRmAccount
 New-AzureRmResourceGroup -Name 'kumar' -location 'South India' 
 $vnet=New-AzureRmVirtualNetwork -ResourceGroupName 'kumar' -Location 'South India' -Name 'kumarvnet' -AddressPrefix 190.168.0.0/25
 #Add-AzureRmVirtualNetworkSubnetConfig Add-AzureRmVirtualNetworkSubnetConfig -Name Frontend -AddressPrefix 190.168.0.0/28 -VirtualNetwork $vnet

 $SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 190.168.0.0/27 -VirtualNetwork $vnet
 $SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 190.168.0.32/27 -VirtualNetwork $vnet

$vnet | Set-AzureRmVirtualNetwork
$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SSH-All' -Description 'Allow SSH' -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22
$rule3 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-HTTP-All' -Description 'Allow HTTP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 102  -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 80
$rule4 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-HTTPS-All' -Description 'Allow HTTPS' -Access Allow -Protocol Tcp -Direction Inbound -Priority 103  -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 443


$rule5 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 104 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$rule6 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-Mssql-All' -Description 'Allow Mssql' -Access Allow -Protocol Tcp -Direction Inbound -Priority 105 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 1433
$rule7 = New-AzureRmNetworkSecurityRuleConfig -Name 'Deny-HTTP-All' -Description 'Deny HTTP' -Access Deny -Protocol Tcp -Direction Outbound -Priority 106  -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 80



$nsgfe = New-AzureRmNetworkSecurityGroup -ResourceGroupName 'kumar' -Location 'South India'  -Name FrontendsubnetNSG -SecurityRules $rule1,$rule2, $rule3,$rule4
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name Frontendsubnet -AddressPrefix 190.168.0.0/27 -NetworkSecurityGroup $nsgfe
$vnet | Set-AzureRmVirtualNetwork

$nsgbe = New-AzureRmNetworkSecurityGroup -ResourceGroupName 'kumar' -Location 'South India'  -Name BackendsubnetNSG -SecurityRules $rule5,$rule6, $rule7

#$nsgfe = New-AzureRmNetworkSecurityGroup -ResourceGroupName 'kumar' -Location 'South India' -Name FrontendSubnetNSG -SecurityRules $rule1,$rule2,$rule3
 
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name Backendsubnet -AddressPrefix 190.168.0.32/27 -NetworkSecurityGroup $nsgbe
$vnet | Set-AzureRmVirtualNetwork

