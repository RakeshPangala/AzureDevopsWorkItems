#login to portal
Login-AzureRmAccount

#creating resource group
New-azurermresourcegroup -resourcegroupname "sunayana.rg" -Location 'South India'

#creating vnet1
$vnet=New-AzureRmVirtualNetwork -Name 'sunvnet' -ResourceGroupName sunayana.rg -Location 'South India' -AddressPrefix "192.166.11.0/25"
$sub1="frend"
$fenadd="192.166.11.0/27"
$sub2="baend"
$benadd="192.166.11.32/27"
$frontendsubnet=Add-AzureRmVirtualNetworkSubnetConfig -Name $sub1 -AddressPrefix $fenadd -VirtualNetwork $vnet
$backendendsubnet=Add-AzureRmVirtualNetworkSubnetConfig -Name $sub2 -AddressPrefix $benadd -VirtualNetwork $vnet
$vnet|Set-AzureRmVirtualNetwork


#creating vnet2
$vnet2=New-AzureRmVirtualNetwork -Name 'sunvnet2' -ResourceGroupName sunayana.rg -Location 'South India' -AddressPrefix "192.165.11.0/25"
$sub21="frend2"
$fenadd2="192.165.11.0/27"
$sub22="baend2"
$benadd="192.165.11.32/27"
$frontendsubnet2=Add-AzureRmVirtualNetworkSubnetConfig -Name $sub21 -AddressPrefix $fenadd2 -VirtualNetwork $vnet2
$vnet2|Set-AzureRmVirtualNetwork

#creating nsg
$nsg=New-AzureRmNetworkSecurityGroup -Name 'sunnsg' -ResourceGroupName 'sunayana.rg' -Location 'South India' 

#creating rules
New-AzureRmNetworkSecurityRuleConfig -Name rdp -Access Allow -Direction Inbound -Priority 100 -Protocol Tcp -SourcePortRange 3389

New-AzureRmNetworkSecurityRuleConfig -Name http -Access Allow -Direction Inbound -Priority 110 -Protocol Tcp -SourcePortRange 80

New-AzureRmNetworkSecurityRuleConfig -Name ssh -Access Allow -Direction Inbound -Priority 120 -Protocol Tcp -SourcePortRange 22 

New-AzureRmNetworkSecurityRuleConfig -Name https -Access Deny -Direction outbound -Priority 110 -Protocol Tcp -SourcePortRange 443

#vnet peering
Add-AzureRmVirtualNetworkPeering -Name sunper -VirtualNetwork $vnet -RemoteVirtualNetworkId $vnet2.Id 

Add-AzureRmVirtualNetworkPeering -Name sunper2 -VirtualNetwork $vnet2 -RemoteVirtualNetworkId $vnet.Id 

#creating vm

$vm=New-AzureRmVM -Name 'sunvm' -ResourceGroupName 'sunayana.rg' -Location 'South India' 


#creating snapshot
$snapshot =  New-AzurermSnapshotConfig -SourceUri $vm.StorageProfile.OsDisk.ManagedDisk.Id -Location southindia -CreateOption copy
New-AzureRmSnapshot -ResourceGroupName sunayana.rg -SnapshotName sunsnap -Snapshot $snapshot
#creating a vm using snapshot
new-azurermvm -ResourceGroupName sunayana.rg -Location $snapshot.Location -Name sunsnapvm

#creating image
Stop-AzureRmVM -Name $vm -Force

set-azurermvm -ResourceGroupName sunayana.rg -Name sunvm -Generalized

$VirMac= Get-AzureRmVM -Name sunvm -ResourceGroupName sunayana.rg

$imageconfig=New-AzureRmImageConfig -SourceVirtualMachineId $vm.Id -Location southindia

$myImage=New-AzureRmImage -ResourceGroupName sunayana.rg -ImageName sumim -Image $imageconfig 
New-Azurermvm -ResourceGroupName sunayana.rg -Name sumimvm -ImageName sumim -Location southindia  -VirtualNetworkName $vnet
#creating vmscaleset
New-AzureRmLoadBalancer -Location southindia -Name sunlb -ResourceGroupName sunayana.rg

New-AzureRmVmss -ResourceGroupName sunayana.rg -VMScaleSetName "sunss" -Location 'South India' -LoadBalancerName sunlb
