
#Login to Azure portal with Credenials

Login-AzureRmAccount



#Creating Resource Group

$ResourceGroupName="RakeshNewRG"

$Location="East us"

New-AzureRmResourceGroup -NAME $ResourceGroupName -Location $Location



#Fields required to create Vnet and subnets

$VirtualNetworkName="RakeshNewVnet"

$SubnetName1="FrontendSubnet"

$SubnetName2="BackendSubnet"

$AddressSpace="10.8.0.0/24"

$AddressRange1="10.8.0.0/28"

$AddressRange2="10.8.0.32/28"



#Creating Virtual Network

$VirtualNetwork= New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Location $Location -Name $VirtualNetworkName -AddressPrefix $AddressSpace



#Creating Subnet1

$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name $SubnetName1 -AddressPrefix $AddressRange1 -VirtualNetwork $VirtualNetwork



$virtualNetwork | Set-AzureRmVirtualNetwork



#Creating Subnet2

$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name $SubnetName2 -AddressPrefix $AddressRange2 -VirtualNetwork $VirtualNetwork



$virtualNetwork | Set-AzureRmVirtualNetwork


$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description 'Allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389



# Create an NSG rule to allow SSH traffic from the Internet to the front-end subnet.

$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SSH-All' -Description 'Allow SSH' -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22



# Create an NSG rule to allow HTTP traffic in from the Internet to the front-end subnet.

$rule3 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-HTTP-All' -Description 'Allow HTTP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 120 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80



  # Create a network security group for the front-end subnet.

$nsgfe = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location -Name 'MyFrontEndNSG' -SecurityRules $rule1,$rule2, $rule3





  # Associate the front-end NSG to the front-end subnet.

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork -Name 'MyFrontEndSubnet' -AddressPrefix '10.8.0.0/28' -NetworkSecurityGroup $nsgfe



  # Create an NSG rule to allow SQL traffic from the front-end subnet to the back-end subnet.

$rule11 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SQL-FrontEnd' -Description "Allow SQL"-Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix '10.8.8.0/24' -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 1433

$rule12 = New-AzureRmNetworkSecurityRuleConfig -Name 'Deny-HTTP-All' -Description "Deny HTTP" -Access Deny -Protocol Tcp -Direction Inbound -Priority 120 -SourceAddressPrefix '10.8.8.0/24' -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80


  # Create a network security group for back-end subnet.

$nsgbe = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location -Name "MyNsg-BackEnd" -SecurityRules $rule1,$rule11



  # Associate the back-end NSG to the back-end subnet

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork -Name 'MyBackEndSubnet' -AddressPrefix '10.8.0.32/24' -NetworkSecurityGroup $nsgbe









