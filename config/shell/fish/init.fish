set -x fish_complete_path ~/.config/shell/fish/completions/
set -x fish_function_path ~/.config/shell/fish/functions/

set CONFIG_DIR (dirname (status filename))
 
if test -f "$CONFIG_DIR/conf.d/env.fish"
    source "$CONFIG_DIR/conf.d/env.fish"
end

# load aliases 
if test -f "$CONFIG_DIR/conf.d/aliases.fish"
    source "$CONFIG_DIR/conf.d/aliases.fish"
end

# Load custom functions and commands
if test -f "$CONFIG_DIR/conf.d/functions.fish"
    source "$CONFIG_DIR/conf.d/functions.fish"
end

starship init fish | source

sleep 0.2
fastfetch
