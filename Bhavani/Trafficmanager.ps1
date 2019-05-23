Login-AzAccount
$rgname="BhavaniRG"
$location="Southindia"
New-AzResourceGroup -Name $rgname  -Location $location

$Tmprofile = New-AzTrafficManagerProfile -Name BhavaniTMPerf -ResourceGroupName $rgname -TrafficRoutingMethod Performance -RelativeDnsName RelativeDn23 -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/"

$TmProfile = Get-AzTrafficManagerProfile -Name BhavaniTMPerf -ResourceGroupName $rgname

#Adding endpoints in Traffic Manager 

Add-AzTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $Tmprofile -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "North Europe" -EndpointStatus Enabled

#Adding endpoints in Traffic Manager Profile having endpoint location as central-US

Add-AzTrafficManagerEndpointConfig -EndpointName us-endpoint -TrafficManagerProfile $Tmprofile -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzTrafficManagerProfile -TrafficManagerProfile $Tmprofile

#Creating traffic manager profile having Routing Method as priority-

$TmprofilePri = New-AzTrafficManagerProfile -Name BhavaniTMPrio -ResourceGroupName $rgname -TrafficRoutingMethod Priority -RelativeDnsName madhDns -Ttl 30 -MonitorProtocol HTTPS -MonitorPort 22 -MonitorPath "/"

#Adding endpoints in Traffic Manager Profile and endpoint location as East-Us

Add-AzTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $TmprofilePri -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "East US " -EndpointStatus Enabled

#Adding endpoints in Traffic Manager Profile having endpoint location as central-US

Add-AzTrafficManagerEndpointConfig -EndpointName cs-endpoint -TrafficManagerProfile $TmprofilePri -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzTrafficManagerProfile -TrafficManagerProfile $TmprofilePri


#Creating traffic manager profile having Routing Method as Weight

$TmprofileWeig = New-AzTrafficManagerProfile -Name BhavaniTMWeig -ResourceGroupName $rgname -TrafficRoutingMethod Weighted -RelativeDnsName Madhu12dns -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/"


#Adding endpoints in Traffic Manager Profile having endpoint location as North-europe

Add-AzTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $TmprofileWeig -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "North Europe" -EndpointStatus Enabled

#Adding endpoints in Traffic Manager Profile having endpoint location as central-US

Add-AzTrafficManagerEndpointConfig -EndpointName us-endpoint -TrafficManagerProfile $TmprofileWeig -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzTrafficManagerProfile -TrafficManagerProfile $TmprofileWeig
