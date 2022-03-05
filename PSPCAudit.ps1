# ? implement classes with strategy pattern


# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
# TODO: Create Function with advanced parameters
function Get-HyperVInformation($computerInfo)
{
    #region HyperV
    $hyperV = $computerInfo | Select-Object HyperV*

    if ($hyperV.HyperVisorPresent) {
        $hyperV.HyperVisorPresent = "HyperVisor is detected"
    }
    else {
        $hyperV.HyperVisorPresent = "HyperVisor is  not detected"
        
    }
    if ($hyperV.HyperVRequirementDataExecutionPreventionAvailable) {
        $hyperV.HyperVRequirementDataExecutionPreventionAvailable = "Data Execution Prevention is available"
    }
    else {
        $hyperV.HyperVRequirementDataExecutionPreventionAvailable = "Data Execution Prevention is not available or unknown"
    }
    if ($hyperV.HyperVRequirementSecondLevelAddressTranslation) {
        $hyperV.HyperVRequirementSecondLevelAddressTranslation = "Second Level Address Translation is available"
    }
    else {
        $hyperV.HyperVRequirementSecondLevelAddressTranslation = "Second Level Address Translation is not available or unknown"
    }
    if ($hyperV.HyperVRequirementVirtualizationFirmwareEnabled) {
        $hyperV.HyperVRequirementVirtualizationFirmwareEnabled = "Virtualization is enabled by firmware"
    }
    else {
        $hyperV.HyperVRequirementVirtualizationFirmwareEnabled = "Virtualization is not enabled by firmware or is unknown"
    }
    if ($hyperV.HyperVRequirementVMMonitorModeExtensions) {
        $hyperV.HyperVRequirementVMMonitorModeExtensions = "The processor supports Intel or AMD Virtual Machine Monitor extensions"
    }
    else {
        $hyperV.HyperVRequirementVMMonitorModeExtensions = "The processor not supports Intel or AMD Virtual Machine Monitor extensions or the state is unknown"
    }
    #endregion HyperV
    $hyperV
}

# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
# TODO: Create Function with advanced parameters
function Get-BasicComputerInformation($computerInfo)
{
    #region Basic
    $basic=$computerInfo | Select-Object Windows*,TimeZone,LogonServer,PowerPlatformRole
    switch($basic.PowerPlatformRole)
    {
        "AppliancePC" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - The OEM specified an appliance PC role"}
        "Desktop" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - The OEM specified a desktop role"}
        "EnterpriseServer" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - The OEM specified an enterprise server role"}
        "MaximumEnumValue" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - Max enum value"}
        "Mobile" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - The OEM specified a mobile role (for example, a laptop)"}
        "PerformanceServer" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - The OEM specified a performance server role"}
        "Slate" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - The OEM specified a tablet form factor role"}
        "SOHOServer" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - The OEM specified a single office/home office (SOHO) server role"}
        "Unspecified" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - UnspecifieThe OEM did not specify a specific role"}
        "Workstation" { $basic.PowerPlatformRole="$($basic.PowerPlatformRole) - The OEM specified a workstation role"}
    }
    #endregion Basic
    $basic
}

# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
# TODO: Create Function with advanced parameters
function Get-BiosInformation($computerInfo)
{
    # TODO: $bios.BiosCharacteristics - list of values
    
    # TODO: $bios.BiosBIOSVersion - list of values
    # TODO: $bios.BiosListOfLanguages - list of values
    $bios=$computerInfo | Select-Object Bios*
    
    switch($bios.BiosFirmwareType)
    {
        "Bios"{$bios.BiosFirmwareType="$($bios.BiosFirmwareType) - The computer booted in legacy BIOS mode"}
        "Max"{$bios.BiosFirmwareType="$($bios.BiosFirmwareType) - Not implemented"}
        "Uefi"{$bios.BiosFirmwareType="$($bios.BiosFirmwareType) - The computer booted in UEFI mode"}
        "Unknown"{$bios.BiosFirmwareType="$($bios.BiosFirmwareType) - The firmware type is unknown"}
    }
    if ($bios.BiosPrimaryBIOS)
    {
        $bios.BiosPrimaryBIOS="Primary BIOS of computerSystem"
    }
    else 
    {
        $bios.BiosPrimaryBIOS = "Not primary BIOS of computerSystem"    
    }
    if($null -eq $bios.BiosSMBIOSMajorVersion)
    {
        $bios.BiosSMBIOSMajorVersion="SMBIOS Major Version not found"
    }
    if($null -eq $bios.BiosSMBIOSMinorVersion)
    {
        $bios.BiosSMBIOSMinorVersion="SMBIOS Minor Version not found"
    }
    if($bios.BiosSMBIOSPresent -eq $true)
    {
        $bios.BiosSMBIOSPresent="SMBIOS is available on this computer system"
    }
    
    $bios.BiosSoftwareElementState="$($bios.BiosSoftwareElementState) - Software element is $($bios.BiosSoftwareElementState)"

    #endregion BIOS

    $bios
}

# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
# TODO: Create Function with advanced parameters
function Get-ComputerSystemInformation($computerInfo)
{
    #region ComputerSystem

    # TODO: $computerSystem.CsBootStatus - list of values
    # TODO: $computerSystem.CsNetworkAdapters - list of values
    # TODO: $computerSystem.CsOEMStringArray - list of values
    # TODO: $computerSystem.CsPowerManagementCapabilities - list of values
    # TODO: $computerSystem.CsRoles - list of values
    # TODO: $computerSystem.CsSupportcontactDescription - list of values

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

    if ($computerSystem.CsNetworkServerModeEnabled) {
        $computerSystem.CsNetworkServerModeEnabled = "Server Mode is Enabled"
    }
    else {
        $computerSystem.CsNetworkServerModeEnabled = "Server Mode is Disabled"    
    }


    $computerSystem.CsNumberOfLogicalProcessors = "$($computerSystem.CsNumberOfLogicalProcessors) - Number of Processor threads enabled for system"
    $computerSystem.CsNumberOfProcessors = "$($computerSystem.CsNumberOfProcessors) - Number of Processors enabled for system"


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

    $computerSystem.CsSystemSKUNumber = "$($computerSystem.CsSystemSKUNumber) - identifies computer configuration  for sale. It is product ID or purcharse order number" 

    if ($computerSystem.CsThermalState -eq "Other") {
        $computerSystem.CsThermalState = "$($computerSystem.CsThermalState) - Element is in state other than provided in documentation"    
    }
    else {
        $computerSystem.CsThermalState = "$($computerSystem.CsThermalState) - Element is in $($computerSystem.CsThermalState) state"
    }
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

    #endregion ComputerSystem
    $computerSystem
}

# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
# TODO: Create Function with advanced parameters
function Get-DeviceGuardInformation($computerInfo)
{
    #region DeviceGuard

    #TODO: $deviceGuard.DeviceGuardRequiredSecurityProperties - list of values
    #TODO: $deviceGuard.DeviceGuardAvailableSecurityProperties - list of values
    #TODO: $deviceGuard.DeviceGuardSecurityServicesConfigured - list of values
    #TODO: $deviceGuard.DeviceGuardSecurityServicesRunning - list of values
    #TODO: $deviceGuard.DeviceGuardCodeIntegrityPolicyEnforcementStatus - list of values
    #TODO: $deviceGuard.DeviceGuardUserModeCodeIntegrityPolicyEnforcementStatus - list of values

    $deviceGuard = $computerInfo | Select-Object DeviceGuard*

    $deviceGuard.DeviceGuardSmartStatus = "DeviceGuard is $($deviceGuard.DeviceGuardSmartStatus)"

    $deviceGuard.DeviceGuardRequiredSecurityProperties
    $deviceGuard.DeviceGuardAvailableSecurityProperties
    $deviceGuard.DeviceGuardSecurityServicesConfigured
    $deviceGuard.DeviceGuardSecurityServicesRunning
    $deviceGuard.DeviceGuardCodeIntegrityPolicyEnforcementStatus
    $deviceGuard.DeviceGuardUserModeCodeIntegrityPolicyEnforcementStatus

    #endregion DeviceGuard

    $deviceGuard
}

# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
# TODO: Create Function with advanced parameters
# TODO: Not working in HTML Why?

function Get-OperatingSystemInformation($computerInfo)
{
    #region OperatingSystem
    
    # TODO: $operatingSystem.OsHotFixes="list of values"
    #! TODO: $operatingSystem.OsCountryCode="238 elements to translate code"
    # TODO: $operatingSystem.OsPagingFiles="list of values" 
    # TODO: $operatingSystem.OsMuiLanguages="list of values" 
    # TODO: $operatingSystem.OsProductSuites="list of values" 
    # TODO: $operatingSystem.OsSuites="list of values" 
    
    $operatingSystem = $computerInfo | Select-Object Os*

    switch ($operatingSystem.OsOperatingSystemSKU) {
        "0" { $operatingSystem.OsOperatingSystemSKU = "The SKU is undefined" }
        "1" { $operatingSystem.OsOperatingSystemSKU = "SKU is Ultimate Edition" }
        "2" { $operatingSystem.OsOperatingSystemSKU = "SKU is Home Basic Edition" }
        "3" { $operatingSystem.OsOperatingSystemSKU = "SKU is Home Premium Edition" }
        "4" { $operatingSystem.OsOperatingSystemSKU = "SKU is Enterprise Edition" }
        "5" { $operatingSystem.OsOperatingSystemSKU = "SKU is Home Basic N Edition" }
        "6" { $operatingSystem.OsOperatingSystemSKU = "SKU is Business Edition" }
        "7" { $operatingSystem.OsOperatingSystemSKU = "SKU is Standard Server Edition" }
        "8" { $operatingSystem.OsOperatingSystemSKU = "SKU is Datacenter Server Edition" }
        "9" { $operatingSystem.OsOperatingSystemSKU = "SKU is Small Business Server Edition" }
        "10" { $operatingSystem.OsOperatingSystemSKU = "SKU is Enterprise Server Edition" }
        "11" { $operatingSystem.OsOperatingSystemSKU = "SKU is Starter Edition" }
        "12" { $operatingSystem.OsOperatingSystemSKU = "SKU is Datacenter Server Core Edition" }
        "13" { $operatingSystem.OsOperatingSystemSKU = "SKU is Standard Server Core Edition" }
        "14" { $operatingSystem.OsOperatingSystemSKU = "SKU is Enterprise Server Core Edition" }
        "15" { $operatingSystem.OsOperatingSystemSKU = "SKU is Enterprise Server IA64 Edition" }
        "16" { $operatingSystem.OsOperatingSystemSKU = "SKU is Business N Edition" }
        "17" { $operatingSystem.OsOperatingSystemSKU = "SKU is Web Server Edition" }
        "18" { $operatingSystem.OsOperatingSystemSKU = "SKU is Cluster Server Edition" }
        "19" { $operatingSystem.OsOperatingSystemSKU = "SKU is Home Server Edition" }
        "20" { $operatingSystem.OsOperatingSystemSKU = "SKU is Storage Express Server Edition" }
        "21" { $operatingSystem.OsOperatingSystemSKU = "SKU is Storage Standard Server Edition" }
        "22" { $operatingSystem.OsOperatingSystemSKU = "SKU is Storage Workgroup Server Edition" }
        "23" { $operatingSystem.OsOperatingSystemSKU = "SKU is Storage Enterprise Server Edition" }
        "24" { $operatingSystem.OsOperatingSystemSKU = "SKU is Server For Small Business Edition" }
        "25" { $operatingSystem.OsOperatingSystemSKU = "SKU is Small Business Server Premium Edition" }
        "27" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Enterprise" }
        "28" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Ultimate" }
        "29" { $operatingSystem.OsOperatingSystemSKU = "SKU is Web Server (core installation)" }
        "33" { $operatingSystem.OsOperatingSystemSKU = "SKU is Server Foundation" }
        "34" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Home Server" }
        "36" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Standard without Hyper-V" }
        "37" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Datacenter without Hyper-V (full installation)" }
        "38" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Enterprise without Hyper-V (full installation)" }
        "39" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Datacenter without Hyper-V (core installation)" }
        "40" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Standard without Hyper-V (core installation)" }
        "41" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Enterprise without Hyper-V (core installation)" }
        "42" { $operatingSystem.OsOperatingSystemSKU = "SKU is Microsoft Hyper-V Server" }
        "43" { $operatingSystem.OsOperatingSystemSKU = "SKU is Storage Server Express (core installation)" }
        "44" { $operatingSystem.OsOperatingSystemSKU = "SKU is Storage Server Standard (core installation)" }
        "45" { $operatingSystem.OsOperatingSystemSKU = "SKU is Storage Server Workgroup (core installation)" }
        "46" { $operatingSystem.OsOperatingSystemSKU = "SKU is Storage Server Enterprise (core installation)" }
        "48" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Professional" }
        "50" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Essentials (Desktop Experience installation)" }
        "63" { $operatingSystem.OsOperatingSystemSKU = "SKU is Small Business Server Premium (core installation)" }
        "64" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Hyper Core V" }
        "87" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Thin PC" }
        "89" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Embedded Industry" }
        "97" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows RT" }
        "101" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Home" }
        "103" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Professional with Media Center" }
        "104" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Mobile" }
        "118" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Embedded Handheld" }
        "123" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows IoT (Internet of Things) Core" }
        "143" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Datacenter Edition (Nano Server installation)" }
        "144" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Standard Edition (Nano Server installation)" }
        "147" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Datacenter Edition (Server Core installation)" }
        "148" { $operatingSystem.OsOperatingSystemSKU = "SKU is Windows Server Standard Edition (Server Core installation)" }
    }
    if ($null -eq $operatingSystem.OsCSDVersion) {
        $operatingSystem.OsCSDVersion = "No service Pack Installed."
    }
    $operatingSystem.OsCountryCode = "$($operatingSystem.OsCountryCode) - country code based on international prefixes"

    $operatingSystem.OsCurrentTimeZone = "$($($operatingSystem.OsCurrentTimeZone)/60) h from London Time"
    
    $operatingSystem.OsLocaleID = "$($operatingSystem.OsCountryCode) - country code based on international prefixes"
    $operatingSystem.OsLocale = "$($operatingSystem.OsLocale) - culture name derived from OsLocaleID"
    $operatingSystem.OsCodeSet = "$($operatingSystem.OsCodeSet) - Code page operating system uses"

    switch ($operatingSystem.OsDataExecutionPreventionSupportPolicy) {
        "AlwaysOff" { $operatingSystem.OsDataExecutionPreventionSupportPolicy = "DEP is turned off for all 32-bit applications on the computer with no exceptions" }
        "AlwaysOn" { $operatingSystem.OsDataExecutionPreventionSupportPolicy = "DEP is enabled for all 32-bit applications on the computer" }
        "OptIn" { $operatingSystem.OsDataExecutionPreventionSupportPolicy = "DEP is enabled for a limited number of binaries, the kernel, and all Windows-based services. However, it is off by default for all 32-bit applications. A user or administrator must explicitly choose either the Always On or the Opt Out setting before DEP can be applied to 32-bit applications" }
        "OptOff" { $operatingSystem.OsDataExecutionPreventionSupportPolicy = "DEP is enabled by default for all 32-bit applications. A user or administrator can explicitly remove support for a 32-bit application by adding the application to an exceptions list" }
    }
    if ($operatingSystem.OsDebug) {
        $operatingSystem.OsDebug = "The computer is debug build"
    }
    else {
        $operatingSystem.OsDebug = "The computer is not debug build"
    }
    if ($operatingSystem.OsDistributed) {
        $operatingSystem.OsDistributed = "Computer works as cluster node"
    }
    else {
        $operatingSystem.OsDistributed = "Computer works single workstation"
    }

    $operatingSystem.OsEncryptionLevel = "$($operatingSystem.OsEncryptionLevel) bit - level of operating system encryption"

    switch ($operatingSystem.OsForegroundApplicationBoost) {
        "Maximum" { $operatingSystem.OsForegroundApplicationBoost = "$($operatingSystem.OsForegroundApplicationBoost) - system boosts the quantum length by 18 for foreground application" }
        "Minimum" { $operatingSystem.OsForegroundApplicationBoost = "$($operatingSystem.OsForegroundApplicationBoost) - system boosts the quantum length by 12 for foreground application" }
        "None" { $operatingSystem.OsForegroundApplicationBoost = "$($operatingSystem.OsForegroundApplicationBoost) - system boosts the quantum length by 6 for foreground application" }
    }
    
    $operatingSystem.OsTotalVisibleMemorySize = "$($($operatingSystem.OsTotalVisibleMemorySize)/1GB) GB - Total amount, in kilobytes, of physical memory available to the operating system. This value does not necessarily indicate the true amount of physical memory, but what is reported to the operating system as available to it."
    
    $operatingSystem.OsFreePhysicalMemory = "$($($operatingSystem.OsFreePhysicalMemory)/1GB) GB - Number, in kilobytes, of physical memory currently unused and available."
    
    $operatingSystem.OsTotalVirtualMemorySize = "$($($operatingSystem.OsTotalVirtualMemorySize)/1GB) GB - Number, in kilobytes, of virtual memory. For example, this may be calculated by adding the amount of total RAM to the amount of paging space, that is, adding the amount of memory in or aggregated by the computer system to the property, SizeStoredInPagingFiles."

    $operatingSystem.OsFreeVirtualMemory = "$($($operatingSystem.OsFreeVirtualMemorySize)/1GB) GB - Number, in kilobytes, of virtual memory currently unused and available."

    $operatingSystem.OsInUseVirtualMemory = "$($($operatingSystem.OsInUseVirtualMemory)/1GB) GB"

    if ($null -ne $operatingSystem.OsTotalSwapSpaceSize) {
        $operatingSystem.OsTotalSwapSpaceSize = "$($($operatingSystem.OsTotalSwapSpaceSize)/1GB) GB - total swap size"
    }
    else {
        $operatingSystem.OsTotalSwapSpaceSize = "The swap space is not distinguished from page files."
    }
    
    if ($operatingSystem.OsSizeStoredInPagingFiles -eq 0) {
        $operatingSystem.OsSizeStoredInPagingFiles = "There are no paging files"
    }
    else {
        $operatingSystem.OsSizeStoredInPagingFiles = "$($operatingSystem.OsSizeStoredInPagingFiles) KB paging file"
    }

    $operatingSystem.OsFreeSpaceInPagingFiles = "$($operatingSystem.OsFreeSpaceInPagingFiles) KB - Number, in kilobytes, that can be mapped into the operating system paging files without causing any other pages to be swapped out"
    
    # TODO: $operatingSystem.OsPagingFiles = "$($operatingSystem.OsPagingFiles)  array of field paths to the operating system paging files - list of values"
    
    $operatingSystem.OsHardwareAbstractionLayer = " $($operatingSystem.OsHardwareAbstractionLayer) - version of the operating system Hardware Abstraction Layer (HAL)"
    
    $operatingSystem.OsMaxNumberOfProcesses = "$($operatingSystem.OsMaxNumberOfProcesses) maximum number of process contexts the operating system can support"
    
    $operatingSystem.OsMaxProcessMemorySize = "$($operatingSystem.OsMaxProcessMemorySize) maximum number of kilobytes of memory that can be allocated to a process"
    
    # TODO: $operatingSystem.OsMuiLanguages = "$($operatingSystem.OsMuiLanguages) array of languages installed on computer - list of values"
    
    $operatingSystem.OsNumberOfProcesses = "$($operatingSystem.OsNumberOfProcesses) - Number of process contexts currently loaded or running on the operating system"
    
    $operatingSystem.OsNumberOfUsers = "$($operatingSystem.OsNumberOfUsers) - Number of user sessions for which the operating system is storing state information currently"
    
    # TODO: $operatingSystem.OsProductSuites="list of values"

    if ($operatingSystem.OsPAEEnabled) {
        $operatingSystem.OsPAEEnabled = "Physical Address extension are enabled by operating system on Intel processors"
    }
    else {
        $operatingSystem.OsPAEEnabled = "Physical Address extension are disabled by operating system on Intel processors"
    }

    if ($operatingSystem.OsPortableOperatingSystem) {
        $operatingSystem.OsPortableOperatingSystem = "System is booted from external device"
    }
    else {
        $operatingSystem.OsPortableOperatingSystem = "System is booted from local disk"
    }
    if ($operatingSystem.OsPrimary) {
        $operatingSystem.OsPrimary = "This system is primary OS."
    }
    else {
        $operatingSystem.OsPrimary = "This system is not primary OS."
    }
    
    #endregion OperatingSystem

    $operatingSystem
}

