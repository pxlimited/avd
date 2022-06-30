# Software install Script
#
# Application to install: Adobe Acrobat Reader DC
#

#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion

#region Adobe Acrobat Reader
try {
    Start-Process -filepath 'C:\temp\AcroRdrDC2200120142_en_US.exe' -Wait -ErrorAction Stop -ArgumentList '/sAll', '/rs', '/msi', 'EULA_ACCEPT=YES'
    if (Test-Path "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRD32.exe") {
        Write-Log "Acrobat Reader has been installed"
    }
    else {
        write-log "Error locating the Acrobat Reader executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Acrobat Reader: $ErrorMessage"
}
#endregion