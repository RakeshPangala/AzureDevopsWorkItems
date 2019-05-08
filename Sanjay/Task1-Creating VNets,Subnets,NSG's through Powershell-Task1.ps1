#$username='quadrantit@hotmail.com'
#$password='Password'
#$password=ConvertTo-SecureString $password -AsPlainText -Force
#$credential= New-Object System.Management.Automation.PSCredential($username,$password)
#Connect-AzAccount -Credential $credential


Login-AzAccount

#--------------------------------------Creates a Virtual Network--------------------------------------------------------#

$feSubnet = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "194.168.0.0/28"
$beSubnet  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "194.168.0.16/28"
$Vnet=New-AzVirtualNetwork -Name Vnet -ResourceGroupName Sanjay -Location southindia -AddressPrefix "194.168.0.0/24" -Subnet $feSubnet1,$beSubnet1

#--------------------------------------Creates Network Security Groups--------------------------------------------------#

$fensg=New-AzNetworkSecurityGroup -Name FrontendNSG -ResourceGroupName Sanjay -Location 'South India'

$bensg=New-AzNetworkSecurityGroup -Name BackendNSG -ResourceGroupName Sanjay -Location 'South India'

#--------------------------------------Creates inbound rules for FrontendNSG--------------------------------------------#

$rule1=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Rdp-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 100 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "3389" | Set-AzNetworkSecurityGroup

$rule2=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Http-Rule" -Description "Allow Http" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 101 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "80" | Set-AzNetworkSecurityGroup

$rule3=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Https-Rule" -Description "Allow Https" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 102 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "443" | Set-AzNetworkSecurityGroup

$rule4=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "SSH-Rule" -Description "Allow SSH" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 103 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "22" | Set-AzNetworkSecurityGroup

#--------------------------------------Creates inbound rules for BackendNSG--------------------------------------------#

$rule5=Get-AzNetworkSecurityGroup -Name "BackendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Rdp-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 100 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "3389" | Set-AzNetworkSecurityGroup

$rule6=Get-AzNetworkSecurityGroup -Name "BackendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "MsSql-Rule" -Description "Allow MSSql" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 101 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "1433" | Set-AzNetworkSecurityGroup

#--------------------------------------Creates Outbound rules for BackendNSG--------------------------------------------#

$ruleGet=AzNetworkSecurityGroup -Name "BackendNSG" -ResourceGroupName "Sanjay" | Add-AzNetworkSecurityRuleConfig -Name "Http-Rule" -Description "Deny Http" -Access "Deny" -Protocol "Tcp" -Direction "Outbound" -Priority 102 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "80" | Set-AzNetworkSecurityGroup

#--------------------------------------Attaching NSG's to Subnets-------------------------------------------------------#

$set=Set-AzVirtualNetworkSubnetConfig -Name "frontendSubnet" -VirtualNetwork $Vnet -NetworkSecurityGroup $fensg -addressprefix "194.168.0.0/28"
$Vnet | Set-AzVirtualNetwork

$set=Set-AzVirtualNetworkSubnetConfig -Name "backendSubnet" -VirtualNetwork $Vnet -NetworkSecurityGroup $bensg -addressprefix "194.168.0.16/28"
$Vnet | Set-AzVirtualNetwork








