#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export GOPATH=~/Development/Go/.go
export GOBIN=$GOPATH/bin
export PATH=$PATH:~/.bin:~/.android-sdk/platform-tools:~/.android-sdk/tools:$GOBIN
export WINEDEBUG=-all
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

## Environment
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export TERM="xterm-256color"
export PS1='[\u@\h \W]\$ '
export EDITOR='vim'

## Cheats
alias pacman='sudo pacman'

## Fun
alias plz='sudo'

## Coreutils
alias cp="\cp -ip"
alias free="\free -h"
alias hurl="\curl -f#LO"
alias ll="\ls -halSFT 0 --group-directories-first --color=auto"
alias ls="\ls -hSCF --group-directories-first --color=auto"
alias mkdir="\mkdir -vp $@"
alias mv="\mv -i"
alias nano="\nano -EOSWcimx"
alias pss="\ps aux --sort -rss | \head -1; \ps aux | \grep -v \grep"
alias psw="\ps aux --sort -rss | \less"
alias rm="\rm -i"
