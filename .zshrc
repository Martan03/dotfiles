# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Sets the prompt style (name@device path$)
PS1="%F{13}%n@%m %F{14}%~%F{8}%(!.#.\$)%f "

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PROG="/mnt/Programming/"
export ANDROID_HOME="$HOME/Android/Sdk"

ZSH_THEME="typedark"
DISABLE_AUTO_UPDATE=true

# ZSH plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Sets system variables
export CC=clang
export CXX=clang++
export EDITOR=nvim

# Aliases
alias vim=nvim
alias weather='curl -s "wttr.in/Brno?F"';

# Functions

# Creates directory and goes into it
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

# Starts mysql server along the symfony server
function symfony-server() {
    sudo xampp startmysql
    symfony server:stop
    symfony server:start -d
}

