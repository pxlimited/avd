# Software install Script
#
# Application to install: MS Power BI Desktop
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'MS-Power-BI-Desktop'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Update MS-Power-BI-Desktop
Write-Host 'AIB Customisation: Downloading the MS-Power-BI-Desktop app'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/PBIDesktopSetup_x64.zip'
$downloadedFile = 'PBIDesktopSetup_x64.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the MS-Power-BI-Desktop app finished'


# MS Power BI Desktop Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # MS Power BI Desktop Unzip
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



#region MS Power BI Desktop
try {
    Start-Process -filepath 'C:\temp\PBIDesktopSetup_x64.exe' -Wait -ErrorAction Stop -ArgumentList '-q', '-norestart', 'ACCEPT_EULA=1'
    if (Test-Path "C:\Program Files\Microsoft Power BI Desktop\bin\PBIDesktop.exe") {
        Write-Host "Power BI Desktop has been installed"
    }
    else {
        write-Host "Error locating the MS Power BI Desktop executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-Host "Error installing MS Power BI Desktop: $ErrorMessage"
}
#endregion