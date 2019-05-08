$ResourceGroupName='AnupRG'

$VirtualMachineName='AnupVM'

$Location='France Central'

$VirtualNetworkName='AnupVnet'

$SubnetName='AnupSubnet'

$SecurityGroupName='AnupNSG'

$PublicIpAddressName='AnupPIP'



New-AzureRmVm -ResourceGroupName $AnupRG -Name $VirtualMachineName -Location $Location -VirtualNetworkName $VirtualNetworkName -SubnetName $SubnetName -SecurityGroupName $SecurityGroupName -PublicIpAddressName $PublicIpAddressName -OpenPorts 80,3389



    #To Connect Virtual Machine

    Get-AzPublicIpAddress -ResourceGroupName $AnupRG | Select $PublicIpAddressName