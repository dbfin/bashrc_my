#!/bin/bash --

stty stop ^p

() {
    _bashrc_my_user="$(echo $USER|sed 's|.|\U&|')"
    _bashrc_my_fortune=$(command -v fortune 2>/dev/null) || _bashrc_my_fortune=''
    if [ -n "$_bashrc_my_fortune" ]; then
        _bashrc_my_width=69
        _bashrc_my_width_text=54
        _bashrc_my_color_b="\e[44m"
        _bashrc_my_color_f="\e[97m"
        _bashrc_my_color_ff="\e[93m"
        _bashrc_my_pad="$( printf "%${_bashrc_my_width}s" " " )"
        _bashrc_my_pad_="$( printf "%${_bashrc_my_width}s" " " | sed 's| |─|g' )"

        _bashrc_my_msg=" Welcome, $_bashrc_my_user! "
        _bashrc_my_text="$( $_bashrc_my_fortune -n 256 -s 2>/dev/null )"
        export QUOTE="$( echo "$_bashrc_my_text" | tr '\n' ' ' | sed 's|\s\+| |g' )"

        echo -en "\e[0m${_bashrc_my_color_b}${_bashrc_my_color_f}"
        printf '%s%s%s%s%s' '╭' "${_bashrc_my_pad_:1:$(( ($_bashrc_my_width-2-${#_bashrc_my_msg})/2 ))}" "$_bashrc_my_msg" "${_bashrc_my_pad_:1:$(( ($_bashrc_my_width-2-${#_bashrc_my_msg}+1)/2 ))}" '╮'
        echo -en "\e[0m\n${_bashrc_my_color_b}${_bashrc_my_color_f}"
        printf '%s%s%s' '│' "${_bashrc_my_pad:1:$(( $_bashrc_my_width-2 ))}" '│'
        while read l; do
            echo -en "\e[0m\n${_bashrc_my_color_b}${_bashrc_my_color_f}│ ${_bashrc_my_color_ff}"
            printf '%s%s' "${_bashrc_my_pad:1:$(( $_bashrc_my_width-4-${#l} ))}" "$( expand -t 1 <<< "$l" )"
            echo -en "${_bashrc_my_color_f} │"
        done < <( echo "$_bashrc_my_text" | fold -s -w $_bashrc_my_width_text )
        echo -en "\e[0m\n${_bashrc_my_color_b}${_bashrc_my_color_f}"
        printf '%s%s%s' '│' "${_bashrc_my_pad:1:$(( $_bashrc_my_width-2 ))}" '│'
        echo -en "\e[0m\n${_bashrc_my_color_b}${_bashrc_my_color_f}"
        printf '%s%s%s' '╰' "${_bashrc_my_pad_:1:$(( $_bashrc_my_width-2 ))}" '╯'
        echo -en "\e[0m\n"
        unset _bashrc_my_text _bashrc_my_msg _bashrc_my_pad_ _bashrc_my_pad _bashrc_my_color_ff _bashrc_my_color_f _bashrc_my_color_b _bashrc_my_width_text _bashrc_my_width
    else
        echo "Welcome, $_bashrc_my_user!"
    fi
    unset _bashrc_my_fortune _bashrc_my_user
}