function Get-BasicComputerInfo
{
    $computerInfo=Get-ComputerInfo
    
    #region Basic
    #region Basic
    
    #region BIOS
    #endregion BIOS

    #region ComputerSystem
    #endregion ComputerSystem

    #region OperatingSystem
    #endregion OperatingSystem
    
    #region HyperV
    #endregion HyperV
    
    #region DeviceGuard
    #endregion DeviceGuard

    $basicInformation = [PSCustomObject]@{
        BasicInformation = Get-BasicComputerInformation($computerInfo)
        Bios             = Get-BiosInformation($computerInfo)
        ComputerSystem   = Get-ComputerSystemInformation($computerInfo)
        OperatingSystem  = Get-OperatingSystemInformation($computerInfo)
        HyperV           = Get-HyperVInformation($computerInfo)
        DeviceGuard      = Get-DeviceGuardInformation($computerInfo)
    }
    $basicInformation
}

# TODO
function Get-HardwareInfo
{
    $hardwareInformation = [PSCustomObject]@{
        Controller1394 = Get-1394Controller
        BaseBoard = Get-BaseBoard
        Battery = Get-Battery
        Bios             = Get-BIOS
        Bus = Get-Bus
        CacheMemory = Get-CacheMemory
        CDROM = Get-CDROMDrive
        CompactDisc = Get-CompactDisc
        Desktop = Get-Desktop
        DesktopMonitor = Get-DesktopMonitor
        DiskDrive = Get-DiskDrive
        DiskPartition = Get-DiskPartition
        Fan=Get-Fan
        Glide = Get-GlidePoint
        HeatPipe = Get-HeatPipe
        IDE=Get-IDEController
        InfraredDevice=Get-InfraredDevice
        Keyboard = Get-Keyboard
        LocalDisk=Get-LocalDisk
        LogicalDisk=Get-LogicalDisk
        MemoryArray=Get-MemoryArray
        MemoryDevice=Get-MemoryDevice
        MotherBoardDevice=Get-MotherboardDevice
        Mouse=Get-Mouse
        NetworkAdapter=Get-NetworkAdapterSysInfo
        NetworkAdapterConfiguration=Get-NetworkAdapterConfiguration
        NetworkDrive=Get-NetworkDrive
        OperatingSystem=Get-OperatingSystem
        OpticalSensor=Get-OpticalSensor
        PhysicalMemory=Get-PhysicalMemory
        PhysicalMemoryArray=Get-PhysicalMemoryArray
        PointingDevice=Get-PointingDevice
        PortableBattery=Get-PortableBattery
        PrinterConfiguration=Get-PrinterConfiguration
        Processor=Get-Processor
        RAMDisk=Get-RAMDisk
        Refrigeration=Get-Refrigeration
        RemovableDisk=Get-RemovableDisk
        SCSIController=Get-SCSIControllerSysInfo
        SoundDevice=Get-SoundDevice
        SystemEnclousure=Get-SystemEnclosure
        TapeDrive=Get-TapeDrive
        TemperatureProbe=Get-TemperatureProbe
        TouchPad=Get-TouchPad
        TouchScreen=Get-TouchScreen
        TrackBall=Get-TrackBall
        TrackPoint=Get-TrackPoint
        USBController=Get-USBController
        VideoController=Get-VideoController
        VoltageProbe=Get-VoltageProbe
    }
    $hardwareInformation
}
# TODO
function Get-MotherBoard
{
Get-CimInstance Win32_BaseBoard | Select-Object * -ExcludeProperty CreationClassName,PSComputerName,Cim*

}

