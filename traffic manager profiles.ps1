# Created  3 traffic manaager TM1,TM2,TM3

# Input Fields


$rg='SuryaRG'
$Loc='South India'

Login-AzureRmAccount
# Create a Resource Group

New-AzureRmResourceGroup -Name $rg -Location $Loc

# Creating Traffic Manager profile

$Tm1 = New-AzureRmTrafficManagerProfile -Name TmPer -ResourceGroupName $rg -TrafficRoutingMethod Performance -RelativeDnsName SuryaDns -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/"


Add-AzureRmTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $Tm1 -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "North Europe" -EndpointStatus Enabled

Add-AzureRmTrafficManagerEndpointConfig -EndpointName us-endpoint -TrafficManagerProfile $Tm1 -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzureRmTrafficManagerProfile -TrafficManagerProfile $Tm1

$Tm2 = New-AzureRmTrafficManagerProfile -Name TmPri -ResourceGroupName $rg -TrafficRoutingMethod Priority -RelativeDnsName SaiDns -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/"

Add-AzureRmTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $Tm2 -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "North Europe" -EndpointStatus Enabled

Add-AzureRmTrafficManagerEndpointConfig -EndpointName us-endpoint -TrafficManagerProfile $Tm2 -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzureRmTrafficManagerProfile -TrafficManagerProfile $Tm2

$Tm3 = New-AzureRmTrafficManagerProfile -Name Tmwei -ResourceGroupName $rg -TrafficRoutingMethod Weighted -RelativeDnsName SaisuryaDns -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/"

Add-AzureRmTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $Tm3 -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "North Europe" -EndpointStatus Enabled

Add-AzureRmTrafficManagerEndpointConfig -EndpointName us-endpoint -TrafficManagerProfile $Tm3 -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzureRmTrafficManagerProfile -TrafficManagerProfile $Tm3

