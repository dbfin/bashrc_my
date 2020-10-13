#!/bin/bash --

stty stop ^p

function __my__init() {

    # Welcome!

    local user="$(echo $USER|sed 's|.|\U&|')"
    local fortune=$(command -v fortune 2>/dev/null) || fortune=''
    if [ -n "$fortune" ]; then

        local W=69
        local WT=54
        local WB="\e[44m"
        local WF="\e[97m"
        local WFF="\e[93m"
        local pad="$( printf "%${W}s" " " )"
        local pad_="$( printf "%${W}s" " " | sed 's| |─|g' )"
        local msg=" Welcome, $user! "

        local text="$( $fortune -n 256 -s 2>/dev/null )"
        export QUOTE="$( echo "$text" | tr '\n' ' ' | sed 's|\s\+| |g' )"
        echo -en "\e[0m${WB}${WF}"
        printf '%s%s%s%s%s' '╭' "${pad_:1:$(( ($W-2-${#msg})/2 ))}" "$msg" "${pad_:1:$(( ($W-2-${#msg}+1)/2 ))}" '╮'
        echo -en "\e[0m\n${WB}${WF}"
        printf '%s%s%s' '│' "${pad:1:$(( $W-2 ))}" '│'
        while read l; do
            echo -en "\e[0m\n${WB}${WF}│ ${WFF}"
            printf '%s%s' "${pad:1:$(( $W-4-${#l} ))}" "$( expand -t 1 <<< "$l" )"
            echo -en "${WF} │"
        done < <( echo "$text" | fold -s -w $WT )
        echo -en "\e[0m\n${WB}${WF}"
        printf '%s%s%s' '│' "${pad:1:$(( $W-2 ))}" '│'
        echo -en "\e[0m\n${WB}${WF}"
        printf '%s%s%s' '╰' "${pad_:1:$(( $W-2 ))}" '╯'
        echo -en "\e[0m\n"

    else
        echo "Welcome, $user!"
    fi

} # function __my__init

__my__init
unset __my__init
