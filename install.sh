#!/usr/bin/bash

# general packages
sudo pacman -Syu --needed base-devel clang composer discord dotnet-sdk ffmpeg \
	firefox git glibc libc++ lldb llvm neofetch nodejs npm obs-studio php \
	steam texlive texlive-langczechslovak ttf-cascadia-code vlc fd lazygit \
	neovim zsh

# editing packages
sudo pacman -S --needed gimp kdenlive

# KDE related packages
sudo pacman -S --needed gwenview noto-fonts-emoji-apple spectacle

if type yay &>/dev/null; then
	# yay install
	git clone https://aur.archlinux.org/yay.git &&
		cd yay &&
		makepkg -si &&
		cd ..
fi

# yay packages
yay -S --needed makeit symfony-cli visual-studio-code-bin \
	ttf-cascadia-code-nerd

if type cargo &>/dev/null; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

cp .zshrc ~/.zshrc
cp .bashrc ~/.bashrc
cp -r nvim ~/.config/nvim

# Oh my zsh install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh extensions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions \
	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
curl -L -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/typedark.zsh-theme \
	https://raw.githubusercontent.com/BonnyAD9/TypeDark/master/zsh-typedark.sh