#region HTMLStructures

# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: creating table in HTML language
# @OUT: HTML code with @IN information
function New-HTMLTable()
{
    [CmdletBinding()]
    param (
    [Parameter(HelpMessage="Table content,Position=0")]
    [Alias("TableContent","TC")]
    $content
    )

    $output="<table><tr><td>KEY</td><td>VALUE</td></tr>"
    $content.PSObject.Properties | ForEach-Object { 
        $output += "<tr><td>$($_.Name)</td><td>$($_.Value)</td></tr>"
    }
    $output += "</table>"
    return $output
}


# TEST
function New-HTMLList() 
{
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "List Content,Position=0")]
        [Alias("ListContent", "LC")]
        $content
    )

    $output = "<ul class='w3-ul w3-small'>"
    $content | ForEach-Object {
        $output += "<li>$($_)</li>"
    }
    $output += "</ul>"
    return $output
}
#New-HTMLList -ListContent $(Get-ComputerInfo).BiosCharacteristics

#endregion HTMLStructures

#region HTMLDeclarations
$HTMLBody1 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).BasicInformation)
$HTMLBody2 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).Bios)
$HTMLBody3 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).ComputerSystem)
$HTMLBody4 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).OperatingSystem)
$HTMLBody5 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).HyperV)
$HTMLBody6 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).DeviceGuard)

