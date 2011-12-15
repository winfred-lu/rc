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
alias emacs="emacs -nw"
alias ls="ls -F --color=auto"
alias grep="grep --color=auto"
alias gencs='find $PWD -type f -name "*.[chxsS]" > cscope.files; cscope -v -b -k; ctags -R -n'

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

# env
export EDITOR="vim"
export PAGER="less -X"

# paths
#export PATH="$PATH:/opt/CodeSourcery/Sourcery_G++_Lite/bin"
export PATH="$PATH:/opt/arm-2011.03/bin"
export PATH="$PATH:/home/winfred/buildroot-2011.08/output/host/usr/bin"
export PATH="$PATH:/home/winfred/bin"

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
