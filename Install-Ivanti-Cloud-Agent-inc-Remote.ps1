# Software install Script
#
# Application to install: Ivanti Neurons Agent
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion


# Setup of the required environment variables
$appName = 'Ivanti Neurons Agent'
$tempDirectory = 'C:\Temp\'
New-Item `
    -Path $tempDirectory `
    -Name $appName `
    -ItemType Directory `
    -ErrorAction SilentlyContinue
$LocalPath = $tempDirectory + $appName

# Update Ivanti Neurons Agent
Write-Host 'AIB Customisation: Downloading the Ivanti Neurons Agent app'
$webSocketsURL = 'https://avdsoftwarestorage.blob.core.windows.net/softwareresource/IvantiCloudAgent.zip'
$downloadedFile = 'Ivanti Neurons Agent.zip'
$outputPath = $LocalPath + '\' + $downloadedFile
(New-Object System.Net.WebClient).DownloadFile("$webSocketsURL","$outputPath")
Write-Host 'AIB Customisation: Downloading of the Ivanti Neurons Agent app finished'


# Ivanti Neurons Agent Unzip Parameters & Variables
$ExpandArchiveParameters = @{
    Path = $outputPath
    DestinationPath = $tempDirectory
    Force = $true
    Verbose = $true
    ErrorAction = "Stop"
    ErrorVariable = "lastError"
}

    # Ivanti Neurons Agent Unzip
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



#region Ivanti Neurons Agent
try {
    Start-Process -filepath 'C:\temp\IvantiCloudAgent.exe' -Wait -ErrorAction Stop -ArgumentList '--tenantid 8adc83c0-a397-4e7d-b103-f488ddc1d041 --activationkey uv1GMhTRtGsMuhwXleUrO8OmlLcv36Z8qDut0nbS8xPzUNHhfFXk83SpqZCinLpa6f8GZDwhKU5mhyARayGz4wnQyQql6Zw26KD16XBUc9KVhH7bsbFWVGQjALd5QUc9 --cloudhost https://agentreg.ivanticloud.com --mode unattended'
    if (Test-Path "C:\Program Files\Ivanti Neurons Agent\CSFalconService.exe") {
        Write-Host "Ivanti Neurons Agent has been installed"
    }
    else {
        write-Host "Error locating the Ivanti Neurons Agent executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-Host "Error installing Ivanti Neurons Agent: $ErrorMessage"
}
#endregion