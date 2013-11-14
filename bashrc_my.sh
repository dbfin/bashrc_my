#!/bin/bash --

function __bashrc_my__init() {

# check that we have an updated copy in /etc/profile.d/
diff "$BASH_SOURCE" "/etc/profile.d/$( basename "$BASH_SOURCE" )" >/dev/null 2>/dev/null || { echo -en "\e[33mUpdating $( basename $BASH_SOURCE )... \e[31m" && sudo cp "$BASH_SOURCE" "/etc/profile.d/$( basename $BASH_SOURCE )" && sudo chmod a+r "/etc/profile.d/$( basename $BASH_SOURCE )" && echo -e "\e[32mDone."; echo -en "\e[0m"; }

# load git completion if needed
[ $UID -ne 0 -a -z "$( type -t __git_ps1 )" -a -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && echo -en "\e[33mLoading git completion... \e[31m" && . /usr/share/git-core/contrib/completion/git-prompt.sh && echo -e "\e[32mDone."
echo -en "\e[0m"

# Welcome!

command -v fortune 1>/dev/null 2>/dev/null && {

local W=69
local WB="\e[44m"
local WF="\e[97m"
local WFF="\e[93m"
local pad="$( printf "%${W}s" " " )"
local pad_="$( printf "%${W}s" " " | sed 's| |─|g' )"
local msg=" Welcome, ${USER^}! "

echo -en "\e[0m\n${WB}${WF}"
printf '%s%s%s%s%s' '╭' "${pad_:1:$(( ($W-2-${#msg})/2 ))}" "$msg" "${pad_:1:$(( ($W-2-${#msg}+1)/2 ))}" '╮'
echo -en "\e[0m\n${WB}${WF}"
printf '%s%s%s' '│' "${pad:1:$(( $W-2 ))}" '│'
local m="$( command -v fortune 2>/dev/null )"
if [ -f "$m" ]; then
	while read l; do
		echo -en "\e[0m\n${WB}${WF}│ ${WFF}"
		printf '%s%s' "${pad:1:$(( $W-4-${#l} ))}" "$l"
		echo -en "${WF} │"
	done < <( $m 2>/dev/null | fold -s -w 54 )
fi
echo -en "\e[0m\n${WB}${WF}"
printf '%s%s%s' '│' "${pad:1:$(( $W-2 ))}" '│'
echo -en "\e[0m\n${WB}${WF}"
printf '%s%s%s' '╰' "${pad_:1:$(( $W-2 ))}" '╯'
echo -en "\e[0m\n"
echo ''

} || echo "Welcome, ${USER^}!"

# Prompt

# colors and decorations
local T0='\[\e[0m\]' # reset all

local TDB='\[\e[1m\]' # bold
local TDU='\[\e[4m\]' # underlined
local TDI='\[\e[7m\]' # inversed
local TDB0='\[\e[21m\]' # reset bold
local TDU0='\[\e[24m\]' # reset underlined
local TDI0='\[\e[27m\]' # reset inversed
local TD0='\[\e[21;24;27m\]' # reset all decorations

local TFBL='\[\e[30m\]'
local TFR='\[\e[31m\]'
local TFG='\[\e[32m\]'
local TFY='\[\e[33m\]'
local TFB='\[\e[34m\]'
local TFM='\[\e[35m\]'
local TFC='\[\e[36m\]'
local TFLGR='\[\e[37m\]'
local TFGR='\[\e[90m\]'
local TFLR='\[\e[91m\]'
local TFLG='\[\e[92m\]'
local TFLY='\[\e[93m\]'
local TFLB='\[\e[94m\]'
local TFLM='\[\e[95m\]'
local TFLC='\[\e[96m\]'
local TFW='\[\e[97m\]'
local TF0='\[\e[39m\]'

local TF256='\[\e[38;5;' # 256-color foreground: must be followed by ###m\]

local TBBL='\[\e[40m\]'
local TBR='\[\e[41m\]'
local TBG='\[\e[42m\]'
local TBY='\[\e[43m\]'
local TBB='\[\e[44m\]'
local TBM='\[\e[45m\]'
local TBC='\[\e[46m\]'
local TBLG='\[\e[47m\]'
local TBG='\[\e[100m\]'
local TBLR='\[\e[101m\]'
local TBLG='\[\e[102m\]'
local TBLY='\[\e[103m\]'
local TBLB='\[\e[104m\]'
local TBLM='\[\e[105m\]'
local TBLC='\[\e[106m\]'
local TBW='\[\e[107m\]'
local TB0='\[\e[49m\]'

local TB256='\[\e[48;5;' # 256-color background: must be followed by ###m\]

# prompt
export PROMPT_DIRTRIM=3
export PS1="\
${TFY}\
\D{%T} \
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
${TF0}\w\
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
		-e \"s|\\(u[-0-9]*\\)+|\\1»|\"\
		-e \"s|\\(u[+0-9]*\\)\\-|\\1«|\"\
		-e \"s|[u=]||g\"\
		-e \"s|\\(\\*\\)\\(\\(.*\\)\\(+\\)\\)\\?|\\4\\1\\3|\"\
		-e \"s|\\(\\\\\\\\\$\\)\\([+*%]\\+\\)|\\2\\1|\"\
		-e \"s|\\\\\\\\\$| ʭ|\"\
		-e \"s|BARE\\:\\([^)]*\\)|\\1 ø |\"\
		-e \"s|  \\+| |g\"\
		-e \"s| *\\\$||g\"\
		-e \"s|(\\(.*\\))|\$PGBC\\1\$PGC|\"\
		-e \"s|\\(+\\)|${TFLY}\\1\$PGC|\"\
		-e \"s|\\(\\*\\)|${TFLR}\\1\$PGC|\"\
		-e \"s|%|${TFLR}?\$PGC|\"\
		-e \"s|\\(«[0-9]*\\)|${TFLY}\\1\$PGC|\"\
		-e \"s|\\(ʭ\\)|${TFLB}\\1\$PGC|\"\
		-e \"s|\\(ø\\)|${TFLR}\\1\$PGC|\"\
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

	export HISTFILESIZE=11111
	export HISTCONTROL=ignoredups

	alias gita='git add -i'
	alias gitam='git commit --amend'
	alias gitc="git commit -m \"\$( read -p Message:\\  m && echo \$m )\""
	alias gitch='git checkout'
	alias gitd='git diff'
	alias gitl='git log --all --oneline --decorate --abbrev-commit --graph -n'
	alias gitp='git push -u --tags origin master'
	alias gitpl='git pull'
	alias gits='git status -sb'
	alias gitst='git stash'
	alias gitsti='git stash --keep-index'
	alias gitstl='git stash list'
	alias gitstp='git stash pop'
	alias gitstpi='git stash pop --index'
fi

