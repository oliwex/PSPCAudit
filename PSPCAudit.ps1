# ? implement classes with strategy pattern
# ? try to rewrite css rules by own css rules
# auditpol /get /category:*

###########################################

#region HTMLFunctions

# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: creating list in HTML language
# @OUT: HTML code with @IN information
function New-HTMLList() {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "List Content,Position=0")]
        [Alias("ListContent", "LC")]
        $content
    )

    $output = "<ul class=`&quot w3-ul `&quot>"
    $content | ForEach-Object {
        $output += "<li>$($_)</li>"
    }
    $output += "</ul>"
    return $output
}

# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: creating table in HTML language
# @OUT: HTML code with @IN information
function New-HTMLTable() {

    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "Table content,Position=0")]
        [Alias("TableContent", "TC")]
        $content
    )
    $output = "<table class=`&quot w3-table-all w3-bordered w3-striped w3-border w3-hoverable `&quot><tr class=w3-green><td>KEY</td><td>VALUE</td></tr>"
    $content.PSObject.Properties | ForEach-Object { 
        $output += "<tr><td>$($_.Name)</td><td>$($_.Value)</td></tr>"
    }
    $output += "</table>"
    return $output
}

#endregion HTMLFunctions
# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
function Get-HyperVInformation() {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "ComputerInfo Object for HyperV Information,Position=0")]
        [Alias("ComputerInfoObject")]
        $computerInfo
    )
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
function Get-BasicComputerInformation() {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "ComputerInfo Object for Basic Computer Information,Position=0")]
        [Alias("ComputerInfoObject")]
        $computerInfo
    )
    #region Basic
    $basic = $computerInfo | Select-Object Windows*, TimeZone, LogonServer, PowerPlatformRole
    switch ($basic.PowerPlatformRole) {
        "AppliancePC" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - The OEM specified an appliance PC role" }
        "Desktop" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - The OEM specified a desktop role" }
        "EnterpriseServer" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - The OEM specified an enterprise server role" }
        "MaximumEnumValue" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - Max enum value" }
        "Mobile" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - The OEM specified a mobile role (for example, a laptop)" }
        "PerformanceServer" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - The OEM specified a performance server role" }
        "Slate" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - The OEM specified a tablet form factor role" }
        "SOHOServer" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - The OEM specified a single office/home office (SOHO) server role" }
        "Unspecified" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - UnspecifieThe OEM did not specify a specific role" }
        "Workstation" { $basic.PowerPlatformRole = "$($basic.PowerPlatformRole) - The OEM specified a workstation role" }
    }
    #endregion Basic
    $basic
}


# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
function Get-BiosInformation() {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "ComputerInfo Object for Bios Information,Position=0")]
        [Alias("ComputerInfoObject")]
        $computerInfo
    )
    
    $bios = $computerInfo | Select-Object Bios*


    $bios.BiosBIOSVersion = New-HTMLList -ListContent $($bios.BiosBIOSVersion)
    switch ($bios.BiosFirmwareType) {
        "Bios" { $bios.BiosFirmwareType = "$($bios.BiosFirmwareType) - The computer booted in legacy BIOS mode" }
        "Max" { $bios.BiosFirmwareType = "$($bios.BiosFirmwareType) - Not implemented" }
        "Uefi" { $bios.BiosFirmwareType = "$($bios.BiosFirmwareType) - The computer booted in UEFI mode" }
        "Unknown" { $bios.BiosFirmwareType = "$($bios.BiosFirmwareType) - The firmware type is unknown" }
    }
    $bios.BiosListOfLanguages = New-HTMLList -ListContent $($bios.BiosListOfLanguages)
    if ($bios.BiosPrimaryBIOS) {
        $bios.BiosPrimaryBIOS = "Primary BIOS of computerSystem"
    }
    else {
        $bios.BiosPrimaryBIOS = "Not primary BIOS of computerSystem"    
    }
    if ($null -eq $bios.BiosSMBIOSMajorVersion) {
        $bios.BiosSMBIOSMajorVersion = "SMBIOS Major Version not found"
    }
    if ($null -eq $bios.BiosSMBIOSMinorVersion) {
        $bios.BiosSMBIOSMinorVersion = "SMBIOS Minor Version not found"
    }
    if ($bios.BiosSMBIOSPresent -eq $true) {
        $bios.BiosSMBIOSPresent = "SMBIOS is available on this computer system"
    }
    
    $bios.BiosSoftwareElementState = "$($bios.BiosSoftwareElementState) - Software element is $($bios.BiosSoftwareElementState)"

    $bios
}

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


