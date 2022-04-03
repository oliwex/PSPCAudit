# ? implement classes with strategy pattern
# ? try to rewrite css rules by own css rules
# auditpol /get /category:*

###########################################

$HTMLBody1 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).BasicInformation)
$HTMLBody2 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).Bios)
$HTMLBody3 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).ComputerSystem)
$HTMLBody4 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).OperatingSystem)
$HTMLBody5 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).HyperV)
$HTMLBody6 = New-HTMLTable -TableContent $($(Get-BasicComputerInfo).DeviceGuard)

$HTMLBody8 = "TEST"

###########################################

New-HTMLBody | Out-File "H:\test.html"