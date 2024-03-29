#!/bin/zsh --

() {
    for plugin in autosuggestions syntax-highlighting history-substring-search; do
        _bashrc_my_found_plugin=0
        for script_name in zsh-$plugin{.plugin,}.{z,}sh; do
            _bashrc_my_f_sns /usr/share/zsh*/ $script_name && { _bashrc_my_found_plugin=1; break; }
        done
        if [[ $_bashrc_my_found_plugin -eq 0 && $_bashrc_my_found_pm -eq 1 ]]; then
            zplug "zsh-users/zsh-$plugin", as:plugin && _bashrc_my_used_pm=1
        fi
    done
    if [[ -n "$POWERLEVEL_SCRIPT" ]]; then
        source $POWERLEVEL_SCRIPT
    fi
    if [[ $_bashrc_my_used_pm -eq 1 ]]; then
        zplug check || zplug install
        zplug load
    fi
}

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=$HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND
export HISTORY_SUBSTRING_SEARCH_FUZZY=1

# Key shortcuts

# common keys
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# search history
#bindkey '^[[1;5A' history-substring-search-up
#bindkey '^[[1;5B' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# autosuggest
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
    end-of-line
    vi-end-of-line
    vi-add-eol
)
