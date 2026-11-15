# set PATH so it includes user's private bin if it exists
if test -d "$HOME/bin"
    fish_add_path "$HOME/bin"
end

# set PATH so it includes user's private bin if it exists
if test -d "$HOME/.local/bin"
    fish_add_path "$HOME/.local/bin"
end

# opencode
fish_add_path "/home/pretzels/.opencode/bin"
