Get-ExecutionPolicy
Import-Module AzureRm
Install-Module AzureRm
Login-AzureRmAccount
$ResourceGroupName='gopal'

$Location='east us'

$vmName='gopalVM'

$snapshotName = 'gopalSnapshot'





#Creating Resource group-----------------

New-AzureRmResourceGroup -Name $ResourceGroupName  -Location $Location



#Creating VM

$Vmdetails=New-AzureRmVm -ResourceGroupName $ResourceGroupName -Location $Location -Name $vmName



#Get the VM

$vm = Get-AzureRmVm -ResourceGroupName $ResourceGroupName -Name $vmName



#Create the snapshot configuration. For this example, the snapshot is of the OS disk

$snapshot =  New-AzureRmSnapshotConfig -SourceUri $vm.StorageProfile.DataDisks.ManagedDisk.Id -Location $Location -CreateOption copy



#Take the snapshot:



New-AzureRmSnapshot -Snapshot $snapshot -SnapshotName $snapshotName -ResourceGroupName $ResourceGroupName 