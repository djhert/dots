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

echo "Checking internet connection..."
ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null;
if [ $? -eq 0 ]; then
	echo "Connected!"
	yn "Check that all packages are installed?"
	if [ $? -eq 0 ]; then
		sudo pacman -Syy --needed i3 tmux zsh git vim dunst picom openssh
	fi
	yn "Install oh-my-zsh?"
	if [$? -eq 0 ]; then
		sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		mkdir -p ~/.cache/oh-my-zsh
		rm -rf ~/.zshrc
		mklink davidh.zsh-theme ~/.oh-my-zsh/themes/davidh.zsh-theme
	fi
else
	echo "Not connected to internet, continuing";
fi

#Links
echo "Linking dots"
mklink .bashrc ~/.bashrc
mklink .zshrc ~/.zshrc
mklink .tmux.conf ~/.tmux.conf
mklink .vimrc ~/.vimrc
mklink .clang-format ~/.clang-format
mklink .gitignore ~/.gitignore
mklink .gitconfig ~/.gitconfig

yn "Enable SSH-Agent? (this will remove any other user systemd files)"
if [ $? -eq 0 ]; then
	echo "Enabling SSH agent"
	rm -rf ~/.config/systemd
	mkdir -p ~/.config/systemd/user
	mklink ssh-agent.service ~/.config/systemd/user/ssh-agent.service
	systemctl --user daemon-reload
	systemctl --user enable ssh-agent
	systemctl --user start ssh-agent
fi

echo "Done!"
