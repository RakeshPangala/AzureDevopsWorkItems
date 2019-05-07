Login-AzureRmAccount

$vmName = "VaijayanthiVM"
$rgName = "VaijayanthiRG"
$location = "Central US"
$imageName = "VaijayanthiImage"


Stop-AzureRmVM -ResourceGroupName $rgName -Name $vmName -Force

Set-AzureRmVm -ResourceGroupName $rgName -Name $vmName -Generalized

$vm = Get-AzureRmVM -Name $vmName -ResourceGroupName $rgName

$image = New-AzureRmImageConfig -Location $location -SourceVirtualMachineId $vm.Id

New-AzureRmImage -Image $image -ImageName $imageName -ResourceGroupName $rgName
