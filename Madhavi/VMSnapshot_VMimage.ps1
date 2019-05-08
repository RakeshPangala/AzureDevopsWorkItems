Login-AzureRmAccount

$RGName=MadhuRG
$Location = westus2

#Creating Virtual Machine

$VM=New-AzureRmVm -ResourceGroupName $RGName -Location $Location -Name MadhuVm

$VmDetailes = Get-azureRmVm -ResourceGroupName $RGName -Name $VMName

#creating snapshot configure

$imageName = VMImage
$snapshotName=Snapshot
$snapshot =  New-AzureRmSnapshotConfig -SourceUri $Vm.StorageProfile.OsDisk.ManagedDisk.Id -Location $location -CreateOption copy

#Creating Snapshot 

New-AzureRmSnapshot -Snapshot $snapshot -SnapshotName Snapshot -ResourceGroupName $RGName

#Creating VM Image 

 Stop-AzureRmVM -ResourceGroupName  $RGName  -Name MadhuVM -Force

#Set the status of the virtual machine to Generalized.

Set-AzureRmVm -ResourceGroupName  $RGName -Name MadhuVM -Generalized

$VM = Get-AzureRmVM -Name MadhuVM -ResourceGroupName $RGName 

#Create the image configuration.

$image = New-AzureRmImageConfig -Location $Location -SourceVirtualMachineId $VM.Id 

#Create the image.

New-AzureRmImage -Image $image -ImageName $imageName -ResourceGroupName $RGName

