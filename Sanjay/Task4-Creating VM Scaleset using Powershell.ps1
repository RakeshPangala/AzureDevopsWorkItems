Login-AzAccount

#$username='quadrantit@hotmail.com'
#$password='password'
#$password=ConvertTo-SecureString $password -AsPlainText -Force
#$credential= New-Object System.Management.Automation.PSCredential($username,$password)
#Connect-AzAccount -Credential $credential




# Common
$LOC = "southindia"
$RGName = "sanjay";




#--------------------------------------Creates VM ScaleSet Configuration-----------------------------#

$VMSSName = "vmss1" + $RGName;
$AdminUsername = "sanjay";
$AdminPassword = "Sanjay@1234567";
$PublisherName = "MicrosoftWindowsServer" 
$Offer         = "WindowsServer" 
$Sku           = "2012-R2-Datacenter" 
$Version       = "latest"        
$VHDContainer = "https://" + $STOName + ".blob.core.windows.net/" + $VMSSName;
$ExtName = "CSETest";
$Publisher = "Microsoft.Compute";
$ExtType = "BGInfo";
$ExtVer = "2.1";

#--------------------------------------IP Config for the NIC-----------------------------------------#

$IPCfg = New-AzVmssIPConfig -Name "Test" -LoadBalancerInboundNatPoolsId $ExpectedLb.InboundNatPools[8].Id -LoadBalancerBackendAddressPoolsId $ExpectedLb.BackendAddressPools[8].Id -SubnetId $SubNetId;
            
#VMSS Config
$VMSS = New-AzVmssConfig -Location $LOC -SkuCapacity 2 -SkuName "Standard_A2" -UpgradePolicyMode "Automatic" `
    | Add-AzVmssNetworkInterfaceConfiguration -Name "Test" -Primary $True -IPConfiguration $IPCfg `
    | Add-AzVmssNetworkInterfaceConfiguration -Name "Test2"  -IPConfiguration $IPCfg `
    | Set-AzVmssOSProfile -ComputerNamePrefix "Test"  -AdminUsername $AdminUsername -AdminPassword $AdminPassword `
    | Set-AzVmssStorageProfile -Name "Test"  -OsDiskCreateOption 'FromImage' -OsDiskCaching "None" `
    -ImageReferenceOffer $Offer -ImageReferenceSku $Sku -ImageReferenceVersion $Version `
    -ImageReferencePublisher $PublisherName -VhdContainer $VHDContainer `
    | Add-AzVmssExtension -Name $ExtName -Publisher $Publisher -Type $ExtType -TypeHandlerVersion $ExtVer -AutoUpgradeMinorVersion $True

#--------------------------------------Create the VMSS-------------------------------------------------#

$RGName='sanjay'
$VMSSName='VMSSsanjay'
New-AzVmss -ResourceGroupName $RGName -Name $VMSSName -VirtualMachineScaleSet $VMSS;