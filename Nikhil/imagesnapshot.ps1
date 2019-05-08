Login-AzureRmAccount

$resourceGroupName="NikhilRG"
$vmName = "NikhilVm"
$location = "southindia"
$imageName = "nikImage"
$snapshotName="nikSnapshot"


$RG=New-AzureRmResourceGroup -Name $resourceGroupName  -Location  $location

$Vm=New-AzureRmVm -ResourceGroupName $resourceGroupName -Location $location -Name $vmName

$VmDetailes = Get-azureRmVm -ResourceGroupName $resourceGroupName -Name $vmName

$snapshot =  New-AzureRmSnapshotConfig -SourceUri $Vm.StorageProfile.OsDisk.ManagedDisk.Id -Location $location -CreateOption copy

New-AzureRmSnapshot -Snapshot $snapshot -SnapshotName $snapshotName -ResourceGroupName 

#Make sure the VM has been deallocated.

 Stop-AzureRmVM -ResourceGroupName  $resourceGroupName  -Name $vmName -Force


#Set the status of the virtual machine to Generalized.
Set-AzureRmVm -ResourceGroupName $resourceGroupName  -Name $vmName -Generalized


#Get the virtual machine.

$vm = Get-AzureRmVM -Name $vmName -ResourceGroupName $resourceGroupName 

#Create the image configuration.

$image = New-AzureRmImageConfig -Location $location -SourceVirtualMachineId $vm.Id 

#Create the image.

New-AzureRmImage -Image $image -ImageName $imageName -ResourceGroupName $rgName