
# Created virtual Machine
    
$ResourceGroupName='SuryaRG'
$VirtualMachineName='SuryaVm'
$Location='South India'
$VirtualNetworkName='SuryaVnet'
$SubnetName='SuryaSubnet'
$SecurityGroupName='SuryaNSG'
$PublicIpAddressName='SuryaPIP'

New-AzureRmVm -ResourceGroupName "SuryaRG" -Name $VirtualMachineName -Location $Location -VirtualNetworkName $VirtualNetworkName -SubnetName $SubnetName -SecurityGroupName $SecurityGroupName -PublicIpAddressName $PublicIpAddressName -OpenPorts 80,3389

#To Connect Virtual Machine

Get-AzPublicIpAddress -ResourceGroupName $VaijayanthiRG | Select $PublicIpAddressName