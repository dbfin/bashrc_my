#!/bin/zsh --

zshrc_dir="$(dirname "$(readlink -f ${(%):-%x})")"

source $zshrc_dir/../welcome.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $zshrc_dir/p10k.sh
source $zshrc_dir/../aliases.sh
