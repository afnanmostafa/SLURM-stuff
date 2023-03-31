# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#echo $'\e[1;33m'.bashrc loaded$'\e[0m'

## if bash prompt is not open, don't do anything and just exit out of this script
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## HISTCONTROL=ignorespace:ignoredups == HISTCONTROL=ignoreboth --> ignoring white space char and repeating entries for bash history to save space/memory
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

## appending new hist to previous
# append to the history file, don't overwrite it
shopt -s histappend

## 3 variables: HISTFILE, HISTSIZE, HISTFILESIZE
## HISTFILE=location of history file; HISTSIZE=# of entries can be saved during a bash session; HISTFILESIZE=# of entries will be saved when you log out
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

## checks and updates the window size after a command is executed
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

## commented-out = only directories; uncomment = directories + sub-directories
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


## LESS features
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

##
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

## for PS1 variable
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"


## prompt feature and colors
if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;35m\]:\[\033[01;31m\]\w\[\033[01;36m\]\$ '
    PS1="\[\e[01;97m\]{\[\e[m\]\[\e[01;32m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[0;36m\]\h\[\e[m\]\[\e[00;33m\]:\[\e[101;93m\]\w\[\e[m\]\[\e[97m\]}\[\e[m\]\[\e[31;46m\]\\$\[\e[m\]\[\e[01;96m\] "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi


unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sq="squeue -u username_domain"
alias sb="sbatch -A pi_username_domain scr_1.lammps"
alias si="sinfo -s"
alias sqq="squeue -u username_domain -o '%.18i %.9P %.12j %.8u %.2t %.10M %.6D %R %c'"
alias sqa='squeue -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R %c %.12e"'
alias sqz="sq -o '%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R %c %Z'"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## cool functions 
md ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}

today()
{
    echo Date: `date +"%A, %B %d, %Y"` return
}

##
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/modules/apps/oneapi/2022.2.3/mkl/latest/lib/intel64

