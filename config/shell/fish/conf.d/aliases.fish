alias ls 'ls --color=auto'
alias rg 'rg --color=auto'
alias grep 'rg --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

# some ls aliases
alias ll 'ls -alhF'
alias la 'ls -A'
alias l 'ls -CF'

# my aliases
alias update 'sudo apt update && apt upgrade'
alias trash 'gio trash'
alias quit 'exit'
alias reload 'source ~/.config/fish/config.fish'
alias tmux-reload 'tmux source ~/.config/tmux/tmux.conf'
alias z 'zoxide'

alias rebuild 'sudo nixos-rebuild switch'

alias gs 'git status'

alias python "python3"
alias zig-quiet "ZIG_PROGRESS=100 zig"
alias zig-build-minimal "zig build-exe \
  -O ReleaseSmall \
  -fstrip \
  -ffunction-sections \
  -fdata-sections \
  --gc-sections \
  -fno-unwind-tables \
  -fsingle-threaded"

alias xmod "xmodmap ~/.xmodmap"

alias shutdown "systemctl poweroff"
alias reboot "systemctl reboot"

