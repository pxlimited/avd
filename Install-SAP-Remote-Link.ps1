# Software install Script
#
# Application to install: SAP Remote Link
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'SAP-Remote-Link'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Update SAP Remote Link
Write-Host 'AIB Customisation: Downloading the SAP Remote Link'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/SAP-Remote.zip'
$downloadedFile = 'SAP-Remote.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the SAP Remote Link app finished'


# SAP Remote Link Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # SAP Remote Link Unzip
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



#region Copy SAP Remote Link
try {
    Copy-Item 'C:\temp\SAP_Remote.rdp' 'C:\Users\Public\Desktop'
    if (Test-Path "C:\Users\Public\Desktop\SAP_Remote.rdp") {
        Write-Host "SAP Remote Link has been copied"
    }
    else {
        write-Host "Error locating the SAP Remote Link"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-Host "Error installing SAP Remote Link: $ErrorMessage"
}
#endregion