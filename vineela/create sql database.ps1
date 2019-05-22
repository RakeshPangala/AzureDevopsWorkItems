Install-Module -Name Az -AllowClobber

#create resource group

 New-AzResourceGroup -Name "vineela" -Location "south india"

$databasename = "vineeladatabase"
$servername = "vineelaserver"

#create sql server

$server = New-AzSqlServer -ServerName $servername -ResourceGroupName "vineela" -Location "south india" -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "sqladmin",$(ConvertTo-SecureString -String Chvineela504* -AsPlainText -Force))

#create sql database

$database = New-AzSqlDatabase -DatabaseName $databasename -ResourceGroupName "vineela" -ServerName $servername -SampleName AdventureWorksLT 

#set firewall settings

$serverfirewall = New-AzSqlServerFirewallRule -FirewallRuleName "vineelarule" -ResourceGroupName "vineela" -StartIpAddress "192.168.145.65" -EndIpAddress "192.168.145.65" -ServerName $servername 
