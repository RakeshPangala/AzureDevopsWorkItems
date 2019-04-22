Get-ExecutionPolicy
#login to Azure portal

Login-AzureRmAccount
#creating Resource Group
$rgName='AnnuRG'
$location='eastus'
New-AzureRmResourceGroup -Name $rgName -Location $location 

#Creating Virtual network and sub net

$fesubnet = New-AzVirtualNetworkSubnetConfig -Name 'MySubnet-FrontEnd' -AddressPrefix '10.0.1.0/24'
$besubnet = New-AzVirtualNetworkSubnetConfig -Name 'MySubnet-BackEnd' -AddressPrefix '10.0.2.0/24'
$vnet = New-AzVirtualNetwork -ResourceGroupName $rgName -Name 'MyVnet' -AddressPrefix '10.0.0.0/28' 
  -Location $location -Subnet $fesubnet, $besubnet

#creating Network Security Group  

$nsg=New-AzureRmNetworkSecurityGroup -ResourceGroupName $rgName -Name AnnuNSG -Location $location

#Adding Security rules to NSG

  $rule1 = New-AzNetworkSecurityRuleConfig -Name 'HTTP' -Description 'Allow HTTP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 

  $rule2 = New-AzNetworkSecurityRuleConfig -Name 'RDP' -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 200 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 

 -NetworkSecurityGroup $nsg -Name $fesubnet -SecurityRules $rule1,$rule2
     
,


