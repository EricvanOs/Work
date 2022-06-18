$sound = new-Object System.Media.SoundPlayer;
$sound.SoundLocation='c:\WINDOWS\Media\notify.wav';
$sound.Play();

$sound | Get-Member

(new-object Media.SoundPlayer 'C:\WINDOWS\Media\notify.wav').play();

########### andere class

[System.Media.SystemSounds] | Get-Member  -Static

[System.Media.SystemSounds]::Asterisk | Get-Member 


[System.Media.SystemSounds]::Asterisk.Play();
[System.Media.SystemSounds]::Beep.Play();
[System.Media.SystemSounds]::Exclamation.Play();
[System.Media.SystemSounds]::Hand.Play();
[System.Media.SystemSounds]::Question.Play(); 



