#Logging into Account

Connect-AzureRmAccount

#Creating a ResourceGroup
 
$ResourceGroup='KrishnaRG'
$location='Southindia'
New-AzureRmResourceGroup -Name $ResourceGroup -Location $location

#Creating Virtual Network

$VirtualNetwork=New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroup -Location $location -Name "KrishnaVNet" -AddressPrefix "198.162.1.0/25"

#Creating Subnets

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.1.0/27 -VirtualNetwork $VirtualNetwork

$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.1.32/27 -VirtualNetwork $VirtualNetwork

$VirtualNetwork | Set-AzureRmVirtualNetwork

#creating inbound security rule

$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'HTTP' -Description 'Allow HTTP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 

$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name 'RDP' -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

$rule3 = New-AzureRmNetworkSecurityRuleConfig -Name 'SSH' -Description "Allow SSH" -Access Allow -Protocol Tcp -Direction Inbound -Priority 300 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange  22

#Creating NetworkSecurityGroup with inbound rule

$nsg= New-AzureRmNetworkSecurityGroup  -ResourceGroupName $ResourceGroup  -Location $location -Name KrishnaNSG -SecurityRules $rule1,$rule2,$rule3

#creating outbound security rule

$rule4 = New-AzureRmNetworkSecurityRuleConfig -Name 'MSSQL' -Description "Allow MSSQL" -Access Deny -Protocol Tcp -Direction Outbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange  1433

$rule5 = New-AzureRmNetworkSecurityRuleConfig -Name 'RDP' -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Outbound -Priority 200 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange  3389

#Creating NetworkSecurityGroup with outbound rule 

$nsg= New-AzureRmNetworkSecurityGroup  -ResourceGroupName  $ResourceGroup -Location $location -Name KrishnaNSG1 -SecurityRules $rule4,$rule5

