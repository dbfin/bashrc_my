#!/bin/sh --

alias diff='colordiff'
alias grep='grep --color=auto'

alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -l'
alias lla='ll -A'
alias l1='ls -1'
alias l1a='l1 -A'

alias vi='vim'
alias svi='sudo vi'
alias svim='sudo vim'

alias thanks='exit'

alias gita='git add -i'
alias gitb='git branch'
function gitcommit() {
	git commit ${1:+-m "$1"};
}
alias gitc='gitcommit'
alias gitca='git commit --amend'
alias gitch='git checkout'
alias gitcl='git clone'
alias gitd='git diff'
alias gitf='git fetch'
function gitlog() {
	git log --oneline --decorate --abbrev-commit --graph ${1:+-n }$1; 
}
alias gitl='gitlog'
alias gitlall='gitlog --all'
alias gitp='git push -u --tags origin `git rev-parse --abbrev-ref HEAD`'
alias gitpb='git push -u --tags origin'
alias gitpl='git pull'
alias gitrb='git rebase'
alias gitrbi='git rebase -i'
alias gitrbc='git rebase --continue'
alias gitrba='git rebase --abort'
alias gits='git status -sb'
alias gitsm='gits | grep '"'"'^[ #][^ ]*'"'"''
alias gitsns='gits | grep '"'"'^[ ?#][^ ]*'"'"''
alias gitss='gits | grep '"'"'^[^ ?]\+'"'"''
alias gitst='git stash'
alias gitsti='git stash --keep-index'
alias gitstl='git stash list'
alias gitstp='git stash pop'
alias gitstpi='git stash pop --index'

function quote_save() {
	if [ -n "$1" ]; then
		fortune=$(command -v fortune 2>/dev/null) || fortune=''
		[ -z "$fortune" ] && echo 'Command fortune is not found.' && return 1
		quote="$( $fortune -n 256 -s -i -m "$1" 2>/dev/null | awk 'BEGIN{srand();RS="\n%\n"}rand()<1/NR{_=$0}END{print _}' )"
		[ -z "$quote" ] && echo 'No matching quotes are found.' && return 1
		echo -e "$quote"
		echo -n 'Save? '
		read yn
		[[ ! "$yn" =~ ^[Yy]([Ee][Ss])?$ ]] && return 0
	else
		quote="$QUOTE"
	fi
	local file=~/Settings/Personal/quotes.txt
	{ [ -z "$quote" ] && echo '$QUOTE is empty.' || \
		[ ! -f "$file" ] && echo "$file is not found."; } && \
		return 1
	echo -e "$quote\n" >> "$file" && echo 'Quote saved.' || { echo "Cannot save the quote to $file."; return 1; }
}
alias qs=quote_save

alias agc='sudo apt-get install -f && sudo apt-get autoremove && sudo apt-get autoclean && sudo apt-get clean'
alias agi='sudo apt-get install'
alias aginr='sudo apt-get install --no-install-recommends'
alias agir='sudo apt-get install --install-recommends'
alias agp='sudo apt-get purge'
alias undu='sudo apt-get update && sudo apt-get dist-upgrade'
alias unu='sudo apt-get update && sudo apt-get upgrade'

alias zclean='sudo zypper clean'
alias zdup='sudo zypper dup'
alias zdupy='sudo zypper dup -y'
alias zif='sudo zypper if'
alias zin='sudo zypper in'
alias zinnr='sudo zypper in --no-recommends'
alias zpch='sudo zypper patch'
alias zps='sudo zypper ps'
alias zref='sudo zypper ref'
alias zrm='sudo zypper rm'
alias zse='sudo zypper se'
alias zup='sudo zypper up'
alias zupy='sudo zypper up -y'
alias zwp='sudo zypper wp'

alias yay='PKGEXT=.pkg.tar yay'