# @IN: PSCustomObject with Get-ComputerInfo information
# @ACTION: editing information from @IN by adding information from Microsoft docs documentation
# @OUT: edited information from @IN 
function Get-OperatingSystemInformation() {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = "ComputerInfo Object for OperatingSystem Information,Position=0")]
        [Alias("ComputerInfoObject")]
        $computerInfo
    )

    $operatingSystem = $computerInfo | Select-Object Os*
    $operatingSystem.OsHotFixes = New-HTMLList -ListContent $($operatingSystem.OsHotFixes) #Object
    
    #! TODO: "238 elements to translate code" $operatingSystem.OsCountryCode #! TODO: "238 elements to translate code"
    
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
    
    $operatingSystem.OsTotalVisibleMemorySize = "$($($operatingSystem.OsTotalVisibleMemorySize)/1MB) GB - Total amount, of physical memory available to the operating system. This value does not necessarily indicate the true amount of physical memory, but what is reported to the operating system as available to it."
    
    $operatingSystem.OsFreePhysicalMemory = "$($($operatingSystem.OsFreePhysicalMemory)/1MB) GB - Number, of physical memory currently unused and available."
    
    $operatingSystem.OsTotalVirtualMemorySize = "$($($operatingSystem.OsTotalVirtualMemorySize)/1MB) GB - Number, of virtual memory. For example, this may be calculated by adding the amount of total RAM to the amount of paging space, that is, adding the amount of memory in or aggregated by the computer system to the property, SizeStoredInPagingFiles."

    $operatingSystem.OsFreeVirtualMemory = "$($($operatingSystem.OsFreeVirtualMemory)/1MB) GB - Number, of virtual memory currently unused and available."
    
    
    $operatingSystem.OsInUseVirtualMemory = "$($($operatingSystem.OsInUseVirtualMemory)/1MB) GB"

    if ($null -ne $operatingSystem.OsTotalSwapSpaceSize) {
        $operatingSystem.OsTotalSwapSpaceSize = "$($($operatingSystem.OsTotalSwapSpaceSize)/1MB) GB - total swap size"
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
    
    $operatingSystem.OsPagingFiles = New-HTMLList -ListContent $($operatingSystem.OsPagingFiles)
    
    $operatingSystem.OsHardwareAbstractionLayer = " $($operatingSystem.OsHardwareAbstractionLayer) - version of the operating system Hardware Abstraction Layer (HAL)"
    
    $operatingSystem.OsMaxNumberOfProcesses = "$($operatingSystem.OsMaxNumberOfProcesses) maximum number of process contexts the operating system can support"
    
    $operatingSystem.OsMaxProcessMemorySize = "$($operatingSystem.OsMaxProcessMemorySize) maximum number of kilobytes of memory that can be allocated to a process"
    
    $operatingSystem.OsMuiLanguages = New-HTMLList -ListContent $($operatingSystem.OsMuiLanguages)
    
    $operatingSystem.OsNumberOfProcesses = "$($operatingSystem.OsNumberOfProcesses) - Number of process contexts currently loaded or running on the operating system"
    
    $operatingSystem.OsNumberOfUsers = "$($operatingSystem.OsNumberOfUsers) - Number of user sessions for which the operating system is storing state information currently"
    
    $operatingSystem.OsProductSuites = New-HTMLList -ListContent $($operatingSystem.OsProductSuites)

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
    $operatingSystem.OsSuites = New-HTMLList -ListContent $($operatingSystem.OsSuites)


    $operatingSystem
}

