Login-AzureRmAccount



$VMName = "RakeshVM"

$RGName = "RakeshRG"

$Loc = "South India"

$imageName = "RakeshImage"





Stop-AzureRmVM -ResourceGroupName $RGName -Name $VMName -Force 


Set-AzureRmVm -ResourceGroupName $RGName -Name $VMName -Generalized



$vm = Get-AzureRmVM -Name $VMName -ResourceGroupName $RGName



$image = New-AzureRmImageConfig -Location $Loc -SourceVirtualMachineId $vm.Id



New-AzureRmImage -Image $image -ImageName $imageName -ResourceGroupName $RGName