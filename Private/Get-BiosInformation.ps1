
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
