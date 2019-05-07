#----Recovery and Backup of VM

Login-AzureRmAccount
$rgname='SuryaRG'
$loc='South india'

#----Creating Resource group-------

New-AzureRmResourceGroup -Name $rgname  -Location $loc

#----Creating virtual network--------

New-AzureRmVm -ResourceGroupName $rgname -Location $loc -Name AnnuVM

#----Creating Recovery Services Vault-------- 

    New-AzureRmRecoveryServicesVault -Name "SuryaRSG" -ResourceGroupName $rgname -Location $loc

    $vault= Get-AzureRmRecoveryServicesVault -Name "SuryaRSG"

   Set-AzureRmRecoveryServicesBackupProperties -Vault $vault -BackupStorageRedundancy GeoRedundant

   #Back up Azure VMs

   #Before enabling protection on a VM, uses Set-AzRecoveryServicesVaultContext to set the vault context. 

$vault | Set-AzureRmRecoveryServicesVaultContext

#Create a protection policy

Get-AzureRmRecoveryServicesBackupProtectionPolicy -WorkloadType "AzureVM"

$schPol = Get-AzureRmRecoveryServicesBackupSchedulePolicyObject -WorkloadType "AzureVM"
$UtcTime = Get-Date -Date "2019-05-23 01:00:00Z"
$UtcTime = $UtcTime.ToUniversalTime()
$schpol.ScheduleRunTimes[0] = $UtcTime

$retPol = Get-AzureRmRecoveryServicesBackupRetentionPolicyObject -WorkloadType "AzureVM"

#creating Recovery Services Backup Protection Policy

New-AzureRmRecoveryServicesBackupProtectionPolicy -Name "SuryaPolicy" -WorkloadType "AzureVM" -RetentionPolicy $retPol -SchedulePolicy $schPol