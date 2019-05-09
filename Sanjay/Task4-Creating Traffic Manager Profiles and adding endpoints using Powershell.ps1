
Login-AzAccount

#$username='quadrantit@hotmail.com'
#$password='password'
#$password=ConvertTo-SecureString $password -AsPlainText -Force
#$credential= New-Object System.Management.Automation.PSCredential($username,$password)
#Connect-AzAccount -Credential $credential




# Common
$LOC = "southindia"
$RGName = "sanjay";

#-------------------------------------Creates Traffic Manager Profiles---------------------------------#

$tm1 = New-AzTrafficManagerProfile -Name TM1 -ResourceGroupName Sanjay -TrafficRoutingMethod Performance -RelativeDnsName sanjayapp -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/" -ProfileStatus Enabled 


$tm2 = New-AzTrafficManagerProfile -Name TM2 -ResourceGroupName Sanjay -TrafficRoutingMethod Priority -RelativeDnsName sanjayapp2 -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/" -ProfileStatus Enabled 


$tm3 = New-AzTrafficManagerProfile -Name TM3 -ResourceGroupName Sanjay -TrafficRoutingMethod Weighted -RelativeDnsName sanjayapp3 -Ttl 30 -MonitorProtocol HTTP -MonitorPort 80 -MonitorPath "/" -ProfileStatus Enabled 



#$profile = Get-AzTrafficManagerProfile -Name TM1 -ResourceGroupName Sanjay
#Set-AzTrafficManagerProfile -TrafficManagerProfile $profile

#----------------------------Creates 3 End points for each one of Traffic Manager Profiles------------#

$ip = Get-AzPublicIpAddress -Name pip1sanjay -ResourceGroupName Sanjay
New-AzTrafficManagerEndpoint -Name Endpoint1 -ProfileName TM1 -ResourceGroupName Sanjay -Type AzureEndpoints -TargetResourceId $ip.Id -EndpointStatus Enabled

$ip2 = Get-AzPublicIpAddress -Name pip1sanjay -ResourceGroupName Sanjay
New-AzTrafficManagerEndpoint -Name Endpoint2 -ProfileName TM2 -ResourceGroupName Sanjay -Type AzureEndpoints -TargetResourceId $ip2.Id -EndpointStatus Enabled

$ip3= Get-AzPublicIpAddress -Name pip1sanjay -ResourceGroupName Sanjay
New-AzTrafficManagerEndpoint -Name Endpoint3 -ProfileName TM3 -ResourceGroupName Sanjay -Type AzureEndpoints -TargetResourceId $ip3.Id -EndpointStatus Enabled