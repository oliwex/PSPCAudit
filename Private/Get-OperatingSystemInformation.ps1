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