#TEST
#TODO: Extract every element from QueryHistory
#TODO: Convert data into readable format like Hresult convert into "ERROR"
#TODO: Return PSCustomObject
#TODO: Show HTML
Function Write-WUAError {
    <#
    .SYNOPSIS
    Convert raw HRESULT codes to a human readable error.
    .PARAMETER Exception
    The COMException that the error code is from.
    .PARAMETER Context
    Further context to add to the error message.
    .NOTES
    Error codes are from https://docs.microsoft.com/en-us/previous-versions/windows/desktop/hh968413(v=vs.85).
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [System.Runtime.InteropServices.COMException]
        $Exception,

        [String]
        $Context
    )

    $constant, $description = switch ($Exception.ErrorCode) {
        0x00240001 { 'WU_S_SERVICE_STOP', 'WUA was stopped successfully.' }
        0x00240002 { 'WU_S_SELFUPDATE', 'WUA updated itself.' }
        0x00240003 { 'WU_S_UPDATE_ERROR', 'The operation completed successfully but errors occurred applying the updates.' }
        0x00240004 { 'WU_S_MARKED_FOR_DISCONNECT', 'A callback was marked to be disconnected later because the request to disconnect the operation came while a callback was executing.' }
        0x00240005 { 'WU_S_REBOOT_REQUIRED', 'The system must be restarted to complete installation of the update.' }
        0x00240006 { 'WU_S_ALREADY_INSTALLED', 'The update to be installed is already installed on the system.' }  
        0x00240007 { 'WU_S_ALREADY_UNINSTALLED', 'The update to be removed is not installed on t he system.' }      
        0x00240008 { 'WU_S_ALREADY_DOWNLOADED', 'The update to be downloaded has already been downloaded.' }       
        0x00242015 { 'WU_S_UH_INSTALLSTILLPENDING', 'The installation operation for the update is still in progress.' }
        0x80240001 { 'WU_E_NO_SERVICE', 'WUA was unable to provide the service.' }
        0x80240002 { 'WU_E_MAX_CAPACITY_REACHED', 'The maximum capacity of the service was exceeded.' }
        0x80240003 { 'WU_E_UNKNOWN_ID', 'WUA cannot find an ID.' }
        0x80240004 { 'WU_E_NOT_INITIALIZED', 'The object could not be initialized.' }
        0x80240005 { 'WU_E_RANGEOVERLAP', 'The update handler requested a byte range overlapping a previously requested range.' }
        0x80240006 { 'WU_E_TOOMANYRANGES', 'The requested number of byte ranges exceeds the maximum number (2³¹ - 1).' }
        0x80240007 { 'WU_E_INVALIDINDEX', 'The index to a collection was invalid.' }
        0x80240008 { 'WU_E_ITEMNOTFOUND', 'The key for the item queried could not be found.' }
        0x80240009 { 'WU_E_OPERATIONINPROGRESS', 'Another conflicting operation was in progress. Some operations such as installation cannot be performed twice simultaneously.' }
        0x8024000A { 'WU_E_COULDNOTCANCEL', 'Cancellation of the operation was not allowed.' }
        0x8024000B { 'WU_E_CALL_CANCELLED', 'Operation was cancelled.' }
        0x8024000C { 'WU_E_NOOP', 'No operation was required.' }
        0x8024000D { 'WU_E_XML_MISSINGDATA', 'WUA could not find required information in the update''s XML data.' }
        0x8024000E { 'WU_E_XML_INVALID', 'WUA found invalid information in the update''s XML data.' }
        0x8024000F { 'WU_E_CYCLE_DETECTED', 'Circular update relationships were detected in the metadata.' }       
        0x80240010 { 'WU_E_TOO_DEEP_RELATION', 'Update relationships too deep to evaluate were evaluated.' }       
        0x80240011 { 'WU_E_INVALID_RELATIONSHIP', 'An invalid update relationship was detected.' }
        0x80240012 { 'WU_E_REG_VALUE_INVALID', 'An invalid registry value was read.' }
        0x80240013 { 'WU_E_DUPLICATE_ITEM', 'Operation tried to add a duplicate item to a list.' }
        0x80240014 { 'WU_E_INVALID_INSTALL_REQUESTED', 'Updates that are requested for install are not installable by the caller.' }
        0x80240016 { 'WU_E_INSTALL_NOT_ALLOWED', 'Operation tried to install while another installation was in progress or the system was pending a mandatory restart.' }
        0x80240017 { 'WU_E_NOT_APPLICABLE', 'Operation was not performed because there are no applicable updates.' }
        0x80240018 { 'WU_E_NO_USERTOKEN', 'Operation failed because a required user token is missing.' }
        0x80240019 { 'WU_E_EXCLUSIVE_INSTALL_CONFLICT', 'An exclusive update can''t be installed with other updates at the same time.' }
        0x8024001A { 'WU_E_POLICY_NOT_SET', 'A policy value was not set.' }
        0x8024001B { 'WU_E_SELFUPDATE_IN_PROGRESS', 'The operation could not be performed because the Windows Update Agent is self-updating.' }
        0x8024001D { 'WU_E_INVALID_UPDATE', 'An update contains invalid metadata.' }
        0x8024001E { 'WU_E_SERVICE_STOP', 'Operation did not complete because the service or system was being shut down.' }
        0x8024001F { 'WU_E_NO_CONNECTION', 'Operation did not complete because the network connection was unavailable.' }
        0x80240020 { 'WU_E_NO_INTERACTIVE_USER', 'Operation did not complete because there is no logged-on interactive user.' }
        0x80240021 { 'WU_E_TIME_OUT', 'Operation did not complete because it timed out.' }
        0x80240022 { 'WU_E_ALL_UPDATES_FAILED', 'Operation failed for all the updates.' }
        0x80240023 { 'WU_E_EULAS_DECLINED', 'The license terms for all updates were declined.' }
        0x80240024 { 'WU_E_NO_UPDATE', 'There are no updates.' }
        0x80240025 { 'WU_E_USER_ACCESS_DISABLED', 'Group Policy settings prevented access to Windows Update.' }    
        0x80240026 { 'WU_E_INVALID_UPDATE_TYPE', 'The type of update is invalid.' }
        0x80240027 { 'WU_E_URL_TOO_LONG', 'The URL exceeded the maximum length.' }
        0x80240028 { 'WU_E_UNINSTALL_NOT_ALLOWED', 'The update could not be uninstalled because the request did not originate from a Windows Server Update Services (WSUS) server.' }
        0x80240029 { 'WU_E_INVALID_PRODUCT_LICENSE', 'Search may have missed some updates before there is an unlicensed application on the system.' }
        0x8024002A { 'WU_E_MISSING_HANDLER', 'A component required to detect applicable updates was missing.' }    
        0x8024002B { 'WU_E_LEGACYSERVER', 'An operation did not complete because it requires a newer version of server.' }
        0x8024002C { 'WU_E_BIN_SOURCE_ABSENT', 'A delta-compressed update could not be installed because it required the source.' }
        0x8024002D { 'WU_E_SOURCE_ABSENT', 'A full-file update could not be installed because it required the source.' }
        0x8024002E { 'WU_E_WU_DISABLED', 'Access to an unmanaged server is not allowed.' }
        0x8024002F { 'WU_E_CALL_CANCELLED_BY_POLICY', 'Operation did not complete because the DisableWindowsUpdateAccess policy was set in the registry.' }
        0x80240030 { 'WU_E_INVALID_PROXY_SERVER', 'The format of the proxy list was invalid.' }
        0x80240031 { 'WU_E_INVALID_FILE', 'The file is in the wrong format.' }
        0x80240032 { 'WU_E_INVALID_CRITERIA', 'The search criteria string was invalid.' }
        0x80240033 { 'WU_E_EULA_UNAVAILABLE', 'License terms could not be downloaded.' }
        0x80240034 { 'WU_E_DOWNLOAD_FAILED', 'Update failed to download.' }
        0x80240035 { 'WU_E_UPDATE_NOT_PROCESSED', 'The update was not processed.' }
        0x80240036 { 'WU_E_INVALID_OPERATION', 'The object''s current state did not allow the operation.' }        
        0x80240037 { 'WU_E_NOT_SUPPORTED', 'The functionality for the operation is not supported.' }
        0x80240039 { 'WU_E_TOO_MANY_RESYNC', 'Agent is asked by server to resync too many times.' }
        0x80240040 { 'WU_E_NO_SERVER_CORE_SUPPORT', 'The WUA API method does not run on the server core installation.' }
        0x80240041 { 'WU_E_SYSPREP_IN_PROGRESS', 'Service is not available while sysprep is running.' }
        0x80240042 { 'WU_E_UNKNOWN_SERVICE', 'The update service is no longer registered with automatic updates.' }
        0x80240043 { 'WU_E_NO_UI_SUPPORT', 'No support for the WUA user interface.' }
        0x80240044 { 'WU_E_PER_MACHINE_UPDATE_ACCESS_DENIED', 'Only administrators can perform this operation on per-computer updates.' }
        0x80240045 { 'WU_E_UNSUPPORTED_SEARCHSCOPE', 'A search was attempted with a scope that is not currently supported for this type of search.' }
        0x80240046 { 'WU_E_BAD_FILE_URL', 'The URL does not point to a file.' }
        0x80240047 { 'WU_E_NOTSUPPORTED', 'The operation requested is not supported.' }
        0x80240048 { 'WU_E_INVALID_NOTIFICATION_INFO', 'The featured update notification info returned by the server is invalid.' }
        0x80240049 { 'WU_E_OUTOFRANGE', 'The data is out of range.' }
        0x8024004A { 'WU_E_SETUP_IN_PROGRESS', 'WUA operations are not available while operating system setup is running.' }
        0x80240FFF { 'WU_E_UNEXPECTED', 'An operation failed due to reasons not covered by another error code.' }  
        default { 'UNKNOWN', "Unknown error code $($Exception.ErrorCode)." }
    }

    if (-not $Context) {
        $Context = "Error received from WUA"
    }

    $errorParams = @{
        Message   = '{0} (0x{1:X8} {2}): {3}' -f ($Context, $Exception.ErrorCode, $constant, $description)
        Exception = $Exception
    }
    Write-Error @errorParams
}

