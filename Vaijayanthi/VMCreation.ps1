$ResourceGroupName='VaijayanthiRG'
$VirtualMachineName='VaijayanthiVM'
$Location='Central US'
$VirtualNetworkName='VaijayanthiVnet'
$SubnetName='VaijayanthiSubnet'
$SecurityGroupName='VaijayanthiNSG'
$PublicIpAddressName='VaijayanthiPIP'

New-AzureRmVm -ResourceGroupName $VaijayanthiRG -Name $VirtualMachineName -Location $Location -VirtualNetworkName $VirtualNetworkName -SubnetName $SubnetName -SecurityGroupName $SecurityGroupName -PublicIpAddressName $PublicIpAddressName -OpenPorts 80,3389

    #To Connect Virtual Machine
    Get-AzPublicIpAddress -ResourceGroupName $VaijayanthiRG | Select $PublicIpAddressName