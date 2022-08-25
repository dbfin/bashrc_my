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

autoload -U is-at-least

function _bashrc_my_f_sns() {
    _bashrc_my_res=$( find "${@:1:$(($#-1))}" -type f -path '*/'"${@[$#]}" 2>/dev/null | head -1 )
    [[ -n "$_bashrc_my_res" ]] || return 1
    source $_bashrc_my_res || return 2
    return 0
}

_bashrc_my_found_pm=0
_bashrc_my_used_pm=0
{
    _bashrc_my_f_sns /usr/share/zsh/ /usr/share/zplug/ $HOME/.zplug/ zplug/init.zsh || \
    _bashrc_my_f_sns /opt/homebrew/Cellar/zplug/ 'zplug/*/init.zsh';
} && _bashrc_my_found_pm=1

POWERLEVEL_VERSION=0
POWERLEVEL_SCRIPT=''
function _bashrc_my_f_load_powerlevel() {
    _bashrc_my_find_dirs=( `find /usr/share/ -maxdepth 1 -type d -name 'zsh*' -o -name '*powerlevel*' 2>/dev/null`
                           `find $HOME/ -maxdepth 1 -type d -name '.zsh*' -o -name '.*powerlevel*' 2>/dev/null`
                           `find $HOME/.zplug/repos/ -maxdepth 2 -type d -name '*powerlevel*' 2>/dev/null` )
    POWERLEVEL_SCRIPT=''
    is-at-least 5.1 && POWERLEVEL_SCRIPT=$( find $_bashrc_my_find_dirs -name powerlevel10k.zsh-theme 2>/dev/null | grep --color=no --max-count=1 . )
    if [[ -n "$POWERLEVEL_SCRIPT" ]]; then
        POWERLEVEL_VERSION=10
    else
        POWERLEVEL_SCRIPT=$( find $_bashrc_my_find_dirs -name powerlevel9k.zsh-theme 2>/dev/null | grep --color=no --max-count=1 . )
        if [[ -n "$POWERLEVEL_SCRIPT" ]]; then
            POWERLEVEL_VERSION=9
        elif [[ $1 -eq 0 ]]; then
            is-at-least 5.1 && {
                ( [[ $_bashrc_my_found_pm -eq 1 ]] && zplug "romkatv/powerlevel10k", as:theme && _bashrc_my_used_pm=1 || mkdir -p $HOME/.zplug/repos/romkatv/ && git clone https://github.com/romkatv/powerlevel10k $HOME/.zplug/repos/romkatv/powerlevel10k ) && _bashrc_my_f_load_powerlevel 1
            }
            is-at-least 5.1 || {
                mkdir -p $HOME/.zplug/repos/Powerlevel9k/ && git clone https://github.com/Powerlevel9k/powerlevel9k $HOME/.zplug/repos/Powerlevel9k/powerlevel9k && _bashrc_my_f_load_powerlevel 1
            }
        fi
    fi
}
_bashrc_my_f_load_powerlevel 0
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
setopt COMPLETE_IN_WORD

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

unset -f -m '_bashrc_my_f_*'
unset -m '_bashrc_my_*'

source $ZSHRC_DIRECTORY/aliases.sh
