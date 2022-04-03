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

    $basic
}