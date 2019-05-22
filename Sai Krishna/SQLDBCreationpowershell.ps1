Login-AzureRmAccount

# Resource name for your resources  
$resourcegroupname = "KrishRG"  
$location = "WestEurope"  
# The logical server name: Use a random value or replace with your own (do not capitalize)  
$servername = "server-$(Get-Random)"  
# Set login and password for your database  
# The login information for the server  
$adminlogin = "saikrishna0888"  
$password = "dbserver@123"  
# The ip address range that you want to allow to access your server   
$startip = "83.12.13.4"  
$endip = "83.12.13.10"  
# The database name  
$databasename = "saikrishnadb" 

New-AzureRmResourceGroup -Name $resourcegroupname -Location $location 

New-AzureRmSqlServer -ResourceGroupName $resourcegroupname -ServerName $servername -Location $location -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminlogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))

#Create an Azure SQL Database server-level firewall rule using the New-AzureRmSqlServerFirewallRule command

New-AzureRmSqlServerFirewallRule -ResourceGroupName $resourcegroupname -ServerName $servername -FirewallRuleName "AllowSome" -StartIpAddress $startip -EndIpAddress $endip

#Create a database with an S0 performance level (Check Pricing Tiers in the server using the New-AzureRmSqlDatabase command)

New-AzureRmSqlDatabase -ResourceGroupName $resourcegroupname -ServerName $servername -DatabaseName $databasename -SampleName "AdventureWorksLT" -RequestedServiceObjectiveName "S0" 