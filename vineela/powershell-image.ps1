Login-AzureRmAccount

$VmName = 'vineela-VM1'
$ResourceGroupName = 'vineela'
$Location = 'south india'
$ImageName = 'vineelaImage'


Stop-AzureRmVM -ResourceGroupName  -Name $ResourceGroupName $VmName -Force

Set-AzureRmVm -ResourceGroupName  -Name $VmName -Generalized

$vm = Get-AzureRmVM -Name $VmName -ResourceGroupName $ResourceGroupName

$image = New-AzureRmImageConfig -Location $Location -SourceVirtualMachineId $vm.Id

New-AzureRmImage -Image $image -ImageName $ImageName -ResourceGroupName $ResourceGroupName