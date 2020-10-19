#!/bin/bash --

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export TERM='xterm-256color'

export HISTFILE=~/.histfile
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export SAVEHIST=1000000000
export HISTCONTROL=ignoredups

export ZLE_RPROMPT_INDENT=0

[[ "$PATH" =~ '/\.local/bin/?(:|$)' ]] || export PATH=$PATH:$HOME/.local/bin

() {
    local found=0
    for d in {/usr/share/{zsh-theme-,},$HOME/.}powerlevel10k/; do
        if [[ -f "${d}powerlevel10k.zsh-theme" ]]; then
            source "${d}"powerlevel10k.zsh-theme
            found=1
            break
        fi
    done
    [[ $found == 1 ]] || { echo 'zsh'"'"'s powerlevel10k theme is not found.'; return 1; }
}