$HTMLBody7 = New-HTMLTable -TableContent $(Get-MotherBoard)
############################################################################################################
function New-JSScript()
{
$script=@"
    <script>
    function changeContent(content) 
    {
        document.getElementById('lama').innerHTML = content;
    }
    function myAccFunc() 
    {
        var x = document.getElementById("demoAcc");
        if (x.className.indexOf("w3-show") == -1) 
        {
            x.className += " w3-show";
            x.previousElementSibling.className += " w3-green";
        } 
        else 
        {
            x.className = x.className.replace(" w3-show", "");
            x.previousElementSibling.className =
            x.previousElementSibling.className.replace(" w3-green", "");
        }
    }
        </script>
"@
return $script
}

function New-HTMLHead()
{
$head=@"
    <head>
        <title>W3.CSS</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
"@
return $head
}


function New-HTMLBody()
{
$report=@"
<!DOCTYPE html>
<html>
$(New-HTMLHead)
<body>
    <div class="w3-sidebar w3-bar-block w3-light-grey w3-card" style="width:160px;">
        <a href="#" class="w3-bar-item w3-button">Link 1</a>
        
        <div class="w3-bar-item w3-button" onclick="myAccFunc()">
            Accordion <i class="fa fa-caret-down"></i>
        </div>
        
        <div id="demoAcc" class="w3-hide w3-white w3-card-4">
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody1')">BasicInformation</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody2')">Bios</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody3')">ComputerSystem</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody4')">OperatingSystem</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody5')">HyperV</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody6')">DeviceGuard</a>
        </div>
        
        <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody7')">MotherBoard</a>
        
        <a class="w3-bar-item w3-button" >Link 3</a>
        
    </div>
    
    <div class="w3-container" id="lama" style="margin-left:160px">
    adsdsa
    </div>
$(New-JSScript)
</body>
</html>
"@

return $report
}
New-HTMLBody | Out-File "H:\test.html"