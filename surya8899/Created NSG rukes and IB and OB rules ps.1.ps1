#Login into the Azure portal

Login-AzureRmAccount 

#creating Resource-Group

$RG=New-AzureRmResourceGroup -Name "SuryaRG" -Location "South india"

#creating Virtual Network


$VN=New-AzureRmVirtualNetwork -ResourceGroupName "SuryaRG" -Location "South india" -Name "SuryaVNet" -AddressPrefix "198.162.1.0/25"

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.1.0/27 -VirtualNetwork $VN
$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.1.32/27 -VirtualNetwork $VN

$VN | Set-AzureRmVirtualNetwork

#creating inbound security rule

  $rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'HTTP' -Description 'Allow HTTP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 

  $rule2 = New-AzureRmNetworkSecurityRuleConfig -Name 'RDP' -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
   
  $rule3 = New-AzureRmNetworkSecurityRuleConfig -Name 'SSH' -Description "Allow SSH" -Access Allow -Protocol Tcp -Direction Inbound -Priority 300 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange  22
  
 

#creation of Nsg with inbound rule

$nsg= New-AzureRmNetworkSecurityGroup  -ResourceGroupName "SuryaRG"  -Location "South india" -Name SuryaNSG -SecurityRules $rule1,$rule2,$rule3

#creating outbound security rule

$rule4 = New-AzureRmNetworkSecurityRuleConfig -Name 'MSSQL' -Description "Allow MSSQL" -Access Deny -Protocol Tcp -Direction Outbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange  1433

 $rule5 = New-AzureRmNetworkSecurityRuleConfig -Name 'RDP' -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Outbound -Priority 200 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange  3389

 #creation of Nsg with outbound rule

$nsg= New-AzureRmNetworkSecurityGroup  -ResourceGroupName "SuryaRG"  -Location "South india" -Name SuryaNSG -SecurityRules $rule4,$rule5