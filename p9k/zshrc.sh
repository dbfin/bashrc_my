#!/bin/zsh --

zshrc_dir="$(dirname "$(readlink -f ${(%):-%x})")"

source $zshrc_dir/../welcome.sh

# Lines configured by zsh-newuser-install
setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob
setopt HIST_IGNORE_DUPS
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename $HOME/.zshrc
autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey "\E[1;5D" backward-word
bindkey "\E[1;5C" forward-word
bindkey "\E[H" beginning-of-line
bindkey "\E[F" end-of-line
#bindkey "${terminfo[khome]}" beginning-of-line
#bindkey "${terminfo[kend]}" end-of-line

function zsh_clear_scrollback_and_reset() { printf '\e[3J' >$TTY && zle clear-screen }
zle -N zsh_clear_scrollback_and_reset
bindkey '^L' zsh_clear_scrollback_and_reset

source $zshrc_dir/my.sh
source $zshrc_dir/../aliases.sh
