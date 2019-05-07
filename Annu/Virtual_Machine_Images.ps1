

Login-AzureRmAccount

$VmName = "AnnuVm"

$rgName = "AnnuRG"

$loc = "East US"

$ImageName = "AnnuRG" 

#----------------Creating Resource Group------------------------

New-AzureRmResourceGroup -Name $rgName  -Location $loc

#----------------Creating Virtual Network------------------------

$Vm=New-AzureRmVm -ResourceGroupName $rgName -Location $loc -Name $VmName

#--------------Stoping the virtual Network------------------------

Stop-AzureRmVM -ResourceGroupName $rgName -Name $VmName -Force

Set-AzureRmVm -ResourceGroupName $rgName -Name $VmName -Generalized

$vm = Get-AzureRmVM -Name $vmName -ResourceGroupName $rgName

$image = New-AzureRmImageConfig -Location $location -SourceVirtualMachineId $vm.IdNew-AzureRmImage -Image $image -ImageName $imageName -ResourceGroupName $rgName