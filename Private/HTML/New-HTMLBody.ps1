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
