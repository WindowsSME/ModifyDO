#DOmode.ps1
#Author : James Romeo Gaspar
#Revision 1.0

function DisableDeliveryOptimization {
    if (Test-Path $DODownloadModePath1) {
        $registryKey1 = Get-ItemProperty -Path $DODownloadModePath1 -Name $ValueName -ErrorAction SilentlyContinue
        if ($registryKey1 -ne $null) {
            Set-ItemProperty -Path $DODownloadModePath1 -Name $ValueName -Value 0 -Force
            Write-Output "Delivery Optimization is now disabled for '$DODownloadModePath1'."
        }
        else {
            Write-Output "Registry value '$ValueName' does not exist in '$DODownloadModePath1'. DODownloadMode value not set."
        }
    }
    else {
        Write-Output "Registry path '$DODownloadModePath1' does not exist. DODownloadMode value not set."
    }

    if (Test-Path $DODownloadModePath2) {
        $registryKey2 = Get-ItemProperty -Path $DODownloadModePath2 -Name $ValueName -ErrorAction SilentlyContinue
        if ($registryKey2 -ne $null) {
            Set-ItemProperty -Path $DODownloadModePath2 -Name $ValueName -Value 0 -Force
            Write-Output "Delivery Optimization is now disabled for '$DODownloadModePath2'."
        }
        else {
            Write-Output "Registry value '$ValueName' does not exist in '$DODownloadModePath2'. DODownloadMode value not set."
        }
    }
    else {
        Write-Output "Registry path '$DODownloadModePath2' does not exist. DODownloadMode value not set."
    }
}

function EnableDeliveryOptimization {
    if (Test-Path $DODownloadModePath1) {
        $registryKey1 = Get-ItemProperty -Path $DODownloadModePath1 -Name $ValueName -ErrorAction SilentlyContinue
        if ($registryKey1 -ne $null) {
            Set-ItemProperty -Path $DODownloadModePath1 -Name $ValueName -Value 2 -Force
            Write-Output "Delivery Optimization is now enabled for '$DODownloadModePath1'."
        }
        else {
            Write-Output "Registry value '$ValueName' does not exist in '$DODownloadModePath1'. DODownloadMode value not set."
        }
    }
    else {
        Write-Output "Registry path '$DODownloadModePath1' does not exist. DODownloadMode value not set."
    }

    if (Test-Path $DODownloadModePath2) {
        $registryKey2 = Get-ItemProperty -Path $DODownloadModePath2 -Name $ValueName -ErrorAction SilentlyContinue
        if ($registryKey2 -ne $null) {
            Set-ItemProperty -Path $DODownloadModePath2 -Name $ValueName -Value 2 -Force
            Write-Output "Delivery Optimization is now enabled for '$DODownloadModePath2'."
        }
        else {
            Write-Output "Registry value '$ValueName' does not exist in '$DODownloadModePath2'. DODownloadMode value not set."
        }
    }
    else {
        Write-Output "Registry path '$DODownloadModePath2' does not exist. DODownloadMode value not set."
    }
}

$choices = @(
    "[1] Disable Delivery Optimization",
    "[2] Enable Delivery Optimization",
    "[0] Exit"
)

$choice = Read-Host "Select an option:`n$($choices -join "`n")"

$DODownloadModePath1 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization"
$DODownloadModePath2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeliveryOptimization"
$ValueName = "DODownloadMode"

switch ($choice) {
    "1" {
        DisableDeliveryOptimization
    }
    "2" {
        EnableDeliveryOptimization
    }
    "3" {
        Write-Output "Exiting..."
        return
    }
    default {
        Write-Output "Invalid choice. Exiting..."
    }
}

foreach ($path in $paths) {
    CheckRegistryValue -Path $path -ValueName $ValueName
}

$currentDownloadMode = (Get-DeliveryOptimizationPerfSnap).DownloadMode
Write-Output "Current DownloadMode: $currentDownloadMode"

function CheckRegistryValue {
    param (
        [string]$Path,
        [string]$ValueName
    )

    if (Test-Path $Path) {
        $registryKey = Get-ItemProperty -Path $Path -Name $ValueName -ErrorAction SilentlyContinue
        if ($registryKey -ne $null) {
            Write-Output "Registry value '$ValueName' exists in '$Path': $($registryKey.$ValueName)"
        }
        else {
            Write-Output "Registry value '$ValueName' does not exist in '$Path'"
        }
    }
    else {
        Write-Output "Registry path '$Path' does not exist"
    }
}
