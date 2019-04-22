#$AzureLoginId=""
#$AzurePassword=ConvertTo-SecureString "" -AsPlainText -Force
#$AzureCreds= New-Object System.Management.Automation.PSCredential($AzureLoginId,$AzurePassword)
#Login-AzureRmAccount -Credential $AzureCreds

#Login to Azure portal with Credenials
Login-AzureRmAccount

#Creating Resource Group
$ResourceGroupName="VaijayanthiRG1"
$Location="East us"
New-AzureRmResourceGroup -NAME $ResourceGroupName -Location $Location



# Create a virtual network with a front-end subnet and back-end subnet.
$fesubnet = New-AzureRmVirtualNetworkSubnetConfig -Name 'MyFrontEndSubnet' -AddressPrefix '10.3.1.0/24'
$besubnet = New-AzureRmVirtualNetworkSubnetConfig -Name 'MyBackEndSubnet' -AddressPrefix '10.3.2.0/24'
$vnet = New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Name 'MyVirtualNetNetwork' -AddressPrefix '10.3.0.0/16' -Location $Location -Subnet $fesubnet, $besubnet


# Create an NSG rule to allow RDP traffic from the Internet to the front-end subnet.
$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description 'Allow RDP' 
-Access Allow -Protocol Tcp -Direction Inbound -Priority 100 
-SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

# Create an NSG rule to allow SSH traffic from the Internet to the front-end subnet.
$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SSH-All' -Description 'Allow SSH' 
-Access Allow -Protocol Tcp -Direction Inbound -Priority 110 
-SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22

# Create an NSG rule to allow HTTP traffic in from the Internet to the front-end subnet.
$rule3 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-HTTP-All' -Description 'Allow HTTP'
  -Access Allow -Protocol Tcp -Direction Inbound -Priority 120 
  -SourceAddressPrefix Internet -SourcePortRange * 
  -DestinationAddressPrefix * -DestinationPortRange 80

  # Create a network security group for the front-end subnet.
$nsgfe = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location
  -Name 'MyFrontEndNSG' -SecurityRules $rule1,$rule2, $rule3


  # Associate the front-end NSG to the front-end subnet.
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name 'MyFrontEndSubnet'
  -AddressPrefix '10.3.1.0/24' -NetworkSecurityGroup $nsgfe

  # Create an NSG rule to allow SQL traffic from the front-end subnet to the back-end subnet.
$rule11 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SQL-FrontEnd' -Description "Allow SQL"
  -Access Allow -Protocol Tcp -Direction Inbound -Priority 110
  -SourceAddressPrefix '10.3.1.0/24' -SourcePortRange *
  -DestinationAddressPrefix * -DestinationPortRange 1433

  # Create a network security group for back-end subnet.
$nsgbe = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location
  -Name "MyNsg-BackEnd" -SecurityRules $rule1,$rule11

  # Associate the back-end NSG to the back-end subnet
Set-AzureRmNetworkSecurityRuleConfig -VirtualNetwork $vnet -Name 'MyBackEndSubnet'
  -AddressPrefix '10.3.2.0/24' -NetworkSecurityGroup $nsgbe
