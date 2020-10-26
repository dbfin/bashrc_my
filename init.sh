#!/bin/bash --

function sns() {
    local res=$( find "${@:1:$(($#-1))}" -type f -path '*/'"${@[$#]}" 2>/dev/null | head -1 )
    [[ -n "$res" ]] || return 1
    source $res || return 2
}

() {
    local found_pm=1
    sns /usr/share/zsh/ /usr/share/zplug/ $HOME/.zplug/ zplug/init.zsh || found_pm=0
    local used_pm=0
    for plugin in autosuggestions syntax-highlighting history-substring-search; do
        local found_plugin=0
        for script_name in zsh-$plugin{.plugin,}.{z,}sh; do
            sns /usr/share/zsh*/ $script_name && { found_plugin=1; break; }
        done
        if [[ $found_plugin -eq 0 && $found_pm -eq 1 ]]; then
            zplug "zsh-users/zsh-$plugin", as:plugin
            used_pm=1
        fi
    done
    if [[ -n "$POWERLEVEL_SCRIPT" ]]; then
        source $POWERLEVEL_SCRIPT
    elif [[ $found_pm -eq 1 ]]; then
        zplug "romkatv/powerlevel${POWERLEVEL_VERSION}k", as:theme
        used_pm=1
    fi
    if [[ $used_pm -eq 1 ]]; then
        zplug check || zplug install
        zplug load
    fi
}

unset sns

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=$HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
export HISTORY_SUBSTRING_SEARCH_FUZZY=1

function zsh_clear_scrollback_and_reset() { printf '\e[3J' >$TTY && zle clear-screen }
zle -N zsh_clear_scrollback_and_reset

bindkey '^L' zsh_clear_scrollback_and_reset
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '^[[1;5A' history-substring-search-up
bindkey '^[[1;5B' history-substring-search-down
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down
