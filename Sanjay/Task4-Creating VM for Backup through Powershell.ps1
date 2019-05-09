Login-AzAccount
Install-Module -Name Az -AllowClobber

#Login-AzAccount

$username='quadrantit@hotmail.com'
$password='password'
ConvertTo-SecureString $password -AsPlainText -Force
$credential= New-Object System.Management.Automation.PSCredential($username,$password)
Connect-AzAccount -Credential $credential


#--------------------------------------Creates a Resource Group-------------------------------------#


$Rg= New-AzResourceGroup -Name 'Sanjay' -Location 'South India'


#---------------------------------Creates a Virtual Machine for Backup ------------------------------------#


$Rg='Sanjay'
$virtualmachinename='VM1'
$loc='southindia'
$vnet='VNet1'
$subnet='Subnet1'
$nsg1='VM1NSG'
$pip1='VM1PublicIP'
$adminusername='sanjay'
$adminpassword='Sanjay@1234567'
$adminpassword=ConvertTo-SecureString $adminpassword -AsPlainText -Force
$admincredential= New-Object System.Management.Automation.PsCredential($adminusername,$adminpassword)
$admincredential=Get-Credential $admincredential
$VMOne= New-AzVM -ResourceGroupName $Rg -Location $loc -Name $virtualmachinename -Credential $admincredential -VirtualNetworkName $vnet -AddressPrefix '191.168.3.0/24' -SubnetName $subnet -SubnetAddressPrefix '191.168.3.0/28' -PublicIpAddressName $pip1 -SecurityGroupName $nsg1 -Image Win2016Datacenter -Size Standard_Ds1_v2 -OpenPorts 3389 -DataDiskSizeInGb 1024 

