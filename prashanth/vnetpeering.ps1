Login-AzureRmAccount



New-AzureRmResourceGroup -Name "kprg" -Location "East Us"

#creating a Virtual Network-1



$VNet1=New-AzureRmVirtualNetwork -ResourceGroupName "kprg" -Location "East Us" -Name "kpvn" -AddressPrefix "198.162.1.0/25"



$SubnetConfig1=Add-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -AddressPrefix 198.162.1.0/28 -VirtualNetwork $VNet1


$SubnetConfig2=Add-AzureRmVirtualNetworkSubnetConfig -Name Backendsubnet  -AddressPrefix 198.162.1.32/28 -VirtualNetwork $VNet1



$Gatesubway=add-AzureRmVirtualNetworkSubnetConfig -Name Gatewaysubway  -AddressPrefix 198.162.1.48/28 -VirtualNetwork $VNet1


$VNet1 | Set-AzureRmVirtualNetwork


#Creating Public Ip and configuring into vpn-gateway for Virtual Network-


$gatewayip = New-AzureRmPublicIpAddress -Name "kpvpng" -ResourceGroupName "kprg" -Location "East Us" -AllocationMethod Dynamic


$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name Frontendsubnet -VirtualNetwork $VNet1


$gwipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name VPNGatewayipconf -Subnet $subnet -PublicIpAddress $gatewayip

