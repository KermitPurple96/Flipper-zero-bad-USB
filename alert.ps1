while($True)
{
    $sb = Start-Job -ScriptBlock{
        Function Set-Speaker($Volume){$wshShell = new-object -com wscript.shell;1..50 | % {$wshShell.SendKeys([char]174)};1..$Volume | % {$wshShell.SendKeys([char]175)}}
        Set-Speaker -Volume 50
        Add-Type -AssemblyName System.Windows.Forms
        $global:balmsg = New-Object System.Windows.Forms.NotifyIcon
        $path = (Get-Process -id $pid).Path
        $balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
        $balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning
        $balmsg.BalloonTipText = ‘This is the pop-up message text for the Windows 10 user'
        $balmsg.BalloonTipTitle = "Attention $Env:USERNAME"
        $balmsg.Visible = $true
        $balmsg.ShowBalloonTip(20000)
        Start-Sleep -Seconds 1
    }
    Wait-Job $sb.Name
}
