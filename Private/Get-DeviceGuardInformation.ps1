# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
function Get-DeviceGuardInformation() {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "ComputerInfo Object for DeviceGuard Information,Position=0")]
        [Alias("ComputerInfoObject")]
        $computerInfo
    )
    $deviceGuard = $computerInfo | Select-Object DeviceGuard*
    $deviceGuard.DeviceGuardSmartStatus = "DeviceGuard is $($deviceGuard.DeviceGuardSmartStatus)"
    $deviceGuard.DeviceGuardAvailableSecurityProperties = New-HTMLList -ListContent $($deviceGuard.DeviceGuardAvailableSecurityProperties)
    $deviceGuard.DeviceGuardRequiredSecurityProperties = New-HTMLList -ListContent $($deviceGuard.DeviceGuardRequiredSecurityProperties)
    $deviceGuard.DeviceGuardSecurityServicesConfigured = New-HTMLList -ListContent $($deviceGuard.DeviceGuardSecurityServicesConfigured)
    $deviceGuard.DeviceGuardSecurityServicesRunning = New-HTMLList -ListContent $($deviceGuard.DeviceGuardSecurityServicesRunning)

    $deviceGuard
}