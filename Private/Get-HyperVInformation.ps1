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
    $hyperV
}