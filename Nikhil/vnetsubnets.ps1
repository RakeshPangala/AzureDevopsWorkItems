




#Login into the Azure portal
Login-AzureRmAccount 
#creating Resource-Group
$RG=New-AzureRmResourceGroup -Name "NikhilRG" -Location "East Us"
#creating Virtual Network
$VN=New-AzureRmVirtualNetwork -ResourceGroupName "NikhilRG" -Location "East Us" -Name "NikhilVN" -AddressPrefix "198.162.1.0/25"
$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.1.0/27 -VirtualNetwork $VN
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.1.32/27 -VirtualNetwork $VN

$VN | Set-AzureRmVirtualNetwork

$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

# Create an NSG rule to allow SSH traffic from the Internet to the front-end subnet.
$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SSH-All' -Description 'Allow SSH' -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22

# Create an NSG rule to allow HTTP traffic in from the Internet to the front-end subnet.
$rule3 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-HTTP-All' -Description 'Allow HTTP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 120  -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 80

# Create a network security group for the front-end subnet.

$nsgfe = New-AzureRmNetworkSecurityGroup -ResourceGroupName "NikhilRG" -Location "East Us"  -Name FrontendsubnetNSG -SecurityRules $rule1,$rule2, $rule3

# Associate the front-end NSG to the front-end subnet.

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VN -Name Frontendsubnet -AddressPrefix 198.162.1.0/27 -NetworkSecurityGroup $nsgfe



$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

# Create an NSG rule to allow SSH traffic from the Internet to the front-end subnet.
$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-Mssql-All' -Description 'Allow Mssql' -Access Allow -Protocol Tcp -Direction Inbound -Priority 130 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3306

# Create an NSG rule to allow HTTP traffic in from the Internet to the front-end subnet.
$rule3 = New-AzureRmNetworkSecurityRuleConfig -Name 'Deny-HTTP-All' -Description 'Deny HTTP' -Access Deny -Protocol Tcp -Direction Outbound -Priority 120  -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 80

# Create a network security group for the front-end subnet.

$nsgfe = New-AzureRmNetworkSecurityGroup -ResourceGroupName "Nikhil" -Location "East Us"  -Name BackendsubnetNSG -SecurityRules $rule1,$rule2, $rule3

# Associate the BACK-end NSG to the back-end subnet.

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VN -Name Backendsubnet -AddressPrefix 198.162.1.32/27 -NetworkSecurityGroup $nsgfe