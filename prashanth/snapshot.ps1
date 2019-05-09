login-AzureRmAccount

#Setting parameters

$ResourceGroupName="kprg"

$Location='Central US'

$VirtualMachineName='kpvm'

$snapshotName = 'kpSnapshot'





#Creating Resource group-----------------

New-AzureRmResourceGroup -Name $ResourceGroupName  -Location $Location



#Creating VM

$Vmdetails=New-AzureRmVm -ResourceGroupName $ResourceGroupName -Location $Location -Name  $VirtualMachineName



#Get the VM

$vm = Get-AzureRmVm -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName



#Create the snapshot configuration. For this example, the snapshot is of the OS disk

$snapshot =  New-AzureRmSnapshotConfig -SourceUri $vm.StorageProfile.OsDisk.ManagedDisk.Id -Location $Location -CreateOption copy



#Take the snapshot:



New-AzureRmSnapshot -Snapshot $snapshot -SnapshotName $snapshotName -ResourceGroupName $ResourceGroupName 