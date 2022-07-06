# Software install Script
#
# Application to install: MS Project and Visio
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'MS-Project-and-Visio'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Update MS-Project-and-Visio
Write-Host 'AIB Customisation: Downloading the MS-Project-and-Visio app'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/MS-Project-and-Visio.zip'
$downloadedFile = 'MS-Project-and-Visio.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the MS-Project-and-Visio app finished'


# MS Project and Visio Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # MS Project and Visio Unzip
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



#region MS Project and Visio
try {
    Start-Process -filepath 'C:\temp\MS-Project-and-Visio\setup.exe' -Wait -ErrorAction Stop -ArgumentList '/configure Add-Project-and-Visio.xml'
    if (Test-Path "C:\Program Files\Microsoft Office\root\Office16\WINPROJ.EXE") {
        Write-Host "Project and Visio have been installed"
    }
    else {
        write-Host "Error locating the MS Project and Visio executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-Host "Error installing MS Project and Visio: $ErrorMessage"
}
#endregion