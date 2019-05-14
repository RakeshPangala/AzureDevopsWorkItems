﻿

Login-AzAccount

New-AzureRmResourceGroup -Name tej -Location South India

$feSubnet1 = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "193.168.0.0/28"
$beSubnet1  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "193.168.0.16/28"
$Vnet=New-AzVirtualNetwork -Name Vnet -ResourceGroupName tej -Location southindia -AddressPrefix "193.168.0.0/24" -Subnet $feSubnet1,$beSubnet1


$fensg=New-AzNetworkSecurityGroup -Name FrontendNSG -ResourceGroupName tej -Location 'South India'


$rule1=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "tej" | Add-AzNetworkSecurityRuleConfig -Name "Rdp-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 100 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "3389" | Set-AzNetworkSecurityGroup

$rule2=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "tej" | Add-AzNetworkSecurityRuleConfig -Name "Http-Rule" -Description "Allow http" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 101 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "80" | Set-AzNetworkSecurityGroup

$rule3=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "tej" | Add-AzNetworkSecurityRuleConfig -Name "Https-Rule" -Description "Allow https" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 102 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "443" | Set-AzNetworkSecurityGroup

$rule4=Get-AzNetworkSecurityGroup -Name "FrontendNSG" -ResourceGroupName "tej" | Add-AzNetworkSecurityRuleConfig -Name "SSH-Rule" -Description "Allow ssh" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 103 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "22" | Set-AzNetworkSecurityGroup


$bensg=New-AzNetworkSecurityGroup -Name BackendNSG -ResourceGroupName tej -Location 'South India'


$rule5=Get-AzNetworkSecurityGroup -Name "BackendNSG" -ResourceGroupName "tej" | Add-AzNetworkSecurityRuleConfig -Name "Rdp-Rule" -Description "Allow RDP" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 100 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "3389" | Set-AzNetworkSecurityGroup

$rule6=Get-AzNetworkSecurityGroup -Name "BackendNSG" -ResourceGroupName "tej" | Add-AzNetworkSecurityRuleConfig -Name "MsSql-Rule" -Description "Allow mssql" -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority 101 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "1433" | Set-AzNetworkSecurityGroup

$ruleGet=AzNetworkSecurityGroup -Name "BackendNSG" -ResourceGroupName "tej" | Add-AzNetworkSecurityRuleConfig -Name "Http-Rule" -Description "Allow http" -Access "Deny" -Protocol "Tcp" -Direction "Outbound" -Priority 102 -SourceAddressPrefix "Internet" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "80" | Set-AzNetworkSecurityGroup


$set=Set-AzVirtualNetworkSubnetConfig -Name "frontendSubnet" -VirtualNetwork $Vnet -NetworkSecurityGroup $fensg -addressprefix "193.168.0.0/28"
$Vnet | Set-AzVirtualNetwork

$set=Set-AzVirtualNetworkSubnetConfig -Name "backendSubnet" -VirtualNetwork $Vnet -NetworkSecurityGroup $bensg -addressprefix "193.168.0.16/28"
$Vnet | Set-AzVirtualNetwork






