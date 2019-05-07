$ResourceGroupName='KrishnaRG'

$VirtualMachineName='KrishnaVM'

$Location='Centralindia'

$VirtualNetworkName='KrishnaVnet'

$SubnetName='KrishnaSubnet'

$SecurityGroupName='KrishnaNSG'

$PublicIpAddressName='KrishnaPIP'

New-AzureRmVm -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName -Location $Location -VirtualNetworkName $VirtualNetworkName -SubnetName $SubnetName -SecurityGroupName $SecurityGroupName -PublicIpAddressName $PublicIpAddressName -OpenPorts 80,3389

#To Connect Virtual Machine
Get-AzPublicIpAddress -ResourceGroupName $VaijayanthiRG | Select $PublicIpAddressName