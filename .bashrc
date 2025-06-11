#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\[\e[95m\]\u@\h \[\e[96m\]\W\[\e[0m\]]\$ '
. "$HOME/.cargo/env"

export ANDROID_HOME="$HOME/Android/Sdk"
export PROG="/mnt/Programming/"

export CC=clang
export CXX=clang++
export EDITOR=nvim

# Aliases
alias vim=nvim
alias weather='curl -s "wttr.in/Brno?F"';

# Creates directory and goes to it
function mkcd() {
	mkdir -p "$1"
	cd "$1"
}

# Creates directory in programming folder and opens vscode
function mkcode() {
	mkcd "$PROG$1"
	code .
}

# Updates the system
function sysup() {
    if type yay &> /dev/null; then
        yay -Syu
    else
        sudo pacman -Syu
    fi
    if type rustup &> /dev/null; then
        rustup update
    fi
    if type npm &> /dev/null; then
        sudo npm update -g npm
    fi
    if type composer &> /dev/null; then
        sudo composer self-update
    fi
    if type ghcup &> /dev/null; then
        ghcup upgrade
    fi
    if type omz &> /dev/null; then
        omz update
    fi
}

# Starts mysql server and symfony server
function symfony-server() {
	sudo xampp startmysql
	symfony server:stop
	symfony server:start -d
}

[ -f "/home/martan03/.ghcup/env" ] && . "/home/martan03/.ghcup/env" # ghcup-env
