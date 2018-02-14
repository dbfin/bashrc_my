#!/bin/bash --

function __bashrc_my__init() {

tt=''
if [[ -n "$ZSH_VERSION" ]]; then tt='zsh'; fi
if [[ -n "$BASH" ]]; then tt='bash'; fi

# check that we have an updated copy in /etc/profile.d/
# use in Bash only if you do not create a symbolic link to this file
#[ "$isbash" '==' 'true' ] && {
#diff "$BASH_SOURCE" "/etc/profile.d/$( basename "$BASH_SOURCE" )" 1>/dev/null 2>/dev/null \
#	|| { \
#		echo -en "\e[33mUpdating $( basename $BASH_SOURCE )... \e[31m" \
#			&& sudo cp "$BASH_SOURCE" "/etc/profile.d/$( basename $BASH_SOURCE )" \
#			&& sudo chmod a+r "/etc/profile.d/$( basename $BASH_SOURCE )" \
#			&& echo -e "\e[32mDone." \
#			|| echo -e "\e[34mFailed."; \
#		echo -en "\e[0m"; \
#	}
#}

# load git completion if needed
local gc
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] \
	&& gc="/usr/share/git-core/contrib/completion/git-prompt.sh" \
|| { \
	[ -f /etc/bash_completion.d/git-prompt.sh ] \
		&& gc="/etc/bash_completion.d/git-prompt.sh" \
	|| { \
		[ -f /usr/share/git/completion/git-completion.$tt ] \
			&& gc='/usr/share/git/completion/git-completion.zsh' \
		|| gc=''; \
	} \
}
[ $UID -ne 0 -a -n "$gc" ] \
	&& { \
		type __git_ps1 1>/dev/null 2>/dev/null \
			|| . "$gc" 2>/dev/null; \
	}

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

setopt PROMPT_SUBST 2>/dev/null
autoload -U colors 2>/dev/null && colors

# Bash requires '\[' and '\]' in the prompt not to count non-printable characters; and other shell-specific variables
local a='%{'
local z='%}'
local d='%D{%H:%M:%S}'
[ "$isbash" '==' 'true' ] && {
	a=$'\['
	z=$'\]'
	d='\D{%T}'
}

# colors and decorations
local T0=$a$'\e[0m'$z # reset all

local TDB=$a$'\e[1m'$z # bold
local TDU=$a$'\e[4m'$z # underlined
local TDI=$a$'\e[7m'$z # inversed
local TDB0=$a$'\e[21m'$z # reset bold
local TDU0=$a$'\e[24m'$z # reset underlined
local TDI0=$a$'\e[27m'$z # reset inversed
local TD0=$a$'\e[21;24;27m'$z # reset all decorations

local TFBL=$a$'\e[30m'$z
local TFR=$a$'\e[31m'$z
local TFG=$a$'\e[32m'$z
local TFY=$a$'\e[33m'$z
local TFB=$a$'\e[34m'$z
local TFM=$a$'\e[35m'$z
local TFC=$a$'\e[36m'$z
local TFLGR=$a$'\e[37m'$z
local TFGR=$a$'\e[90m'$z
local TFLR=$a$'\e[91m'$z
local TFLG=$a$'\e[92m'$z
local TFLY=$a$'\e[93m'$z
local TFLB=$a$'\e[94m'$z
local TFLM=$a$'\e[95m'$z
local TFLC=$a$'\e[96m'$z
local TFW=$a$'\e[97m'$z
local TF0=$a$'\e[39m'$z

local TBBL=$a$'\e[40m'$z
local TBR=$a$'\e[41m'$z
local TBG=$a$'\e[42m'$z
local TBY=$a$'\e[43m'$z
local TBB=$a$'\e[44m'$z
local TBM=$a$'\e[45m'$z
local TBC=$a$'\e[46m'$z
local TBLGR=$a$'\e[47m'$z
local TBGR=$a$'\e[100m'$z
local TBLR=$a$'\e[101m'$z
local TBLG=$a$'\e[102m'$z
local TBLY=$a$'\e[103m'$z
local TBLB=$a$'\e[104m'$z
local TBLM=$a$'\e[105m'$z
local TBLC=$a$'\e[106m'$z
local TBW=$a$'\e[107m'$z
local TB0=$a$'\e[49m'$z

# prompt

