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

# key bindings
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey "\e[3~" delete-char

# aliases
alias b="exit"
alias ls="ls -F --color=auto"
alias grep="grep --color=auto"
alias mm="make menuconfig"
alias md="make dep; make"
alias mc="make clean; make"

setopt AUTO_PUSHD

export EDITOR="vim"

# prompt
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' actionformats '%s%F{3}(%f%b%F{3})%f '
zstyle ':vcs_info:cvs:*' formats       '%s '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r '
zstyle ':vcs_info:*' enable git cvs svn
precmd () { vcs_info }
PROMPT='${vcs_info_msg_0_}%F{6}%3~%f %# '