Function Get-WindowsUpdateRecords {

    $session = New-Object -ComObject Microsoft.Update.Session
    try {
        $searcher = $session.CreateUpdateSearcher()
    }
    catch [System.Runtime.InteropServices.COMException] {
        $_.Exception | Write-WUAError -Context "Creating update searcher"
        return
    }

    try {
        $searchResult = $searcher.Search('IsInstalled=1')
    }
    catch [System.Runtime.InteropServices.COMException] {
        $_.Exception | Write-WUAError -Context "Search with filter IsInstalled=1"
        return
    }

    if ($searchResult.ResultCode -notin @(2, 3)) {
        $errorTitle, $errorMsg = switch ($searchResult.ResultCode) {
            0 { 'NotStarted', 'The operation is not started.' }
            1 { 'InProgress', 'The operation is in progress.' }
            2 { 'Succeeded', 'The operation was completed successfully.' }
            3 { 'SucceededWithErrors', 'The operation is complete, but one or more errors occurred during the operation. The results might be incomplete.' }
            4 { 'Failed', 'The operation failed to complete.' }
            5 { 'Aborted', 'The operation is canceled.' }
            default { 'Unknown', "Unknown result code $($searchResult.ResultCode)." }
        }
        Write-Error -Message "Search for updates failed with $errorTitle - $errorMsg"
        return
    }

    foreach ($warning in $searchResult.Warnings) {
        Write-Warning -Message '{0} - {1}' -f ($warning.Message, $warning.HResult)
    }

    $history = $searcher.QueryHistory(0, $searcher.GetTotalHistoryCount()) | Group-Object Title -AsHashtable -AsString

    $output = foreach ($update in $searchResult.Updates) {

        $updateHistory = $history[$update.Title]

        $installBehaviour = $update.InstallationBehavior

        # https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-uamg/9ed3c4f7-30fc-4b7b-97e1-308b5159822c
        $impact = switch ($installBehaviour.Impact) {
            0 { 'Normal' }
            1 { 'Minor' }
            2 { 'RequiresExclusiveHandling' }
            default { "Unknown $($installBehaviour.Impact)" }
        }
        
        # https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-uamg/eee24bbd-0be7-4a81-bed5-bff1fbb1832b
        $rebootBehavior = switch ($installBehaviour.RebootBehavior) {
            0 { 'NeverReboots' }
            1 { 'AlwaysRequiresReboot' }
            2 { 'CanRequestReboot' }
            default { "Unknown $($installBehaviour.RebootBehavior)" }
        }

        # https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-uamg/a4ec1231-6523-4196-8497-7b63ecc35b61
        $updateType = switch ($update.Type) {
            1 { 'Software' }
            2 { 'Driver' }
            default { "Unknown $($update.Type)" }
        }

        # https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-uamg/d4dc5648-a8a9-436d-9fdd-c90730bf64b0
        $deploymentAction = switch ($update.DeploymentAction) {
            0 { 'None' }
            1 { 'Installation' }
            2 { 'Uninstallation' }
            3 { 'Detection' }
            default { "Unknown $($update.DeploymentAction)" }
        }

        # https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-uamg/012a7226-c23d-4905-b630-9a6506032aa9
        $autoSelection = switch ($update.AutoSelection) {
            0 { 'LetWindowsUpdateDecide' }
            1 { 'AutoSelectIfDownloaded' }
            2 { 'NeverAutoSelect' }
            3 { 'AlwaysAutoSelect' }
            default { "Unknown $($update.AutoSelection)" }
        }

        # https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-uamg/02e59b57-4d4e-4060-ab69-8207a10271aa
        $autoDownload = switch ($update.AutoDownload) {
            0 { 'LetWindowsUpdateDecide' }
            1 { 'NeverAutoDownload' }
            2 { 'AlwaysAutoDownload' }
            default { "Unknown $($update.AutoDownload)" }
        }
        
        $operation=switch ($updateHistory.Operation)
        {
            1 { 'InProgress - The operation is in progress.' }
            2 { 'Succeeded - The operation was completed successfully.' }
            default { 'NotStarted - The operation is not started.' }
        }

        $resultCode = switch ($updateHistory.ResultCode) 
        {
            0 { 'NotStarted - The operation is not started.' }
            1 { 'InProgress - The operation is in progress.' }
            2 { 'Succeeded - The operation was completed successfully.' }
            3 { 'SucceededWithErrors - The operation is complete, but one or more errors occurred during the operation. The results might be incomplete.' }
            4 { 'Failed - The operation failed to complete.' }
            5 { 'Aborted - The operation is canceled.' }
            default { 'Unknown - Unknown result code' }
        }


        
        [PSCustomObject]@{
            # User friendly info
            KB                   = 'KB{0}' -f (@($update.KBArticleIDs | ForEach-Object { $_ })[0])
            Title                = $update.Title #OK
            Description          = $update.Description #OK
            
            # Search filter critera
            Type                 = $updateType #OK
            DeploymentAction     = $deploymentAction #OK
            AutoSelectOnWebSites = $update.AutoSelectOnWebSites #OK
            BrowseOnly           = $update.BrowseOnly #OK
            UpdateID             = $update.Identity.UpdateID #OK
            RevisionNumber       = $update.Identity.RevisionNumber #TODO: Replace value
            Categories           = @($update.Categories | ForEach-Object { $_.Name }) #TODO: Create html lsit with categories
            IsInstalled          = $update.IsInstalled #OK
            IsHidden             = $update.IsHidden #OK
            IsPresent            = $update.IsPresent #OK
            RebootRequired       = $update.RebootRequired #OK

            # Extra info
            Impact               = $impact  #OK
            RebootBehavior       = $rebootBehavior #OK
            IsBeta               = $update.IsBeta #OK
            IsDownloaded         = $update.IsDownloaded #OK
            IsMandatory          = $update.IsMandatory #OK
            IsUninstallatble     = $update.IsUninstallable #OK
            AutoSelection        = $autoSelection #OK
            AutoDownload         = $autoDownload #OK
            
            # History info
            Operation            = New-HTMLList -ListContent $($operation) #OK
            ResultCode           = New-HTMLList -ListContent $($resultCode) #OK
            HResult              = New-HTMLList -ListContent $($updateHistory.HResult) #TODO: Replace Error Values with Write-WUError function
            Date                 = New-HTMLList -ListContent $($updateHistory.Date) #OK
            UpdateIdentity       = New-HTMLList -ListContent $($updateHistory.UpdateIdentity) # ? return System._Object - translating?
            UnmappedResultCode   = New-HTMLList -ListContent $($updateHistory.UnmappedResultCode) #TODO: Replace Error Values with Write-WUError function
            #ServerSelection      = $updateHistory.ServerSelection  #! ERROR - throws stacktrace
            #ClientApplicationID
            ServiceID            = $updateHistory.ServiceID #TODO: 
            UninstallationSteps  = $updateHistory.UninstallationSteps #TODO: 
            UninstallationNotes  = $updateHistory.UninstallationNotes #TODO: 
            SupportUrl           = $updateHistory.SupportUrl #TODO: 
        }
    }

    $output
}



