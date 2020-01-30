#!/bin/bash

if [ ! -f "setup.sh" ]; then
	echo "You must run this from the dots directory"
	exit
fi
echo "Setting up environment..."

function mklink() {
	echo "  Linking: $1 -> $2"
	ln -sf $PWD/$1 $2
}

function yn() {
	while
		printf "$1 [y/n] " && read a
	do
		case $a in
			([yY]) return 0;;
			([nN]) return 1;;
			(*) printf "$a is not valid\n";;
			esac
	done
}

##Sanity
mkdir -vp ~/.config
mkdir -vp ~/.ssh

yn "Check that all packages are installed?"
if [ $? -eq 0 ]; then
	sudo pacman -Syy --needed i3 tmux zsh git vim dunst picom openssh
fi

##zsh
echo "Setting up oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -p ~/.cache/oh-my-zsh
rm -rf ~/.zshrc

#Links
echo "Linking dots"
rm -rf ~/.config/i3
mklink i3 ~/.config/i3
rm -rf ~/.config/systemd
mkdir -p ~/.config/systemd/user
mklink ssh-agent.service ~/.config/systemd/user/ssh-agent.service
mklink .bashrc ~/.bashrc
mklink .zshrc ~/.zshrc
mklink .tmux.conf ~/.tmux.conf
mklink .vimrc ~/.vimrc
mklink .Xresources ~/.Xresources
mklink .dunstrc ~/.dunstrc
mklink .picom.conf ~/.picom.conf
mklink .clang-format ~/.clang-format
mklink .gitignore ~/.gitignore
mklink .gitconfig ~/.gitconfig
mklink davidh.zsh-theme ~/.oh-my-zsh/themes/davidh.zsh-theme

echo "Enabling SSH agent"
systemctl --user daemon-reload
systemctl --user enable ssh-agent
systemctl --user start ssh-agent

echo "Done!"
