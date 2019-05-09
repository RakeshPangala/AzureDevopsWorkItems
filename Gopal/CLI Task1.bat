#login azure portal
az login -u quadrantit@hotmail.com -p 'password'

#created resource group
az group create --name gopal --location southindia

#created vnet and subnet
az network vnet create -g gopal -n Vnet --address-prefixes 193.168.0.0/25 --subnet-name frontend --subnet-prefixes 193.168.0.0/28

#created a subnet for vnet
az network vnet subnet create -g gopal --vnet-name Vnet --name backend --address-prefixes 193.168.0.16/28

#created a NSG Frontend
az network nsg create -n FrontendNSG -g gopal 

#created a update frontendNSG subnet
az network vnet subnet update -g gopal -n frontend --vnet-name Vnet --network-security-group FrontendNSG

#created a NSG Backend
az network nsg create -n BackendNSG -g gopal 

#created a update backendNSG subnet
az network vnet subnet update -g gopal -n backend --vnet-name Vnet --network-security-group BackendNSG

#Created a NSG group RDP Rule Frontend
az network nsg rule create -g gopal --nsg-name FrontendNSG -n RDPRule --priority 100 --destination-port-ranges 3389

#Created a NSG group SSH Rule Frontend
az network nsg rule create -g gopal --nsg-name FrontendNSG-n SSHRule --priority 101 --destination-port-ranges 22

#Created a NSG group HTTP Rule Frontend
az network nsg rule create -g gopal --nsg-name FrontendNSG-n HTTPRule --priority 102 --destination-port-ranges 80

#Created a NSG group HTTPS Rule Frontend
az network nsg rule create -g gopal --nsg-name FrontendNSG-n HTTPSRule --priority 103 --destination-port-ranges 443

#Created a NSG group RDP Rule Backend
az network nsg rule create -g gopal --nsg-name BackendNSG -n RDPRule --priority 100 --destination-port-ranges 3389

#Created a NSG group RDP Rule Backend
az network nsg rule create -g gopal --nsg-name BackendNSG -n MSSQLRule --priority 104 --destination-port-ranges 1433

#Created a NSG group RDP Rule Backend
az network nsg rule create -g gopal --nsg-name BackendNSG -n HTTPRule --priority 105 --destination-port-ranges 80 --access Deny --direction outbound
© 2019 GitHub, Inc.