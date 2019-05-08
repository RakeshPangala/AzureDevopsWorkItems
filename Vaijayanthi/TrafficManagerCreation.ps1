#login to Azure portal--------------------------

Login-AzureRmAccount
$rgname='VaijayanthiRG'
$loc='Central US'

#------------Creating Resource group-----------------------------------------------

New-AzureRmResourceGroup -Name $rgname  -Location $loc

#------------Creating traffic manager profile having Routing Method as Performance---------------------------------

$Tmprofile = New-AzureRmTrafficManagerProfile -Name VaijayanthiTMPer -ResourceGroupName $rgname -TrafficRoutingMethod Performance -RelativeDnsName VaijayanthiDns -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/"

#------------Retrieve an existing Traffic Manager profile object

$TmProfile = Get-AzureRmTrafficManagerProfile -Name VaijayanthiTMPer -ResourceGroupName $rgname

#------------Adding endpoints in Traffic Manager Profile having endpoint location as North-europe------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $Tmprofile -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "North Europe" -EndpointStatus Enabled

#------------Adding endpoints in Traffic Manager Profile having endpoint location as central-US------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName us-endpoint -TrafficManagerProfile $Tmprofile -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzureRmTrafficManagerProfile -TrafficManagerProfile $Tmprofile

Get-AzureRmTrafficManagerProfile

#------------Creating traffic manager profile having Routing Method as priority---------------------------------

$TmprofilePri = New-AzureRmTrafficManagerProfile -Name VaijayanthiTMPrio -ResourceGroupName $rgname -TrafficRoutingMethod Priority -RelativeDnsName Vaijayanthi2Dns -Ttl 30 -MonitorProtocol HTTPS -MonitorPort 22 -MonitorPath "/"


#------------Adding endpoints in Traffic Manager Profile having endpoint location as East-Us------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $TmprofilePri -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "East US " -EndpointStatus Enabled

#------------Adding endpoints in Traffic Manager Profile having endpoint location as central-US------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName cs-endpoint -TrafficManagerProfile $TmprofilePri -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzureRmTrafficManagerProfile -TrafficManagerProfile $TmprofilePri


#------------Creating traffic manager profile having Routing Method as Weight---------------------------------

$TmprofileWeig = New-AzureRmTrafficManagerProfile -Name VaijayanthiTMWeig -ResourceGroupName $rgname -TrafficRoutingMethod Weighted -RelativeDnsName Vaijayanthi3dns -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/"



#------------Adding endpoints in Traffic Manager Profile having endpoint location as North-europe------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName eu-endpoint -TrafficManagerProfile $TmprofileWeig -Type ExternalEndpoints -Target app-eu.contoso.com -EndpointLocation "North Europe" -EndpointStatus Enabled

#------------Adding endpoints in Traffic Manager Profile having endpoint location as central-US------------------------------------

Add-AzureRmTrafficManagerEndpointConfig -EndpointName us-endpoint -TrafficManagerProfile $TmprofileWeig -Type ExternalEndpoints -Target app-us.contoso.com -EndpointLocation "Central US" -EndpointStatus Enabled

Set-AzureRmTrafficManagerProfile -TrafficManagerProfile $TmprofileWeig