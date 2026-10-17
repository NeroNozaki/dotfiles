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
