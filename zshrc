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
HISTSIZE=3000
SAVEHIST=6000
export HISTORY_IGNORE="(ls*|b|exit|clear|cd|cd -|cd ..)"
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS

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
alias e="emacsclient -nw"
alias E='SUDO_EDITOR="emacsclient -t -a emacs" sudoedit'
alias ls="ls -F --color=auto"
alias gencs='find . -type f -name "*.[chxsS]" -o -name "*.cpp" >! cscope.files; cscope -b -k; ctags -R -n -e'
alias genarcs='find . -type f -regextype posix-egrep -regex ".*\.(cpp|pde|ino|h)$" >! cscope.files; cscope -b -k; ctags -R -n -e'

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

# customized grep options
GREP_OPTIONS="-I --color=auto"
GREP_OPTIONS+=" --exclude=tags --exclude=TAGS --exclude=cscope.\*"
grep-flag-available() {
    echo | grep $1 "" >/dev/null 2>&1
}
if grep-flag-available --exclude-dir=.cvs; then
    for PATTERN in .cvs .git .hg .svn; do
        GREP_OPTIONS+=" --exclude-dir=$PATTERN"
    done
elif grep-flag-available --exclude=.cvs; then
    for PATTERN in .cvs .git .hg .svn; do
        GREP_OPTIONS+=" --exclude=$PATTERN"
    done
fi
unfunction grep-flag-available

# alias grep since GREP_OPTIONS is deprecated
alias grep="grep $GREP_OPTIONS"

# env
export ALTERNATE_EDITOR=""    # for emacsclient
export EDITOR="vim"
export PAGER="less"
export LESS="-FRX"
case $TTY in
/dev/pts*)
    if [[ -n $TMUX ]]; then
        export TERM=tmux-256color
    else
        export TERM=rxvt-unicode-256color
    fi
    ;;
*)
    uname=`uname`
    if [[ $uname[1,6] = "CYGWIN" ]]; then
        export TERM=rxvt-256color
    else
        export TERM=xterm-256color
    fi
    ;;
esac
export MINICOM='-c on'

# colored less
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;120m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# paths
export PATH="$PATH:/sbin:/usr/sbin"
export PATH="$PATH:/usr/lib/cargo/bin"
export PATH="$PATH:/usr/local/nvim-linux64/bin"
export PATH="$PATH:$HOME/.local/bin:$HOME/bin:./"

# toolchain settings
function wf-remove-toolchain-from-path() {
    if [ $PATH[1,5] = "/opt/" ]; then     # if PATH (first element) starts with "/opt/"
        export PATH=${PATH#*:}            # take part after first :
    fi
}
function use-linaro-baremetal() {
    local tcpath=/opt/gcc-arm-none-eabi-4_8-2014q2/bin
    export CROSS_COMPILE=arm-none-eabi-
    wf-remove-toolchain-from-path
    export PATH=$tcpath:$PATH
    echo "path = $tcpath"
    echo "CROSS_COMPILE = $CROSS_COMPILE"
}
function use-linaro-baremetal4.9() {
    local tcpath=/opt/gcc-linaro-arm-none-eabi-4.9-2014.05_linux/bin
    export CROSS_COMPILE=arm-none-eabi-
    wf-remove-toolchain-from-path
    export PATH=$tcpath:$PATH
    echo "path = $tcpath"
    echo "CROSS_COMPILE = $CROSS_COMPILE"
}
function use-linaro-linux() {
    local tcpath=/opt/gcc-linaro-arm-linux-gnueabihf-4.9-2014.05_linux/bin
    export CROSS_COMPILE=arm-linux-gnueabihf-
    wf-remove-toolchain-from-path
    export PATH=$tcpath:$PATH
    echo "path = $tcpath"
    echo "CROSS_COMPILE = $CROSS_COMPILE"
}
function use-sourcery-uclinux() {
    local tcpath=/opt/arm-2010q1/bin
    export CROSS_COMPILE=arm-uclinuxeabi-
    wf-remove-toolchain-from-path
    export PATH=$tcpath:$PATH
    echo "path = $tcpath"
    echo "CROSS_COMPILE = $CROSS_COMPILE"
}
function use-eldk() {
    local tcpath=/opt/eldk-5.1/armv5te/sysroots/i686-eldk-linux/usr/bin/armv5te-linux-gnueabi
    export CROSS_COMPILE=arm-linux-gnueabi-
    wf-remove-toolchain-from-path
    export PATH=$tcpath:$PATH
    echo "path = $tcpath"
    echo "CROSS_COMPILE = $CROSS_COMPILE"
}

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

#autoload -U zmv

export FZF_DEFAULT_COMMAND='fd'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND -t f"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND -t d"

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
