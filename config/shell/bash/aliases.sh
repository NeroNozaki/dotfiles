# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# my aliases
alias update='sudo apt update && apt upgrade'
alias trash='gio trash'
alias quit='exit'
alias reload='source ~/.bashrc'
alias tmux-reload='tmux source ~/.config/tmux/tmux.conf'

alias dotfiles="pushd ~/.dotfiles && ll"

alias python="python3"
alias zig-quiet="ZIG_PROGRESS=100 zig"
alias zig-build-minimal="zig build-exe \
  -O ReleaseSmall \
  -fstrip \
  -ffunction-sections \
  -fdata-sections \
  --gc-sections \
  -fno-unwind-tables \
  -fsingle-threaded"

alias xmod="xmodmap ~/.xmodmap"

# Add an "alert" alias for long running commands. Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
