# Path to your oh-my-zsh installation.
ZSH=$HOME/.oh-my-zsh/

# Set the theme and theme options
ZSH_THEME="davidh"
DEFAULT_USER=$(whoami)

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# enable tmux plugin and option
plugins=(tmux)
[[ ! -z "$DISPLAY" ]] && ZSH_TMUX_AUTOSTART='true'

# Cache Setup
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

############
# My Stuff #
############

export GOPATH=~/Development/Go/.go
export GOBIN=$GOPATH/bin
export ANDROID_SDK=~/.android-sdk
export ANDROID_SDK_ROOT=$ANDROID_SDK
export ANDROID_NDK=$ANDROID_SDK/ndk/22.1.7171670
export ANDROID_NDK_HOME=$ANDROID_NDK
export PATH=$PATH:~/.bin:$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools:$GOBIN
export WINEDEBUG=-all
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

## Environment
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export TERM="xterm-256color"
export PAGER=less

## Use Clang by default
export CC='/usr/bin/clang'
export CXX='/usr/bin/clang++'

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

## Cheats
alias pacman='\sudo pacman'
alias dnf='\sudo dnf'
alias docker='\sudo docker'

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
alias nano="\nano -EOSWcimxl"
alias pss="\ps aux --sort -rss | \head -1; \ps aux | \grep -v \grep"
alias psw="\ps aux --sort -rss | \less"
alias rm="\rm -i"
alias mpa="\mpv --no-video"
alias less="\less -FXRQ"
alias man="\man -P 'less -FXRQ'"

## Functions
mkcd () {
  if [[ $# -eq 0 ]]; then
    printf "mkcd: mkdir and cd\n"
    printf "USAGE:\n"
    printf "   mkcd /path/to/create/and/cd\n\n"
    printf "mkcd will create all parent directories as needed\n"
    return
  fi
  \mkdir -pv $1
  \cd $1
}

untar () {
  if [[ $# -eq 0 ]]; then
    printf "untar: extract a tar file\n"
    printf "USAGE:\n"
    printf "   untar /path/to/file.tar.{bz2 gz xz}\n\n"
    printf "untar will determine the extension\n"
    return
  fi

  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1 ;;
      *.tar.gz)    tar zxf $1 ;;
      *.tar.xz)    tar xJf $1 ;;
      *.tar)       tar xf  $1 ;;
      *) echo "$1 is not a valid tar file"; return ;;
    esac
  else
    echo "'$1' is not a valid tar file"
  fi
}

mktar () {
  if [[ $# -lt 2 ]]; then
    printf "mktar: create tar file\n"
    printf "USAGE:\n"
    printf "   mktar /name/of/file.tar.{bz2 gz xz} /path/to/compress\n\n"
    printf "mktar will determine the extension\n"
    return
  fi

  case $1 in
     *.tar.bz2)   tar cjf $1 $2;;
     *.tar.gz)    tar czf $1 $2;;
     *.tar.xz)    tar cJf $1 $2;;
     *.tar)       tar cf  $1 $2;;
     *) echo "$1 is not a valid tar file"; return ;;
  esac
}

########################
source $ZSH/oh-my-zsh.sh
