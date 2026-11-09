$ENV:STARSHIP_CONFIG = "$HOME\dotfiles\config\starship\starship.toml"
Invoke-Expression (&starship init powershell)

$env:EDITOR = "nvim"
$env:VISUAL = "nvim"

Set-Alias -Name yt-dlp -Value yt-dlp.exe
Set-Alias -name vlc -value "C:\Program Files\VideoLAN\VLC\vlc.exe"
set-alias -name mpv -value mpvnet.exe

function youtube-download {
    param([string]$url)
        yt-dlp.exe -P "~/Videos/downloads" $url -f "bestvideo[height<=480][ext=mp4]+(bestaudio[ext=m4a]/bestaudio)/best[height<=480][ext=mp4]/best" --merge-output-format mp4 --sponsorblock-remove sponsor
}

