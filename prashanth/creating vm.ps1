$ResourceGroupName='kprg'

$VirtualMachineName='kpvn'

$Location='south india'

$VirtualNetworkName='kpVnet'

$SubnetName='kpSubnet'

$SecurityGroupName='kpNSG'

$PublicIpAddressName='kpPIP'



New-AzureRmVm -ResourceGroupName $kprg -Name $VirtualMachineName -Location $Location -VirtualNetworkName $VirtualNetworkName -SubnetName $SubnetName -SecurityGroupName $SecurityGroupName -PublicIpAddressName $PublicIpAddressName -OpenPorts 80,3389



    #To Connect Virtual Machine

    Get-AzPublicIpAddress -ResourceGroupName $kprg | Select $PublicIpAddressName