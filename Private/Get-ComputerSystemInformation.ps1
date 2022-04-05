# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
function Get-ComputerSystemInformation() {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "ComputerInfo Object for ComputerSystem Information,Position=0")]
        [Alias("ComputerInfoObject")]
        $computerInfo
    )

    $computerSystem = $computerInfo | Select-Object Cs*
    
    $computerSystem.CsAdminPasswordStatus = "$($computerSystem.CsAdminPasswordStatus) - Hardware security is $($computerSystem.CsAdminPasswordStatus)"

    if ($computerSystem.CsAutomaticManagedPagefile) {
        $computerSystem.CsAutomaticManagedPagefile = "System manages the pagefile.sys file"
    }
    else {
        $computerSystem.CsAutomaticManagedPagefile = "System is not managing the pagefile.sys file"
    }

    if ($computerSystem.CsAutomaticResetBootOption) {
        $computerSystem.CsAutomaticResetBootOption = "Automatic reset boot option is enabled"
    }
    else {
        $computerSystem.CsAutomaticResetBootOption = "Automatic reset boot option is disabled"
    }

    if ($computerSystem.CsAutomaticResetCapability) {
        $computerSystem.CsAutomaticResetCapability = "Automatic reset is enabled"
    }
    else {
        $computerSystem.CsAutomaticResetCapability = "Automatic reset is disabled"
    }
    
    switch ($computerSystem.CsBootOptionOnLimit) {
        "DoNotReboot" { $computerSystem.CsBootOptionOnLimit = "$($computerSystem.CsBootOptionOnLimit) - do not reboot" }
        "OperatingSystem" { $computerSystem.CsBootOptionOnLimit = "$($computerSystem.CsBootOptionOnLimit) - Boot into operating system" }
        "SystemUtilities" { $computerSystem.CsBootOptionOnLimit = "$($computerSystem.CsBootOptionOnLimit) - Boot into system utilites" }
        default { $computerSystem.CsBootOptionOnLimit = "No information" }
    }
    
    switch ($computerSystem.CsBootOptionOnWatchdog) {
        "DoNotReboot" { $computerSystem.CsBootOptionOnWatchdog = "$($computerSystem.CsBootOptionOnWatchdog) - do not reboot" }
        "OperatingSystem" { $computerSystem.CsBootOptionOnWatchdog = "$($computerSystem.CsBootOptionOnWatchdog) - Boot into operating system" }
        "SystemUtilities" { $computerSystem.CsBootOptionOnWatchdog = "$($computerSystem.CsBootOptionOnWatchdog) - Boot into system utilites" }
        default { $computerSystem.CsBootOptionOnWatchdog = "No information" }
    }

    if ($computerSystem.CsBootROMSupported) {
        $computerSystem.CsBootROMSupported = "Boot ROM is supported"
    }
    else {
        $computerSystem.CsBootROMSupported = "Boot ROM is not supported"
    }
    $computerSystem.CsBootStatus = New-HTMLList -ListContent $($computerSystem.CsBootStatus)

    if ($computerSystem.CsChassisBootupState -like "Other") {
        $computerSystem.CsChassisBootupState = "$($computerSystem.CsChassisBootupState) - The element is something other than in documentation" 
    }
    else {
        $computerSystem.CsChassisBootupState = "$($computerSystem.CsChassisBootupState) - The element is in $($computerSystem.CsChassisBootupState) state" 
    }
    
    if ($null -ne $computerSystem.CsCurrentTimeZone) {
        $calc = $computerSystem.CsCurrentTimeZone / 60
        $computerSystem.CsCurrentTimeZone = "$calc h is from London time"
    }

    if ($computerSystem.CsDaylightInEffect) {
        $computerSystem.CsDaylightInEffect = "Daylight saving mode is ON"
    }
    else {
        $computerSystem.CsDaylightInEffect = "Daylight saving mode is OFF"
    }

    switch ($computerSystem.CsDomainRole) {
        "BackupDomainController" { $computerSystem.CsDomainRole = "Computer is Backup Domain Controller" }
        "MemberServer" { $computerSystem.CsDomainRole = "Computer is Member Server of Domain" }
        "MemberWorkstation" { $computerSystem.CsDomainRole = "Computer is Member Workstation of Domain" }
        "PrimaryDomainController" { $computerSystem.CsDomainRole = "Computer is Primary Domain Controller" }
        "StandaloneServer" { $computerSystem.CsDomainRole = "Computer is Standalone Server" }
        "StandaloneWorkstation" { $computerSystem.CsDomainRole = "Computer is Standalone Workstation" }
    }
    switch ($computerSystem.CsEnableDaylightSavingsTime) {
        "True" { $computerSystem.CsEnableDaylightSavingsTime = "Daylight saving time is enabled.System time is change 1 hour forward or backward when daylight saving time is started or ended." }
        "False" { $computerSystem.CsEnableDaylightSavingsTime = "Daylight saving time is disabled." }
        "" { $computerSystem.CsEnableDaylightSavingsTime = "State of daylight saving time is unknown" }
    }
    
    $computerSystem.CsFrontPanelResetStatus = "Hardware security setting for the reset button on front Panel is $($computerSystem.CsFrontPanelResetStatus)"

    $computerSystem.CsKeyboardPasswordStatus = "Hardware security setting for keyboard password status is $($computerSystem.CsKeyboardPasswordStatus)"

    $computerSystem.CsNetworkAdapters = New-HTMLList -ListContent $($computerSystem.CsNetworkAdapters) # Object

    if ($computerSystem.CsNetworkServerModeEnabled) {
        $computerSystem.CsNetworkServerModeEnabled = "Server Mode is Enabled"
    }
    else {
        $computerSystem.CsNetworkServerModeEnabled = "Server Mode is Disabled"    
    }

    $computerSystem.CsNumberOfLogicalProcessors = "$($computerSystem.CsNumberOfLogicalProcessors) - Number of Processor threads enabled for system"
    $computerSystem.CsNumberOfProcessors = "$($computerSystem.CsNumberOfProcessors) - Number of Processors enabled for system"
    $computerSystem.CsProcessors = New-HTMLList -ListContent $($computerSystem.CsProcessors)
    $computerSystem.CsOEMStringArray = New-HTMLList -ListContent $($computerSystem.CsOEMStringArray)
    

    if ($computerSystem.CsPauseAfterReset -eq -1) {
        $computerSystem.CsPauseAfterReset = "Time Delay before reboot is initaited value is unknown"
    }
    else {
        $calc = $computerSystem.CsPauseAfterReset / 1000
        $computerSystem.CsPauseAfterReset = "$calc seconds before reboot is initaited"
    }

    switch ($computerSystem.CsPCSystemType) {
        "AppliancePC" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - The OEM specified an appliance PC role" }
        "Desktop" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - The OEM specified a desktop role" }
        "EnterpriseServer" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - The OEM specified an enterprise server role" }
        "MaximumEnumValue" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - Max enum value" }
        "Mobile" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - The OEM specified a mobile role (for example, a laptop)" }
        "PerformanceServer" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - The OEM specified a performance server role" }
        "Slate" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - The OEM specified a tablet form factor role" }
        "SOHOServer" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - The OEM specified a single office/home office (SOHO) server role" }
        "Unspecified" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - UnspecifieThe OEM did not specify a specific role" }
        "Workstation" { $computerSystem.CsPCSystemType = "$($computerSystem.CsPCSystemType) - The OEM specified a workstation role" }
    }

    switch ($computerSystem.CsPCSystemTypeEx) {
        "AppliancePC" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - The OEM specified an appliance PC role" }
        "Desktop" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - The OEM specified a desktop role" }
        "EnterpriseServer" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - The OEM specified an enterprise server role" }
        "MaximumEnumValue" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - Max enum value" }
        "Mobile" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - The OEM specified a mobile role (for example, a laptop)" }
        "PerformanceServer" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - The OEM specified a performance server role" }
        "Slate" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - The OEM specified a tablet form factor role" }
        "SOHOServer" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - The OEM specified a single office/home office (SOHO) server role" }
        "Unspecified" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - UnspecifieThe OEM did not specify a specific role" }
        "Workstation" { $computerSystem.CsPCSystemTypeEx = "$($computerSystem.CsPCSystemTypeEx) - The OEM specified a workstation role" }
    }
    $computerSystem.CsPowerManagementCapabilities = New-HTMLList -ListContent $($computerSystem.CsPowerManagementCapabilities)
    if ($computerSystem.CsPowerManagementSupported) {
        $computerSystem.CsPowerManagementSupported = "Device can be power managed. Property does not indicate that power management features are not enabled currently, but it indicates that the device is capable of power management."       
    }
    else {
        $computerSystem.CsPowerManagementSupported = "Device cannot be power managed."   
    }

    $computerSystem.CsPowerOnPasswordStatus = "$($computerSystem.CsPowerOnPasswordStatus) - Hardware security setting for PowerOn Password Status is $($computerSystem.CsPowerOnPasswordStatus)"

    $computerSystem.CsPowerState = "$($computerSystem.CsPowerState) - Current power state of computer is  $($computerSystem.CsPowerState)"
    if ($computerSystem.CsPowerSupplyState -eq "Other") {
        $computerSystem.CsPowerSupplyState = "$($computerSystem.CsPowerSupplyState) - Element is in state not provided in documentation"  
    }
    else {
        $computerSystem.CsPowerSupplyState = "$($computerSystem.CsPowerSupplyState) - Current power supply state is in $($computerSystem.CsPowerSupplyState) state"
    }
    if ($computerSystem.CsResetCapability -eq "Other") {
        $computerSystem.CsResetCapability = "$($computerSystem.CsResetCapability) - indicates that the computer system can be reset. Capability value is other than provided in documentation."
    }
    else {
        $computerSystem.CsResetCapability = "$($computerSystem.CsResetCapability) - indicates that the computer system can be reset. Capability is $($computerSystem.CsResetCapability)"
    }
    if ($computerSystem.CsResetCount -eq -1) {
        $computerSystem.CsResetCount = "The value of automatic reset since last reset is unknown."        
    }
    else {
        $computerSystem.CsResetCount = "The value of automatic reset since last reset is $($computerSystem.CsResetCount)."
    }
    if ($computerSystem.CsResetLimit -eq -1) {
        $computerSystem.CsResetLimit = "Number of consecutive times a system reset is attempted. The value is uknonwn."        
    }
    else {
        $computerSystem.CsResetLimit = "Number of consecutive times a system reset is attempted. The value is $($computerSystem.CsResetLimit)" 
    }
    $computerSystem.CsRoles = New-HTMLList -ListContent $($computerSystem.CsRoles)

    $computerSystem.CsSystemSKUNumber = "$($computerSystem.CsSystemSKUNumber) - identifies computer configuration  for sale. It is product ID or purcharse order number" 
    
    if ($computerSystem.CsThermalState -eq "Other") {
        $computerSystem.CsThermalState = "$($computerSystem.CsThermalState) - Element is in state other than provided in documentation"    
    }
    else {
        $computerSystem.CsThermalState = "$($computerSystem.CsThermalState) - Element is in $($computerSystem.CsThermalState) state"
    }
    $computerSystem.CsSupportcontactDescription = New-HTMLList -ListContent $($computerSystem.CsSupportcontactDescription)
    $computerSystem.CsTotalPhysicalMemory = "$($($computerSystem.CsTotalPhysicalMemory)/1GB)GB - it is physically installed memory without memory used by system"
    $computerSystem.CsPhysicallyInstalledMemory = "$($($computerSystem.CsPhyicallyInstalledMemory)/1MB) GB"

    switch ($computerSystem.CsWakeUpType) {
        "ACPowerRestored" { $computerSystem.CsWakeUpType = "ACPower was restored" }
        "APMTimer" { $computerSystem.CsWakeUpType = "Event is APM timer" }
        "LANRemote" { $computerSystem.CsWakeUpType = "Event is a LAN Remove" }
        "ModemRing" { $computerSystem.CsWakeUpType = "Event is Modem Ring" }
        "Other" { $computerSystem.CsWakeUpType = "An event is other then specified in documentation" }
        "PCIPME" { $computerSystem.CsWakeUpType = "Event is a PCI PME# signal" }
        "PowerSwitch" { $computerSystem.CsWakeUpType = "Event is a power switch" }
        "Unknown" { $computerSystem.CsWakeUpType = "Event type is unknown" }
    }

    $computerSystem
}