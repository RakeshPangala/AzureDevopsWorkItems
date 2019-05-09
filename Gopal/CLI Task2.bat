az login -u quadrantit@hotmail.com -p <password>

#Creates a Resource Group 
az group create --name gopal --location southindia

#Creates Vnet,Subnets, GatewaySubnets for VNet1,Vnet2,Vnet3

az network vnet create -g gopal -n Vnet1 --address-prefixes 193.168.1.0/24 --subnet-name frontend1 --subnet-prefixes 193.168.1.0/28

az network vnet subnet create -g gopal --vnet-name Vnet1 --name backend1 --address-prefixes 193.168.1.16/28

az network vnet subnet create -g gopal --vnet Vnet1 -n GatewaySubnet --address-prefixes 193.168.1.32/28


az network vnet create -g gopal -n Vnet2 --address-prefixes 193.168.2.0/24 --subnet-name frontend2 --subnet-prefixes 193.168.2.0/28

az network vnet subnet create -g gopal --vnet-name Vnet2 --name backend2 --address-prefixes 193.168.2.16/28

az network vnet subnet create -g gopal --vnet Vnet2 -n GatewaySubnet --address-prefixes 193.168.2.32/28



az network vnet create -g gopal -n Vnet3 --address-prefixes 193.168.3.0/25 --subnet-name frontend3 --subnet-prefixes 193.168.3.0/28

az network vnet subnet create -g gopal --vnet-name Vnet3 --name backend3 --address-prefixes 193.168.3.16/28

az network vnet subnet create -g gopal --vnet Vnet3 -n GatewaySubnet --address-prefixes 193.168.3.32/28


#Requests publicIP for Vnet1-Gateway

az network public-ip create -n Gw1publicip --allocation-method Dynamic -g gopal 

az network vnet-gateway create -n Vnet1GW -g gopal --public-ip-address Gw1publicip --vnet Vnet1 -l southindia --gateway-type Vpn --vpn-type RouteBased

#Requests publicIP for Vnet2-Gateway

az network public-ip create -n Gw2publicip --allocation-method Dynamic -g gopal 

az network vnet-gateway create -n Vnet2GW -g gopal --public-ip-address Gw2publicip --vnet Vnet2 -l southindia --gateway-type Vpn --vpn-type RouteBased

#Vnet2Vnet Connection through VPN Gateways

az network vpn-connection create --name vnet1-vnet2 -g gopal --vnet-gateway1 Vnet1GW --vnet-gateway2 Vnet2GW --shared-key 13.71.92.204

az network vpn-connection create --name vnet2-vnet1 -g gopal --vnet-gateway1 Vnet2GW --vnet-gateway2 Vnet1GW --shared-key 13.71.92.204

#Vnet2-Vnet3 Peering and made Vnet2 as HUB

az network vnet peering create -n Vnet2-Vnet3 --vnet-name Vnet2 --remote-vnet Vnet3--allow-gateway-transit -g gopal 

#Vnet3-Vnet2 Peering and made Vnet3 as SPOKE

az network vnet peering create -n Vnet3-Vnet2 --vnet-name Vnet3 --remote-vnet Vnet2-g gopal --use-remote-gateways