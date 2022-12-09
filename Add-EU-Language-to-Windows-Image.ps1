# Script to download and install multiple languages to Windows Image
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_languageinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'Languages'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Download compressed language files
Write-Host 'AIB Customisation: Downloading the Language files'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/Language-Files.zip'
$downloadedFile = 'Language-Files.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the Language files finished'


# Language Files Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # Languge files Unzip
# Unzips the downloaded file to the $appPath directory.
try {
    Write-Host -Object "AIB Customisation: Unzipping $downloadedFile."
    Expand-Archive @ExpandArchiveParameters
    Write-Host -Object "AIB Customisation: Unzipped $downloadedFile."
}
catch {
    Write-Host -Object "AIB Customisation Error: Unable to unzip $downloadedFile."
    Write-Host -Object $lastError
    Write-Host -Object "Exit code: $LASTEXITCODE"
}


########################################################
## Add Languages to running Windows Image for Capture ##
########################################################

##Disable Language Pack Cleanup##
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup"

##Set Language Pack Content Stores##
[string]$LIPContent = "C:\Temp\Language-Files"

##Norwegian##
Add-AppProvisionedPackage -Online -PackagePath $LIPContent\LocalExperiencePack\nb-no\LanguageExperiencePack.nb-NO.Neutral.appx -LicensePath $LIPContent\LocalExperiencePack\nb-no\License.xml
Add-WindowsPackage -Online -PackagePath $LIPContent\langpacks\Microsoft-Windows-Client-Language-Pack_x64_nb-no.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Basic-nb-no-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Handwriting-nb-no-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-OCR-nb-no-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-TextToSpeech-nb-no-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~nb-NO~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~nb-NO~.cab
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("nb-no")
Set-WinUserLanguageList $LanguageList -force

##Dutch##
Add-AppProvisionedPackage -Online -PackagePath $LIPContent\LocalExperiencePack\nl-nl\LanguageExperiencePack.nl-NL.Neutral.appx -LicensePath $LIPContent\LocalExperiencePack\nl-nl\License.xml
Add-WindowsPackage -Online -PackagePath $LIPContent\langpacks\Microsoft-Windows-Client-Language-Pack_x64_nl-nl.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Basic-nl-nl-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Handwriting-nl-nl-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-OCR-nl-nl-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-TextToSpeech-nl-nl-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~nl-NL~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~nl-NL~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~nl-NL~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~nl-NL~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~nl-NL~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~nl-NL~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~nl-NL~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~nl-NL~.cab
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("nl-nl")
Set-WinUserLanguageList $LanguageList -force

##German##
Add-AppProvisionedPackage -Online -PackagePath $LIPContent\LocalExperiencePack\de-de\LanguageExperiencePack.de-DE.Neutral.appx -LicensePath $LIPContent\LocalExperiencePack\de-de\License.xml
Add-WindowsPackage -Online -PackagePath $LIPContent\langpacks\Microsoft-Windows-Client-Language-Pack_x64_de-de.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Basic-de-de-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Handwriting-de-de-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-OCR-de-de-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Speech-de-de-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-TextToSpeech-de-de-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~de-DE~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~de-DE~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~de-DE~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~de-DE~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~de-DE~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~de-DE~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~de-DE~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~de-DE~.cab
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("de-de")
Set-WinUserLanguageList $LanguageList -force

##Spanish##
Add-AppProvisionedPackage -Online -PackagePath $LIPContent\LocalExperiencePack\es-es\LanguageExperiencePack.es-es.Neutral.appx -LicensePath $LIPContent\LocalExperiencePack\es-es\License.xml
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Client-Language-Pack_x64_es-es.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Basic-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Handwriting-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-OCR-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Speech-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-TextToSpeech-es-es-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~es-es~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~es-es~.cab
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("es-es")
Set-WinUserLanguageList $LanguageList -force

##French##
Add-AppProvisionedPackage -Online -PackagePath $LIPContent\LocalExperiencePack\fr-fr\LanguageExperiencePack.fr-fr.Neutral.appx -LicensePath $LIPContent\LocalExperiencePack\fr-fr\License.xml
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Client-Language-Pack_x64_fr-fr.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Basic-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Handwriting-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-OCR-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-Speech-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-LanguageFeatures-TextToSpeech-fr-fr-Package~31bf3856ad364e35~amd64~~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~fr-fr~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Notepad-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-PowerShell-ISE-FOD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-Printing-WFS-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-StepsRecorder-Package~31bf3856ad364e35~amd64~fr-FR~.cab
Add-WindowsPackage -Online -PackagePath $LIPContent\Microsoft-Windows-WordPad-FoD-Package~31bf3856ad364e35~amd64~fr-FR~.cab
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("fr-fr")
Set-WinUserLanguageList $LanguageList -force

