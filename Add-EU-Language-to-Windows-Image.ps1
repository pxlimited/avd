
########################################################
## Add Languages to running Windows Image for Capture ##
########################################################

##Disable Language Pack Cleanup##
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup"

##Set Language Pack Content Stores##
[string]$LIPContent = "https://avdsoftwarestorage.blob.core.windows.net/px-avd-langpacks"

##Norwegian##
Add-AppProvisionedPackage -Online -PackagePath $LIPContent/LanguageExperiencePack.nb-NO.Neutral.appx -LicensePath $LIPContent/License.xml
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-Client-Language-Pack_x64_nb-no.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-Basic-nb-no-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-Handwriting-nb-no-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-OCR-nb-no-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-TextToSpeech-nb-no-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("nb-no")
Set-WinUserLanguageList $LanguageList -force

##Spanish##
Add-AppProvisionedPackage -Online -PackagePath $LIPContent/LanguageExperiencePack.es-es.Neutral.appx -LicensePath $LIPContent/License.xml
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-Client-Language-Pack_x64_es-es.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-Basic-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-Handwriting-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-OCR-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-Speech-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-TextToSpeech-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~es-es~.cab
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("es-es")
Set-WinUserLanguageList $LanguageList -force

##French##
Add-AppProvisionedPackage -Online -PackagePath $LIPContent/LanguageExperiencePack.fr-fr.Neutral.appx -LicensePath $LIPContent/License.xml
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-Client-Language-Pack_x64_fr-fr.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-Basic-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-Handwriting-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-OCR-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-Speech-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-LanguageFeatures-TextToSpeech-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~fr-fr~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent/Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("fr-fr")
Set-WinUserLanguageList $LanguageList -force