function Get-BasicComputerInfo {
    $computerInfo = Get-ComputerInfo
    
    $basicInformation = [PSCustomObject]@{
        BasicInformation = Get-BasicComputerInformation -ComputerInfoObject $computerInfo
        Bios             = Get-BiosInformation -ComputerInfoObject $computerInfo
        ComputerSystem   = Get-ComputerSystemInformation -ComputerInfoObject $computerInfo
        OperatingSystem  = Get-OperatingSystemInformation -ComputerInfoObject $computerInfo
        HyperV           = Get-HyperVInformation -ComputerInfoObject $computerInfo
        DeviceGuard      = Get-DeviceGuardInformation -ComputerInfoObject $computerInfo
    }
    $basicInformation
}

# TODO
function Get-HardwareInfo {
    $hardwareInformation = [PSCustomObject]@{
        Controller1394              = Get-1394Controller
        BaseBoard                   = Get-BaseBoard
        Battery                     = Get-Battery
        Bios                        = Get-BIOS
        Bus                         = Get-Bus
        CacheMemory                 = Get-CacheMemory
        CDROM                       = Get-CDROMDrive
        CompactDisc                 = Get-CompactDisc
        Desktop                     = Get-Desktop
        DesktopMonitor              = Get-DesktopMonitor
        DiskDrive                   = Get-DiskDrive
        DiskPartition               = Get-DiskPartition
        Fan                         = Get-Fan
        Glide                       = Get-GlidePoint
        HeatPipe                    = Get-HeatPipe
        IDE                         = Get-IDEController
        InfraredDevice              = Get-InfraredDevice
        Keyboard                    = Get-Keyboard
        LocalDisk                   = Get-LocalDisk
        LogicalDisk                 = Get-LogicalDisk
        MemoryArray                 = Get-MemoryArray
        MemoryDevice                = Get-MemoryDevice
        MotherBoardDevice           = Get-MotherboardDevice
        Mouse                       = Get-Mouse
        NetworkAdapter              = Get-NetworkAdapterSysInfo
        NetworkAdapterConfiguration = Get-NetworkAdapterConfiguration
        NetworkDrive                = Get-NetworkDrive
        OperatingSystem             = Get-OperatingSystem
        OpticalSensor               = Get-OpticalSensor
        PhysicalMemory              = Get-PhysicalMemory
        PhysicalMemoryArray         = Get-PhysicalMemoryArray
        PointingDevice              = Get-PointingDevice
        PortableBattery             = Get-PortableBattery
        PrinterConfiguration        = Get-PrinterConfiguration
        Processor                   = Get-Processor
        RAMDisk                     = Get-RAMDisk
        Refrigeration               = Get-Refrigeration
        RemovableDisk               = Get-RemovableDisk
        SCSIController              = Get-SCSIControllerSysInfo
        SoundDevice                 = Get-SoundDevice
        SystemEnclousure            = Get-SystemEnclosure
        TapeDrive                   = Get-TapeDrive
        TemperatureProbe            = Get-TemperatureProbe
        TouchPad                    = Get-TouchPad
        TouchScreen                 = Get-TouchScreen
        TrackBall                   = Get-TrackBall
        TrackPoint                  = Get-TrackPoint
        USBController               = Get-USBController
        VideoController             = Get-VideoController
        VoltageProbe                = Get-VoltageProbe
    }
    $hardwareInformation
}
# TODO
function Get-MotherBoard {
    Get-CimInstance Win32_BaseBoard | Select-Object * -ExcludeProperty CreationClassName, PSComputerName, Cim*

}

