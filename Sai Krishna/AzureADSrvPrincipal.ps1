#Step 1: Set up Service Principal in AAD
#Input Area
$subscriptionName = 'Pay-As-You-Go'
$aadSvcPrinAppDisplayName = 'VMEncryptionSvcPrincipal'
$aadSvcPrinAppHomePage = 'http://FakeURLBecauseItsNotReallyNeededForThisPurpose'
$aadSvcPrinAppIdentifierUri = 'https://DomainName.com/VMEncryptionSvcPrincipal'
$aadSvcPrinAppPassword = ConvertTo-SecureString '' -AsPlainText -Force

#-----------------------------------------

#Manual login into Azure
Login-AzureRmAccount -SubscriptionName $subscriptionName

#-----------------------------------------

#Create Service Principal App to Use For Encryption of VMs
$aadSvcPrinApplication = New-AzureRmADApplication -DisplayName $aadSvcPrinAppDisplayName -HomePage $aadSvcPrinAppHomePage -IdentifierUris $aadSvcPrinAppIdentifierUri -Password $aadSvcPrinAppPassword
New-AzureRmADServicePrincipal -ApplicationId $aadSvcPrinApplication.ApplicationId



