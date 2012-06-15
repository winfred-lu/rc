# -*- mode: sh -*-

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/winfred/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# history
HISTFILE=~/.history
HISTSIZE=5000
SAVEHIST=10000
export HISTIGNORE="&:ls:b:exit:clear:cd:cd .."
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# key bindings
bindkey -v
bindkey -M viins 'kj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
bindkey "\e[3~" delete-char
bindkey '\e[C' forward-char
bindkey '\e[D' backward-char
bindkey '\e^?' backward-delete-word
bindkey -s '\eu' 'cd ..^M'
bindkey -s '\ep' 'dirs -v^M'

# aliases
alias b="exit"
alias em="emacsclient -nw"
alias ls="ls -F --color=auto"
alias gencs='find . -type f -name "*.[chxsS]" -o -name "*.cpp" >! cscope.files; cscope -b -k; ctags -R -n -e'

# nocorrect
alias irssi="nocorrect irssi"
alias git="nocorrect git"

stty -ixon
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CORRECT
setopt CORRECTALL
setopt NO_FLOW_CONTROL
setopt NO_CLOBBER
setopt RM_STAR_WAIT
set ignoreeof on

# env
export ALTERNATE_EDITOR=""    # for emacsclient
export EDITOR="vim"
export PAGER="less"
export LESS="-FRX"
export GREP_OPTIONS="-I --color=auto --exclude=tags --exclude=TAGS --exclude=cscope.\*"
case $TTY in
/dev/pts*)
    export TERM=rxvt-unicode-256color
    ;;
*)
    export TERM=xterm-256color
    ;;
esac

# colored less
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;120m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# paths
#export PATH="$PATH:/opt/CodeSourcery/Sourcery_G++_Lite/bin"
#export PATH="$PATH:/opt/eldk-5.1/armv5te/sysroots/i686-eldk-linux/usr/bin/armv5te-linux-gnueabi"
#export PATH="$PATH:/opt/arm-2011.03/bin"
export PATH="$PATH:$HOME/buildroot/output/host/usr/bin"
export PATH="$PATH:/sbin:/usr/sbin"
export PATH="$PATH:$HOME/bin:./"

# prompt
PROMPT='%F{5}%m %F{6}%~ %(!.%F{1}.%f)%#%f '
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:cvs:*' formats   '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%r%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'

autoload run-help
bindkey '\eh' run-help
