Login-AzureRmAccount
#Giving Input Parameter
$vmName = "GowthamiVm"
$rgName = "GowthamiRG"
$location = "East US"
$imageName = "GowthamiRG"

#Make sure the VM has been deallocated.

 Stop-AzureRmVM -ResourceGroupName $rgName -Name $vmName -Force


#Set the status of the virtual machine to Generalized.
Set-AzureRmVm -ResourceGroupName $rgName -Name $vmName -Generalized


#Get the virtual machine.

$vm = Get-AzureRmVM -Name $vmName -ResourceGroupName $rgName

#Create the image configuration.

$image = New-AzureRmImageConfig -Location $location -SourceVirtualMachineId $vm.Id 

#Create the image.

New-AzureRmImage -Image $image -ImageName $imageName -ResourceGroupName $rgName



