# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' '' '' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/winfred/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# history
HISTFILE=~/.history
HISTSIZE=5000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# key bindings
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
bindkey "\e[3~" delete-char
bindkey '\e[C' forward-char
bindkey '\e[D' backward-char
bindkey -s '\eu' 'cd ..^M'
bindkey -s '\ep' 'dirs -v^M'

# aliases
alias b="exit"
alias ls="ls -F --color=auto"
alias grep="grep --color=auto"
alias mm="make menuconfig"
alias md="make dep; make"
alias mc="make clean; make"
alias gencs='find $PWD -type f -name "*.[chxsS]" -a ! -path "*RT3090_ap*" -a ! -path "*RT3572_ap*" > cscope.files; cscope -v -b -k; ctags -R -n'

stty -ixon
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CORRECT
setopt CORRECTALL
setopt NO_FLOW_CONTROL
setopt NO_CLOBBER
setopt RM_STAR_WAIT

export EDITOR="vim"

# prompt
PROMPT='%F{6}%~%f %# '
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