#region HTMLDeclarations
$HTMLBody1 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).BasicInformation)
$HTMLBody2 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).Bios)
$HTMLBody3 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).ComputerSystem)
$HTMLBody4 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).OperatingSystem)
$HTMLBody5 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).HyperV)
$HTMLBody6 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).DeviceGuard)

$tests = $(Get-WindowsUpdateRecords)[0]
$HTMLBody7 = New-HTMLTable -TableContent $($tests)

$HTMLBody8 = "TEST"

############################################################################################################

# @IN: NONE
# @ACTION: changing data in dashboard
# @OUT: Javascript code to inject into HTML file
function New-JSScript() {
    $script = @"
    <script>
    function changeContent(content) 
    {
        document.getElementById('lama').innerHTML = content;
    }
    function dropdownMenu1() 
    {
        const x = document.getElementById("basic");
        if (x.className.indexOf("w3-show") == -1) {
            x.className += " w3-show";
            x.previousElementSibling.className += " w3-green";
        }
        else {
            x.className = x.className.replace(" w3-show", "");
            x.previousElementSibling.className = x.previousElementSibling.className.replace(" w3-green", "");
        }
    }
    function dropdownMenu2() 
    {
        const x = document.getElementById("update");
        if (x.className.indexOf("w3-show") == -1) {
            x.className += " w3-show";
            x.previousElementSibling.className += " w3-green";
        }
        else {
            x.className = x.className.replace(" w3-show", "");
            x.previousElementSibling.className = x.previousElementSibling.className.replace(" w3-green", "");
        }
    }
    </script>
"@
    return $script
}

