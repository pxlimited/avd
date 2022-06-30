# Software install Script
#
# Applications to install:
#
# Foxit Reader Enterprise Packaging (requires registration)
# https://kb.foxitsoftware.com/hc/en-us/articles/360040658811-Where-to-download-Foxit-Reader-with-Enterprise-Packaging-MSI-
# 
# Notepad++
# https://notepad-plus-plus.org/downloads/v7.8.8/
# See comments on creating a custom setting to disable auto update message
# https://community.notepad-plus-plus.org/post/38160



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

#region Sysprep Fix
# Fix for first login delays due to Windows Module Installer
try {
    ((Get-Content -path C:\DeprovisioningScript.ps1 -Raw) -replace 'Sysprep.exe /oobe /generalize /quiet /quit', 'Sysprep.exe /oobe /generalize /quit /mode:vm' ) | Set-Content -Path C:\DeprovisioningScript.ps1
    write-log "Sysprep Mode:VM fix applied"
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error updating script: $ErrorMessage"
}
#endregion

#region Time Zone Redirection
$Name = "fEnableTimeZoneRedirection"
$value = "1"
# Add Registry value
try {
    New-ItemProperty -ErrorAction Stop -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name $name -Value $value -PropertyType DWORD -Force
    if ((Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services").PSObject.Properties.Name -contains $name) {
        Write-log "Added time zone redirection registry key"
    }
    else {
        write-log "Error locating the Teams registry key"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error adding teams registry KEY: $ErrorMessage"
}
#endregion