$ResourceGroupName='gopal'

$VirtualMachineName='gopalVM'

$Location='east us'

$VirtualNetworkName='gopalVnet'

$SubnetName='gopalSubnet'

$SecurityGroupName='gopalNSG'

$PublicIpAddressName='gopalPIP'



New-AzureRmVm -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName -Location $Location -VirtualNetworkName $VirtualNetworkName -SubnetName $SubnetName -SecurityGroupName $SecurityGroupName -PublicIpAddressName $PublicIpAddressName -OpenPorts 80,3389



    #To Connect Virtual Machine

    Get-AzPublicIpAddress -ResourceGroupName $AnupRG | Select $PublicIpAddressName
© 2019 GitHub, Inc.