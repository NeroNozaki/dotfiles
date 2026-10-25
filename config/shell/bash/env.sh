# how to export a directory to PATH. so you don't forget.
# export PATH=$PATH:"~/path/to/directory/"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# opencode
export PATH=/home/pretzels/.opencode/bin:$PATH
