Get-ExecutionPolicy
Set-ExecutionPolicy remotesignced -Sope CurrentUser
Install-Module -Name azurerm -AllowClobber
Import-Module -Name azurerm
install-Module -name AzureRM.profile
Import-Module -Name azurerm.profile
Connect-AzureRmAccount
Login-AzAccount
#creating resource group
New-AzResourceGroup -Name BhavaniRG -Location southindia
#creating virtual network
$vnet = New-AzVirtualNetwork -ResourceGroupName BhavaniRG -Location Southindia -Name BhavaniVN -AddressPrefix 192.68.0.0/25
$subnetConfig = Add-AzVirtualNetworkSubnetConfig -Name FrontSN -AddressPrefix 192.68.0.0/27 -virtualNetwork $vnet
$subnetConfig = Add-AzVirtualNetworkSubnetConfig -Name BackSN -AddressPrefix 192.68.0.32/27 -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork
#Asigning NSG for frontend NSG
$rule1 = New-AzNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$rule2 = New-AzNetworkSecurityRuleConfig -Name 'Allow-SSH-All' -Description 'Allow SSH' -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22
$rule3 = New-AzNetworkSecurityRuleConfig -Name 'Allow-HTTP-All' -Description 'Allow HTTP'-Access Allow -Protocol Tcp -Direction Inbound -Priority 120 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80
$nsgfe = New-AzNetworkSecurityGroup -ResourceGroupName BhavaniRG -Location Southindia -Name 'BFrontNSG' -SecurityRules $rule1,$rule2,$rule3
# Associate the front-end NSG to the front-end subnet.
Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name 'FrontSN'-AddressPrefix '192.68.0.0/27' -NetworkSecurityGroup $nsgfe
#assigning NSG for Backend NSG
$rule11 = New-AzNetworkSecurityRuleConfig -Name 'Allow-SQL' -Description "Allow SQL"-Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix '192.68.0.0/27' -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 1433
$rule12= New-AzNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$rule13 = New-AzNetworkSecurityRuleConfig -Name 'Deny-HTTP-BackEnd' -Description "Deny HTTP"-Access Deny -Protocol Tcp -Direction Outbound -Priority 120 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80
$nsgbe = New-AzNetworkSecurityGroup -ResourceGroupName BhavaniRG -Location Southindia -Name "BBackNSG" -SecurityRules $rule11,$rule12,$rule13
#associate the backend NSG to the Backend subnet
Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name 'BackSN'-AddressPrefix '192.68.0.32/27' -NetworkSecurityGroup $nsgbe