# @IN: NONE
# @ACTION: information about stylesheet
# @OUT: CSS code to inject into HTML file
function New-HTMLHead() {
    $head = @"
    <head>
        <title>W3.CSS</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
"@
    return $head
}


# @IN: NONE
# @ACTION: creating dashboard and injecting operating system data into it
# @OUT: full dashboard with data showing to user
function New-HTMLBody() {
    $report = @"
<!DOCTYPE html>
<html>
$(New-HTMLHead)
<body>
    <div class="w3-sidebar w3-bar-block w3-light-grey w3-card" style="width:160px;">
        <a href="#" class="w3-bar-item w3-button">Link 1</a>
        
        <div class="w3-bar-item w3-button" onclick="dropdownMenu1()">
            Basic <i class="fa fa-caret-down"></i>
        </div>
        <div id="basic" class="w3-hide w3-white w3-card-4">
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody1')">BasicInformation</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody2')">Bios</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody3')">ComputerSystem</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody4')">OperatingSystem</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody5')">HyperV</a>
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody6')">DeviceGuard</a>
        </div>

        <div class="w3-bar-item w3-button" onclick="dropdownMenu2()">
            Updates <i class="fa fa-caret-down"></i>
        </div>
        <div id="update" class="w3-hide w3-white w3-card-4">
            <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody7')">Update1</a>
        </div>

        <a class="w3-bar-item w3-button" onclick="changeContent('$HTMLBody8')">MotherBoard</a>
        
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