#NSG's Creation


#$LogId=""

#$Pwd=ConvertTo-SecureString "" -AsPlainText -Force

#$Creds= New-Object System.Management.Automation.PSCredential($LogId,$Pwd)

#Login-AzureRmAccount -Credential $Creds
#------------------------------------------------------------------------------------


#Login to portal

Login-AzureRmAccount

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Creating RG

$ResourceGroupName="KrishRG"

$Location="South India"

New-AzureRmResourceGroup -NAME $ResourceGroupName -Location $Location




#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



# Create a virtual network with a front-end subnet and back-end subnet.

$frontsubnet = New-AzureRmVirtualNetworkSubnetConfig -Name 'MyFrontEndSubnet' -AddressPrefix '10.3.2.0/24'

$backsubnet = New-AzureRmVirtualNetworkSubnetConfig -Name 'MyBackEndSubnet' -AddressPrefix '10.3.3.0/24'

$vnet = New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Name 'MyVirtualNetNetwork' -AddressPrefix '10.3.2.0/16' -Location $Location -Subnet $frontsubnet, $backsubnet



#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# Create an NSG rule to allow RDP traffic from the Internet to the front-end subnet.

$SGR1 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description 'Allow RDP' 

-Access Allow -Protocol Tcp -Direction Inbound -Priority 100 

-SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





# Create an NSG rule to allow HTTP traffic in from the Internet to the front-end subnet.

$SGR2 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-HTTP-All' -Description 'Allow HTTP'

  -Access Allow -Protocol Tcp -Direction Inbound -Priority 120 

  -SourceAddressPrefix Internet -SourcePortRange * 

  -DestinationAddressPrefix * -DestinationPortRange 
   #--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  
  # Create an NSG rule to allow SSH traffic from the Internet to the front-end subnet.

$SGR3 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SSH-All' -Description 'Allow SSH' 

-Access Allow -Protocol Tcp -Direction Inbound -Priority 110 

-SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



  # Create a network security group for the front-end subnet.

$nsgfront = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location

  -Name 'MyFrontEndNSG' -SecurityRules $SGR1,$SGR2, $SGR3


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



  # Associate the front-end NSG to the front-end subnet.

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name 'MyFrontEndSubnet'

  -AddressPrefix '10.3.2.0/24' -NetworkSecurityGroup $nsgfront

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


  # Create an NSG rule to allow SQL traffic from the front-end subnet to the back-end subnet.

$SGR4 = New-AzureRmNetworkSecurityRuleConfig -Name 'Allow-SQL-FrontEnd' -Description "Allow SQL"

  -Access Allow -Protocol Tcp -Direction Inbound -Priority 110

  -SourceAddressPrefix '10.3.2.0/24' -SourcePortRange *

  -DestinationAddressPrefix * -DestinationPortRange 1433

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


  # Create a network security group for back-end subnet.

$nsgback= New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location

  -Name "NsgBack" -SecurityRules $SGR1,$SGR4

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


  # Associate the back-end NSG to the back-end subnet

Set-AzureRmNetworkSecurityRuleConfig -VirtualNetwork $vnet -Name 'MyBackEndSubnet'

  -AddressPrefix '10.3.3.0/24' -NetworkSecurityGroup $nsgback