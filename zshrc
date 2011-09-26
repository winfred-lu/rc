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

# prompt
PROMPT="%F{cyan}%~%f %% "

setopt AUTO_PUSHD

export EDITOR="vim"

