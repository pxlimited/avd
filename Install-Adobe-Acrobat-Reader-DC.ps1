# Software install Script
#
# Application to install: Adobe Acrobat Reader DC
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'Adobe-Acrobat-Reader-DC'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Update Adobe-Acrobat-Reader-DC
Write-Host 'AIB Customisation: Downloading the Adobe-Acrobat-Reader-DC app'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/Adobe-Acrobat-Reader-DC.zip?sp=r&st=2022-07-01T07:56:25Z&se=2023-07-01T15:56:25Z&spr=https&sv=2021-06-08&sr=b&sig=Kx89URy2vRJ0GCaINifq0Y57nfaGi5%2FefxAZWRG%2B%2Bck%3D'
$downloadedFile = 'Adobe-Acrobat-Reader-DC.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the Adobe-Acrobat-Reader-DC app finished'


# Adobe Acrobat Reader DC Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # Adobe Acrobat Reader DC Unzip
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
    Start-Process -filepath 'C:\temp\AcroRdrDC2200120142_en_US.exe' -Wait -ErrorAction Stop -ArgumentList '/sAll', '/rs', '/msi', 'EULA_ACCEPT=YES'
    if (Test-Path "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRD32.exe") {
        Write-Log "Acrobat Reader has been installed"
    }
    else {
        write-log "Error locating the Acrobat Reader executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Acrobat Reader: $ErrorMessage"
}
#endregion