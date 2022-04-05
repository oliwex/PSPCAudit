# @IN: NONE
# @ACTION: Merge information from function into one PsCustomObject
# @OUT: PSCustomObject with Basic information about computer
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