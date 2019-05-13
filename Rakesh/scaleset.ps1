Login-AzureRmAccount



#Input--------------------

$RG='RakeshRG'

$Loc='South India'

$VMScaleSetName='RakeshSSet'

$SubnetName='FrontendSubnet'

$PublicIpAddressName='RakeshPIP'

$LoadBalancerName='RakeshLB'

$UpgradePolicyMode='Automatic'

$virtualNetworkName='RakeshVnet'



#Creating Resource group-----------------



New-AzureRmResourceGroup -Name $RG  -Location $Loc



#Creating Virtual Network---------------------



$VNet=New-AzureRmVirtualNetwork  -ResourceGroupName $RG -Location $Loc -Name $virtualNetworkName -AddressPrefix 10.9.0.0/25



#Creating Subnet-----------------------



New-azureRmVirtualNetworksubnetconfig -Name Rakeshsubnet -AddressPrefix 10.9.0.0/27



#Creating Virtual machine Scale set-------------------------------------



New-AzureRmVmss -ResourceGroupName $RG -Location $Loc -VMScaleSetName $VMScaleSetName  -VirtualNetworkName $VNet -SubnetName $SubnetName -PublicIpAddressName $PublicIpAddressName -LoadBalancerName $LoadBalancerName  -UpgradePolicyMode $UpgradePolicyMode

#Auto Scale Out......

$myRuleScaleOut = New-AzureRmAutoscaleRule 
  -MetricName "Percentage CPU" 
  -MetricResourceId /subscriptions/$mySubscriptionId/resourceGroups/$myResourceGroup/providers/Microsoft.Compute/virtualMachineScaleSets/$myScaleSet 
  -TimeGrain 00:01:00 
  -MetricStatistic "Average" 
  -TimeWindow 00:05:00 
  -Operator "GreaterThan" 
  -Threshold 70 
  -ScaleActionDirection "Increase" 
  –ScaleActionScaleType "ChangeCount" 
  -ScaleActionValue 3 
  -ScaleActionCooldown 00:05:00
#Auto Scale in----------

$myRuleScaleIn = New-AzureRmAutoscaleRule 
  -MetricName "Percentage CPU" 
  -MetricResourceId /subscriptions/$mySubscriptionId/resourceGroups/$myResourceGroup/providers/Microsoft.Compute/virtualMachineScaleSets/$myScaleSet 
  -Operator "LessThan" 
  -MetricStatistic "Average" 
  -Threshold 30 
  -TimeGrain 00:01:00 
  -TimeWindow 00:05:00 
  -ScaleActionCooldown 00:05:00 
  -ScaleActionDirection "Decrease" 
  –ScaleActionScaleType "ChangeCount" 
  -ScaleActionValue 1
#Define Autoscale Profile---------

$myScaleProfile = New-AzureRmAutoscaleProfile 
  -DefaultCapacity 2  
  -MaximumCapacity 10 
  -MinimumCapacity 2 
  -Rule $myRuleScaleOut,$myRuleScaleIn 
  -Name "autoprofile"

#Apply Autoscale rules to scaleset

Add-AzureRmAutoscaleSetting 
  -Location $Loc
  -Name "autosetting" 
  -ResourceGroup $myResourceGroup 
  -TargetResourceId /subscriptions/$mySubscriptionId/resourceGroups/$myResourceGroup/providers/Microsoft.Compute/virtualMachineScaleSets/$myScaleSet 
  -AutoscaleProfile $myScaleProfile

#Generating CPU load on it

# Get the load balancer object
$lb = Get-AzureRmLoadBalancer -ResourceGroupName "myResourceGroup" -Name "myLoadBalancer"

# View the list of inbound NAT rules
Get-AzureRmLoadBalancerInboundNatRuleConfig -LoadBalancer $lb | Select-Object Name,Protocol,FrontEndPort,BackEndPort