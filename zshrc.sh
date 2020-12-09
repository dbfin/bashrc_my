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

function sns() {
    local res=$( find "${@:1:$(($#-1))}" -type f -path '*/'"${@[$#]}" 2>/dev/null | head -1 )
    [[ -n "$res" ]] || return 1
    source $res || return 2
}

found_pm=0
used_pm=0
sns /usr/share/zsh/ /usr/share/zplug/ zplug/init.zsh && found_pm=1

POWERLEVEL_VERSION=0
POWERLEVEL_SCRIPT=''
() {
    local find_dirs=( `find /usr/share/ -maxdepth 1 -type d -name 'zsh*' -o -name '*powerlevel*' 2>/dev/null`
                      `find $HOME/ -maxdepth 1 -type d -name '.zsh*' -o -name '.*powerlevel*' 2>/dev/null`
                      `find $HOME/.zplug/repos/ -maxdepth 2 -type d -name '*powerlevel*' 2>/dev/null` )
    POWERLEVEL_SCRIPT=$( find $find_dirs -name powerlevel10k.zsh-theme 2>/dev/null | grep --color=no --max-count=1 . )
    if [[ -n "$POWERLEVEL_SCRIPT" ]]; then
        POWERLEVEL_VERSION=10
    else
        POWERLEVEL_SCRIPT=$( find $find_dirs -name powerlevel9k.zsh-theme 2>/dev/null | grep --color=no --max-count=1 . )
        if [[ -n "$POWERLEVEL_SCRIPT" ]]; then
            POWERLEVEL_VERSION=9
        elif [[ $found_pm -eq 1 ]]; then
            zplug "romkatv/powerlevel10k", as:theme && ( POWERLEVEL_VERSION=10; used_pm=1; )
        fi
    fi
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

source $ZSHRC_DIRECTORY/welcome.sh

if [[ $POWERLEVEL_VERSION -eq 10 ]]; then
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
elif [[ $POWERLEVEL_VERSION -eq 9 ]]; then
    source $ZSHRC_DIRECTORY/p9k_pre.sh
fi

source $ZSHRC_DIRECTORY/init.sh

autoload -U is-at-least
is-at-least 5.8 && {
    export ZLE_RPROMPT_INDENT=0
    function zsh_clear_scrollback_and_reset() { printf '\e[3J' >$TTY && zle clear-screen }
    zle -N zsh_clear_scrollback_and_reset
    bindkey '^L' zsh_clear_scrollback_and_reset
}

if [[ $POWERLEVEL_VERSION -eq 10 ]]; then
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    source $ZSHRC_DIRECTORY/p10k_post.sh
elif [[ $POWERLEVEL_VERSION -eq 9 ]]; then
    source $ZSHRC_DIRECTORY/p9k_post.sh
fi

unset used_pm
unset found_pm
unset sns

source $ZSHRC_DIRECTORY/aliases.sh
