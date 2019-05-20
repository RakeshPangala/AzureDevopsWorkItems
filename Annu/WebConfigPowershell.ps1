$xml = [xml](Get-Content c:\Web.config)
$String = $xml.connectionStrings.add[0].connectionString
$String2 = $String -replace '10.10.10.10','172.11.0.10'
$xml.connectionStrings.add[0].connectionString = $String2
$String = $xml.connectionStrings.add[1].connectionString
$String2 = $String -replace '10.10.10.10','172.11.0.10'
$xml.connectionStrings.add[1].connectionString = $String2
$xml.Save('c:\Web2.config')