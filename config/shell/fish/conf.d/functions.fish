function bandit
    set -l level 0
    if set -q $argv[1]
        set level $argv[1]
    end

    ssh -p 2220 "bandit$level@bandit.labs.overthewire.org"
end

function cdl -w cd
    cd $argv[1]
    ls -laF
end

function youtube-download
     yt-dlp -f "bestvideo[height<=720][ext=mp4]+(bestaudio[ext=m4a]/bestaudio)/best[height<=720][ext=mp4]/best" --merge-output-format mp4 "$argv[1]" --sponsorblock-remove sponsor --paths "/mnt/HD/videos/youtube"
end

function alert
    set -l last_status $status
    set -l icon error

    if test $last_status -eq 0
        set icon terminal
    end

    set -l last_command (history | head -n 1 | string replace -r '^\s*' '' | string replace -r '[;&|]\s*alert$' '')

    notify-send --urgency=low -i $icon $last_command
end
