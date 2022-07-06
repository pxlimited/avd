# Software install Script
#
# Application to install: Bluebeam Standard 20
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'BlueBeam'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Download Bluebeam
Write-Host 'AIB Customisation: Downloading the Bluebeam'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/Bluebeam.zip'
$downloadedFile = 'Bluebeam-20.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the Bluebeam app finished'


# Bluebeam Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # Bluebeam Unzip
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



#region Install Bluebeam OCR
try {
    Start-Process -filepath 'msiexec.exe' -Wait -ErrorAction Stop -ArgumentList '/i "C:\Temp\Bluebeam\Bluebeam Revu x64 20.msi"', 'TRANSFORMS="C:\Temp\Bluebeam\Bluebeam Revu x64 20.mst"', '/qn'
    if (Test-Path "C:\Program Files\Bluebeam Software\Bluebeam Revu\20\Revu\Revu.exe") {
        Write-Host "Bluebeam has been installed"
    }
    else {
        write-Host "Error locating the Bluebeam executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-Host "Error installing Bluebeam: $ErrorMessage"
}
#endregion