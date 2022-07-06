# Software install Script
#
# Application to install: Firefox Browser
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'Firefox-Browser'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Update Firefox Browser
Write-Host 'AIB Customisation: Downloading the Firefox Browser app'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/Firefox_Setup_102.0_x64_en.zip'
$downloadedFile = 'Firefox_Setup_102.0_x64_en.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the Firefox Browser app finished'


# Firefox Browser Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # Firefox Browser Unzip
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



#region Install Firefox Browser
try {
    Start-Process -filepath msiexec.exe -Wait -ErrorAction Stop -ArgumentList '/i', 'C:\temp\Firefox_Setup_102.0_x64_en.msi', '/quiet'
    if (Test-Path "C:\Program Files\Mozilla Firefox\firefox.exe") {
        Write-Host "Firefox Browser has been installed"
    }
    else {
        write-Host "Error locating the Firefox Browser executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-Host "Error installing Firefox Browser: $ErrorMessage"
}
#endregion