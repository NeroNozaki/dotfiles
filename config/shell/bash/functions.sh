# quick bandit level connector
bandit() {
	local level=${1:-0}
	ssh -p 2220 "bandit$level@bandit.labs.overthewire.org"
}

# tab auto complete
bind "TAB:menu-complete"

# change directory and list
cdl() {
     cd "$1"
     ls -laF
}

# short for .config
c() {
    cd ~/.config/"$@"
}

youtube-download() {
     yt-dlp -f "bestvideo[height<=720][ext=mp4]+(bestaudio[ext=m4a]/bestaudio)/best[height<=720][ext=mp4]/best" --merge-output-format mp4 $ "$1" --sponsorblock-remove sponsor --paths "/mnt/HD/videos/youtube"
}
