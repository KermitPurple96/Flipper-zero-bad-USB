iwr -uri https://www.dropbox.com/s/ifw94j1ctxtycss/videoplayback%20%28online-video-cutter.com%29.mp4?dl=1 -OutFile C:\Users\Public\rick.mp4
#WPF Library for Playing Movie and some components
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.ComponentModel
#XAML File of WPF as windows for playing movie
[xml]$XAML = @"
 
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="PowerShell Video Player" Height="355" Width="553" ResizeMode="NoResize">
    <Grid Margin="0,0,2,3">
        <MediaElement Height="250" Width="525" Name="VideoPlayer" LoadedBehavior="Manual" UnloadedBehavior="Stop" Margin="8,10,10,61" />
        <Button Content="Pause" Name="PauseButton" HorizontalAlignment="Left" Margin="236,283,0,0" VerticalAlignment="Top" Width="75"/>
        <Button Content="Play" Name="PlayButton" HorizontalAlignment="Left" Margin="236,283,0,0" VerticalAlignment="Top" Width="75"/>
    </Grid>
</Window>
"@
 
#Movie Path
[uri]$VideoSource = "C:\Users\Public\rick.mp4"
 
#Devide All Objects on XAML
$XAMLReader=(New-Object System.Xml.XmlNodeReader $XAML)
$Window=[Windows.Markup.XamlReader]::Load( $XAMLReader )
$VideoPlayer = $Window.FindName("VideoPlayer")
$PauseButton = $Window.FindName("PauseButton")
$PlayButton = $Window.FindName("PlayButton")
 
#Video Default Setting
$VideoPlayer.Volume = 100;
$VideoPlayer.Source = $VideoSource;
$VideoPlayer.Play()
$PauseButton.Visibility = [System.Windows.Visibility]::Visible
$PlayButton.Visibility = [System.Windows.Visibility]::Hidden
 
#Button click event 
$PlayButton.Add_Click({
    $VideoPlayer.Play()
    $PauseButton.Visibility = [System.Windows.Visibility]::Visible
    $PlayButton.Visibility = [System.Windows.Visibility]::Hidden
})
$PauseButton.Add_Click({
    $VideoPlayer.Pause()
    $PauseButton.Visibility = [System.Windows.Visibility]::Hidden
    $PlayButton.Visibility = [System.Windows.Visibility]::Visible
})
 
#Show Up the Window 
$Window.ShowDialog() | out-null
