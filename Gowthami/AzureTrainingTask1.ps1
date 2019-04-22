#Assignment-1 Creating Virtual Network(Vnet) under that create a subnets 
#like frontend,backend and each subnet create network security groups 
# in frontend allow RDP,SSH,HTTP,HTTPS CONNECTION INBOUND AND allow RDP,MS SQL Deny the http connection Outbound.

#Login in azure account
#$username=Read-host "please enter email"
#$password=convertTo -SecurityStriing "*******" -AsPlainText -Force

#$AzureCred=New-Object System.Management.Automation.PsContainer($username,$password)
Login-AzureRmAccount 
#-Credential $AzureCred




#creating Resource-Group
#$Resourcegroupname=Read-host "enter a resource group name"
#$location=Read-host "enter a location"
New-AzureRmResourceGroup -Name "GowthamiRG" -Location "South india"

#creating Virtual Network
#$vnetname=Read-host "enter vnet name"
#$addresspace=Read-host "enter address space"

New-AzureRmVirtualNetwork -ResourceGroupName GowthamiRG -Name "Vnet" -Location "South india" -AddressPrefix  "10.0.0.0/25"


#creating subnets
#$frontendsubnet=Read-host "enter a frontendsubnet name"
#$backendsubnet=Read-host "enter a backendsubnet name"
#$subnet1addressrange=Read-host "enter a subnet1addressrange"
#$subnet2addressrange=Read-host "enter a subnet2addressrange"

New-AzureRmVirtualNetworkSubnetConfig -Name "frontendsubnet" -AddressPrefix "10.0.0.0/27" -VirtualNetwork "Vnet"
New-AzureRmVirtualNetworkSubnetConfig -Name "backendsubnet"  -AddressPrefix "10.0.0.16/27" -VirtualNetwork "Vnet"





# Create an NSG rule to allow HTTP traffic in from the Internet to the front-end subnet.
$rule1 = New-AzNetworkSecurityRuleConfig -Name 'Allow-HTTP-All' -Description 'Allow HTTP' 
  -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 
  -SourceAddressPrefix Internet -SourcePortRange * 
  -DestinationAddressPrefix * -DestinationPortRange 80

# Create an NSG rule to allow RDP traffic from the Internet to the front-end subnet.
$rule2 = New-AzNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description "Allow RDP" 
  -Access Allow -Protocol Tcp -Direction Inbound -Priority 200
  -SourceAddressPrefix Internet -SourcePortRange * 
  -DestinationAddressPrefix * -DestinationPortRange 3389

  # Create an NSG rule to allow SSH traffic from the Internet to the front-end subnet.
$rule3 = New-AzNetworkSecurityRuleConfig -Name 'Allow-SSH-All' -Description "Allow SSH" 
  -Access Allow -Protocol Tcp -Direction Inbound -Priority 300
  -SourceAddressPrefix Internet -SourcePortRange * 
  -DestinationAddressPrefix * -DestinationPortRange 22


  # Create a network security group for the front-end subnet.
$nsgfe = New-AzNetworkSecurityGroup -ResourceGroupName "GowthamiRG" -Location "South india"
  -Name 'MyNsg-FrontEnd' -SecurityRules $rule1,$rule2,$rule3


# Associate the front-end NSG to the front-end subnet.
Set-AzVirtualNetworkSubnetConfig -VirtualNetwork "Vnet" -Name 'MySubnet-FrontEnd' 
  -AddressPrefix "10.0.0.0/27 -NetworkSecurityGroup $nsgfe

#Create a public IP address for the web server VM

$publicipvm1 = New-AzPublicIpAddress -ResourceGroupName "GowthamiRG"  -Name "MyPublicIp-Web"
  -location "South india" -AllocationMethod Dynamic




# Create an NSG rule to allow SQL traffic from the front-end subnet to the back-end subnet.

$rule1 = New-AzNetworkSecurityRuleConfig -Name 'Allow-SQL-FrontEnd' -Description "Allow SQL" 
  -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 
  -SourceAddressPrefix internet -SourcePortRange * 
  -DestinationAddressPrefix * -DestinationPortRange 1433

# Create an NSG rule to allow RDP traffic from the Internet to the back-end subnet.
$rule2 = New-AzNetworkSecurityRuleConfig -Name 'Allow-RDP-All' -Description "Allow RDP" 
  -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 
  -SourceAddressPrefix Internet -SourcePortRange * 
  -DestinationAddressPrefix * -DestinationPortRange 3389

# Create a network security group for back-end subnet.
$nsgbe = New-AzNetworkSecurityGroup -ResourceGroupName "GowthamiRG" -Location "South india"
  -Name "MyNsg-BackEnd" -SecurityRules $rule1,$rule2

# Associate the back-end NSG to the back-end subnet
Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name 'MySubnet-BackEnd' 
  -AddressPrefix "10.0.0.16/27" -NetworkSecurityGroup $nsgbe

# Create a public IP address for the SQL VM.


$publicipvm2 = New-AzPublicIpAddress -ResourceGroupName "GowthamiRG" -Name MyPublicIP-Sql 
  -location "South india" -AllocationMethod Dynamic

