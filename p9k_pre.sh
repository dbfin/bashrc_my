#!/bin/bash --

() {
    _bashrc_my_ssh=''
    [[ -n "$SSH_CLIENT$SSH_CONNECTION$SSH_TTY" ]] && {
        _bashrc_my_ssh=${HOST:0:4}
        [[ ${#HOST} -gt 4 ]] && _bashrc_my_ssh=$_bashrc_my_ssh$HOST[${#HOST}]
    }

    #export POWERLEVEL9K_MODE='awesome-fontconfig'
    export POWERLEVEL9K_MODE='nerdfont-complete'

    # time icons
    export POWERLEVEL9K_TIME_ICON="${_bashrc_my_ssh:+ⵖ}"
    # dir icons
    export POWERLEVEL9K_HOME_ICON=''
    export POWERLEVEL9K_HOME_SUB_ICON=''
    export POWERLEVEL9K_FOLDER_ICON=''
    export POWERLEVEL9K_LOCK_ICON=$'\u26b7'
    export POWERLEVEL9K_ETC_ICON=$POWERLEVEL9K_LOCK_ICON
    # vcs icons
    #export POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
    #export POWERLEVEL9K_VCS_STAGED_ICON='+'
    #export POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
    export POWERLEVEL9K_VCS_STASH_ICON=$'\uF01C'           		# 
    #export POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$'\uF01A'		# 
    export POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='▼'
    #export POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$'\uF01B'		# 
    export POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='▲'
    export POWERLEVEL9K_VCS_TAG_ICON=$'\uF02B'             		# 
    export POWERLEVEL9K_VCS_BOOKMARK_ICON=$'\uF461'        		# 
    export POWERLEVEL9K_VCS_COMMIT_ICON=$'\uE729'          		# 
    export POWERLEVEL9K_VCS_BRANCH_ICON=$'\uF126'          		# 
    export POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON=$'\uE728'   		# 
    export POWERLEVEL9K_VCS_GIT_ICON=$'\uF113'             		# 
    export POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uE709'      		# 
    export POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=$'\uE703'   		# 
    export POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uF296'      		# 
    export POWERLEVEL9K_VCS_HG_ICON=$'\uF0C3'              		# 
    export POWERLEVEL9K_VCS_SVN_ICON=$'\uE72D'             		# 
}
