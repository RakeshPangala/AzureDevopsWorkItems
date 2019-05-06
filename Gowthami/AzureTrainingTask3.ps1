
Login-AzureRmAccount
#creating Virtual machine
New-AzureRmVm -ResourceGroupName GowthamiRG -Location "East Us" -Name "Gowthami-VM" 



$resourceGroupName = 'GowthamiRG' 
$location = 'eastus' 

#Getting Azure virtual machine what we created previously
get-azureRmVm -ResourceGroupName GowthamiRG -Name "Gowthami-VM"




#Creating Snapshot for Adding into  vitual machine 

New-AzureRmSnapshot -ResourceGroupName GowthamiRG -Snapshot GowthamiSnapshot -SnapshotName GowthamiSnapshot1

#Creating Managed Disk in azure
ConvertTo-AzureRmVMManagedDisk -ResourceGroupName GowthamiRG -VMName Gowthami-VM

#New-AzureRmDisk -Disk GowthamiDisk -DiskName GowthamiDisk1 -ResourceGroupName GowthamiRG



#Adding disk to Vm

Add-AzureRmVMDataDisk -CreateOption VmDisj -Lun GLun -VM Gowthami-VM




#Creating Imaging with vm
New-AzureRmImage -Image Image -ImageName Gowthami-Image -ResourceGroupName GowthamiRG

#Adding imaging 

Add-AzureRmImageDataDisk -Image Gowthami-image 





