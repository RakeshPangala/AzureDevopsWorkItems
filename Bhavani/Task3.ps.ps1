
#creating Virtual machine
$nsg="NSG"
$vm=New-AzVM -Name BhavaniVM -ResourceGroupName BhavaniRG -Location southindia 
-DataDiskSizeInGb 10 -VirtualNetworkName BhavaniVN1 -AddressPrefix 192.66.0.0/24
-SubnetName FrontSN1 -SubnetAddressPrefix 192.66.0.0/28 -image Win2012R2Datacenter
-OpenPorts 3389 -Size Standard_DS1_v2 -SecurityGroupName $nsg

#creating snapshot on os disk

$snapshot =  New-AzSnapshotConfig -SourceUri $vm.StorageProfile.OsDisk.ManagedDisk.Id -Location southindia -CreateOption copy
New-AzSnapshot -Snapshot $snapshot -SnapshotName BhavaniSS -ResourceGroupName BhavaniRG
#creating VM through snapshot
$snapshot = Get-AzSnapshot -ResourceGroupName BhavaniRG -SnapshotName $snapshot
$diskConfig = New-AzDiskConfig -Location $snapshot.Location -SourceResourceId $snapshot.Id -CreateOption Copy
$disk = New-AzDisk -Disk $diskConfig -ResourceGroupName BhavaniRG -DiskName BhavaniOS
$VirtualMachine = New-AzVMConfig -VMName BhavaniVM -VMSize Standard_DS1_v2
$VirtualMachine = Set-AzVMOSDisk -VM $VirtualMachine -ManagedDiskId $disk.Id -CreateOption Attach -Windows
$publicIp = New-AzPublicIpAddress -Name ($VirtualMachineName.ToLower()+'_ip') -ResourceGroupName BhavaniRG -Location $snapshot.Location -AllocationMethod Dynamic
$vnet = Get-AzVirtualNetwork -Name BhavaniVN -ResourceGroupName BhavaniRG
$nic = New-AzNetworkInterface -Name (BhavaniVM.ToLower( )+'_nic') -ResourceGroupName BhavaniRG -Location $snapshot.Location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id
$VirtualMachine = Add-AzVMNetworkInterface -VM BhavaniVM2 -Id $nic.Id
New-AzVM -VM $VirtualMachine -ResourceGroupName BhavaniRG -Location $snapshot.Location

#Creating scaleset

New-AzVmss -ResourceGroupName BhavaniRG -Location southindia
-VMScaleSetName BhavaniScaleset -ImageName Win2012R2Datacenter
-VirtualNetworkName BhavaniVN1 -SubnetName FrontSN1 -PublicIpAddressName BhavaniIP
 -InstanceCount 3 
 
 #Creating Image
Stop-AzVM -ResourceGroupName BhavaniRG -Name $vm -Force
Set-AzVm -ResourceGroupName BhavaniRG -Name $vm -Generalized
 $vm = Get-AzVM -Name $vm -ResourceGroupName BhavaniRG
  $image = New-AzImageConfig -Location southindia -SourceVirtualMachineId $vm.Id 
New-AzImage -Image $image -ImageName Bhavaniimage -ResourceGroupName BhavaniRG

