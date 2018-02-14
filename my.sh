#!/bin/bash --

function custom_vcs() {
    POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
    prompt_vcs $1 $2
    POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
}

function __my__init() {

tt=''
[ -n "$BASH" ] && tt='bash'
[ -n "$ZSH_VERSION" ] && tt='zsh'

# Welcome!

user="$(echo $USER|sed 's|.|\U&|')"

fortune=$(command -v fortune 2>/dev/null) || fortune=''
[ -n "$fortune" ] && {

local W=69
local WT=54
local WB="\e[44m"
local WF="\e[97m"
local WFF="\e[93m"
local pad="$( printf "%${W}s" " " )"
local pad_="$( printf "%${W}s" " " | sed 's| |─|g' )"
local msg=" Welcome, $user! "

text="$( $fortune -n 256 -s 2>/dev/null )"
export QUOTE="$( echo "$text" | tr '\n' ' ' | sed 's|\s\s\+| |g' )"
echo -en "\e[0m\n${WB}${WF}"
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
echo ''

} || echo "Welcome, $user!"

# Prompt

# POWERLEVEL9K
DEFAULT_USER=$USER
local BG_COLOR=0

source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( time custom_user dir custom_vcs status )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( background_jobs )
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS=''
POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR=' '
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '
POWERLEVEL9K_WHITESPACE_BETWEEN_RIGHT_SEGMENTS=''
POWERLEVEL9K_RIGHT_SEGMENT_END_SEPARATOR=''

# time
POWERLEVEL9K_TIME_BACKGROUND=$BG_COLOR
POWERLEVEL9K_TIME_FOREGROUND=3
# custom_user
POWERLEVEL9K_CUSTOM_USER='echo $USER'
POWERLEVEL9K_CUSTOM_USER_BACKGROUND=$BG_COLOR
POWERLEVEL9K_CUSTOM_USER_FOREGROUND=12
# dir
POWERLEVEL9K_HOME_FOLDER_ABBREVIATION='⌂'
POWERLEVEL9K_SHORTEN_STRATEGY=Default
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$BG_COLOR
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=15
POWERLEVEL9K_DIR_HOME_BACKGROUND=$BG_COLOR
POWERLEVEL9K_DIR_HOME_FOREGROUND=15
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$BG_COLOR
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=15
POWERLEVEL9K_DIR_NOT_WRITABLE_BACKGROUND=$BG_COLOR
POWERLEVEL9K_DIR_NOT_WRITABLE_FOREGROUND=15
# custom_vcs
POWERLEVEL9K_CUSTOM_VCS='custom_vcs $1 $2'
POWERLEVEL9K_CUSTOM_VCS_BACKGROUND=$BG_COLOR
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=10
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=$BG_COLOR
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=11
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=$BG_COLOR
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=13
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=$BG_COLOR
# status
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_OK_BACKGROUND=$BG_COLOR
POWERLEVEL9K_STATUS_ERROR_BACKGROUND=$BG_COLOR
# background_jobs
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=$BG_COLOR
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=14

}

__my__init
unset __my__init

# User specific settings

if [ $UID -ne 0 ]; then
#	export GIT_PS1_SHOWDIRTYSTATE=true
#	export GIT_PS1_SHOWSTASHSTATE=true
#	export GIT_PS1_SHOWUNTRACKEDFILES=true
#	export GIT_PS1_SHOWUPSTREAM="verbose"
#	export GIT_PS1_DESCRIBE_STYLE="branch"
#	export GIT_PS1_SHOWCOLORHINTS=true
fi

stty stop ^p

export HISTFILESIZE=1000000
export HISTCONTROL=ignoredups
