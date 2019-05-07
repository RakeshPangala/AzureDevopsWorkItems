#Powershell cleanup for clearing azure resources

$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Write-Output $conn
$a = Login-AzureRmAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
Write-Output $a

$allRG=Get-AzureRmResourceGroup  where{$_.ResourcegroupName -ne RAM}


foreach ( $g in $allRG){


        Remove-AzureRmResourceGroup -Name $g.ResourceGroupName -Force

}