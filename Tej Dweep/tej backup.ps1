Login-AzureRmAccount

$RGname=tej007

$location=eastus

#virtual Network
New-AzureRmVm -ResourceGroupName $RGname -Location $location -Name tej007

#Recovery Services Vault 
New-AzureRmRecoveryServicesVault -Name "tejsv" -ResourceGroupName $RGname -Location $location
$vault= Get-AzureRmRecoveryServicesVault -Name "tejRSG"
Set-AzureRmRecoveryServicesBackupProperties -Vault $vault -BackupStorageRedundancy GeoRedundant
#Back up for Azure VMs
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

New-AzureRmRecoveryServicesBackupProtectionPolicy -Name "Policy" -WorkloadType "AzureVM" -RetentionPolicy $retPol -SchedulePolicy $schPol
