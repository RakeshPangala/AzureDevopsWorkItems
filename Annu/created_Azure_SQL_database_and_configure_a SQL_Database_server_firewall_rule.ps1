# Connect-AzureAccount

Login-AzureRmAccount

# The SubscriptionId in which to create these objects

$SubscriptionId = 'Pay-As-You-Go'

# Set the resource group name and location for your server

$resourceGroupName = "AnnuRG-$(Get-Random)"
$location = "East US"

# Set an admin login and password for your server

$adminSqlLogin = "Annu"
$password = "Choubey@123"

# Set server name - the logical server name has to be unique in the system

$serverName = "annuserver-$(Get-Random)"

# The sample database name

$databaseName = "AnnuDb"

# The ip address range that you want to allow to access your server

$startIp = "10.0.0.1"
$endIp = "10.0.0.24"

# Set subscription 

Set-AzureRmContext -SubscriptionId $subscriptionId 

# Create a resource group

$resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location

# Create a server with a system wide unique server name

$server = New-AzureRmSqlServer -ResourceGroupName $resourceGroupName 
    -ServerName $serverName 
    -Location $location 
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))

# Create a server firewall rule that allows access from the specified IP range

$serverFirewallRule = New-AzureRmSqlServerFirewallRule -ResourceGroupName $resourceGroupName 
    -ServerName $serverName -FirewallRuleName "AllowedIPs" -StartIpAddress $startIp -EndIpAddress $endIp

# Create a blank database with an S0 performance level
$database = New-AzureRmSqlDatabase  -ResourceGroupName $resourceGroupName 
    -ServerName $serverName 
    -DatabaseName $databaseName 
    -RequestedServiceObjectiveName "So" 
    -SampleName "AdventureWorksLT"


 Remove-AzureRmResourceGroup -ResourceGroupName $resourceGroupName