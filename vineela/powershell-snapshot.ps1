Login-AzureRmAccount
#Set some parameters
$ResourceGroupName='vineela'
$Location='south india'
$VmName='vineela-VM1'
$SnapshotName = 'vineelasnapshot'


#Creating Resource group-----------------
New-AzureRmResourceGroup -Name $ResourceGroupName  -Location $Location

#Creating VM
$Vm=New-AzureRmVm -ResourceGroupName $ResourceGroupName -Location $Location -Name $VmName

#Get the VM
$vm = Get-AzureRmVm -ResourceGroupName $ResourceGroupName -Name $VmName

#Create the snapshot configuration. For this example, the snapshot is of the OS disk
$snapshot =  New-AzureRmSnapshotConfig -SourceUri $vm.StorageProfile.OsDisk.ManagedDisk.Id -Location $Location -CreateOption copy

#Take the snapshot:

New-AzureRmSnapshot -Snapshot $snapshot -SnapshotName $SnapshotName -ResourceGroupName $ResourceGroupName 