# Software install Script
#
# Application to install: Google Chrome
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'Google-Chrome'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Update Google-Chrome
Write-Host 'AIB Customisation: Downloading the Google-Chrome app'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/googlechromestandaloneenterprise64.zip'
$downloadedFile = 'googlechromestandaloneenterprise64.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the Google-Chrome app finished'


# Google Chrome Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # Google Chrome Unzip
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



#region Adobe Acrobat Reader
try {
    Start-Process -filepath 'C:\temp\googlechromestandaloneenterprise64.zip' -Wait -ErrorAction Stop -ArgumentList '/sAll', '/rs', '/msi', 'EULA_ACCEPT=YES'
    if (Test-Path "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRD32.exe") {
        Write-Host "Acrobat Reader has been installed"
    }
    else {
        write-Host "Error locating the Acrobat Reader executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-Host "Error installing Acrobat Reader: $ErrorMessage"
}
#endregion