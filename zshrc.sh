#!/bin/zsh --

export ZSHRC_DIRECTORY="$(dirname "$(readlink -f ${(%):-%x})")"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export TERM='xterm-256color'

export HISTFILE=~/.histfile
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export SAVEHIST=1000000000
export HISTCONTROL=ignoredups

[[ "$PATH" =~ '/\.local/bin/?(:|$)' ]] || export PATH=$PATH:$HOME/.local/bin

POWERLEVEL_VERSION=10
() {
    find_dirs=( `find /usr/share/ -maxdepth 1 -type d -name 'zsh*' -o -name '*powerlevel*' 2>/dev/null`
                `find $HOME -maxdepth 1 -type d -name '.zsh*' -o -name '.*powerlevel*' 2>/dev/null` )
    POWERLEVEL_SCRIPT=`find $find_dirs -name powerlevel10k.zsh-theme 2>/dev/null | grep --color=no .` || \
    ( POWERLEVEL_SCRIPT=`find $find_dirs -name powerlevel9k.zsh-theme 2>/dev/null | grep --color=no .` && POWERLEVEL_VERSION=9 )
}
export POWERLEVEL_VERSION
export POWERLEVEL_SCRIPT

# Lines configured by zsh-newuser-install
setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename $HOME/.zshrc
autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U is-at-least
is-at-least 5.8 && export ZLE_RPROMPT_INDENT=0

source $ZSHRC_DIRECTORY/welcome.sh

if [[ $POWERLEVEL_VERSION -eq 10 ]]; then
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
else
    source $ZSHRC_DIRECTORY/p9k_pre.sh
fi

source $ZSHRC_DIRECTORY/init.sh

if [[ $POWERLEVEL_VERSION -eq 10 ]]; then
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    source $ZSHRC_DIRECTORY/p10k_post.sh
else
    source $ZSHRC_DIRECTORY/p9k_post.sh
fi

source $ZSHRC_DIRECTORY/aliases.sh
