Login-AzureRmAccount
$rgname="GowthamiRG"
$loc="East Us"

#Creating Peformancebased Traffic manager






New-AzureRmResourceGroup -Name $rgname  -Location $loc

#------------Creating traffic manager profile having Routing Method as Performance---------------------------------

$Tmprofile = New-AzureRmTrafficManagerProfile -Name GowthamiTMPer -ResourceGroupName $rgname -TrafficRoutingMethod Performance -RelativeDnsName gowthamiDns -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/"

#------------Retrieve an existing Traffic Manager profile object

$TmProfile = Get-AzureRmTrafficManagerProfile -Name GowthamiTMPer -ResourceGroupName $rgname

#------------Adding endpoints in Traffic Manager Profile having endpoint location as North-europe------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $Tmprofile -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "North Europe" -EndpointStatus Enabled

#------------Adding endpoints in Traffic Manager Profile having endpoint location as central-US------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName us-endpoint -TrafficManagerProfile $Tmprofile -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzureRmTrafficManagerProfile -TrafficManagerProfile $Tmprofile






#------------Creating traffic manager profile having Routing Method as priority---------------------------------

$TmprofilePri = New-AzureRmTrafficManagerProfile -Name GoowthamiTMPrio -ResourceGroupName $rgname -TrafficRoutingMethod Priority -RelativeDnsName GowthamiDns -Ttl 30 -MonitorProtocol HTTPS -MonitorPort 22 -MonitorPath "/"


#------------Adding endpoints in Traffic Manager Profile having endpoint location as East-Us------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $TmprofilePri -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "East US " -EndpointStatus Enabled

#------------Adding endpoints in Traffic Manager Profile having endpoint location as central-US------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName cs-endpoint -TrafficManagerProfile $TmprofilePri -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzureRmTrafficManagerProfile -TrafficManagerProfile $TmprofilePri







#------------Creating traffic manager profile having Routing Method as Weight---------------------------------

$TmprofileWeig = New-AzureRmTrafficManagerProfile -Name GowthamiTMWeig -ResourceGroupName $rgname -TrafficRoutingMethod Weighted -RelativeDnsName Gowthamidns -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/"



#------------Adding endpoints in Traffic Manager Profile having endpoint location as North-europe------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $TmprofileWeig -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "North Europe" -EndpointStatus Enabled

#------------Adding endpoints in Traffic Manager Profile having endpoint location as central-US------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName us-endpoint -TrafficManagerProfile $TmprofileWeig -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzureRmTrafficManagerProfile -TrafficManagerProfile $TmprofileWeig





