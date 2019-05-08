

#$username='quadrantit@hotmail.com'
#$password='password'
#$password=ConvertTo-SecureString $password -AsPlainText -Force
#$credential= New-Object System.Management.Automation.PSCredential($username,$password)
#Connect-AzAccount -Credential $credential


Login-AzAccount

#---------------------------------Creates a Resource Group-----------------------------#


$Rg= New-AzResourceGroup -Name "Sanjay" -Location 'South India'


#--------------------------------Creates a Virtual Machine-----------------------------#

$Rg='Sanjay'
$virtualmachinename='VMOne'
$loc='southindia'
$vnet='VNet1'
$subnet='Subnet1'
$nsg1='VMOneNSG'
$pip1='VMOnePublicIP'
$adminusername='sanjay'
$adminpassword='Sanjay@1234567'
$adminpassword=ConvertTo-SecureString $adminpassword -AsPlainText -Force
$admincredential= New-Object System.Management.Automation.PsCredential($adminusername,$adminpassword)
$admincredential=Get-Credential $admincredential
$VMOne= New-AzVM -ResourceGroupName $Rg -Location $loc -Name $virtualmachinename -Credential $admincredential -VirtualNetworkName $vnet -AddressPrefix '191.168.0.0/24' -SubnetName $subnet -SubnetAddressPrefix '191.168.0.0/28' -PublicIpAddressName $pip1 -SecurityGroupName $nsg1 -Image Win2016Datacenter -Size Standard_Ds1_v2 -OpenPorts 3389 -DataDiskSizeInGb 1024 


#--------------------------------Configures the Snapshot of VM1--------------------------#

$snapshotName='SnapShot-VMOne'
$Rg='Sanjay'
$virtualmachinename='VMOne'
$loc='SouthIndia'

$vm = get-azvm -ResourceGroupName $Rg -Name $virtualmachinename


$snapshotconfig= New-AzSnapshotConfig -SkuName Standard_LRS -OsType Windows -DiskSizeGB 1024 -Location $loc -SourceUri $vm.StorageProfile.DataDisks.ManagedDisk.Id -CreateOption copy

#---------------------------------Creates Snapshot of VM-------------------------------

$VMOnesnapshot=New-AzSnapshot -Snapshot $Snapshotconfig -SnapshotName $snapshotName -ResourceGroupName $Rg

#---------------------------------Creates a Managed Disk Using Snapshot of VM1----------# 

$Rg='Sanjay'
$storageType = 'StandardSSD_LRS'
$diskName='MyDisk'
$snapshotName='SnapShot-VMOne'
$loc='southindia'

$snapshot = Get-AzSnapshot -ResourceGroupName $Rg -SnapshotName $snapshotName


$diskConfig = New-AzDiskConfig -AccountType $storageType -Location $loc -CreateOption Copy -SourceResourceId $snapshot.Id 

$disk=New-AzDisk -Disk $diskConfig -ResourceGroupName $Rg -DiskName $diskName 

#-----------Creates a Virtual Machine & attaches Managed disk of snapshot to this VM-----#
#Provide the subscription Id
#$subscriptionId = 'yourSubscriptionId'

#Provide the name of your resource group
#$Rg ='Sanjay'

#Provide the name of the snapshot that will be used to create OS disk
$snapshotName = 'SnapShot-VMOne'

#Provide the name of the OS disk that will be created using the snapshot
$osDiskName = 'VMTwo-OS'

#Provide the name of an existing virtual network where virtual machine will be created
$virtualNetworkName = 'VNet2'

#Provide the name of the virtual machine
$virtualMachineName = 'VMTwo'

#Provide the size of the virtual machine
#e.g. Standard_DS3
#Get all the vm sizes in a region using below script:
#e.g. Get-AzVMSize -Location westus
$virtualMachineSize = 'Standard_DS1_v2'

#Initialize virtual machine configuration
$VirtualMachine = New-AzVMConfig -VMName $virtualMachineName -VMSize $virtualMachineSize 

#Use the Managed Disk Resource Id to attach it to the virtual machine. Please change the OS type to linux if OS disk has linux OS
$VirtualMachine = Set-AzVMOSDisk -VM $VirtualMachine -ManagedDiskId $disk.Id -CreateOption Attach -Windows -DiskSizeInGB 1024 -StorageAccountType StandardSSD_LRS 

#Create a public IP for the VM
$publicIp = New-AzPublicIpAddress -Name ($VirtualMachineName.ToLower()+'_ip') -ResourceGroupName $Rg -Location $snapshot.Location -AllocationMethod Dynamic

#Get the virtual network where virtual machine will be hosted
$Rg='Sanjay'

$virtualNetworkName = 'VNet1'
$vnet = Get-AzVirtualNetwork -Name $virtualNetworkName -ResourceGroupName $Rg 

# Create NIC in the first subnet of the virtual network
$nic = New-AzNetworkInterface -Name ($VirtualMachineName.ToLower()+'_nic') -ResourceGroupName $Rg -Location $snapshot.Location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id 

$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $nic.Id 

#Create the virtual machine with Managed Disk

New-AzVM -VM $VirtualMachine -ResourceGroupName $Rg -Location $snapshot.Location

#---------------------------------------Creates Image of VM1----------------------------------------------#

$virtualmachinename='VMOne'
$Rg='Sanjay'
$loc='southindia'

Stop-AzVM `
   -ResourceGroupName $Rg `
   -Name $virtualmachinename -Force

   Set-AzVM `
   -ResourceGroupName $Rg `
   -Name $virtualmachinename -Generalized

   $vm = Get-AzVM `
   -Name $virtualmachinename `
   -ResourceGroupName $Rg


   $image = New-AzImageConfig `
   -Location $loc `
   -SourceVirtualMachineId $vm.ID 


   New-AzImage `
   -Image $image `
   -ImageName ImageVMOne `
   -ResourceGroupName $Rg

#--------------------------------Creates Virtual Machine using Image of VM1-----------------------#

$virtualmachinename='VM3'
$Rg='Sanjay'
$adminusername='sanjay'
$adminpassword='Sanjay@1234567'
$adminpassword=ConvertTo-SecureString $adminpassword -AsPlainText -Force
$admincredential= New-Object System.Management.Automation.PsCredential($adminusername,$adminpassword)
New-AzVm -Name $virtualmachinename -ResourceGroupName 'Sanjay' -ImageName "ImageVMOne" -Location 'South India' -VirtualNetworkName "VNet2" -SubnetName "Subnet2" -SecurityGroupName "ImageNSG" -PublicIpAddressName "myImagePIP" -OpenPorts 3389 -DataDiskSizeInGb 1024 -AddressPrefix 191.168.1.0/24 -Size Standard_DS1_v2 -SubnetAddressPrefix 191.168.1.0/28 -Credential $admincredential