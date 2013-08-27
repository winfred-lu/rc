# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
if [ "$color_prompt" = yes ]; then
  if [ "$WINDOW" ]; then
    if [ `id -u` == "0" ]; then
      PS1="[\[\033[36m\]\h\[\033[0m\]][\[\033[32m\]W$WINDOW\[\033[0m\]][\[\033[1;33m\]\w\[\033[0m\]]\[\033[1;31m\]\\$\[\033[0m\] "
    else
      PS1="[\[\033[36m\]\h\[\033[0m\]][\[\033[32m\]W$WINDOW\[\033[0m\]][\[\033[1;33m\]\w\[\033[0m\]]\\$ "
    fi
  else
    if [ `id -u` == "0" ]; then
      PS1="[\[\033[36m\]\h\[\033[0m\]][\[\033[1;33m\]\w\[\033[0m\]]\[\033[1;31m\]\\$\[\033[0m\] "
    else
      PS1="[\[\033[36m\]\h\[\033[0m\]][\[\033[1;33m\]\w\[\033[0m\]]\\$ "
    fi
  fi
else
  if [ "$WINDOW" ]; then
    PS1="[\h][W$WINDOW][\w]\\$ "
  else
    PS1="[\h][\w]\\$ "
  fi
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
else
    alias ls='ls -F'
fi

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

stty -ixon
#set -o vi

export PATH=/opt/buildroot-gcc342/bin:$PATH
export PATH=$PATH:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH=$PATH:~/perl5/bin
export PAGER="less -X"
export EDITOR=vim
#export LANG=zh_TW.Big5
#export LC_ALL=en_US.ISO-8859-1
export LC_ALL=en_US.UTF8
#export LC_ALL=C
export CVS_RSH=ssh
#export CVSROOT=":ext:winfred@cvs:/home/cvsroot"
export HISTSIZE=5000
#export DISPLAY="192.168.43.99:0"

export J2RE_HOME=/usr/lib/jvm/java-1.5.0-sun/jre
export JAVA_HOME=/usr/lib/jvm/java-1.5.0-sun/jre
export ANDROID_JAVA_HOME=/usr/lib/jvm/java-1.5.0-sun/jre
export PATH=/usr/lib/jvm/java-1.5.0-sun/bin:$PATH
export PERL5LIB=~/perl5/lib/perl5

alias cdr='cd `echo $PWD | sed -e "s|\(/home/winfred/\)\([^/]\+\).*|\1\2|"`'
alias cdu='cd `echo $PWD | sed -e "s|\(/home/winfred/\)\([^/]\+\).*|\1\2/user|"`'
#alias cdk='cd `echo $PWD | sed -e "s|\(/home/winfred/\)\([^/]\+\).*|\1\2/linux-2.6.21.x|"`'
alias cdk='cd `echo $PWD | sed -e "s|\(.*\)\(linux\)\([a-zA-Z0-9._-]*\)/.*|\1\2\3/|"`'
alias cdw='cd `echo $PWD | sed -e "s|\(/home/winfred/\)\([^/]\+\).*|\1\2/linux-2.6.21.x/drivers/net/wireless/rt2860v2|"`'
alias cde='cd `echo $PWD | sed -e "s|\(/home/winfred/\)\([^/]\+\).*|\1\2/linux-2.6.21.x/drivers/net/raeth|"`'

alias b=exit
alias grep='grep -I -n --color --exclude=tags --exclude=cscope.out --exclude=cscope.files --exclude=.#*'
alias ls='ls -F --color=auto'
alias vi=vim
alias gencs='find $PWD -type f -name "*.[chxsS]" -a ! -path "*RT3090_ap*" -a ! -path "*RT3572_ap*" > cscope.files; cscope -v -b -k; ctags -R -n'
alias man="LANG=en_US.iso8859-1 man"

