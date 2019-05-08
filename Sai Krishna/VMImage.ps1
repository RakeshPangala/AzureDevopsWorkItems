Login-AzureRmAccount

$VMName = "KrishVM"
$RGName = "KrishRG"
$Loc = "South India"
$imageName = "KrishImage"


Stop-AzureRmVM -ResourceGroupName $RGName -Name $VMName -Force 



Set-AzureRmVm -ResourceGroupName $RGName -Name $VMName -Generalized

$vm = Get-AzureRmVM -Name $VMName -ResourceGroupName $RGName

$image = New-AzureRmImageConfig -Location $Loc -SourceVirtualMachineId $vm.Id

New-AzureRmImage -Image $image -ImageName $imageName -ResourceGroupName $RGName