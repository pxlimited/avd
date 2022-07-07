# Software install Script
#
# Application to install: Navisworks Manage
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'Navisworks-Manage'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName


# Download Autodesk Navisworks Manage
Write-Host 'AIB Customisation: Downloading the Autodesk Navisworks Manage app'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/Navisworks-Manage-1.zip'
$downloadedFile = 'Navisworks-Manage-1.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the Autodesk Navisworks-Manage app finished'


# Autodesk Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # Autodesk Navisworks Manage Unzip
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




#region Install Navisworks Manage
try {

$proc =  Start-Process -filepath C:\temp\Navisworks-Manage-1\Setup.exe -PassThru -ErrorAction Stop -ArgumentList '--silent'
$proc.WaitForExit()
    if (Test-Path "C:\Program Files\Autodesk\Navisworks Manage 2023\roamer.exe") {
        Write-Host "Navisworks Manage has been installed"
    }
    else {
        write-Host "Error locating the Navisworks Manage executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-Host "Error installing Navisworks Manage: $ErrorMessage"
}
#endregion
