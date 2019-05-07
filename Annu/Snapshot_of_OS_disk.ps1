
#Creating Resource Group

$RG=New-AzureRmResourceGroup -Name $rgName -Location  $loc

#Creating Virtual Machine

$Vm=New-AzureRmVm -ResourceGroupName $rgName -Location $loc -Name $VmName

#Getting Vm detailes here

$VmDetailes = Get-azureRmVm -ResourceGroupName $rgName -Name $VmName

#creating snapshot configure

$snapshot =  New-AzureRmSnapshotConfig -SourceUri $Vm.StorageProfile.OsDisk.ManagedDisk.Id -Location $loc -CreateOption copy

#Creating Snapshot
New-AzureRmSnapshot -Snapshot $snapshot -SnapshotName $snapshotName -ResourceGroupName $rgName