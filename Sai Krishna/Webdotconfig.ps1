$xml = [xml](Get-Content c:\Users\v-saikka\Web.config)
$conString = $xml.connectionStrings.add[0].connectionString
$conString2 = $conString -replace '192.168.1.100','10.10.10.10'
$xml.connectionStrings.add[0].connectionString = $conString2
$conString = $xml.connectionStrings.add[1].connectionString
$conString2 = $conString -replace '192.168.1.100','10.10.10.10'
$xml.connectionStrings.add[1].connectionString = $conString2
$xml.Save('c:\Users\v-saikka\Web2.config')