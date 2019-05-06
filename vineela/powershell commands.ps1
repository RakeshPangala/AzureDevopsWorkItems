Install-Module -Name AzureRm -AllowClobber
Login-AzureRmAccount

#create resource group
New-AzureRmResourceGroup -Name "vineela1" -Location "south india"

#create virtual networks
$vnet = New-AzureRmVirtualNetwork -ResourceGroupName 'vineela1' -Location 'southindia' -Name 'vvnet' -AddressPrefix '192.168.0.0/24' 

$subnetf = Add-AzureRmVirtualNetworkSubnetConfig  -Name 'Frontend45' -AddressPrefix '192.168.0.0/28'  -VirtualNetwork $vnet 

$subnetb = Add-AzureRmVirtualNetworkSubnetConfig  -Name 'backend80' -AddressPrefix '192.168.0.16/28'  -VirtualNetwork $vnet

$vnet| Set-AzureRmVirtualNetwork 

#create NSG
$Nsg = New-AzureRmNetworkSecurityGroup -Name "FrontendNsg"-ResourceGroupName "vineela1"  -Location "south india" -SecurityRules $rule1,$rule2,$rule3

$Nsg1 = New-AzureRmNetworkSecurityGroup -Name "BackendendNsg"-ResourceGroupName "vineela1"  -Location "south india" -SecurityRules $rule4,$rule5

#NSG Security rules

$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'SSH' -Description "Allow SSH" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22 

$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name 'HTTPS' -Description "Allow HTTPS" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange *  -DestinationAddressPrefix * -DestinationPortRange 443

$rule3 = New-AzureRmNetworkSecurityRuleConfig -Name 'RDP' -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 102 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 

$rule4 = New-AzureRmNetworkSecurityRuleConfig -Name 'FTP' -Description "Allow FTP" -Access Allow -Protocol Tcp -Direction Outbound -Priority 103 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 21 

$rule5 = New-AzureRmNetworkSecurityRuleConfig -Name 'HTTP' -Description "Deny HTTP" -Access Deny -Protocol Tcp -Direction Outbound -Priority 104 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 
