Set-ExecutionPolicy
get-excutionpolicy
install-module az
#create resource group
New-AzResourceGroup -name "gopal" -location "east us"
$databasename="gopaldb"
$servername="gopalserver"
#create sql server
$server=new-Azsqlserver -name "$servername" ResourceGroupname "gopal" location "east us"  -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "admin",$(ConvertTo-SecureString -String gopal504* -AsPlainText -Force))
 
#create sql database
$database=new-AzSqlDatabase -name "$databasename" ResourceGroupname "gopal" location "east us"  -ServerName $servername -SampleName gopalsample
#set firewall settings
$serverfirewall = New-AzSqlServerFirewallRule -FirewallRuleName "gopalfirewall" -ResourceGroupName "gopal" -StartIpAddress "192.168.0.68" -EndIpAddress "192.168.0.68" -ServerName $servername 