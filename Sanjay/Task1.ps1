#$name="quadrantit@hotmail.com"
#$passwd = ConvertTo-SecureString "password" -AsPlainText -Force
#$credential = New-Object System.Management.Automation.PSCredential($name, $passwd)
#Login-AzAccount -Credential $credential


Login-AzAccount

#-----------------------Creates a Resource Group--------------------#

$Rg= New-AzureRmResourceGroup -Name $RgName -Location $RgLocation

#-------------------------------Creates a VirtualNetwork with 2 Subnets-------------------------------#

$feSubnet = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "194.168.0.0/28"
$beSubnet  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "194.168.0.16/28"
$Vnet=New-AzVirtualNetwork -Name Vnet -ResourceGroupName Sanjay -Location southindia -AddressPrefix "194.168.0.0/24" -Subnet $feSubnet1,$beSubnet1

#-------------------------------Creates 2 Network Security Groups-------------------------------------#
$fensg=New-AzNetworkSecurityGroup -Name FrontendNSG -ResourceGroupName Sanjay -Location 'South India'

$bensg=New-AzNetworkSecurityGroup -Name BackendNSG -ResourceGroupName Sanjay -Location 'South India'


#-------------------------------Adds Inbound Rules to FrontendNSG-------------------------------------#
$rule1=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Rdp-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 100 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "3389" | Set-AzNetworkSecurityGroup

$rule2=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Http-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 101 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "80" | Set-AzNetworkSecurityGroup

$rule3=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Https-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 102 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "443" | Set-AzNetworkSecurityGroup

$rule4=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "SSH-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 103 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "22" | Set-AzNetworkSecurityGroup

#-------------------------------Adds Inbound Rules to BackendNSG--------------------------------------#

$rule5=Get-AzNetworkSecurityGroup -Name "BackendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Rdp-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 100 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "3389" | Set-AzNetworkSecurityGroup

$rule6=Get-AzNetworkSecurityGroup -Name "BackendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "MsSql-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 101 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "1433" | Set-AzNetworkSecurityGroup

#-------------------------------Adds Outbound Rules to BackendNSG-------------------------------------#

$rule7=AzNetworkSecurityGroup -Name "BackendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Http-Rule" -Description "Allow RDP" -Access "Deny" -Protocol "Tcp" -Direction "Outbound" -Priority 102 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "80" | Set-AzNetworkSecurityGroup

#-------------------------------Attaches FrontendNsG to frontendsubnet--------------------------------#

$set=Set-AzVirtualNetworkSubnetConfig -Name "frontendSubnet" -VirtualNetwork $Vnet -NetworkSecurityGroup $fensg -addressprefix "194.168.0.0/28"
$Vnet | Set-AzVirtualNetwork

#-------------------------------Attaches BackendNSG to Backendsubnet--------------------------------#


$set=Set-AzVirtualNetworkSubnetConfig -Name "backendSubnet" -VirtualNetwork $Vnet -NetworkSecurityGroup $bensg -addressprefix "194.168.0.16/28"
$Vnet | Set-AzVirtualNetwork



