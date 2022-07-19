# Software install Script
#
# Application to install: Crowdstrike
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'Crowdstrike'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Update Crowdstrike
Write-Host 'AIB Customisation: Downloading the Crowdstrike app'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/Crowdstrike.zip'
$downloadedFile = 'Crowdstrike.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the Crowdstrike app finished'


# Crowdstrike Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # Crowdstrike Unzip
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



#region Crowdstrike
try {
    Start-Process -filepath 'C:\temp\WindowsSensor.LionLanner.exe' -Wait -ErrorAction Stop -ArgumentList '/install', '/quiet', '/norestart', 'CID=403E53443A304DF0AB144C2B4859BB41-71'
    if (Test-Path "C:\Program Files\Crowdstrike\CSFalconService.exe") {
        Write-Host "Crowdstrike has been installed"
    }
    else {
        write-Host "Error locating the Crowdstrike executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-Host "Error installing Crowdstrike: $ErrorMessage"
}
#endregion