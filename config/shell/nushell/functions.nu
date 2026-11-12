def reload [] {
  exec nu
}

def youtube-download [url: string] {
  yt-dlp.exe -P "~/Videos/downloads" $url -f "bestvideo[height<=480][ext=mp4]+(bestaudio[ext=m4a]/bestaudio)/best[height<=480][ext=mp4]/best" --merge-output-format mp4 --sponsorblock-remove sponsor
}

def fastfetch [] {
  fastfetch.exe -c "C:/Users/higor.otaviano/dotfiles/config/fastfetch/config_no_logo.jsonc"
}
