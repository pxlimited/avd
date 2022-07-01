# Software install Script
#
# Application to install: DWG Trueview 2023
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'Autodesk'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName


# Download Autodesk DWG Trueview 2023
Write-Host 'AIB Customisation: Downloading the Autodesk DWG Trueview 2023 app'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/DWG-TrueView-2023.zip?sp=r&st=2022-07-01T07:50:30Z&se=2023-07-01T15:50:30Z&spr=https&sv=2021-06-08&sr=b&sig=c09rO8%2BmdspwqaDYdEdLgrzILSULLT41gTA8Hyp6TrQ%3D'
$downloadedFile = 'DWG-TrueView-2023.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the Autodesk DWG Trueview 2023 app finished'


# Autodesk Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # Autodesk Unzip
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




#region DWG Trueview
try {
    Start-Process -filepath C:\temp\Autodesk\Setup.exe -Wait -ErrorAction Stop -ArgumentList '--silent'
    if (Test-Path "C:\Program Files\Autodesk\DWG Trueview 2023 - English\dwgviewr.exe") {
        Write-Log "DWG Trueview has been installed"
    }
    else {
        write-log "Error locating the DWG Trueview executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing DWG Trueview: $ErrorMessage"
}
#endregion