function __pwd() {
	echo -n "${PWD}"\
	| sed\
	-e 's/^'"$(echo "${HOME//\//\\\/}")"'\(\/\|$\)/⌂\1/'\
		-e 's|^\(⌂\?/[^/]*/\).*\(\(/[^/]*\)\{3\}/\?\)$|\1...\2|'\
		-e 's|\(.\)\/$|\1⇨|'
}

function __fetch() {
	local fetch="$( git rev-parse --show-toplevel 2>/dev/null )"
	if [ -n "$fetch" -a -n "$( git remote show 2>/dev/null )" ]; then
		fetch="$fetch/.git/FETCH_HEAD"
		if [ ! -e "$fetch" -o -n "$( find "$fetch" -mmin +5 2>/dev/null )" ]; then
			nohup git fetch --all --quiet >/dev/null 2>/dev/null & disown >/dev/null 2>/dev/null
		fi
	fi
}

function __fetch() {
    :
}
function __git_ps1() {
    :
}

export PS1="\
\$( __fetch )\
\
${TFY}\
${d} \
\
\$( [[ \${UID} -eq 0 ]] \
	&& echo -n '${TFLR}' \
	|| echo -n '${TFLB}' \
  )\
\
\$( [[ ! -z \"\${SUDO_USER}\" ]] \
	&& echo -n \"\${SUDO_USER}\" \
	|| echo -n \"\${USER}\" \
  ) \
\
${TF0}\$( __pwd )\
\
\$( PG=\"\$( __git_ps1 ' ± %s' 2>/dev/null )\" && [[ -n \"\$PG\" ]] && {\
	PGC='${TFLG}';\
	PGBC='${TFLG}';\
	PGB=\"\$( echo \"\$PG\" | sed -e 's|^.*(\\(.*\\)).*$|\\1|' )\";\
	PG_=\"\$( git symbolic-ref HEAD 2>/dev/null )\" || {\
		[[ \"\$PGB\" =~ ^[a-f0-9]+\.\.\.$ ]] \
			&& PGBC='${TFR}'\
			|| PGBC='${TFLY}';\
	};\
	echo '${TFLG}'\"\$( echo \"\$PG\" | sed\
		-e \"s|\\(u\\)\\([+0-9]*\\)\\-\\([0-9]\\+\\)|\\1«\\3\\2|\"\
		-e \"s|\\(u[«0-9]*\\)+|\\1»|\"\
		-e \"s|u||g\"\
		-e \"s|\\(\\*\\)\\(\\(.*\\)\\(+\\)\\)\\?|\\4\\1\\3|\"\
		-e \"s|\\(\\\\\\\\\$\\)\\([+*%]\\+\\)|\\2\\1|\"\
		-e \"s|\\\\\\\\\$| ʭ|\"\
		-e \"s|BARE\\:\\([^)]*\\)|\\1 ø |\"\
		-e \"s|\\|\\?MERGING| ×|\"\
		-e \"s| *\\\$||g\"\
		-e \"s|%|${TFLR}?\$PGC |\"\
		-e \"s|(\\(.*\\))|\$PGBC\\1\$PGC|\"\
		-e \"s|\\(+\\)|${TFLY}\\1\$PGC|\"\
		-e \"s|\\(\\*\\)|${TFLR}\\1\$PGC|\"\
		-e \"s|\\(«[0-9]*\\)|${TFLY}\\1\$PGC|\"\
		-e \"s|\\(ʭ\\)|${TFLB}\\1\$PGC|\"\
		-e \"s|\\(ø\\)|${TFLR}\\1\$PGC|\"\
		-e \"s|\\(×\\)|${TFLR}\\1\$PGC|\"\
		-e \"s|\\|\\?\\(AM\\)| ${TFLR}\\1\$PGC|\"\
		-e \"s|\\|\\?\\(REBASE\\(-[a-z]\\)\\?\\)| ${TFLR}\\1\$PGC|\"\
		-e \"s|  \\+| |g\"\
	)\"; \
} ) \
\
\$( [[ \${UID} -eq 0 ]] \
	&& echo -n '${TFLR}' \
	|| echo -n '${T0}' \
  )\
\
\\$ \
\
\$( [[ \${UID} -eq 0 ]] \
	&& echo -n '${TFGR}' \
  )\
"

}

__bashrc_my__init
unset __bashrc_my__init

# User specific aliases and functions
if [ $UID -ne 0 ]; then
	export GIT_PS1_SHOWDIRTYSTATE=true
	export GIT_PS1_SHOWSTASHSTATE=true
	export GIT_PS1_SHOWUNTRACKEDFILES=true
	export GIT_PS1_SHOWUPSTREAM="verbose"
	export GIT_PS1_DESCRIBE_STYLE="branch"
#	export GIT_PS1_SHOWCOLORHINTS=true

	stty stop ^p

	export HISTFILESIZE=1000000
	export HISTCONTROL=ignoredups
fi
