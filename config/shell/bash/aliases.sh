# enable color support of ls and also add handy aliases
if command -v dircolors >/dev/null 2>&1; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='rg --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


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

alias rebuild='sudo nixos-rebuild switch'

alias dotfiles="~/.dotfiles"

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
