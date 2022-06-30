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
