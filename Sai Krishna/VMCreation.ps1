#Login to portal
Login-AzureRmAccount

$resourceGroupName = 'KrishRG'
$Location = 'South India'
#--------------------------------------------------------
New-AzureRmResourceGroup -Name $resourceGroupName -Location $Location

#------------------------------------------------------------------
#Creating a virtual network and subnet with public IP

# Create a subnet configuration  
$subnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name KrishSubnet -AddressPrefix 192.168.1.0/24  
# Create a virtual network  
$vnet = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Location $Location `  
-Name KrishVnet -AddressPrefix 192.168.0.0/16 -Subnet $subnetConfig  
# Create a public IP address and specify a DNS name  
$pip = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName -Location $Location `  
-AllocationMethod Static -IdleTimeoutInMinutes 4 -Name "mypublicdns$(Get-Random)" 

#----------------------------------------------------------------------------------------------------
#Creating a network security group
# Create an inbound network security group rule for port 3389  
$nsgRuleRDP = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleRDP -Protocol Tcp `  
-Direction Inbound -Priority 100 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * `  
-DestinationPortRange 3389 -Access Allow  
# Create an inbound network security group rule for port 80  
$nsgRuleWeb = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleWWW -Protocol Tcp `  
-Direction Inbound -Priority 101 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * `  
-DestinationPortRange 80 -Access Allow  
# Create a network security group  
$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $Location `  
-Name myNetworkSecurityGroup -SecurityRules $nsgRuleRDP,$nsgRuleWeb 
#--------------------------------------------------------------------------------------------------------------

#Creating a network card for VM
# Create a virtual network card and associate with public IP address and NSG  
$nic = New-AzureRmNetworkInterface -Name myNic -ResourceGroupName $resourceGroupName -Location $Location `  
-SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id 
#----------------------------------------------------------------------------------------------------------------
#Creating a virtual machine
#Define a credential object  
$cred = Get-Credential 
#Create a virtual machine configuration  
$vmConfig = New-AzureRmVMConfig -VMName KrishVM -VMSize Standard_DS2 | `  
  
Set-AzureRmVMOperatingSystem -Windows -ComputerName KrishVM -Credential $cred | `  
Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer `  
  
-Skus 2016-Datacenter -Version latest | Add-AzureRmVMNetworkInterface -Id $nic.Id 
#---------------------------------------------------------------------------------------------------------------------
New-AzureRmVM -ResourceGroupName $resourceGroupName -Location $Location -VM $vmConfig
Get-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName | Select IpAddress
#Now do mstsc and connect to VM with ip